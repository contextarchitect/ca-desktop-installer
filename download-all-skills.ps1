# ============================================================================
# ContextArchitect Skills - Bulk Download (Windows PowerShell)
# Installs all skills in one command for new project setup.
#
# Usage:
#   iex (irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.ps1')
#
# Or if you have the repo cloned locally:
#   .\download-all-skills.ps1
# ============================================================================

$ErrorActionPreference = "Stop"

$REPO_URL  = "https://github.com/contextarchitect/ca-desktop-installer.git"
$RAW_BASE  = "https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
$DEST_DIR  = "$env:USERPROFILE\.claude\skills\context-architect"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ContextArchitect - Bulk Skills Download" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------
# Detect git availability and choose install method
# -------------------------------------------------------
$hasGit = $null -ne (Get-Command git -ErrorAction SilentlyContinue)

if ($hasGit) {
    Write-Host "Using git (fastest method)..." -ForegroundColor Yellow
    Write-Host ""

    if (Test-Path "$DEST_DIR\.git") {
        # Already a git repo - just pull latest
        Write-Host "Updating existing skills install..." -ForegroundColor Yellow
        Push-Location $DEST_DIR
        git pull --ff-only
        Pop-Location
    } else {
        # Fresh install - sparse clone (skills only, no session logs etc.)
        if (Test-Path $DEST_DIR) {
            Write-Host "  !   Destination exists but is not a git repo." -ForegroundColor Yellow
            Write-Host "      Backing up to $DEST_DIR.bak and doing a fresh clone."
            if (Test-Path "$DEST_DIR.bak") { Remove-Item -Recurse -Force "$DEST_DIR.bak" }
            Rename-Item $DEST_DIR "$DEST_DIR.bak"
        }

        New-Item -ItemType Directory -Force -Path (Split-Path $DEST_DIR) | Out-Null

        git clone `
            --filter=blob:none `
            --sparse `
            $REPO_URL `
            $DEST_DIR

        Push-Location $DEST_DIR

        # Read skill names from VERSION and sparse-checkout just those folders
        $versionContent = (Invoke-WebRequest -Uri "$RAW_BASE/VERSION" -UseBasicParsing).Content
        $skillFolders = $versionContent -split "`n" |
            Where-Object { $_ -match '=\d' } |
            ForEach-Object { ($_ -split '=')[0].Trim() }

        git sparse-checkout set $skillFolders
        Pop-Location
    }

    $installed = (Get-ChildItem -Path $DEST_DIR -Directory | Where-Object {
        Test-Path (Join-Path $_.FullName "SKILL.md")
    }).Count

    Write-Host ""
    Write-Host "  OK  $installed skills installed to:" -ForegroundColor Green
    Write-Host "      $DEST_DIR" -ForegroundColor Green

} else {
    # No git - fall back to downloading each skill folder via raw GitHub API
    Write-Host "git not found - downloading skills via HTTPS..." -ForegroundColor Yellow
    Write-Host "  (Install git for faster future updates)"
    Write-Host ""

    # Fetch VERSION manifest to get exact skill list
    $versionContent = (Invoke-WebRequest -Uri "$RAW_BASE/VERSION" -UseBasicParsing).Content
    $skills = $versionContent -split "`n" |
        Where-Object { $_ -match '=\d' } |
        ForEach-Object {
            $parts = $_ -split '='
            [PSCustomObject]@{ Name = $parts[0].Trim(); Version = $parts[1].Trim() }
        }

    Write-Host "Found $($skills.Count) skills in VERSION manifest." -ForegroundColor Cyan
    Write-Host ""

    $installed = 0
    $failed    = @()

    foreach ($skill in $skills) {
        $skillDest = Join-Path $DEST_DIR $skill.Name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null

        # Always download SKILL.md; also grab any files one level deep
        $apiUrl = "https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents/$($skill.Name)"
        try {
            $entries = (Invoke-WebRequest -Uri $apiUrl -UseBasicParsing).Content | ConvertFrom-Json

            foreach ($entry in $entries) {
                if ($entry.type -eq "file") {
                    $outPath = Join-Path $skillDest $entry.name
                    Invoke-WebRequest -Uri $entry.download_url -OutFile $outPath -UseBasicParsing
                } elseif ($entry.type -eq "dir") {
                    # One level of subdirectory (references/, etc.)
                    $subDest = Join-Path $skillDest $entry.name
                    New-Item -ItemType Directory -Force -Path $subDest | Out-Null
                    $subEntries = (Invoke-WebRequest -Uri $entry.url -UseBasicParsing).Content | ConvertFrom-Json
                    foreach ($sub in $subEntries) {
                        if ($sub.type -eq "file") {
                            Invoke-WebRequest -Uri $sub.download_url -OutFile (Join-Path $subDest $sub.name) -UseBasicParsing
                        }
                    }
                }
            }

            Write-Host "  OK  $($skill.Name) v$($skill.Version)" -ForegroundColor Green
            $installed++
        } catch {
            Write-Host "  !!  $($skill.Name) - FAILED: $_" -ForegroundColor Red
            $failed += $skill.Name
        }
    }

    Write-Host ""
    if ($failed.Count -gt 0) {
        Write-Host "WARNING: $($failed.Count) skill(s) failed to download:" -ForegroundColor Yellow
        $failed | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
        Write-Host "Re-run this script to retry, or install them manually."
        Write-Host ""
    }

    Write-Host "  OK  $installed/$($skills.Count) skills installed to:" -ForegroundColor Green
    Write-Host "      $DEST_DIR" -ForegroundColor Green
}

# -------------------------------------------------------
# Done
# -------------------------------------------------------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  All skills downloaded. Restart Claude Desktop to activate." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT STEP:" -ForegroundColor Yellow
Write-Host "  Right-click the Claude icon in the system tray and Quit."
Write-Host "  Reopen Claude Desktop."
Write-Host "  Skills will be available in every conversation."
Write-Host ""
