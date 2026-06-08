# =============================================================================
# Figma-to-Lovable asset upload script (PowerShell template)
# -----------------------------------------------------------------------------
# Downloads assets from the Figma local-render server, optionally optimizes
# them (raster only), and uploads to a Supabase Storage bucket.
#
# This template ships with the figma-to-lovable skill. The operator
# parameterizes it for each brand/page and runs it after extraction.
#
# Required pipeline stages: download from Figma, upload to Supabase.
# Enhancement stages: ImageMagick optimization.
# Enhancement stages MUST degrade gracefully (do not abort the pipeline).
# WebP conversion is REQUIRED-FOR-WEBP-rows (gated by manifest declaration).
#
# Preflight-first contract (manifest validation is a single pass at the top):
#   Test-ManifestPreflight runs ONCE before any per-row work and hard-fails on
#   any of the following. Per-row stages run only after preflight passes for
#   every row. This removes the round-1 + round-2 class of bugs where per-row
#   validation checks were anchored to the wrong field or could be bypassed.
#
#     A. Schema completeness (required columns are non-blank)
#     B. target_filename safety (no path traversal, no separators, no absolute paths)
#     C. target_filename uniqueness (no two rows share a target_filename)
#     D. extension-vs-suffix consistency (extension column equals target_filename suffix)
#     E. target_url consistency (target_url equals the computed public URL)
#     F. Duplicate figma_hash detection (Bug 4 content-review WARN, not fatal)
#
# Usage:
#   .\asset-upload-script.ps1 `
#       -ManifestPath "path\to\asset-manifest.csv" `
#       -SupabaseUrl "https://<project>.supabase.co" `
#       -SupabaseBucket "brand-assets" `
#       -SupabasePath "<brand>/<page-slug>" `
#       -AnonKey "<supabase-anon-or-service-key>" `
#       -FigmaLocalhostBase "http://localhost:3845"
# =============================================================================

param (
    [Parameter(Mandatory = $true)]
    [string]$ManifestPath,

    [Parameter(Mandatory = $true)]
    [string]$SupabaseUrl,

    [Parameter(Mandatory = $true)]
    [string]$SupabaseBucket,

    [Parameter(Mandatory = $true)]
    [string]$SupabasePath,

    [Parameter(Mandatory = $true)]
    [string]$AnonKey,

    [Parameter(Mandatory = $false)]
    [string]$FigmaLocalhostBase = "http://localhost:3845",

    [Parameter(Mandatory = $false)]
    [string]$WorkDir = (Join-Path $env:TEMP "figma-assets")
)

# -----------------------------------------------------------------------------
# Top-level pre-flight on the script's own dependencies (path + tool detection)
# -----------------------------------------------------------------------------

if (-not (Test-Path $ManifestPath)) {
    Write-Error "Manifest not found at: $ManifestPath"
    exit 1
}

if (-not (Test-Path $WorkDir)) {
    New-Item -ItemType Directory -Path $WorkDir | Out-Null
}

Write-Host "Manifest: $ManifestPath"
Write-Host "Supabase: $SupabaseUrl/storage/v1/object/$SupabaseBucket/$SupabasePath"
Write-Host "Work dir: $WorkDir"

function Test-CommandAvailable {
    param([string]$Command)
    $cmd = Get-Command $Command -ErrorAction SilentlyContinue
    return ($null -ne $cmd)
}

$hasImageMagick = Test-CommandAvailable "magick"
$hasCwebp = Test-CommandAvailable "cwebp"

if ($hasImageMagick) {
    Write-Host "[OK] ImageMagick (magick) detected. Raster optimization ENABLED."
} else {
    Write-Warning "ImageMagick not found on PATH. Raster optimization will be SKIPPED (enhancement stage)."
    Write-Warning "Install ImageMagick from https://imagemagick.org/ and ensure 'magick' is on PATH to enable."
}

if ($hasCwebp) {
    Write-Host "[OK] cwebp detected. WebP conversion available for .webp rows."
} else {
    Write-Warning "cwebp not found on PATH. Rows with target_filename ending in .webp will FAIL preflight unless the Figma source is already WebP."
    Write-Warning "Install libwebp from https://developers.google.com/speed/webp/download to enable."
}

# -----------------------------------------------------------------------------
# Read the manifest
# -----------------------------------------------------------------------------

$manifest = Import-Csv $ManifestPath
Write-Host "Manifest rows: $($manifest.Count)"

# -----------------------------------------------------------------------------
# Test-ManifestPreflight - single hard-fail pass over the whole manifest
# -----------------------------------------------------------------------------
# Class fix: round 1 + round 2 same-class regressions were all "validation
# anchored to the wrong field, leaving bypass paths." The preflight is the
# single source of truth for every cross-row and cross-field invariant. After
# it passes, the per-row loop trusts the manifest and does not re-validate.

function Test-ManifestPreflight {
    param(
        [Parameter(Mandatory = $true)] $Manifest,
        [Parameter(Mandatory = $true)] [string]$ExpectedSupabaseUrl,
        [Parameter(Mandatory = $true)] [string]$ExpectedSupabaseBucket,
        [Parameter(Mandatory = $true)] [string]$ExpectedSupabasePath
    )

    $errors = @()
    $warnings = @()
    $requiredCols = @("figma_hash", "semantic_role", "target_filename", "target_url", "extension")
    $recommendedCols = @("figma_node_id", "parent_section", "parent_component")
    $unsafeFilenameRegex = '^[A-Za-z0-9._-]+$'
    $absolutePathRegex = '^([A-Za-z]:|/)'
    $rowIdx = 0
    $seenFilenames = @{}

    foreach ($row in $Manifest) {
        $rowIdx++
        $rowLabel = "row $rowIdx (semantic_role='$($row.semantic_role)')"

        # ---- A. Schema completeness ----
        foreach ($col in $requiredCols) {
            $val = $null
            if ($row.PSObject.Properties.Name -contains $col) {
                $val = $row.$col
            }
            if ([string]::IsNullOrWhiteSpace($val)) {
                $errors += "PREFLIGHT [A] $rowLabel - required column '$col' is missing or blank"
            }
        }
        foreach ($col in $recommendedCols) {
            $val = $null
            if ($row.PSObject.Properties.Name -contains $col) {
                $val = $row.$col
            }
            if ([string]::IsNullOrWhiteSpace($val)) {
                $warnings += "PREFLIGHT [A] $rowLabel - recommended column '$col' is missing or blank"
            }
        }

        # Cannot run the remaining checks meaningfully if target_filename is blank
        if ([string]::IsNullOrWhiteSpace($row.target_filename)) {
            continue
        }

        $tfn = $row.target_filename.Trim()

        # ---- B. target_filename safety (path traversal, separators, absolute paths) ----
        if ($tfn -match '[\\/]') {
            $errors += "PREFLIGHT [B] $rowLabel - target_filename '$tfn' contains a path separator. Use a leaf filename only."
        }
        if ($tfn -match '\.\.') {
            $errors += "PREFLIGHT [B] $rowLabel - target_filename '$tfn' contains '..' parent-traversal. Reject."
        }
        if ($tfn -match $absolutePathRegex) {
            $errors += "PREFLIGHT [B] $rowLabel - target_filename '$tfn' is an absolute path. Use a leaf filename only."
        }
        if ($tfn -notmatch $unsafeFilenameRegex) {
            $errors += "PREFLIGHT [B] $rowLabel - target_filename '$tfn' contains disallowed characters. Allowed: alphanumeric, dot, underscore, hyphen."
        }

        # ---- C. target_filename uniqueness (case-insensitive) ----
        $key = $tfn.ToLowerInvariant()
        if ($seenFilenames.ContainsKey($key)) {
            $errors += "PREFLIGHT [C] $rowLabel - target_filename '$tfn' duplicates earlier $($seenFilenames[$key]). Distinct manifest rows must have distinct target_filenames."
        } else {
            $seenFilenames[$key] = $rowLabel
        }

        # ---- D. extension-vs-suffix consistency ----
        if (-not [string]::IsNullOrWhiteSpace($row.extension)) {
            $declaredExt = $row.extension.Trim().ToLowerInvariant()
            $suffixIdx = $tfn.LastIndexOf('.')
            if ($suffixIdx -lt 0 -or $suffixIdx -eq ($tfn.Length - 1)) {
                $errors += "PREFLIGHT [D] $rowLabel - target_filename '$tfn' has no suffix. Cannot reconcile with extension '$declaredExt'."
            } else {
                $actualSuffix = $tfn.Substring($suffixIdx + 1).ToLowerInvariant()
                if ($actualSuffix -ne $declaredExt) {
                    $errors += "PREFLIGHT [D] $rowLabel - extension column '$declaredExt' does not match target_filename suffix '$actualSuffix'. They must be equal (lowercase)."
                }
            }
        }

        # ---- E. target_url consistency ----
        if (-not [string]::IsNullOrWhiteSpace($row.target_url)) {
            $computed = "$ExpectedSupabaseUrl/storage/v1/object/public/$ExpectedSupabaseBucket/$ExpectedSupabasePath/$tfn"
            $declaredUrl = $row.target_url.Trim()
            if ($declaredUrl -ne $computed) {
                $errors += "PREFLIGHT [E] $rowLabel - target_url does not match computed public URL.`n      declared: $declaredUrl`n      computed: $computed"
            }
        }
    }

    # ---- F. Duplicate figma_hash detection (Bug 4 - WARN, not fatal) ----
    $dupes = $Manifest | Group-Object -Property figma_hash | Where-Object { $_.Count -gt 1 -and -not [string]::IsNullOrWhiteSpace($_.Name) }
    if ($dupes) {
        foreach ($dupe in $dupes) {
            $rolesList = ($dupe.Group | ForEach-Object { "'$($_.semantic_role)'" }) -join ", "
            $warnings += "PREFLIGHT [F] figma_hash '$($dupe.Name)' appears in $($dupe.Count) semantic roles ($rolesList). Confirm with the designer that asset reuse is intentional (Bug 4 content-review flag, not fatal)."
        }
    }

    # ---- Report ----
    if ($warnings.Count -gt 0) {
        Write-Host ""
        Write-Host "===== Preflight warnings ====="
        foreach ($w in $warnings) { Write-Warning $w }
    }
    if ($errors.Count -gt 0) {
        Write-Host ""
        Write-Host "===== Preflight ERRORS (fatal) ====="
        foreach ($e in $errors) { Write-Error $e }
        Write-Host ""
        Write-Error "Preflight failed. Fix the manifest and re-run from Step 3 of operator-workflow.md. No downloads or uploads were attempted."
        return $false
    }
    Write-Host ""
    Write-Host "===== Preflight PASS (manifest validated, $($Manifest.Count) rows) ====="
    return $true
}

if (-not (Test-ManifestPreflight -Manifest $manifest -ExpectedSupabaseUrl $SupabaseUrl -ExpectedSupabaseBucket $SupabaseBucket -ExpectedSupabasePath $SupabasePath)) {
    exit 1
}

# -----------------------------------------------------------------------------
# Pipeline: per-row download, optimize (enhancement), upload (required)
# -----------------------------------------------------------------------------
# Preflight has asserted: target_filename is safe, unique, suffix matches
# extension, target_url matches the computed public URL. Per-row code below
# can trust those invariants and does NOT re-validate them.

$results = @()

foreach ($row in $manifest) {
    $hash = $row.figma_hash
    $filename = $row.target_filename.Trim()
    $extension = $row.extension.Trim().ToLowerInvariant()
    $optimizeFlag = ($row.optimize -eq "true" -or $row.optimize -eq "True" -or $row.optimize -eq "1")
    $localPath = Join-Path $WorkDir $filename
    $computedPublicUrl = "$SupabaseUrl/storage/v1/object/public/$SupabaseBucket/$SupabasePath/$filename"

    Write-Host ""
    Write-Host "----- $filename ($($row.semantic_role)) -----"

    # ---- REQUIRED STAGE: download from Figma localhost ----
    $figmaUrl = "$FigmaLocalhostBase/$hash"
    try {
        Invoke-WebRequest -Uri $figmaUrl -OutFile $localPath -ErrorAction Stop
        Write-Host "  [OK] downloaded from $figmaUrl"
    } catch {
        Write-Error "  [FAIL] download from $figmaUrl - $($_.Exception.Message)"
        Write-Error "  This is a REQUIRED stage. Ensure the Figma localhost server is running and the hash is valid."
        $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "DOWNLOAD_FAILED"; url = $null; manifest_target_url = $row.target_url }
        continue
    }

    # ---- ENHANCEMENT STAGE: ImageMagick raster optimization ----
    if ($optimizeFlag -and $hasImageMagick -and $extension -ne "svg") {
        try {
            $optimizedPath = "$localPath.optimized.$extension"
            & magick $localPath -strip -quality 85 $optimizedPath
            if ($LASTEXITCODE -eq 0 -and (Test-Path $optimizedPath)) {
                Move-Item -Force $optimizedPath $localPath
                Write-Host "  [OK] optimized via ImageMagick"
            } else {
                Write-Warning "  [SKIP] ImageMagick exited with code $LASTEXITCODE - uploading original"
            }
        } catch {
            Write-Warning "  [SKIP] ImageMagick optimization failed - uploading original. Error: $($_.Exception.Message)"
        }
    } elseif ($optimizeFlag -and -not $hasImageMagick -and $extension -ne "svg") {
        Write-Host "  [SKIP] optimization (ImageMagick not available)"
    }

    # ---- REQUIRED-FOR-WEBP STAGE: WebP conversion ----
    # Preflight [D] has asserted that target_filename suffix == extension column.
    # So keying on $extension (which is the lowercased suffix) is equivalent to
    # keying on target_filename's suffix. The Bug 6 same-class regression that
    # round 2 flagged (guard on extension column while comment claimed
    # target_filename suffix) is closed by that preflight invariant.
    #
    # If the source from Figma is already WebP (magic bytes RIFF....WEBP), no
    # conversion is needed. Otherwise cwebp is REQUIRED for this row; missing
    # cwebp = abort the row, do not upload non-WebP bytes under a .webp filename
    # with image/webp content type.
    if ($extension -eq "webp") {
        $isAlreadyWebp = $false
        try {
            $headerBytes = [System.IO.File]::ReadAllBytes($localPath) | Select-Object -First 12
            if ($headerBytes.Length -ge 12 -and
                $headerBytes[0] -eq 0x52 -and $headerBytes[1] -eq 0x49 -and  # 'R','I'
                $headerBytes[2] -eq 0x46 -and $headerBytes[3] -eq 0x46 -and  # 'F','F'
                $headerBytes[8] -eq 0x57 -and $headerBytes[9] -eq 0x45 -and  # 'W','E'
                $headerBytes[10] -eq 0x42 -and $headerBytes[11] -eq 0x50) {  # 'B','P'
                $isAlreadyWebp = $true
            }
        } catch {
            # If we can't read the header, fall through to cwebp requirement
        }

        if ($isAlreadyWebp) {
            Write-Host "  [OK] source already WebP, no conversion needed"
        } elseif ($hasCwebp) {
            try {
                $webpPath = "$localPath.webp"
                & cwebp -q 85 $localPath -o $webpPath
                if ($LASTEXITCODE -eq 0 -and (Test-Path $webpPath)) {
                    Move-Item -Force $webpPath $localPath
                    Write-Host "  [OK] converted to WebP"
                } else {
                    Write-Error "  [FAIL] cwebp exited with code $LASTEXITCODE - cannot upload non-webp bytes under .webp filename"
                    $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "WEBP_CONVERSION_FAILED"; url = $null; manifest_target_url = $row.target_url }
                    continue
                }
            } catch {
                Write-Error "  [FAIL] WebP conversion failed - cannot upload non-webp bytes under .webp filename. Error: $($_.Exception.Message)"
                $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "WEBP_CONVERSION_FAILED"; url = $null; manifest_target_url = $row.target_url }
                continue
            }
        } else {
            Write-Error "  [FAIL] target_filename ends in .webp but source is not WebP and cwebp is not installed."
            Write-Error "  Either install cwebp (https://developers.google.com/speed/webp/download) or change target_filename + extension in the manifest to match the source format (then re-run preflight)."
            $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "WEBP_TOOL_MISSING"; url = $null; manifest_target_url = $row.target_url }
            continue
        }
    }

    # ---- REQUIRED STAGE: upload to Supabase ----
    # Preflight [E] has asserted target_url equals the computed public URL,
    # so the per-row upload trusts both. No inline target_url check here.
    $uploadUrl = "$SupabaseUrl/storage/v1/object/$SupabaseBucket/$SupabasePath/$filename"
    $contentType = switch ($extension) {
        "svg"  { "image/svg+xml" }
        "png"  { "image/png" }
        "jpg"  { "image/jpeg" }
        "jpeg" { "image/jpeg" }
        "webp" { "image/webp" }
        "gif"  { "image/gif" }
        default { "application/octet-stream" }
    }

    try {
        $headers = @{
            "Authorization" = "Bearer $AnonKey"
            "x-upsert"      = "true"
            "Content-Type"  = $contentType
        }
        $body = [System.IO.File]::ReadAllBytes($localPath)
        $response = Invoke-WebRequest -Uri $uploadUrl -Method PUT -Headers $headers -Body $body -ErrorAction Stop
        Write-Host "  [OK] uploaded to $uploadUrl"
        $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "UPLOADED"; url = $computedPublicUrl; manifest_target_url = $row.target_url }
    } catch {
        Write-Error "  [FAIL] upload to $uploadUrl - $($_.Exception.Message)"
        Write-Error "  This is a REQUIRED stage. Verify SupabaseUrl, bucket, path, and AnonKey."
        $results += [PSCustomObject]@{ filename = $filename; semantic_role = $row.semantic_role; status = "UPLOAD_FAILED"; url = $null; manifest_target_url = $row.target_url }
        continue
    }
}

# -----------------------------------------------------------------------------
# Summary
# -----------------------------------------------------------------------------

Write-Host ""
Write-Host "===== Summary ====="
$ok = ($results | Where-Object { $_.status -eq "UPLOADED" }).Count
$failed = ($results | Where-Object { $_.status -ne "UPLOADED" }).Count
Write-Host "Uploaded: $ok"
Write-Host "Failed:   $failed"

if ($failed -gt 0) {
    Write-Host ""
    Write-Host "Failed rows:"
    $results | Where-Object { $_.status -ne "UPLOADED" } | Format-Table -AutoSize
    exit 1
}

# Write the public URLs back to a results file the operator can paste into the
# intent-spec generation step (or compare against the manifest target_url
# column for verification - preflight [E] already asserted they match).
$resultsPath = Join-Path $WorkDir "upload-results.csv"
$results | Export-Csv -Path $resultsPath -NoTypeInformation
Write-Host "Results written to: $resultsPath"

Write-Host ""
Write-Host "Next step: open each uploaded URL in a browser tab to verify the asset renders."
Write-Host "Then proceed to intent-spec generation. Asset URLs in the spec come from"
Write-Host "the manifest, never from memory (Bug 8 prevention)."
