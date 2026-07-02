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

If any of these fail, halt and resolve before proceeding.

## Step 2: Figma extraction

The manifest is now a lightweight inventory: it records which asset fills which slot (semantic role to exported filename), not a CDN destination.

For each section node ID:

1. Run `Figma:get_metadata nodeId=<node>`. This returns the section's child elements with their bounds and types.
2. Run `Figma:get_design_context nodeId=<node>`. This returns the JSX export with Tailwind classes and asset hash references.
3. For each asset hash encountered in the JSX export, add a row to the asset manifest. The columns mirror `_reference/asset-manifest-template.md` exactly:
   - **Required** (validation A; a blank value fails the manifest):
     - `figma_hash` = the hash from the JSX
     - `semantic_role` = the operator's description of what this asset is (e.g. "hero benefit card icon - card 1 - For Nights She Can't Walk After"). Operator authors this by reading the surrounding JSX context.
     - `target_filename` = the filename to export as (operator chooses, with semantic naming)
   - **Recommended** (validation warns if blank):
     - `figma_node_id` = the node containing the asset reference
     - `parent_section` = which page section this belongs to (e.g. `Hero`)
     - `parent_component` = which sub-component (e.g. `HeroBenefitCards`)
   - **Optional** (default behavior applies if blank):
     - `notes` = free-form operator notes (duplicate flag, designer note)
     - `aspect_ratio` = native aspect ratio when known (feeds the placeholder-box fallback in the intent-spec template)
4. After all sections are processed, run the duplicate-hash check: any `figma_hash` appearing in more than one row triggers a content-review flag (`_reference/asset-manifest-template.md` Bug 4 prevention). Confirm with the designer whether reuse is intentional.

Also extract brand identity at this step: pick a representative node and follow `_reference/brand-token-extraction.md`.

**Gate before Step 3.** Confirm the manifest passes the validation contract in `_reference/asset-manifest-template.md`:

- **A. Schema completeness:** every row has non-blank `figma_hash`, `semantic_role`, and `target_filename`.
- **B. target_filename safety:** every `target_filename` is a leaf name only (no path separators, no `..`, no absolute path).
- **C. target_filename uniqueness:** no two rows share a `target_filename` (case-insensitive).
- **F. Duplicate figma_hash:** any `figma_hash` in more than one row is surfaced for designer content review (intentional reuse) - not fatal.
- One row per asset reference (no duplicates dropped, no rows missing); each `semantic_role` understandable to an operator unfamiliar with the page.

If any of A, B, or C fail, return to Step 2 for the affected rows.

## Step 3: Asset export

1. Name the design-folder slug for this page: kebab-case (e.g. `pdp-v1`). Create one local folder with that name to hold every exported asset for this design.

2. In Figma, select the layers/frames the manifest lists and export them via the native Figma Export panel. Choose the format the design uses per asset (SVG for vector; PNG, WebP, or JPG for raster). Export into the design folder from step 1.

3. **Resolve blank or duplicate layer names before exporting.** A blank layer name produces an invalid `..png` path, and duplicate names collide on export (one file overwrites another). Rename so every exported file has a distinct, safe filename that matches the manifest's `target_filename`. There is no CDN upload, no PowerShell, and no Supabase preflight in this step.

4. Confirm one exported file exists per manifest row. The exported files attach directly to the Lovable prompt in Step 5.

**Gate before Step 4.** Confirm:

- One exported file exists in the design folder for every manifest row.
- Every exported filename matches its manifest `target_filename` (safe leaf name: no path separators, no `..`).
- No two rows resolve to the same exported filename (duplicate names collide on export).
- Duplicate-hash flags resolved with the designer (intentional reuse) or replaced with distinct assets.

If any of these fail, return to Step 3 (or Step 2 for manifest fixes).

## Step 4: Intent-spec generation

1. Open `_reference/intent-spec-template.md`.
2. Fill the brand-identity block from the Step 2 extraction output.
3. For each section, write a section block describing structure, elements, asset references, and verbatim copy. Asset references use the exported filename from the manifest (look up by `semantic_role`), never from memory (Bug 8 prevention).
4. Remove all `>` instructional commentary lines from the template.
5. Run the em-dash sweep on the filled spec (`_reference/em-dash-sweep.md`).
6. Run the pre-paste checklist at the bottom of `_reference/intent-spec-template.md`.

**Gate before Step 5.** Confirm:

- Every `[BRACKETED_PLACEHOLDER]` from the template has been replaced.
- Every asset reference in the spec matches a `target_filename` in the manifest.
- Body copy in every section is verbatim from the source content document (no AI paraphrasing).
- Section count in the page-structure block matches the number of section blocks below.
- `grep -nP '\x{2014}' <spec.md>` returns zero hits.

If any of these fail, fix and re-run the gate.

## Step 5: Lovable paste

1. Open a **fresh** Lovable project (not an existing project, even for the same brand). Reusing projects can introduce state from prior conversations that affects generation quality.
2. Paste the complete intent-spec as a single prompt and attach the exported assets from the design folder. Lovable accepts at most 10 attachments per prompt: attach up to 10 alongside the intent-spec paste, then send follow-up prompt(s) attaching the remainder until every manifest row's asset has been attached. Lovable persists attached assets in the project.
3. Wait for Lovable's first generation to complete. Typical time: 60-180 seconds for a 12-section PDP.
4. Open the rendered preview in the default Lovable preview viewport.
5. Capture a screenshot of the page from above the fold to the bottom of the page (scroll if needed; multiple screenshots are fine).
6. Test at 2-3 viewports (mobile 360px, tablet 768px, desktop 1280px or 1440px). The Lovable preview has a viewport-resizer in its toolbar.

**Gate before Step 6.** Confirm:

- Every manifest row's asset was attached (initial prompt plus any follow-ups); none left un-attached.
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
- `_reference/asset-upload-script-template.ps1` deprecated (v3.0.0); Mode 1 no longer uploads to a CDN, assets attach directly to the Lovable prompt
- `_reference/lovable-remediation-patterns.md` for the fix-up escalation ladder
- `_reference/brand-token-extraction.md` for the brand identity block
- `_reference/em-dash-sweep.md` for the universal pre-output sweep
- `_examples/ultimapeak-pdp/README.md` for the canonical example of an end-to-end run
