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

# Search for existing claude_desktop_config.json
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
    $CLAUDE_CONFIG_FILE = $foundFiles[0]
    Write-Host "  Found: $CLAUDE_CONFIG_FILE" -ForegroundColor Green
    if ($foundFiles.Count -gt 1) {
        Write-Host "  Also found at (not using):" -ForegroundColor Yellow
        for ($i = 1; $i -lt $foundFiles.Count; $i++) {
            Write-Host "    $($foundFiles[$i])"
        }
    }
} else {
    # No config found - look for Claude directory
    $storeBase = "$env:LOCALAPPDATA\Packages"
    if (Test-Path $storeBase) {
        $claudePkg = Get-ChildItem -Path $storeBase -Directory -Filter "Claude*" -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($claudePkg) {
            $CLAUDE_CONFIG_FILE = Join-Path $claudePkg.FullName "LocalCache\Roaming\Claude\claude_desktop_config.json"
        }
    }
    if (-not $CLAUDE_CONFIG_FILE) {
        $CLAUDE_CONFIG_FILE = "$env:APPDATA\Claude\claude_desktop_config.json"
    }
    Write-Host "  No config found. Will create at:" -ForegroundColor Yellow
    Write-Host "  $CLAUDE_CONFIG_FILE"
}

Write-Host ""

# -------------------------------------------------------
# Configure GitHub MCP (preserve existing settings)
# -------------------------------------------------------
Write-Host "Configuring GitHub MCP..." -ForegroundColor Yellow

$CLAUDE_CONFIG_DIR = Split-Path $CLAUDE_CONFIG_FILE -Parent

if (-not (Test-Path $CLAUDE_CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $CLAUDE_CONFIG_DIR -Force | Out-Null
}

# GitHub MCP block as a hashtable
$githubMcp = [ordered]@{
    command = "npx"
    args = @("-y", "@modelcontextprotocol/server-github")
    env = [ordered]@{
        GITHUB_PERSONAL_ACCESS_TOKEN = "YOUR_GITHUB_PAT_HERE"
    }
}

if (Test-Path $CLAUDE_CONFIG_FILE) {
    # Read existing config as UTF-8 (strip BOM if present)
    $raw = [System.IO.File]::ReadAllText($CLAUDE_CONFIG_FILE, [System.Text.UTF8Encoding]::new($false))

    if ($raw -match '"github"') {
        Write-Host "  !   GitHub MCP already configured." -ForegroundColor Yellow
        Write-Host "      To update your token, edit:"
        Write-Host "      $CLAUDE_CONFIG_FILE"
    } else {
        # Parse existing config, add mcpServers with github, preserve everything else
        Copy-Item $CLAUDE_CONFIG_FILE "$CLAUDE_CONFIG_FILE.backup"
        Write-Host "  !   Existing config backed up" -ForegroundColor Yellow

        try {
            $config = $raw | ConvertFrom-Json

            # Build a new ordered hashtable preserving all existing keys
            $newConfig = [ordered]@{}

            # Copy all existing properties
            foreach ($prop in $config.PSObject.Properties) {
                $newConfig[$prop.Name] = $prop.Value
            }

            # Add mcpServers
            $newConfig["mcpServers"] = [ordered]@{
                github = $githubMcp
            }

            # Write as UTF-8 without BOM
            $json = $newConfig | ConvertTo-Json -Depth 10
            [System.IO.File]::WriteAllText($CLAUDE_CONFIG_FILE, $json, [System.Text.UTF8Encoding]::new($false))
            Write-Host "  OK  GitHub MCP added (existing settings preserved)" -ForegroundColor Green
        } catch {
            Write-Host "  !   Error: $_" -ForegroundColor Red
            Write-Host "  !   Could not parse config. Please add GitHub MCP manually." -ForegroundColor Yellow
            Write-Host "      See the installation guide for the JSON to add."
        }
    }
} else {
    # No config - create fresh
    $newConfig = [ordered]@{
        mcpServers = [ordered]@{
            github = $githubMcp
        }
    }
    $json = $newConfig | ConvertTo-Json -Depth 10
    [System.IO.File]::WriteAllText($CLAUDE_CONFIG_FILE, $json, [System.Text.UTF8Encoding]::new($false))
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
