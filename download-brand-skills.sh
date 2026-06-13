#!/usr/bin/env bash
# ============================================================================
# ContextArchitect Skills - Brand (Production) Download (macOS / Linux)
# Installs only the skills needed for brand production projects.
# Excludes: avatar-research, business-validation, brand-analyzer,
#           breakthrough-advertising
#
# Usage:
#   bash <(curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-brand-skills.sh)
# ============================================================================

curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.sh | bash -s -- --mode brand
