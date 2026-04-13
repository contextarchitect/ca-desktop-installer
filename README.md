# ContextArchitect - Claude Desktop Installer

Installs ContextArchitect skills and GitHub MCP integration for Claude Desktop.

## Quick Install (Mac)

Open Terminal and paste:

```bash
git clone https://github.com/contextarchitect/ca-desktop-installer.git ~/.claude/skills/context-architect && cd ~/.claude/skills/context-architect && chmod +x setup && ./setup
```

This installs all skills and configures GitHub access. After running, replace the GitHub token placeholder with your real token (the script will tell you how).

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
- **Node.js** (LTS) - [Download](https://nodejs.org) (required for GitHub MCP)
- **Git** - Pre-installed on Mac; [Download](https://git-scm.com) for Windows
- **GitHub token** - Provided by your ContextArchitect admin

## What Gets Installed

### Skills

| Skill | Phase | Description |
|-------|-------|-------------|
| business-validation | Phase 1 | Market validation research briefs |
| avatar-research | Phase 2 | Customer avatar and psychographic profiles |
| brand-analyzer | Phase 3 | Brand guidelines from research |
| copywriting-guide | Phase 4 | Brand voice and humanization rules |
| angle-roadmap | Phase 4.5 | Marketing angles with root cause narratives |
| ad-style-generator | Creative | Ad briefs with image prompts (12 styles) |
| funnel-builder | Creative | Advertorial and listicle funnel pages |
| nano-banana-prompting | Creative | AI image generation prompts |
| video-prompting-guide | Creative | AI video prompts for ad production |
| video-script-generator | Creative | AI video scripts with beat framework |
| product-deep-research | Strategy | Product portfolio and expansion research |

### GitHub MCP

Configures Claude Desktop to read and write files in your assigned GitHub repository directly from conversations.

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

See the [Claude Desktop Installation Guide](https://github.com/contextarchitect/ca-desktop-installer/blob/main/INSTALLATION-GUIDE.md) for detailed step-by-step instructions with screenshots, Windows setup, and troubleshooting.

## Support

Contact your ContextArchitect admin for help with setup or token issues.
