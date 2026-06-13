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
# Locate the active Claude Desktop data directory.
#
# Two install methods produce two completely different paths:
#
#   Store / MSIX / WinGet:
#     %LOCALAPPDATA%\Packages\Claude_<hash>\LocalCache\Roaming\Claude\
#
#   Direct .exe installer:
#     %APPDATA%\Claude\
#
# We detect by install method, NOT by searching for config files.
# Searching for claude_desktop_config.json is unreliable - the file
# may exist in stale install remnants or backup copies. Using
# Get-AppxPackage queries the live Windows package registry instead,
# which is authoritative for Store/MSIX installs.
# -------------------------------------------------------
Write-Host "Locating Claude Desktop installation..." -ForegroundColor Yellow

$claudeDataDir = $null
$installMethod = $null

# --- Method 1: Store / MSIX / WinGet (Get-AppxPackage is authoritative) ---
try {
    $pkg = Get-AppxPackage -Name "Claude" -ErrorAction SilentlyContinue
    if (-not $pkg) {
        # WinGet and some MSIX installers register under a different family name
        $pkg = Get-AppxPackage | Where-Object { $_.Name -like "*Claude*" -or $_.PackageFamilyName -like "*Claude*" } | Select-Object -First 1
    }
    if ($pkg) {
        # PackageFamilyName gives us the stable folder name under Packages
        $pkgDataPath = "$env:LOCALAPPDATA\Packages\$($pkg.PackageFamilyName)\LocalCache\Roaming\Claude"
        if (Test-Path (Split-Path $pkgDataPath)) {
            $claudeDataDir = $pkgDataPath
            $installMethod = "Windows Store / MSIX (package: $($pkg.PackageFamilyName))"
        }
    }
} catch {
    # Get-AppxPackage can fail in restricted environments - treat as not found
}

# --- Method 2: Direct .exe installer ---
if (-not $claudeDataDir) {
    $directPath = "$env:APPDATA\Claude"
    if (Test-Path $directPath) {
        $claudeDataDir = $directPath
        $installMethod = "Direct installer (%APPDATA%\Claude)"
    }
}

# --- Neither found: warn and prompt ---
if (-not $claudeDataDir) {
    Write-Host ""
    Write-Host "  !!  Could not detect Claude Desktop installation." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Expected locations:" -ForegroundColor Yellow
    Write-Host "    Store/WinGet: %LOCALAPPDATA%\Packages\Claude_<hash>\LocalCache\Roaming\Claude"
    Write-Host "    Direct .exe:  %APPDATA%\Claude"
    Write-Host ""
    Write-Host "  Make sure Claude Desktop is installed and has been launched at least once."
    Write-Host "  Download from: https://claude.ai/download"
    Write-Host ""
    exit 1
}

# Skills live alongside the Claude config, two levels up from the Roaming\Claude dir:
#   Store: Packages\Claude_<hash>\LocalCache\Roaming\Claude  -> skills at Packages\Claude_<hash>\LocalCache\Roaming\Claude\..\..\skills
#   Wait - skills actually sit inside the same Claude data dir, not relative to Packages root.
#   Claude reads skills from: <claudeDataDir>\skills\context-architect
$DEST_DIR = Join-Path $claudeDataDir "skills\context-architect"

Write-Host "  OK  Install method : $installMethod" -ForegroundColor Green
Write-Host "  OK  Claude data dir: $claudeDataDir" -ForegroundColor Green
Write-Host "  OK  Skills target  : $DEST_DIR" -ForegroundColor Green
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
$excluded   = $allSkills.Count - $skills.Count

Write-Host "  $($skills.Count) skills selected ($($allSkills.Count) total, $excluded excluded for brand mode)" -ForegroundColor Cyan
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
