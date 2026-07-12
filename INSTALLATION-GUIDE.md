# Claude Desktop Installation Guide - MCP Setup

**Version 1.0 - 2026-07-12**

This guide sets up the three ContextArchitect MCP servers in Claude Desktop:

| Server | What it does | Runs via |
|--------|--------------|----------|
| **github** | Read and write files in your assigned GitHub repository from a conversation | `npx` (needs Node.js) |
| **kie** | Generate AI images and video (Kie / GPT Image 2, Veo) | `npx` (needs Node.js) |
| **mindcase** | CA's screened research client for customer-voice and review harvesting (unofficial Mindcase client) | `uvx` (needs uv) |

Skills are installed separately by the `setup` script (see the [README](README.md)). This guide is only about the three MCP servers.

Follow the track for your operating system. Every command is copy-paste - do not retype. The `setup` script (see the [README](README.md) quick-install) does Sections 2 and 3 for you automatically, including merging into a config you already have. Do the manual steps below only if you are setting up by hand or fixing a problem.

---

## 1. Prerequisites

You need **Node.js** (for github and kie) and **uv** (for mindcase). Install both, then verify each before editing any config.

### Windows

**Node.js** - download the LTS installer from <https://nodejs.org> and run it. Leave "Add to PATH" checked. After it finishes, **close and reopen PowerShell.**

**uv** - open PowerShell and paste this one line:

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

Then **close and reopen PowerShell** so the new commands are found.

**Verify both** (each line should print a version number, not an error):

```powershell
node --version
uvx --version
```

### macOS

**Node.js** - either install with Homebrew:

```bash
brew install node
```

or download the LTS installer from <https://nodejs.org> and run it.

**uv** - open Terminal and paste this one line:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Then **close and reopen Terminal** so the new commands are found.

**Verify both** (each line should print a version number, not an error):

```bash
node --version
uvx --version
```

If either `uvx --version` or `node --version` says "command not found", the install did not add it to your PATH yet - close every terminal window, open a fresh one, and try again. See Troubleshooting if it persists.

---

## 2. Open the Claude Desktop config file

The config file is named `claude_desktop_config.json`.

### Windows

Its folder is `%APPDATA%\Claude`. To open the file in Notepad, paste this into PowerShell:

```powershell
notepad $env:APPDATA\Claude\claude_desktop_config.json
```

If Notepad asks to create a new file, click **Yes** - it means you had no config yet.

> **If you edited by hand and the servers still do not appear:** make sure you edited the file at `%APPDATA%\Claude\claude_desktop_config.json` (the standard location) and that the JSON is valid (see Section 6). The `setup` script prints the exact path it wrote to - if you ran it, edit that same file. If your Claude Desktop keeps its config somewhere else entirely, contact your ContextArchitect admin.

### macOS

Its folder is `~/Library/Application Support/Claude`. To open the file in TextEdit, paste this into Terminal:

```bash
open -e ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

If it says the file does not exist, create it first, then open it:

```bash
mkdir -p ~/Library/Application\ Support/Claude
touch ~/Library/Application\ Support/Claude/claude_desktop_config.json
open -e ~/Library/Application\ Support/Claude/claude_desktop_config.json
```

---

## 3. Paste the config

**If the file is empty**, paste this entire block and save:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "YOUR_GITHUB_TOKEN_HERE"
      }
    },
    "kie": {
      "command": "npx",
      "args": ["-y", "@contextarchitect/kie-ai-mcp-server"],
      "env": {
        "KIE_AI_API_KEY": "YOUR_KIE_KEY_HERE"
      }
    },
    "mindcase": {
      "command": "uvx",
      "args": ["ca-mindcase-mcp"],
      "env": {
        "MINDCASE_API_KEY": "YOUR_MINDCASE_KEY_HERE"
      }
    }
  }
}
```

**If the file already has content** (for example, the previous installer added only a `github` block), do not paste over the whole file. Add the missing `kie` and `mindcase` blocks **inside** the existing `"mcpServers": { ... }`, and make sure every block except the last one is followed by a comma.

Worked example - if your file currently looks like this:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "your-real-token" }
    }
  }
}
```

change it to this (note the comma added after the `github` block, and that your real token is left untouched):

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "your-real-token" }
    },
    "kie": {
      "command": "npx",
      "args": ["-y", "@contextarchitect/kie-ai-mcp-server"],
      "env": { "KIE_AI_API_KEY": "YOUR_KIE_KEY_HERE" }
    },
    "mindcase": {
      "command": "uvx",
      "args": ["ca-mindcase-mcp"],
      "env": { "MINDCASE_API_KEY": "YOUR_MINDCASE_KEY_HERE" }
    }
  }
}
```

Then replace the placeholders with your real keys (keep the quotes):

| Placeholder | Replace with | Where the key comes from |
|-------------|--------------|--------------------------|
| `YOUR_GITHUB_TOKEN_HERE` | your GitHub personal access token | Provided by your ContextArchitect admin. |
| `YOUR_KIE_KEY_HERE` | your Kie API key | From your ContextArchitect admin, or your own account at <https://kie.ai/api-key>. |
| `YOUR_MINDCASE_KEY_HERE` | your Mindcase API key (starts with `mk_live_`) | From your admin (Hilal) if you are a team member; from the client's own Mindcase account for a client install. |

> **Keep your keys private.** Never paste a real key into chat, email, a screenshot, or a public repository. Anyone with the key can spend on your account.

Save the file and close the editor.

### Retiring SociaVault / SocialVault

SociaVault is **retired** - `mindcase` replaces it. If your config still has a `"sociavault"` or `"socialvault"` server block, delete that block when you add the three servers above (remove the whole `"sociavault": { ... }` entry and any stray comma it leaves behind).

---

## 4. Restart Claude Desktop completely

Closing the window is not enough - the server list only reloads on a full restart.

- **Windows:** find the Claude icon in the system tray (bottom-right, near the clock - you may need to click the up-arrow to show hidden icons), right-click it, and choose **Quit**. Then reopen Claude Desktop.
- **macOS:** with Claude focused, press **Command + Q** (not just the red close button). Then reopen Claude Desktop.

---

## 5. Verify it worked

1. Open a new conversation.
2. Open the tools / connectors panel (the tools icon near the message box). You should see **github**, **kie**, and **mindcase** listed.
3. Expand **mindcase** - it should list **12 tools** (reddit, youtube, amazon, instagram, twitter harvesters, balance, and the run-agent escape hatch).

The first time `mindcase` starts, `uvx` downloads the package - give it up to about 30 seconds. Later starts are instant.

---

## 6. Troubleshooting

| Symptom | Windows fix | macOS fix |
|---------|-------------|-----------|
| A server shows "failed" or "command not found" | Node/uv not on PATH. Re-run `node --version` and `uvx --version` in a fresh PowerShell. If they work there but the server still fails, set `"command"` to the full path, e.g. `"C:\\Users\\YOU\\.local\\bin\\uvx.exe"` for mindcase (double backslashes required in JSON). | Node/uv not on PATH. Re-run `node --version` and `uvx --version` in a fresh Terminal. If they work there but the server still fails, set `"command"` to the full path, e.g. `"/Users/YOU/.local/bin/uvx"` for mindcase. |
| All servers disappear after editing | JSON syntax error - almost always a **trailing comma** after the last server, or a missing quote. Re-paste the block from Section 3 exactly, or paste your file into a JSON validator. | Same - check for a trailing comma after the last server block or a missing quote. |
| Changes do not take effect | You closed the window but the app is still running. Quit fully from the **system tray** (right-click, Quit), then reopen. | You closed the window but the app is still running. Press **Command + Q** to quit fully, then reopen. |
| `mindcase` is slow on first launch | Normal - `uvx` is downloading the package on first run. Wait ~30 seconds; it is cached afterward. | Same - first `uvx` run downloads the package. Wait ~30 seconds. |

Still stuck? Contact your ContextArchitect admin with a screenshot of the error and the section you were on.
