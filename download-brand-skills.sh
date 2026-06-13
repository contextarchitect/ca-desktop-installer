#!/usr/bin/env bash
# ============================================================================
# ContextArchitect Skills - Download Brand (Production) Skills as Zips
#
# Downloads the brand production skill set as ready-to-install .zip files
# into the folder where this script is run.
#
# Excludes: avatar-research, business-validation, brand-analyzer,
#           breakthrough-advertising
#
# Usage:
#   bash download-brand-skills.sh
#
# One-liner:
#   curl -fsSL https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main/download-brand-skills.sh | bash
# ============================================================================

set -euo pipefail

RAW_BASE="https://raw.githubusercontent.com/contextarchitect/ca-desktop-installer/main"
API_BASE="https://api.github.com/repos/contextarchitect/ca-desktop-installer/contents"
OUT_DIR="$(pwd)"
TEMP_BASE="$(mktemp -d)"
EXCLUDE=("avatar-research" "business-validation" "brand-analyzer" "breakthrough-advertising")

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
NC="\033[0m"

echo ""
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  ContextArchitect - Download Brand (Production) Skills${NC}"
echo -e "${CYAN}============================================================${NC}"
echo -e "${CYAN}  Saving zips to: $OUT_DIR${NC}"
echo ""

VERSION_CONTENT=$(curl -fsSL "$RAW_BASE/VERSION")
mapfile -t ALL_LINES < <(echo "$VERSION_CONTENT" | grep -E '=[0-9]')

# Filter out excluded skills
SKILL_LINES=()
for line in "${ALL_LINES[@]}"; do
    NAME=$(echo "$line" | cut -d'=' -f1 | tr -d '[:space:]')
    skip=0
    for ex in "${EXCLUDE[@]}"; do [[ "$NAME" == "$ex" ]] && skip=1 && break; done
    [[ $skip -eq 0 ]] && SKILL_LINES+=("$line")
done

EXCLUDED_COUNT=$(( ${#ALL_LINES[@]} - ${#SKILL_LINES[@]} ))
echo -e "${CYAN}${#SKILL_LINES[@]} skills selected (${#ALL_LINES[@]} total, $EXCLUDED_COUNT excluded).${NC}"
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
