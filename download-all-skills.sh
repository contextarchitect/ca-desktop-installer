#!/usr/bin/env bash
# ============================================================================
# ContextArchitect Skills - Bulk Download (macOS / Linux)
# Installs all skills in one command for new project setup.
#
# FULL install (all skills):
#   bash <(curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.sh)
#
# BRAND install (production skills only, no research/validation):
#   bash <(curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.sh) --mode brand
#
# Or locally:
#   bash download-all-skills.sh              # full
#   bash download-all-skills.sh --mode brand # brand
# ============================================================================

set -euo pipefail

MODE="full"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --mode) MODE="$2"; shift 2 ;;
        *) echo "Unknown argument: $1"; exit 1 ;;
    esac
done

if [[ "$MODE" != "full" && "$MODE" != "brand" ]]; then
    echo "Invalid --mode. Use 'full' or 'brand'."
    exit 1
fi

REPO_URL="https://github.com/contextarchitect/ca-desktop-installer.git"
RAW_BASE="https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"

# Skills excluded from the brand (production) set
BRAND_EXCLUDE=("avatar-research" "business-validation" "brand-analyzer" "breakthrough-advertising")

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m"

MODE_LABEL="Full"
[[ "$MODE" == "brand" ]] && MODE_LABEL="Brand (Production)"

echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  ContextArchitect - Skills Download [$MODE_LABEL]${NC}"
echo -e "${CYAN}============================================================${NC}"
echo ""

# -------------------------------------------------------
# Locate Claude Desktop data directory
# macOS: ~/Library/Application Support/Claude/
# Linux: ~/.config/Claude/ (direct) or XDG_CONFIG_HOME
# -------------------------------------------------------
echo -e "${YELLOW}Locating Claude Desktop installation...${NC}"

CLAUDE_DATA_DIR=""

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS - standard location
    CLAUDE_DATA_DIR="$HOME/Library/Application Support/Claude"
elif [[ "$(uname)" == "Linux" ]]; then
    # Linux - check XDG then fallback
    XDG_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
    if [[ -d "$XDG_CONFIG/Claude" ]]; then
        CLAUDE_DATA_DIR="$XDG_CONFIG/Claude"
    elif [[ -d "$HOME/.config/Claude" ]]; then
        CLAUDE_DATA_DIR="$HOME/.config/Claude"
    else
        CLAUDE_DATA_DIR="$HOME/.config/Claude"
    fi
fi

if [[ -z "$CLAUDE_DATA_DIR" ]]; then
    echo -e "${RED}ERROR: Could not detect OS / Claude data directory.${NC}"
    exit 1
fi

DEST_DIR="$CLAUDE_DATA_DIR/skills/context-architect"

if [[ -d "$CLAUDE_DATA_DIR" ]]; then
    echo -e "${GREEN}  OK  Claude data dir: $CLAUDE_DATA_DIR${NC}"
else
    echo -e "${YELLOW}  !   Claude data dir not found at expected path:${NC}"
    echo    "      $CLAUDE_DATA_DIR"
    echo    "      Creating it - make sure Claude Desktop is installed."
    mkdir -p "$CLAUDE_DATA_DIR"
fi

echo -e "${GREEN}  OK  Skills destination: $DEST_DIR${NC}"
echo ""

# -------------------------------------------------------
# Fetch VERSION manifest and apply mode filter
# -------------------------------------------------------
echo -e "${YELLOW}Fetching VERSION manifest...${NC}"
VERSION_CONTENT=$(curl -fsSL "$RAW_BASE/VERSION")

# Build filtered skill list
SKILL_NAMES=()
SKILL_VERS=()
while IFS='=' read -r name ver; do
    name=$(echo "$name" | tr -d '[:space:]')
    ver=$(echo "$ver"  | tr -d '[:space:]')
    [[ -z "$name" || -z "$ver" ]] && continue

    if [[ "$MODE" == "brand" ]]; then
        skip=0
        for ex in "${BRAND_EXCLUDE[@]}"; do
            [[ "$name" == "$ex" ]] && skip=1 && break
        done
        [[ $skip -eq 1 ]] && continue
    fi

    SKILL_NAMES+=("$name")
    SKILL_VERS+=("$ver")
done < <(echo "$VERSION_CONTENT" | grep -E '=[0-9]')

TOTAL_IN_VERSION=$(echo "$VERSION_CONTENT" | grep -cE '=[0-9]' || true)
EXCLUDED=$(( TOTAL_IN_VERSION - ${#SKILL_NAMES[@]} ))
echo "  ${#SKILL_NAMES[@]} skills selected ($TOTAL_IN_VERSION total, $EXCLUDED excluded for brand mode)"
echo ""

# -------------------------------------------------------
# Download - git path (fast) or HTTPS fallback
# -------------------------------------------------------
if command -v git &>/dev/null; then
    echo -e "${YELLOW}Using git (fastest method)...${NC}"

    if [[ -d "$DEST_DIR/.git" ]]; then
        echo "Updating existing skills install..."
        git -C "$DEST_DIR" pull --ff-only
        git -C "$DEST_DIR" sparse-checkout set "${SKILL_NAMES[@]}"
    else
        if [[ -d "$DEST_DIR" ]]; then
            echo -e "${YELLOW}  !   Destination exists but is not a git repo. Backing up...${NC}"
            [[ -d "$DEST_DIR.bak" ]] && rm -rf "$DEST_DIR.bak"
            mv "$DEST_DIR" "$DEST_DIR.bak"
        fi

        mkdir -p "$(dirname "$DEST_DIR")"

        git clone --filter=blob:none --sparse "$REPO_URL" "$DEST_DIR"
        git -C "$DEST_DIR" sparse-checkout set "${SKILL_NAMES[@]}"
    fi

    INSTALLED=$(find "$DEST_DIR" -maxdepth 2 -name "SKILL.md" | wc -l | tr -d ' ')
    echo ""
    echo -e "${GREEN}  OK  $INSTALLED skills ready${NC}"

else
    echo -e "${YELLOW}git not found - downloading via HTTPS (install git for faster updates)...${NC}"
    echo ""

    if ! command -v curl &>/dev/null; then
        echo -e "${RED}ERROR: Neither git nor curl is available. Install one and retry.${NC}"
        exit 1
    fi

    INSTALLED=0
    FAILED=()

    for i in "${!SKILL_NAMES[@]}"; do
        SKILL_NAME="${SKILL_NAMES[$i]}"
        SKILL_VER="${SKILL_VERS[$i]}"
        SKILL_DEST="$DEST_DIR/$SKILL_NAME"
        mkdir -p "$SKILL_DEST"

        API_URL="https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents/$SKILL_NAME"
        ENTRIES=$(curl -fsSL "$API_URL") || { FAILED+=("$SKILL_NAME"); continue; }

        while IFS= read -r dl_url && IFS= read -r entry_type && IFS= read -r entry_name && IFS= read -r sub_url; do
            if [[ "$entry_type" == "file" ]]; then
                curl -fsSL "$dl_url" -o "$SKILL_DEST/$entry_name"
            elif [[ "$entry_type" == "dir" ]]; then
                mkdir -p "$SKILL_DEST/$entry_name"
                curl -fsSL "$sub_url" | python3 -c "
import sys,json
for e in json.load(sys.stdin):
    if e['type']=='file': print(e.get('download_url','')); print('file'); print(e['name']); print('')
" | while IFS= read -r sdl && IFS= read -r _ && IFS= read -r sname && IFS= read -r _; do
                    [[ -n "$sdl" ]] && curl -fsSL "$sdl" -o "$SKILL_DEST/$entry_name/$sname"
                done
            fi
        done < <(echo "$ENTRIES" | python3 -c "
import sys,json
for e in json.load(sys.stdin): print(e.get('download_url') or ''); print(e['type']); print(e['name']); print(e.get('url',''))
")

        echo -e "${GREEN}  OK  $SKILL_NAME v$SKILL_VER${NC}"
        ((INSTALLED++)) || true
    done

    echo ""
    if [[ ${#FAILED[@]} -gt 0 ]]; then
        echo -e "${YELLOW}WARNING: ${#FAILED[@]} skill(s) failed - re-run to retry:${NC}"
        for s in "${FAILED[@]}"; do echo "  - $s"; done
        echo ""
    fi
    echo -e "${GREEN}  OK  $INSTALLED/${#SKILL_NAMES[@]} skills downloaded${NC}"
fi

# -------------------------------------------------------
# Done
# -------------------------------------------------------
echo ""
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  Done! [$MODE_LABEL] skills installed to:${NC}"
echo -e "${GREEN}  $DEST_DIR${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""
echo -e "${YELLOW}NEXT STEP:${NC}"
echo "  Quit Claude Desktop fully (Cmd+Q or menu bar > Quit)."
echo "  Reopen Claude Desktop."
echo "  Skills will be available in every conversation."
echo ""
