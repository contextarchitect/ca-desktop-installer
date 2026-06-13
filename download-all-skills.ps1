# ============================================================================
# ContextArchitect Skills - Download All as Zips (Windows PowerShell)
#
# Downloads every skill as a ready-to-install .zip file into the folder
# where this script is run. Install each zip manually via Claude Desktop
# Settings > Skills > Install from file.
#
# Usage:
#   .\download-all-skills.ps1
#
# One-liner (runs from any folder):
#   iex (irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.ps1')
# ============================================================================

$ErrorActionPreference = "Stop"
$RAW_BASE = "https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
$API_BASE = "https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents"
$OUT_DIR  = $PSScriptRoot
if (-not $OUT_DIR) { $OUT_DIR = (Get-Location).Path }  # fallback when run via iex

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ContextArchitect - Download All Skills" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Saving zips to: $OUT_DIR" -ForegroundColor Cyan
Write-Host ""

# Read skill list from VERSION manifest
$versionContent = (Invoke-WebRequest -Uri "$RAW_BASE/VERSION" -UseBasicParsing).Content
$skills = $versionContent -split "`n" |
    Where-Object { $_ -match '=\d' } |
    ForEach-Object {
        $parts = $_ -split '='
        [PSCustomObject]@{ Name = $parts[0].Trim(); Version = $parts[1].Trim() }
    }

Write-Host "Found $($skills.Count) skills in VERSION manifest." -ForegroundColor Cyan
Write-Host ""

$downloaded = 0
$failed     = @()
$tempBase   = Join-Path $env:TEMP "ca-skills-$$"

foreach ($skill in $skills) {
    $zipName  = "$($skill.Name).zip"
    $zipPath  = Join-Path $OUT_DIR $zipName
    $tempDir  = Join-Path $tempBase $skill.Name

    try {
        # Fetch folder listing from GitHub API
        $entries = (Invoke-WebRequest -Uri "$API_BASE/$($skill.Name)" -UseBasicParsing).Content | ConvertFrom-Json

        New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

        foreach ($entry in $entries) {
            if ($entry.type -eq 'file') {
                Invoke-WebRequest -Uri $entry.download_url -OutFile (Join-Path $tempDir $entry.name) -UseBasicParsing
            } elseif ($entry.type -eq 'dir') {
                $subDir     = Join-Path $tempDir $entry.name
                New-Item -ItemType Directory -Force -Path $subDir | Out-Null
                $subEntries = (Invoke-WebRequest -Uri $entry.url -UseBasicParsing).Content | ConvertFrom-Json
                foreach ($sub in $subEntries) {
                    if ($sub.type -eq 'file') {
                        Invoke-WebRequest -Uri $sub.download_url -OutFile (Join-Path $subDir $sub.name) -UseBasicParsing
                    }
                }
            }
        }

        # Zip it
        if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
        Compress-Archive -Path "$tempDir\*" -DestinationPath $zipPath

        Write-Host "  OK  $($skill.Name) v$($skill.Version)" -ForegroundColor Green
        $downloaded++
    } catch {
        Write-Host "  !!  $($skill.Name) - FAILED: $_" -ForegroundColor Red
        $failed += $skill.Name
    }
}

# Cleanup temp
if (Test-Path $tempBase) { Remove-Item $tempBase -Recurse -Force -ErrorAction SilentlyContinue }

Write-Host ""
if ($failed.Count -gt 0) {
    Write-Host "WARNING: $($failed.Count) skill(s) failed - re-run to retry:" -ForegroundColor Yellow
    $failed | ForEach-Object { Write-Host "  - $_" }
    Write-Host ""
}

Write-Host "============================================================" -ForegroundColor Green
Write-Host "  $downloaded/$($skills.Count) zips saved to:" -ForegroundColor Green
Write-Host "  $OUT_DIR" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT: Install each .zip via Claude Desktop" -ForegroundColor Yellow
Write-Host "  Settings > Skills > Install from file" -ForegroundColor Yellow
Write-Host ""
