# ============================================================================
# ContextArchitect Skills - Download Brand (Production) Skills as Zips
#
# Downloads the brand production skill set as ready-to-install .zip files
# into the folder where this script is run.
#
# Excludes: avatar-research, business-validation, brand-analyzer,
#           breakthrough-advertising
#
# Usage:
#   .\download-brand-skills.ps1
#
# One-liner:
#   iex (irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-brand-skills.ps1')
# ============================================================================

$ErrorActionPreference = "Stop"
$RAW_BASE = "https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
$API_BASE = "https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents"
$OUT_DIR  = $PSScriptRoot
if (-not $OUT_DIR) { $OUT_DIR = (Get-Location).Path }

$EXCLUDE = @(
    'avatar-research',
    'business-validation',
    'brand-analyzer',
    'breakthrough-advertising'
)

Add-Type -AssemblyName System.IO.Compression.FileSystem

function New-SkillZip {
    param([string]$SourceDir, [string]$ZipPath)
    if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
    $zip = [System.IO.Compression.ZipFile]::Open($ZipPath, 'Create')
    try {
        Get-ChildItem -Path $SourceDir -Recurse -File | ForEach-Object {
            $entryName = $_.FullName.Substring($SourceDir.Length).TrimStart('\', '/').Replace('\', '/')
            [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $_.FullName, $entryName) | Out-Null
        }
    } finally {
        $zip.Dispose()
    }
}

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ContextArchitect - Download Brand (Production) Skills" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  Saving zips to: $OUT_DIR" -ForegroundColor Cyan
Write-Host ""

$versionContent = (Invoke-WebRequest -Uri "$RAW_BASE/VERSION" -UseBasicParsing).Content
$allSkills = $versionContent -split "`n" |
    Where-Object { $_ -match '=\d' } |
    ForEach-Object {
        $parts = $_ -split '='
        [PSCustomObject]@{ Name = $parts[0].Trim(); Version = $parts[1].Trim() }
    }

$skills = $allSkills | Where-Object { $EXCLUDE -notcontains $_.Name }

Write-Host "$($skills.Count) skills selected ($($allSkills.Count) total, $($allSkills.Count - $skills.Count) excluded)." -ForegroundColor Cyan
Write-Host ""

$downloaded = 0
$failed     = @()
$tempBase   = Join-Path $env:TEMP "ca-skills-$PID"

foreach ($skill in $skills) {
    $zipPath = Join-Path $OUT_DIR "$($skill.Name).zip"
    $tempDir = Join-Path $tempBase $skill.Name

    try {
        $entries = (Invoke-WebRequest -Uri "$API_BASE/$($skill.Name)" -UseBasicParsing).Content | ConvertFrom-Json
        New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

        foreach ($entry in $entries) {
            if ($entry.type -eq 'file') {
                Invoke-WebRequest -Uri $entry.download_url -OutFile (Join-Path $tempDir $entry.name) -UseBasicParsing
            } elseif ($entry.type -eq 'dir') {
                $subDir = Join-Path $tempDir $entry.name
                New-Item -ItemType Directory -Force -Path $subDir | Out-Null
                $subEntries = (Invoke-WebRequest -Uri $entry.url -UseBasicParsing).Content | ConvertFrom-Json
                foreach ($sub in $subEntries) {
                    if ($sub.type -eq 'file') {
                        Invoke-WebRequest -Uri $sub.download_url -OutFile (Join-Path $subDir $sub.name) -UseBasicParsing
                    }
                }
            }
        }

        New-SkillZip -SourceDir $tempDir -ZipPath $zipPath
        Write-Host "  OK  $($skill.Name) v$($skill.Version)" -ForegroundColor Green
        $downloaded++
    } catch {
        Write-Host "  !!  $($skill.Name) - FAILED: $_" -ForegroundColor Red
        $failed += $skill.Name
    }
}

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
