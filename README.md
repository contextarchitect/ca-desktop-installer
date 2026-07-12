# ContextArchitect - Claude Desktop Installer

Installs ContextArchitect skills and three MCP integrations (GitHub, Kie, and Mindcase) for Claude Desktop.

## Quick Install (Mac)

Open Terminal and paste:

```bash
git clone https://github.com/contextarchitect/ca-desktop-installer.git ~/.claude/skills/context-architect && cd ~/.claude/skills/context-architect && chmod +x setup && ./setup
```

This installs all skills and sets up the three MCP servers. After running, replace the three key placeholders with your real keys and follow the [MCP Setup Guide](INSTALLATION-GUIDE.md) (the script will tell you how).

## Quick Install (Windows)

Open PowerShell and paste:

```powershell
git clone https://github.com/contextarchitect/ca-desktop-installer.git $env:USERPROFILE\.claude\skills\context-architect
cd $env:USERPROFILE\.claude\skills\context-architect
bash setup
```

Requires [Git for Windows](https://git-scm.com) (includes Git Bash).

## Prerequisites

- **Claude Desktop** - [Download](https://claude.ai/download)
- **Node.js** (LTS) - [Download](https://nodejs.org) (required for the GitHub and Kie MCPs, via `npx`)
- **uv** - fast Python runner (required for the Mindcase MCP, via `uvx`). Install line and verification are in the [MCP Setup Guide](INSTALLATION-GUIDE.md).
- **Git** - Pre-installed on Mac; [Download](https://git-scm.com) for Windows
- **API keys** - a GitHub token, a Kie key, and a Mindcase key. Provided by your ContextArchitect admin (client installs use the client's own Mindcase account).

## What Gets Installed

### Skills

| Skill | Phase | Description |
|-------|-------|-------------|
| business-validation | Phase 1 | Market validation research briefs |
| avatar-research | Phase 2 | Customer avatar and psychographic profiles |
| brand-analyzer | Phase 3 | Brand guidelines from research |
| copywriting-guide | Phase 4 | Brand voice and humanization rules |
| angle-roadmap | Phase 4.5 | Marketing angles with root cause narratives; drives funnel-builder, ad-style-generator, and long-form-static-builder |
| ad-style-generator | Creative | Ad briefs with image prompts (13 styles, REDDIT-NATIVE pairs with long-form-static-builder) |
| funnel-builder | Creative | Advertorial and listicle funnel pages, deployed via Funnel Factory pipeline |
| long-form-static-builder | Creative | Long-form static ad copy (2,500-3,500 words) for Facebook in-feed advertorials |
| nano-banana-prompting | Creative | AI image generation prompts (Nano Banana Pro) |
| gpt-image-2-prompting | Creative | AI image generation prompts (OpenAI GPT Image 2) |
| video-prompting-guide | Creative | AI video prompts for ad production |
| video-script-generator | Creative | AI video scripts with beat framework |
| product-deep-research | Strategy | Product portfolio and expansion research |

### MCP servers

The setup writes three MCP servers into your `claude_desktop_config.json`. Full step-by-step setup, key sources, and troubleshooting are in the [MCP Setup Guide](INSTALLATION-GUIDE.md).

| Server | Purpose | Runs via | Key |
|--------|---------|----------|-----|
| **github** | Read and write files in your assigned GitHub repository from conversations | `npx` (Node.js) | `GITHUB_PERSONAL_ACCESS_TOKEN` |
| **kie** | Generate AI images and video (Kie / GPT Image 2, Veo) | `npx` (Node.js) | `KIE_AI_API_KEY` |
| **mindcase** | CA's screened customer-voice / review research client (unofficial Mindcase client, `ca-mindcase-mcp`) | `uvx` (uv) | `MINDCASE_API_KEY` |

> Migrating from SociaVault? It is retired - `mindcase` replaces it. Remove any `sociavault` / `socialvault` block from your `claude_desktop_config.json` when you add `mindcase`.

## Versioning

Each skill carries its version in two places: the `version:` field in its `SKILL.md` YAML frontmatter, and a matching line in the root `VERSION` file. Both must agree -- `sync-installer.py` refuses to run when they don't. See [VERSIONING.md](VERSIONING.md) for the full contract and bump procedure.

## Updating Skills

When notified of a skill update:

```bash
# Mac
cd ~/.claude/skills/context-architect && git pull

# Windows
cd $env:USERPROFILE\.claude\skills\context-architect
git pull
```

Then restart Claude Desktop.

## Full Installation Guide

See the [MCP Setup Guide](INSTALLATION-GUIDE.md) for detailed step-by-step MCP setup - prerequisites (Node.js and uv), parallel Windows and macOS tracks, the complete config block for all three servers, key sources, restart, verification, and troubleshooting.

## Support

Contact your ContextArchitect admin for help with setup or token issues.
