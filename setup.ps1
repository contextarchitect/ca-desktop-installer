# ============================================================================
# ContextArchitect Skills - Setup Script (Windows PowerShell)
# Configures Claude Desktop with all skills and three MCP servers
# (github, kie, mindcase)
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
    Write-Host "  OK  Node.js / npx available (for github and kie)" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js is not installed (npx not found)." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Download from https://nodejs.org (LTS version)"
    Write-Host "  Make sure 'Add to PATH' is checked during installation."
    Write-Host "  Then CLOSE and REOPEN PowerShell before re-running this setup."
    Write-Host ""
    exit 1
}

try {
    $null = Get-Command uvx -ErrorAction Stop
    Write-Host "  OK  uv / uvx available (for mindcase)" -ForegroundColor Green
} catch {
    Write-Host "ERROR: uv is not installed (uvx not found)." -ForegroundColor Red
    Write-Host ""
    Write-Host "  Install uv, then CLOSE and REOPEN PowerShell and re-run this setup:"
    Write-Host '    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"'
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
# Configure MCP servers (preserve existing settings)
# -------------------------------------------------------
Write-Host "Configuring MCP servers (github, kie, mindcase)..." -ForegroundColor Yellow

$CLAUDE_CONFIG_DIR = Split-Path $CLAUDE_CONFIG_FILE -Parent

if (-not (Test-Path $CLAUDE_CONFIG_DIR)) {
    New-Item -ItemType Directory -Path $CLAUDE_CONFIG_DIR -Force | Out-Null
}

# The three CA MCP server blocks as hashtables
$githubMcp = [ordered]@{
    command = "npx"
    args = @("-y", "@modelcontextprotocol/server-github")
    env = [ordered]@{
        GITHUB_PERSONAL_ACCESS_TOKEN = "YOUR_GITHUB_TOKEN_HERE"
    }
}
$kieMcp = [ordered]@{
    command = "npx"
    args = @("-y", "@contextarchitect/kie-ai-mcp-server")
    env = [ordered]@{
        KIE_AI_API_KEY = "YOUR_KIE_KEY_HERE"
    }
}
$mindcaseMcp = [ordered]@{
    command = "uvx"
    args = @("ca-mindcase-mcp")
    env = [ordered]@{
        MINDCASE_API_KEY = "YOUR_MINDCASE_KEY_HERE"
    }
}

if (Test-Path $CLAUDE_CONFIG_FILE) {
    # Read existing config as UTF-8 (strip BOM if present)
    $raw = [System.IO.File]::ReadAllText($CLAUDE_CONFIG_FILE, [System.Text.UTF8Encoding]::new($false))

    # Parse first, then add each server independently. Any server already present
    # (e.g. a github block you already tokenised) is preserved untouched; only the
    # missing servers are added. This is idempotent and safe to re-run.
    Copy-Item $CLAUDE_CONFIG_FILE "$CLAUDE_CONFIG_FILE.backup"

    try {
        $config = if ($raw.Trim()) { $raw | ConvertFrom-Json } else { [PSCustomObject]@{} }

        # Build a new ordered hashtable preserving all existing top-level keys
        $newConfig = [ordered]@{}
        foreach ($prop in $config.PSObject.Properties) {
            $newConfig[$prop.Name] = $prop.Value
        }

        # Preserve any existing servers; only add a canonical server if absent.
        $servers = [ordered]@{}
        if ($config.PSObject.Properties.Name -contains "mcpServers" -and $config.mcpServers) {
            foreach ($p in $config.mcpServers.PSObject.Properties) {
                $servers[$p.Name] = $p.Value
            }
        }
        $added = @()
        if (-not $servers.Contains("github"))   { $servers["github"]   = $githubMcp;   $added += "github" }
        if (-not $servers.Contains("kie"))      { $servers["kie"]      = $kieMcp;      $added += "kie" }
        if (-not $servers.Contains("mindcase")) { $servers["mindcase"] = $mindcaseMcp; $added += "mindcase" }

        # Normalize a lingering placeholder from the previous installer to the
        # current name, so the "replace the placeholders" step below covers it.
        if ($servers["github"].env -and $servers["github"].env.GITHUB_PERSONAL_ACCESS_TOKEN -eq "YOUR_GITHUB_PAT_HERE") {
            $servers["github"].env.GITHUB_PERSONAL_ACCESS_TOKEN = "YOUR_GITHUB_TOKEN_HERE"
        }

        $newConfig["mcpServers"] = $servers

        # Write as UTF-8 without BOM
        $json = $newConfig | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($CLAUDE_CONFIG_FILE, $json, [System.Text.UTF8Encoding]::new($false))
        if ($added.Count -gt 0) {
            Write-Host "  OK  Added: $($added -join ', ') (existing settings preserved)" -ForegroundColor Green
        } else {
            Write-Host "  OK  All three servers already present (no change)" -ForegroundColor Green
        }
    } catch {
        Write-Host ""
        Write-Host "  Could not update your existing config (it is not valid JSON)." -ForegroundColor Red
        Write-Host "  Your skills are installed, but the MCP servers were NOT added."
        Write-Host "  Add them by hand: open INSTALLATION-GUIDE.md (Section 3), then restart Claude."
        Write-Host "  Your original config is backed up at:"
        Write-Host "    $CLAUDE_CONFIG_FILE.backup"
        Write-Host ""
        exit 1
    }
} else {
    # No config - create fresh with all three servers
    $newConfig = [ordered]@{
        mcpServers = [ordered]@{
            github   = $githubMcp
            kie      = $kieMcp
            mindcase = $mindcaseMcp
        }
    }
    $json = $newConfig | ConvertTo-Json -Depth 10
    [System.IO.File]::WriteAllText($CLAUDE_CONFIG_FILE, $json, [System.Text.UTF8Encoding]::new($false))
    Write-Host "  OK  github, kie, mindcase configured with placeholder keys" -ForegroundColor Green
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
Write-Host "  1. Replace the three key placeholders:" -ForegroundColor Cyan
Write-Host "     Open this file in any text editor:"
Write-Host "     $CLAUDE_CONFIG_FILE"
Write-Host ""
Write-Host "     Replace any of these placeholders that appear in the file (keep the quotes):"
Write-Host '       "YOUR_GITHUB_TOKEN_HERE"    -> your GitHub token'
Write-Host '       "YOUR_KIE_KEY_HERE"         -> your Kie API key'
Write-Host '       "YOUR_MINDCASE_KEY_HERE"    -> your Mindcase key (starts with mk_live_)'
Write-Host "     Keys come from your ContextArchitect admin. Never share or commit them."
Write-Host "     Save and close the file. See INSTALLATION-GUIDE.md for details."
Write-Host ""
Write-Host "  2. Restart Claude Desktop:" -ForegroundColor Cyan
Write-Host "     Right-click the Claude icon in the system tray and Quit."
Write-Host "     Reopen it."
Write-Host ""
Write-Host "You're all set! The skills are available in every conversation." -ForegroundColor Green
Write-Host ""
