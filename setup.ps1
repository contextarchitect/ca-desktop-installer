# ============================================================================
# ContextArchitect Skills - Setup Script (Windows PowerShell)
# Configures Claude Desktop with all skills and GitHub MCP
# ============================================================================

$ErrorActionPreference = "Stop"

$SKILLS_DIR = "$env:USERPROFILE\.claude\skills\context-architect"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  ContextArchitect - Claude Desktop Setup" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

# -------------------------------------------------------
# Check prerequisites
# -------------------------------------------------------
Write-Host "Checking prerequisites..." -ForegroundColor Yellow

try {
    $null = Get-Command npx -ErrorAction Stop
    Write-Host "  OK  Node.js / npx available" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js is not installed (npx not found)." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Download from https://nodejs.org (LTS version)"
    Write-Host "  Make sure 'Add to PATH' is checked during installation."
    Write-Host "  Then CLOSE and REOPEN PowerShell before re-running this setup."
    Write-Host ""
    exit 1
}

Write-Host ""

# -------------------------------------------------------
# Register skills
# -------------------------------------------------------
Write-Host "Registering skills..." -ForegroundColor Yellow
Write-Host ""

$skillCount = 0

if (Test-Path $SKILLS_DIR) {
    Get-ChildItem -Path $SKILLS_DIR -Directory | ForEach-Object {
        $skillMd = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillMd) {
            Write-Host "  OK  $($_.Name)" -ForegroundColor Green
            $skillCount++
        }
    }
}

if ($skillCount -eq 0) {
    Write-Host "  No skills found. Make sure you cloned the repo correctly." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "$skillCount skills installed." -ForegroundColor Green
Write-Host ""

# -------------------------------------------------------
# Find Claude Desktop config file
# -------------------------------------------------------
Write-Host "Locating Claude Desktop config..." -ForegroundColor Yellow

$CLAUDE_CONFIG_FILE = $null

# Search for existing claude_desktop_config.json across all possible locations
# Use Get-ChildItem to find the ACTUAL file wherever it lives
$searchRoots = @(
    "$env:LOCALAPPDATA\Packages",
    "$env:APPDATA",
    "$env:LOCALAPPDATA"
)

$foundFiles = @()
foreach ($root in $searchRoots) {
    if (Test-Path $root) {
        Get-ChildItem -Path $root -Recurse -Filter "claude_desktop_config.json" -ErrorAction SilentlyContinue | ForEach-Object {
            $foundFiles += $_.FullName
        }
    }
}

if ($foundFiles.Count -gt 0) {
    # Use the first found file
    $CLAUDE_CONFIG_FILE = $foundFiles[0]
    Write-Host "  Found config at:" -ForegroundColor Green
    Write-Host "  $CLAUDE_CONFIG_FILE"
    if ($foundFiles.Count -gt 1) {
        Write-Host ""
        Write-Host "  Also found at (not using these):" -ForegroundColor Yellow
        for ($i = 1; $i -lt $foundFiles.Count; $i++) {
            Write-Host "  $($foundFiles[$i])"
        }
    }
} else {
    # No existing config found - look for the Claude directory to create one
    # Check Microsoft Store path first
    $storeDir = $null
    $storeBase = "$env:LOCALAPPDATA\Packages"
    if (Test-Path $storeBase) {
        $claudePkg = Get-ChildItem -Path $storeBase -Directory -Filter "Claude*" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($claudePkg) {
            $storeDir = Join-Path $claudePkg.FullName "LocalCache\Roaming\Claude"
        }
    }

    if ($storeDir -and (Test-Path (Split-Path $storeDir -Parent))) {
        $CLAUDE_CONFIG_FILE = Join-Path $storeDir "claude_desktop_config.json"
    } else {
        $CLAUDE_CONFIG_FILE = "$env:APPDATA\Claude\claude_desktop_config.json"
    }
    Write-Host "  No existing config found. Will create at:" -ForegroundColor Yellow
    Write-Host "  $CLAUDE_CONFIG_FILE"
}

Write-Host ""

# -------------------------------------------------------
# Configure GitHub MCP
# -------------------------------------------------------
Write-Host "Configuring GitHub MCP..." -ForegroundColor Yellow

$CLAUDE_CONFIG_DIR = Split-Path $CLAUDE_CONFIG_FILE -Parent

if (-not (Test-Path $CLAUDE_CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $CLAUDE_CONFIG_DIR -Force | Out-Null
}

$configJson = @'
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_PAT_HERE"
      }
    }
  }
}
'@

if (Test-Path $CLAUDE_CONFIG_FILE) {
    $content = Get-Content $CLAUDE_CONFIG_FILE -Raw
    if ($content -match '"github"') {
        Write-Host "  !   GitHub MCP already configured at this location." -ForegroundColor Yellow
        Write-Host "      To update your token, edit:"
        Write-Host "      $CLAUDE_CONFIG_FILE"
    } else {
        Copy-Item $CLAUDE_CONFIG_FILE "$CLAUDE_CONFIG_FILE.backup"
        Write-Host "  !   Existing config backed up to .backup" -ForegroundColor Yellow
        Set-Content -Path $CLAUDE_CONFIG_FILE -Value $configJson -Encoding UTF8
        Write-Host "  OK  Config replaced with GitHub MCP (placeholder token)" -ForegroundColor Green
    }
} else {
    Set-Content -Path $CLAUDE_CONFIG_FILE -Value $configJson -Encoding UTF8
    Write-Host "  OK  GitHub MCP configured with placeholder token" -ForegroundColor Green
}

Write-Host ""

# -------------------------------------------------------
# Done
# -------------------------------------------------------
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  Setup complete! $skillCount skills installed." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "TWO LAST STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Replace the GitHub token placeholder:" -ForegroundColor Cyan
Write-Host "     Open this file in any text editor:"
Write-Host "     $CLAUDE_CONFIG_FILE"
Write-Host ""
Write-Host '     Find:    "YOUR_GITHUB_PAT_HERE"'
Write-Host "     Replace with the token from your admin (keep the quotes)."
Write-Host "     Save and close the file."
Write-Host ""
Write-Host "  2. Restart Claude Desktop:" -ForegroundColor Cyan
Write-Host "     Right-click the Claude icon in the system tray and Quit."
Write-Host "     Reopen it."
Write-Host ""
Write-Host "You're all set! The skills are available in every conversation." -ForegroundColor Green
Write-Host ""
