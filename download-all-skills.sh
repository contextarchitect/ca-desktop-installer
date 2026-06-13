#!/usr/bin/env bash
# ============================================================================
# ContextArchitect Skills - Download All as Zips (macOS / Linux)
#
# Downloads every skill as a ready-to-install .zip file into the folder
# where this script is run. Install each zip manually via Claude Desktop
# Settings > Skills > Install from file.
#
# Usage:
#   bash download-all-skills.sh
#
# One-liner:
#   curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-all-skills.sh | bash
# ============================================================================

set -euo pipefail

RAW_BASE="https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
API_BASE="https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents"
OUT_DIR="$(pwd)"
TEMP_BASE="$(mktemp -d)"

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m"

echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  ContextArchitect - Download All Skills${NC}"
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  Saving zips to: $OUT_DIR${NC}"
echo ""

# Parse VERSION manifest
VERSION_CONTENT=$(curl -fsSL "$RAW_BASE/VERSION")
mapfile -t SKILL_LINES < <(echo "$VERSION_CONTENT" | grep -E '=[0-9]')

echo -e "${CYAN}Found ${#SKILL_LINES[@]} skills in VERSION manifest.${NC}"
echo ""

DOWNLOADED=0
FAILED=()

for line in "${SKILL_LINES[@]}"; do
    SKILL_NAME=$(echo "$line" | cut -d'=' -f1 | tr -d '[:space:]')
    SKILL_VER=$(echo "$line"  | cut -d'=' -f2 | tr -d '[:space:]')
    TEMP_DIR="$TEMP_BASE/$SKILL_NAME"
    ZIP_PATH="$OUT_DIR/$SKILL_NAME.zip"

    mkdir -p "$TEMP_DIR"

    ENTRIES=$(curl -fsSL "$API_BASE/$SKILL_NAME") || { FAILED+=("$SKILL_NAME"); continue; }

    # Download files (and one level of subdirs)
    while IFS= read -r dl_url && IFS= read -r entry_type && IFS= read -r entry_name && IFS= read -r sub_url; do
        if [[ "$entry_type" == "file" && -n "$dl_url" ]]; then
            curl -fsSL "$dl_url" -o "$TEMP_DIR/$entry_name"
        elif [[ "$entry_type" == "dir" ]]; then
            mkdir -p "$TEMP_DIR/$entry_name"
            curl -fsSL "$sub_url" | python3 -c "
import sys,json
for e in json.load(sys.stdin):
    if e['type']=='file': print(e.get('download_url','')); print('file'); print(e['name']); print('')
" | while IFS= read -r sdl && IFS= read -r _ && IFS= read -r sname && IFS= read -r _; do
                [[ -n "$sdl" ]] && curl -fsSL "$sdl" -o "$TEMP_DIR/$entry_name/$sname"
            done
        fi
    done < <(echo "$ENTRIES" | python3 -c "
import sys,json
for e in json.load(sys.stdin): print(e.get('download_url') or ''); print(e['type']); print(e['name']); print(e.get('url',''))
")

    # Zip the skill folder
    rm -f "$ZIP_PATH"
    (cd "$TEMP_DIR" && zip -r "$ZIP_PATH" . -x "*.DS_Store") > /dev/null

    echo -e "${GREEN}  OK  $SKILL_NAME v$SKILL_VER${NC}"
    ((DOWNLOADED++)) || true
done

rm -rf "$TEMP_BASE"

echo ""
if [[ ${#FAILED[@]} -gt 0 ]]; then
    echo -e "${YELLOW}WARNING: ${#FAILED[@]} skill(s) failed - re-run to retry:${NC}"
    for s in "${FAILED[@]}"; do echo "  - $s"; done
    echo ""
fi

echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}  $DOWNLOADED/${#SKILL_LINES[@]} zips saved to:${NC}"
echo -e "${GREEN}  $OUT_DIR${NC}"
echo -e "${GREEN}============================================================${NC}"
echo ""
echo -e "${YELLOW}NEXT: Install each .zip via Claude Desktop${NC}"
echo -e "${YELLOW}  Settings > Skills > Install from file${NC}"
echo ""
