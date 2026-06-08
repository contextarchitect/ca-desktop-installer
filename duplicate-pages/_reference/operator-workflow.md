# Operator workflow

End-to-end procedure for converting a Figma design into a Lovable.dev implementation. This is the expanded version of the 6-step summary in `SKILL.md`. Each step has a "verify before next step" gate; do not advance past a gate without confirming the gate condition. Audits go stale fast (validation discipline rule 3 in `_tests/figma-to-lovable-mode-1-findings.md`); refresh state immediately before executing each step.

## Step 1: Receive inputs

The operator collects the following before the pipeline starts:

| Input | Source | Format |
|---|---|---|
| Figma file URL | Designer / client | Full URL with file key |
| Section node IDs | Operator selects in Figma | List of `<file-key>:<node-id>` pairs |
| Brand identity | Brand-guidelines doc, designer interview, or `_reference/brand-token-extraction.md` output | Filled brand-identity block |
| Verbatim copy | Client copy document, brand voice doc | One block of text per section |
| Asset destination | Operator | Supabase URL + bucket + path |

### Figma node-selection checklist

Operators new to Figma extraction often produce incomplete section lists or miss assets that the design depends on. Walk this checklist for every page before declaring the section node IDs complete:

1. **Start from the artboard root.** In Figma, click the empty canvas next to the page mockup and use the layers panel (left side) to see the page's top-level children. These are the candidate section frames.
2. **Top-level section frames only.** Each section in the section_node_ids list should be a Frame (not a Group) directly under the artboard. If a section is wrapped in a Group or auto-layout container, the immediate parent Frame is the right node ID; if there is no parent Frame, ask the designer to add one rather than extracting a Group.
3. **Sections you might miss.** Walk top-to-bottom and confirm each of these candidates is in the list or explicitly excluded:
   - Sticky/floating bars (announcement bar at top, mobile sticky CTA at bottom)
   - Header / navigation
   - Footer (always last; easy to forget)
   - Hidden states. Tabs, accordions, dropdowns: the default-visible state and the alternate states. Capture each as a separate node ID OR document the state machine in the section's brief.
   - Modal/overlay components (login modal, cart drawer, age gate). These are typically rendered on a separate page in the Figma file.
   - Off-canvas mobile variants if the file has separate mobile artboards.
4. **Repeated components.** If a card or testimonial repeats with different content across sections, the section node IDs go to the parent section, not to each card instance. The card's structural definition lives once; the content goes per-section.
5. **Variant states.** For components with variants (button states, form states), capture all variants. The intent-spec then describes the state machine in prose ("primary CTA button: idle, hover, pressed, disabled states").
6. **Off-canvas assets.** Some Figma files include assets (logos, icons, badges) parked off-canvas as a "design system" sheet rather than placed in their consumed sections. Search the file's pages for these and include them when their asset hashes appear in `Figma:get_design_context` output.

If the designer cannot point to a clear set of section frames, the file is not Mode 1 ready. Either ask for a designer pass to add proper frames, or escalate to the operator for a manual section enumeration.

**Gate before Step 2.** Confirm:

- Figma file is accessible (you can open the URL in a browser and see the artboard).
- Every section node ID renders an actual frame in Figma (not a layer or a group with no defined section).
- The node-selection checklist above is walked end-to-end. Specifically, the operator can name which sticky/floating elements, hidden states, modal/overlay components, and off-canvas asset sheets are included or explicitly excluded.
- Brand palette has hex codes for every locked role (background, text, accent gradient).
- Copy is verbatim from a source document, not improvised. No paraphrased TBD blocks.
- Supabase bucket exists and the anon/service key has upload permission (test with a single small file before Step 3).

If any of these fail, halt and resolve before proceeding.

## Step 2: Figma extraction

For each section node ID:

1. Run `Figma:get_metadata nodeId=<node>`. This returns the section's child elements with their bounds and types.
2. Run `Figma:get_design_context nodeId=<node>`. This returns the JSX export with Tailwind classes and asset hash references.
3. For each asset hash encountered in the JSX export, add a row to the asset manifest with:
   - `figma_node_id` = the node containing the asset reference
   - `figma_hash` = the hash from the JSX
   - `semantic_role` = the operator's description of what this asset is (e.g. "hero benefit card icon - card 1 - For Nights She Can't Walk After"). Operator authors this by reading the surrounding JSX context.
   - `parent_section` = which page section this belongs to (e.g. `Hero`)
   - `parent_component` = which sub-component (e.g. `HeroBenefitCards`)
   - `target_filename` = the filename to upload as (operator chooses, with semantic naming)
   - `target_url` = full Supabase public URL (constructed from base + filename)
   - `extension` = lowercase, no dot (`svg`, `png`, `webp`, `jpg`)
   - `optimize` (optional; default is `false`) - set `true` for raster assets that should run through ImageMagick optimization; omit, blank, or `false` skips optimization (SVG rows ignore this column either way)
4. After all sections are processed, run the duplicate-hash check: any `figma_hash` appearing in more than one row triggers a content-review flag (`_reference/asset-manifest-template.md` Bug 4 prevention). Confirm with the designer whether reuse is intentional.

Also extract brand identity at this step: pick a representative node and follow `_reference/brand-token-extraction.md`.

**Gate before Step 3.** Confirm:

- The manifest has one row per asset reference (no duplicates dropped, no rows missing).
- Every row has a `semantic_role` that an operator unfamiliar with the page could understand.
- Every `target_url` is constructed from the agreed Supabase base + bucket + path + filename.
- Duplicate-hash flags resolved with the designer (or explicitly accepted as intentional reuse).

If any of these fail, return to Step 2 for the affected rows.

## Step 3: Asset upload

1. Run `_reference/asset-upload-script-template.ps1` with parameters:
   - `-ManifestPath <path-to-asset-manifest.csv>`
   - `-SupabaseUrl <project URL>`
   - `-SupabaseBucket <bucket name>`
   - `-SupabasePath <bucket-relative path>`
   - `-AnonKey <upload key>`

2. **Preflight stage (runs first).** Before any download or upload, the script runs `Test-ManifestPreflight` over every manifest row. Preflight hard-fails (exit 1) on:
   - Required column blank (figma_hash, semantic_role, target_filename, target_url, extension)
   - Unsafe target_filename (path separators, `..`, absolute paths, disallowed characters)
   - Duplicate target_filename across rows
   - extension column not matching target_filename suffix
   - target_url not matching the computed public URL
   See `_reference/asset-manifest-template.md` "Validation contract" for the full checklist. If preflight fails, no downloads happen; fix the manifest and re-run from this step.

3. **Per-row stages (run only after preflight passes).** For each row: download from Figma localhost (required), optimize via ImageMagick (enhancement, may SKIP if not installed), WebP conversion (REQUIRED-FOR-WEBP rows; aborts the row if the source is not already WebP and cwebp is missing), upload to Supabase (required).

4. The script writes a `upload-results.csv` to the work directory with the public URL of each uploaded asset.

5. **Verify each URL manually.** Open at least 3-5 uploaded URLs in browser tabs to confirm the assets render. Pay attention to assets the script's enhancement stages may have changed (raster optimization should not visibly degrade quality).

**Gate before Step 4.** Confirm:

- Preflight passed (no PREFLIGHT [A]-[E] errors in the script output). If preflight failed, fix the manifest and re-run Step 3 from the top.
- Per-row script summary shows zero rows in states other than `UPLOADED` (no `DOWNLOAD_FAILED`, `WEBP_CONVERSION_FAILED`, `WEBP_TOOL_MISSING`, `UPLOAD_FAILED`).
- 3-5 spot-checked URLs render in a browser.
- Any preflight [F] duplicate-hash warnings are resolved with the designer (intentional reuse) or addressed by replacing duplicates with distinct assets and re-running.

If a URL 404s or the asset is visibly broken, return to Step 3 for that row.

## Step 4: Intent-spec generation

1. Open `_reference/intent-spec-template.md`.
2. Fill the brand-identity block from the Step 2 extraction output.
3. Fill the asset base URL from the Supabase upload destination.
4. For each section, write a section block describing structure, elements, asset references, and verbatim copy. Asset URLs come from the manifest (look up by `semantic_role`), never from memory (Bug 8 prevention).
5. Remove all `>` instructional commentary lines from the template.
6. Run the em-dash sweep on the filled spec (`_reference/em-dash-sweep.md`).
7. Run the pre-paste checklist at the bottom of `_reference/intent-spec-template.md`.

**Gate before Step 5.** Confirm:

- Every `[BRACKETED_PLACEHOLDER]` from the template has been replaced.
- Every asset URL in the spec exists in the manifest (`target_url` column).
- Body copy in every section is verbatim from the source content document (no AI paraphrasing).
- Section count in the page-structure block matches the number of section blocks below.
- `grep -nP '\x{2014}' <spec.md>` returns zero hits.

If any of these fail, fix and re-run the gate.

## Step 5: Lovable paste

1. Open a **fresh** Lovable project (not an existing project, even for the same brand). Reusing projects can introduce state from prior conversations that affects generation quality.
2. Paste the complete intent-spec as a single prompt.
3. Wait for Lovable's first generation to complete. Typical time: 60-180 seconds for a 12-section PDP.
4. Open the rendered preview in the default Lovable preview viewport.
5. Capture a screenshot of the page from above the fold to the bottom of the page (scroll if needed; multiple screenshots are fine).
6. Test at 2-3 viewports (mobile 360px, tablet 768px, desktop 1280px or 1440px). The Lovable preview has a viewport-resizer in its toolbar.

**Gate before Step 6.** Confirm:

- All N sections rendered (count them; check for omissions or merged sections).
- No console errors in the Lovable preview devtools that indicate broken asset references.
- Initial brand palette colors look correct at desktop (you are checking for catastrophic palette failures, not subtle drift).

If Lovable produced fewer sections than the spec called for, paste a follow-up prompt: "You built sections 1-N. Please continue with sections N+1 through M from the brief I sent." Do this once. If Lovable still drops sections after one follow-up, return to Step 4 and tighten the spec.

## Step 6: Visual review and remediation

1. Compare the screenshot side-by-side with the Figma source for each section.
2. List visual issues found. Categorize each as:
   - **Asset issue** (missing asset, wrong asset, broken URL) - usually a Pattern 1 prescriptive fix.
   - **Layout issue** (positioning, spacing, breakpoints) - sometimes Pattern 1, often escalates to Pattern 2.
   - **Brand identity issue** (wrong palette, wrong typography) - Pattern 1 with explicit citation of the locked brand block.
   - **Copy issue** (paraphrased, dropped, reordered) - Pattern 1, usually fixed by citing the verbatim source.
3. Apply the fix-up escalation ladder from `_reference/lovable-remediation-patterns.md`:
   - Pattern 1 (prescriptive) - one round max per issue, requires ground-truth verification precondition
   - Pattern 2 (screenshot + plain English) - one round max per issue
   - Pattern 3 (source-code diagnostic + operator disposition) - one round max per issue; the exit is SHIP-AS-IS, HAND-OFF, or SCOPE-DOWN (a new issue, not a 4th attempt on the original)
4. Run the em-dash sweep on every fix-up prompt before sending.
5. After each fix-up round, re-screenshot and re-review.

**Gate to declare the page shipped.** Confirm:

- Every visual issue identified in step 6.1 is resolved.
- No new issues introduced by fix-ups (regression check).
- Page tested at mobile / tablet / desktop without catastrophic breakage.
- Operator opens at least one client-facing share link and verifies it loads.

The UltimaPeak iteration shipped after 4 fix-up rounds (1 prescriptive multi-issue, 1 prescriptive narrower-scope, 1 prescriptive with asset upload included, 1 screenshot + plain English to resolve a layout issue that 2 prior rounds had failed on). A typical PDP should ship in 1-4 rounds.

## When to abort and ask for help

- The intent-spec exceeds 40KB. The spec is over-specified somewhere; tighten before retrying.
- Lovable's first generation drops more than 30% of sections. The spec structure may be hitting a Lovable input parser issue; re-split or re-format.
- A single issue has consumed all 3 escalation rungs (Pattern 1, 2, 3) and the operator cannot disposition it into any of the three valid Pattern 3 exits: **SHIP-AS-IS** (accept current state), **HAND-OFF** (manual fix outside Lovable), or **SCOPE-DOWN** (open a structurally different issue with a fresh 1+1+1 budget). If none of the three fits, the issue is outside this skill's iteration ceiling. Stop and escalate. A 4th attempt on the original issue under any framing is what this rule prevents.
- The brand palette in Lovable's output drifts from the spec by more than 2-3 hex points and a Pattern 1 prescriptive fix fails to lock it. Lovable's theme initialization is wrong; investigate the spec's brand-identity block.

In each of these cases, halt and escalate to the operator or the skill author rather than continuing to iterate.

## Cross-references

- `SKILL.md` for the high-level 6-step summary
- `_reference/intent-spec-template.md` for the spec template
- `_reference/asset-manifest-template.md` for the manifest format
- `_reference/asset-upload-script-template.ps1` for the upload script
- `_reference/lovable-remediation-patterns.md` for the fix-up escalation ladder
- `_reference/brand-token-extraction.md` for the brand identity block
- `_reference/em-dash-sweep.md` for the universal pre-output sweep
- `_examples/ultimapeak-pdp/README.md` for the canonical example of an end-to-end run
