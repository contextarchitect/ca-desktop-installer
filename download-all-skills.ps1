# ============================================================================
# ContextArchitect Skills - Bulk Download (Windows PowerShell)
# Installs all skills in one command for new project setup.
#
# FULL install (all skills):
#   iex (irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.ps1')
#
# BRAND install (production skills only, no research/validation):
#   iex "& { $(irm 'https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.ps1') } -Mode brand"
#
# Or locally:
#   .\download-all-skills.ps1              # full
#   .\download-all-skills.ps1 -Mode brand  # brand
# ============================================================================

param(
    [ValidateSet('full','brand')]
    [string]$Mode = 'full'
)

$ErrorActionPreference = "Stop"

$REPO_URL = "https://github.com/contextarchitect/ca-desktop-installer.git"
$RAW_BASE = "https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"

# Skills excluded from the brand (production) set
$BRAND_EXCLUDE = @(
    'avatar-research',
    'business-validation',
    'brand-analyzer',
    'breakthrough-advertising'
)

$ModeLabel = if ($Mode -eq 'brand') { 'Brand (Production)' } else { 'Full' }

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ContextArchitect - Skills Download [$ModeLabel]" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------
# Locate Claude Desktop config to find the correct
# skills directory (handles direct install + Store install)
# -------------------------------------------------------
Write-Host "Locating Claude Desktop installation..." -ForegroundColor Yellow

$searchRoots = @(
    "$env:LOCALAPPDATA\Packages",
    "$env:APPDATA",
    "$env:LOCALAPPDATA"
)

$foundConfigs = @()
foreach ($root in $searchRoots) {
    if (Test-Path $root) {
        Get-ChildItem -Path $root -Recurse -Filter "claude_desktop_config.json" -ErrorAction SilentlyContinue |
            ForEach-Object { $foundConfigs += $_.FullName }
    }
}

if ($foundConfigs.Count -gt 0) {
    $claudeConfigFile = $foundConfigs[0]
    $claudeConfigDir  = Split-Path $claudeConfigFile -Parent
    Write-Host "  OK  Config found: $claudeConfigFile" -ForegroundColor Green
} else {
    # Config doesn't exist yet - find the Claude data directory
    $claudeConfigDir = $null

    # Check Windows Store package location first
    $storeBase = "$env:LOCALAPPDATA\Packages"
    if (Test-Path $storeBase) {
        $claudePkg = Get-ChildItem -Path $storeBase -Directory -Filter "AnthropicPBC.Claude*" -ErrorAction SilentlyContinue |
                     Select-Object -First 1
        if ($claudePkg) {
            $claudeConfigDir = Join-Path $claudePkg.FullName "LocalCache\Roaming\Claude"
        }
    }

    # Fall back to standard direct-install location
    if (-not $claudeConfigDir) {
        $claudeConfigDir = "$env:APPDATA\Claude"
    }

    $claudeConfigFile = Join-Path $claudeConfigDir "claude_desktop_config.json"
    Write-Host "  !   No config found. Will use: $claudeConfigDir" -ForegroundColor Yellow
    Write-Host "      (Run setup.ps1 after this script to create the config)" -ForegroundColor Yellow
}

$DEST_DIR = Join-Path $claudeConfigDir "..\..\skills\context-architect"
$DEST_DIR = [System.IO.Path]::GetFullPath($DEST_DIR)

Write-Host "  OK  Skills destination: $DEST_DIR" -ForegroundColor Green
Write-Host ""

# -------------------------------------------------------
# Fetch VERSION manifest and apply mode filter
# -------------------------------------------------------
Write-Host "Fetching VERSION manifest..." -ForegroundColor Yellow
$versionContent = (Invoke-WebRequest -Uri "$RAW_BASE/VERSION" -UseBasicParsing).Content

$allSkills = $versionContent -split "`n" |
    Where-Object { $_ -match '=\d' } |
    ForEach-Object {
        $parts = $_ -split '='
        [PSCustomObject]@{ Name = $parts[0].Trim(); Version = $parts[1].Trim() }
    }

$skills = if ($Mode -eq 'brand') {
    $allSkills | Where-Object { $BRAND_EXCLUDE -notcontains $_.Name }
} else {
    $allSkills
}

$skillNames = $skills | ForEach-Object { $_.Name }

Write-Host "  $($skills.Count) skills selected ($($allSkills.Count) total, $($allSkills.Count - $skills.Count) excluded for brand mode)" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------
# Download - git path (fast) or HTTPS fallback
# -------------------------------------------------------
$hasGit = $null -ne (Get-Command git -ErrorAction SilentlyContinue)

if ($hasGit) {
    Write-Host "Using git (fastest method)..." -ForegroundColor Yellow

    if (Test-Path "$DEST_DIR\.git") {
        Write-Host "Updating existing skills install..."
        git -C $DEST_DIR pull --ff-only
        # Re-apply sparse-checkout in case mode changed
        Push-Location $DEST_DIR
        git sparse-checkout set $skillNames
        Pop-Location
    } else {
        if (Test-Path $DEST_DIR) {
            Write-Host "  !   Destination exists but is not a git repo. Backing up..." -ForegroundColor Yellow
            if (Test-Path "$DEST_DIR.bak") { Remove-Item -Recurse -Force "$DEST_DIR.bak" }
            Rename-Item $DEST_DIR "$DEST_DIR.bak"
        }

        New-Item -ItemType Directory -Force -Path (Split-Path $DEST_DIR) | Out-Null

        git clone --filter=blob:none --sparse $REPO_URL $DEST_DIR

        Push-Location $DEST_DIR
        git sparse-checkout set $skillNames
        Pop-Location
    }

    $installed = (Get-ChildItem -Path $DEST_DIR -Directory |
        Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") }).Count

    Write-Host ""
    Write-Host "  OK  $installed skills ready" -ForegroundColor Green

} else {
    Write-Host "git not found - downloading via HTTPS (install git for faster updates)..." -ForegroundColor Yellow
    Write-Host ""

    $installed = 0
    $failed    = @()

    foreach ($skill in $skills) {
        $skillDest = Join-Path $DEST_DIR $skill.Name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null

        $apiUrl = "https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents/$($skill.Name)"
        try {
            $entries = (Invoke-WebRequest -Uri $apiUrl -UseBasicParsing).Content | ConvertFrom-Json

            foreach ($entry in $entries) {
                if ($entry.type -eq 'file') {
                    Invoke-WebRequest -Uri $entry.download_url -OutFile (Join-Path $skillDest $entry.name) -UseBasicParsing
                } elseif ($entry.type -eq 'dir') {
                    $subDest = Join-Path $skillDest $entry.name
                    New-Item -ItemType Directory -Force -Path $subDest | Out-Null
                    $subEntries = (Invoke-WebRequest -Uri $entry.url -UseBasicParsing).Content | ConvertFrom-Json
                    foreach ($sub in $subEntries) {
                        if ($sub.type -eq 'file') {
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
        Write-Host "WARNING: $($failed.Count) skill(s) failed - re-run to retry:" -ForegroundColor Yellow
        $failed | ForEach-Object { Write-Host "  - $_" }
        Write-Host ""
    }
    Write-Host "  OK  $installed/$($skills.Count) skills downloaded" -ForegroundColor Green
}

# -------------------------------------------------------
# Done
# -------------------------------------------------------
Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  Done! [$ModeLabel] skills installed to:" -ForegroundColor Green
Write-Host "  $DEST_DIR" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT STEP:" -ForegroundColor Yellow
Write-Host "  Right-click the Claude icon in the system tray and Quit."
Write-Host "  Reopen Claude Desktop."
Write-Host "  Skills will be available in every conversation."
Write-Host ""
