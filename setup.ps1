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

# Search order: most common locations for claude_desktop_config.json
$searchPaths = @()

# 1. Standard install path
$searchPaths += "$env:APPDATA\Claude\claude_desktop_config.json"

# 2. Microsoft Store sandboxed path (search for Claude package)
$storeBase = "$env:LOCALAPPDATA\Packages"
if (Test-Path $storeBase) {
    Get-ChildItem -Path $storeBase -Directory -Filter "Claude*" -ErrorAction SilentlyContinue | ForEach-Object {
        $searchPaths += Join-Path $_.FullName "LocalCache\Roaming\Claude\claude_desktop_config.json"
    }
}

# 3. Also check LocalAppData directly
$searchPaths += "$env:LOCALAPPDATA\Claude\claude_desktop_config.json"

# Find the first existing config file
foreach ($path in $searchPaths) {
    if (Test-Path $path) {
        $CLAUDE_CONFIG_FILE = $path
        break
    }
}

# If no existing config found, check which Claude directory exists
if (-not $CLAUDE_CONFIG_FILE) {
    foreach ($path in $searchPaths) {
        $dir = Split-Path $path -Parent
        if (Test-Path $dir) {
            $CLAUDE_CONFIG_FILE = $path
            break
        }
    }
}

# Last resort: use standard path
if (-not $CLAUDE_CONFIG_FILE) {
    $CLAUDE_CONFIG_FILE = "$env:APPDATA\Claude\claude_desktop_config.json"
}

$CLAUDE_CONFIG_DIR = Split-Path $CLAUDE_CONFIG_FILE -Parent
Write-Host "  Found: $CLAUDE_CONFIG_DIR" -ForegroundColor Green
Write-Host ""

# -------------------------------------------------------
# Configure GitHub MCP in Claude Desktop config
# -------------------------------------------------------
Write-Host "Configuring GitHub MCP..." -ForegroundColor Yellow

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
        Write-Host "  !   GitHub MCP already configured." -ForegroundColor Yellow
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
