# Duplicate Pages - Mode 1 (Figma Source)

**Use when:** The brand has a Figma design file. The page has been designed
and needs to be built in Lovable.

**Input:** Figma file URL + section node IDs + brand identity + verbatim copy
+ Supabase asset destination.

**Output:** Lovable intent-spec (single paste) + asset upload script.

## Inputs required

Collect all of these before the pipeline runs. If any are missing, halt and
ask. Do not infer copy from Figma element labels (designer scratch text), and
do not guess brand palette from screenshot pixels.

1. **Figma file URL.** Full URL with file key:
   `https://www.figma.com/design/<file-key>/<file-name>`
2. **Section node IDs.** Top-level frame node IDs for each page section.
   Operator selects each section in Figma and copies the node ID. Typical
   PDP has 10-15 sections.
3. **Brand identity.** Name, product, positioning, palette (hex codes),
   typography (font + weights), voice notes. See
   `../_reference/brand-token-extraction.md` for extracting from Figma
   variables when available.
4. **Verbatim copy.** Every paragraph of body text the page renders. The
   skill never paraphrases (Bug 4/5 prevention).
5. **Asset destination.** Supabase Storage bucket + path. Intent-spec
   references assets by their public Supabase URL.

## 6-step pipeline

Full step-by-step in `../_reference/operator-workflow.md`. Summary:

**Step 1 - Receive and verify inputs.** Confirm all 5 inputs above before
proceeding.

**Step 2 - Figma extraction.** Loop section node IDs. For each: call
`Figma:get_metadata` to enumerate elements, then `Figma:get_design_context`
for JSX export. Capture every asset hash and pair with a semantic role. Build
the asset manifest (one row per asset). See
`../_reference/brand-token-extraction.md` for brand identity extraction.

**Step 3 - Asset upload.** Parameterize
`../_reference/asset-upload-script-template.ps1` with manifest path and
Supabase destination. Run the script. Verify each uploaded URL in a browser
tab before proceeding.

**Step 4 - Intent-spec generation.** Fill `../_reference/intent-spec-template.md`
with brand identity, asset base URL, and per-section blocks. Body copy is
verbatim from input 4. Asset URLs come from the manifest - never reconstructed
from memory (Bug 8 prevention).

**Step 5 - Lovable paste.** Open a fresh Lovable project. Paste the complete
intent-spec as a single prompt. Do not split. Wait for first generation.
Capture a screenshot of the rendered page.

**Step 6 - Visual review and fix-up.** Apply the shared fix-up escalation
ladder from `../SKILL.md`. One prescriptive attempt, then screenshot +
plain-English, then source-code diagnostic + disposition.

Each step ends with a "verify before next step" gate. Refresh state
immediately before executing - audits go stale.

## Asset workflow

Mode 1 uses Supabase Storage as the asset host. The asset upload script
downloads assets from Figma's localhost export and uploads to Supabase.
Intent-spec references assets by their permanent public Supabase URL.

This is different from Mode 2's asset workflow (Kie.ai temp URLs direct to
Lovable with download instruction).

## Known bugs and how this pipeline prevents them

All 9 bugs documented in the Known bugs section below.
Key ones:

- **Bug 5 (Lovable rewrites pasted JSX):** Prevented by Approach B. The
  skill ships prose intent-specs, not JSX. Nothing to rewrite.
- **Bug 8 (asset mapping reconstructed from memory gets reversed):**
  Prevented by the asset manifest. Read from the manifest, never from memory.
- **Bug 9 (prescriptive CSS fails where screenshot + plain English succeeds):**
  Codified as Level 2 of the fix-up ladder. Prescriptive is Level 1;
  screenshot is Level 2. Never skip to Level 2 without trying Level 1 first,
  but never repeat Level 1 if it has already failed on the same issue.

Full bug-to-skill mapping in the Known bugs section above.
