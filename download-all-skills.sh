#!/usr/bin/env bash
# ============================================================================
# ContextArchitect Skills - Bulk Download (macOS / Linux)
# Installs all skills in one command for new project setup.
#
# Usage:
#   bash <(curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.sh)
#
# Or if you have the repo cloned locally:
#   bash download-all-skills.sh
# ============================================================================

set -euo pipefail

REPO_URL="https://github.com/contextarchitect/ca-desktop-installer.git"
RAW_BASE="https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
DEST_DIR="$HOME/.claude/skills/context-architect"

# Colour helpers (safe fallback if terminal doesn't support colours)
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m" # No Colour

echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  ContextArchitect - Bulk Skills Download${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

# -------------------------------------------------------
# Detect git availability and choose install method
# -------------------------------------------------------
if command -v git &>/dev/null; then
    echo -e "${YELLOW}Using git (fastest method)...${NC}"
    echo ""

    if [ -d "$DEST_DIR/.git" ]; then
        echo "Updating existing skills install..."
        git -C "$DEST_DIR" pull --ff-only
    else
        if [ -d "$DEST_DIR" ]; then
            echo -e "${YELLOW}  !   Destination exists but is not a git repo."
            echo -e "      Backing up to $DEST_DIR.bak and doing a fresh clone.${NC}"
            [ -d "$DEST_DIR.bak" ] && rm -rf "$DEST_DIR.bak"
            mv "$DEST_DIR" "$DEST_DIR.bak"
        fi

        mkdir -p "$(dirname "$DEST_DIR")"

        # Sparse clone - only pull skill folders, skip session logs etc.
        git clone \
            --filter=blob:none \
            --sparse \
            "$REPO_URL" \
            "$DEST_DIR"

        # Read skill names from VERSION manifest
        SKILL_FOLDERS=$(curl -fsSL "$RAW_BASE/VERSION" | \
            grep -E '=[0-9]' | \
            cut -d'=' -f1 | \
            tr -d '[:space:]' | \
            tr '\n' ' ')

        git -C "$DEST_DIR" sparse-checkout set $SKILL_FOLDERS
    fi

    INSTALLED=$(find "$DEST_DIR" -maxdepth 2 -name "SKILL.md" | wc -l | tr -d ' ')
    echo ""
    echo -e "${GREEN}  OK  $INSTALLED skills installed to:${NC}"
    echo -e "${GREEN}      $DEST_DIR${NC}"

else
    # No git - fall back to curl + GitHub API
    echo -e "${YELLOW}git not found - downloading skills via HTTPS...${NC}"
    echo "  (Install git for faster future updates: https://git-scm.com)"
    echo ""

    if ! command -v curl &>/dev/null; then
        echo -e "${RED}ERROR: Neither git nor curl is available. Install one and retry.${NC}"
        exit 1
    fi

    # Parse VERSION manifest
    VERSION_CONTENT=$(curl -fsSL "$RAW_BASE/VERSION")
    mapfile -t SKILL_LINES < <(echo "$VERSION_CONTENT" | grep -E '=[0-9]')

    echo "Found ${#SKILL_LINES[@]} skills in VERSION manifest."
    echo ""

    INSTALLED=0
    FAILED=()

    for line in "${SKILL_LINES[@]}"; do
        SKILL_NAME=$(echo "$line" | cut -d'=' -f1 | tr -d '[:space:]')
        SKILL_VER=$(echo "$line"  | cut -d'=' -f2 | tr -d '[:space:]')
        SKILL_DEST="$DEST_DIR/$SKILL_NAME"
        mkdir -p "$SKILL_DEST"

        API_URL="https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents/$SKILL_NAME"
        ENTRIES=$(curl -fsSL "$API_URL")

        if [ $? -ne 0 ]; then
            echo -e "${RED}  !!  $SKILL_NAME - API request failed${NC}"
            FAILED+=("$SKILL_NAME")
            continue
        fi

        # Download each file in the skill folder (and one level of subdirs)
        FILE_COUNT=0
        while IFS= read -r dl_url && IFS= read -r entry_type && IFS= read -r entry_name && IFS= read -r sub_url; do
            if [ "$entry_type" = "file" ]; then
                curl -fsSL "$dl_url" -o "$SKILL_DEST/$entry_name"
                ((FILE_COUNT++)) || true
            elif [ "$entry_type" = "dir" ]; then
                mkdir -p "$SKILL_DEST/$entry_name"
                # One level deep
                curl -fsSL "$sub_url" | \
                    python3 -c "
import sys, json
for e in json.load(sys.stdin):
    if e['type'] == 'file':
        print(e.get('download_url',''))
        print('file')
        print(e['name'])
        print('')
" | while IFS= read -r sdl && IFS= read -r stype && IFS= read -r sname && IFS= read -r _; do
                    [ -n "$sdl" ] && curl -fsSL "$sdl" -o "$SKILL_DEST/$entry_name/$sname"
                done
            fi
        done < <(echo "$ENTRIES" | python3 -c "
import sys, json
for e in json.load(sys.stdin):
    print(e.get('download_url') or '')
    print(e['type'])
    print(e['name'])
    print(e.get('url',''))
")

        echo -e "${GREEN}  OK  $SKILL_NAME v$SKILL_VER${NC}"
        ((INSTALLED++)) || true
    done

    echo ""
    if [ ${#FAILED[@]} -gt 0 ]; then
        echo -e "${YELLOW}WARNING: ${#FAILED[@]} skill(s) failed to download:${NC}"
        for s in "${FAILED[@]}"; do echo "  - $s"; done
        echo "Re-run this script to retry, or install them manually."
        echo ""
    fi

    echo -e "${GREEN}  OK  $INSTALLED skills installed to:${NC}"
    echo -e "${GREEN}      $DEST_DIR${NC}"
fi

# -------------------------------------------------------
# Done
# -------------------------------------------------------
echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  All skills downloaded. Restart Claude Desktop to activate.${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""
echo -e "${YELLOW}NEXT STEP:${NC}"
echo "  Quit Claude Desktop fully (Cmd+Q or menu bar icon > Quit)."
echo "  Reopen Claude Desktop."
echo "  Skills will be available in every conversation."
echo ""
