# Duplicate Pages - Mode 1 (Figma Source)

**Use when:** The brand has a Figma design file. The page has been designed
and needs to be built in Lovable.

**Input:** Figma file URL + section node IDs + brand identity + verbatim copy.

**Output:** Lovable intent-spec (single paste) + exported Figma assets
attached to the Lovable prompt.

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

## 6-step pipeline

Full step-by-step in `../_reference/operator-workflow.md`. Summary:

**Step 1 - Receive and verify inputs.** Confirm all 4 inputs above before
proceeding.

**Step 2 - Figma extraction.** Loop section node IDs. For each: call
`Figma:get_metadata` to enumerate elements, then `Figma:get_design_context`
for JSX export. Capture every asset hash and pair with a semantic role. Build
the asset manifest (one row per asset). See
`../_reference/brand-token-extraction.md` for brand identity extraction.

**Step 3 - Asset export.** Export the manifest's assets from Figma to one
local folder for this design (native Figma Export panel). Resolve any blank
or duplicate layer names first. No CDN upload; the exported files attach
directly to the Lovable prompt in Step 5.

**Step 4 - Intent-spec generation.** Fill `../_reference/intent-spec-template.md`
with brand identity and per-section blocks. Body copy is verbatim from input 4.
Assets are referenced by their exported filename from the manifest - never
reconstructed from memory (Bug 8 prevention).

**Step 5 - Lovable paste.** Open a fresh Lovable project. Paste the complete
intent-spec as a single prompt and attach the exported assets (up to 10 per
prompt; follow-up prompts attach the remainder). Do not split the spec. Wait
for first generation. Capture a screenshot of the rendered page.

**Step 6 - Visual review and fix-up.** Apply the shared fix-up escalation
ladder from `../SKILL.md`. One prescriptive attempt, then screenshot +
plain-English, then source-code diagnostic + disposition.

Each step ends with a "verify before next step" gate. Refresh state
immediately before executing - audits go stale.

## Asset workflow

Export the manifest's assets from Figma to a local folder using the native
Figma Export panel. Resolve any blank or duplicate layer names first, since a
blank name produces an invalid `..png` path and duplicates collide on export.

Then attach the exported images directly to the Lovable prompt. Lovable
persists them in the project; there is no CDN upload step. Lovable accepts at
most 10 attachments per prompt, so batch accordingly: the initial prompt
attaches up to 10 assets alongside the intent-spec, and follow-up prompts
attach the remainder until every manifest row's asset has been attached.

Mode 1 attaches Figma exports directly to the Lovable prompt; Mode 2 supplies
Kie.ai temp URLs in the prompt text.

## Known bugs and how this pipeline prevents them

All 9 bugs documented in the Known bugs section below.
Key ones:

- **Bug 5 (Lovable rewrites pasted JSX):** Prevented by Approach B. The
  skill ships prose intent-specs, not JSX. Nothing to rewrite.
- **Bug 8 (asset mapping reconstructed from memory gets reversed):**
  Prevented by the asset manifest, which maps each semantic_role to its
  exported filename. The intent-spec references assets by that filename, read
  from the manifest and never reconstructed from memory.
- **Bug 9 (prescriptive CSS fails where screenshot + plain English succeeds):**
  Codified as Level 2 of the fix-up ladder. Prescriptive is Level 1;
  screenshot is Level 2. Never skip to Level 2 without trying Level 1 first,
  but never repeat Level 1 if it has already failed on the same issue.

Full bug-to-skill mapping in the Known bugs section above.
