---
name: figma-to-lovable
version: "1.0.0"
description: >
  Convert a Figma design file (typically a PDP, landing page, or marketing site)
  into a production-quality Lovable.dev implementation. Use this skill whenever
  the user wants to ship a Figma design to Lovable, generate an intent-spec from
  Figma, build a brand site from a designer mockup, or rebuild an existing
  competitor's page in a branded variant. Trigger on phrases like: 'build this
  Figma in Lovable', 'convert Figma to Lovable', 'ship this design', 'turn this
  mockup into a working site', 'rebuild this page in our brand', 'Lovable intent
  spec for [Figma file]', 'PDP from Figma', 'figma to lovable', 'lovable from
  figma'. Reads Figma node IDs as input and produces a prose intent-spec prompt
  for Lovable plus an asset-upload script and asset manifest.
---

# figma-to-lovable Skill (Mode 1)

## Purpose

Convert a Figma design file into a Lovable.dev implementation by shipping Lovable a prose intent-spec (what each section contains, what brand identity, what verbatim copy) rather than verbatim JSX. Lovable owns implementation details (spacing, breakpoints, image cropping, semantic HTML); the skill owns intent, brand, copy, and asset URLs.

This is **Mode 1**: Figma source as the design ground truth. Mode 2 (competitor screenshot conversion + brand-adapted image generation) is a separate skill that shares this skill's Lovable interaction layer but has a different upstream pipeline.

## When to use this skill

Trigger when an operator wants to:

- Ship a Figma design as a Lovable.dev page (PDP, landing page, marketing site)
- Generate a Lovable intent-spec from a Figma file
- Build a branded variant of a competitor's page where the competitor's design is the layout reference
- Rebuild any existing Figma-authored design as a Lovable production page

Trigger phrases that should fire this skill:

- "build this Figma in Lovable"
- "convert Figma to Lovable"
- "ship this design to Lovable"
- "turn this mockup into a working site"
- "rebuild this page in our brand"
- "Lovable intent spec for [Figma URL]"
- "PDP from Figma"
- "figma to lovable"
- "lovable from figma"

## When NOT to use this skill

- Building a funnel page (advertorial, listicle, or one of the 7 alternative funnel formats) - use `funnel-builder` instead. Funnel pages are copy-first, image-generated-via-Nano-Banana, and deploy via the Funnel Factory pipeline or a separate Lovable prompt path. They do not start from a Figma design file.
- Building a long-form static ad (in-feed Facebook advertorial body) - use `long-form-static-builder`. That skill produces ad primary text, not a landing page.
- Generating images from scratch - image generation belongs in `ad-style-generator` or the funnel-builder Nano Banana pipeline. This skill consumes asset URLs that already exist; it does not generate images.
- Building a Lovable page where there is no Figma source - if the design has not been authored in Figma, Mode 1 has no input to extract. Wait for Mode 2 (screenshot-driven, deferred to a follow-up session).

## Inputs required

The operator collects these before the pipeline runs:

1. **Figma file URL.** The full Figma URL with the file key, e.g. `https://www.figma.com/design/<file-key>/<file-name>`.
2. **Section node IDs.** A list of top-level frame node IDs identifying each section of the page (announcement bar, header, hero, stats band, etc.). The operator selects these by clicking each section in Figma and copying the node ID from the URL or right-click menu. Typical PDP has 10-15 sections.
3. **Brand identity inputs.** Brand name, product name, positioning sentence, palette (hex codes), typography (font family + weights), brand voice notes. See `_reference/brand-token-extraction.md` for how to source these from Figma variables when available.
4. **Section-by-section verbatim copy.** Every paragraph of body text the page renders. The skill never paraphrases (this is Bug 4 / Bug 5 prevention).
5. **Asset destination.** A Supabase Storage bucket + path where uploaded assets will live. The intent-spec references assets by their public Supabase URL.

If any input is missing, halt and ask. Do not infer copy from Figma element labels (those are designer scratch text), and do not guess at brand palette from screenshot pixels.

## Operator workflow (6-step pipeline)

This is the end-to-end procedure from Figma URL to client-deliverable Lovable preview. Full step-by-step is in `_reference/operator-workflow.md`. Summary:

1. **Receive inputs** (above) and verify each before proceeding.
2. **Figma extraction.** Loop the section node IDs. For each, call `Figma:get_metadata` to enumerate elements, then `Figma:get_design_context` for the JSX export. Capture every asset hash and pair it with a semantic role. Build the asset manifest at this step (one row per asset). See `_reference/brand-token-extraction.md` for brand identity extraction.
3. **Asset upload.** Parameterize `_reference/asset-upload-script-template.ps1` with the manifest path and Supabase destination. Run the script. Verify each uploaded URL in a browser tab.
4. **Intent-spec generation.** Fill `_reference/intent-spec-template.md` with brand identity, asset base URL, per-section blocks. Body copy is verbatim from input #4. Asset URLs come from the manifest, never reconstructed from memory (Bug 8).
5. **Lovable paste.** Open a fresh Lovable project. Paste the complete intent-spec as a single prompt. Wait for first generation. Capture a screenshot of the rendered page.
6. **Visual review and remediation.** Identify visual issues. Apply the fix-up escalation ladder in `_reference/lovable-remediation-patterns.md`: one prescriptive attempt → screenshot + plain English → source-code diagnostic. Halt to operator if unresolved after diagnostic.

Each step ends with a "verify before next step" gate. Audits go stale (validation discipline rule 3 in `_tests/figma-to-lovable-mode-1-findings.md`); refresh state immediately before executing each step.

## Design philosophy

**Ship intent, not implementation.** The skill describes WHAT each section contains and HOW it should feel. Lovable decides HOW to implement it.

This was validated by the UltimaPeak PDP test pass (see `_tests/figma-to-lovable-mode-1-findings.md`). Two approaches were tested:

- **Approach A (rejected): ship verbatim Figma JSX with posture-instruction blocks forbidding rewrites.** Lovable's AI rewrites pasted JSX based on its own design preferences regardless of how loudly the prompt forbids it (Bug 5). Required 6 prompts per page, multiple rounds of evidence-based remediation, and produced buggy interfaces (cropped images, fixed-pixel column math that only worked at the Figma artboard width).

- **Approach B (validated): ship a prose intent-spec describing structure, brand identity, and copy, while letting Lovable own implementation details.** Required 1 prompt per page. Lovable's first generation produced 80%+ production quality. Remaining issues fixable in 1-4 targeted follow-up prompts.

**The skill produces intent-specs. It does not produce JSX.** When the skill describes a hero section, it says "two-column layout on desktop, stacked on mobile, with a product gallery on the left and product info on the right." It does not specify `flex-row` vs `grid grid-cols-2`, the breakpoint, the gap, or the column widths. Those are Lovable's call.

## Locked vs flexible

This is the contract between the skill and Lovable. Both directions are explicit.

| The skill controls (locked) | Lovable controls (flexible) |
|----------------------------|-----------------------------|
| Brand palette (specific hex codes) | Exact spacing values |
| Typography (font family, weights) | Padding / margin / gap |
| Section order and count | Breakpoint choice (`md:` vs `lg:` vs `xl:`) |
| Per-section element list (what exists) | Aspect ratios for images |
| Verbatim body copy and headings | Image cropping (`object-cover` vs `object-contain`) |
| Asset URLs (Supabase paths) | Hover and active states |
| Spatial positioning of major elements (LEFT/MIDDLE/RIGHT) | Semantic HTML tag choice |
| Brand voice tone notes | Font scale within type system |
| What the skill optimizes for (visual equivalence, responsive, conversion, brand) | Micro-animations and transitions |
| What the skill does NOT want (cropping, overflow, paraphrasing, palette changes) | Grid vs flex implementation choice |

The skill author does not override Figma-authored visual properties on author intuition (Bug 3). The skill author does not reconstruct asset role-to-file mappings from memory (Bug 8).

## Em-dash sweep rule

Universal CA rule applied to every artifact this skill produces:

- After authoring any artifact (intent-spec, fix-up prompt, asset manifest, brand block, README), run `grep -nP '\x{2014}' <file>` and verify zero hits.
- Replace any em-dash with a hyphen `-` or a period `.` depending on context.
- This is a pre-output gate. No artifact ships with em-dashes.

Procedure detail in `_reference/em-dash-sweep.md`.

## Fix-up escalation ladder

When Lovable's output has visual issues, escalate in this order. Do not skip levels. Do not iterate the same level more than once for the same issue.

1. **Prescriptive fix prompt.** When the issue has a clear CSS or structural fix (missing logo asset, wrong icon assignment, explicit pixel dimensions for an SVG) AND the operator has verified the fix against Figma source or Lovable code readback. One round only. If the issue persists after one round, escalate to Pattern 2. Do not write a second prescriptive prompt for the same issue.

2. **Screenshot + plain-English prompt.** When prescriptive failed, when the issue is visual and hard to articulate in CSS terms, when the operator cannot verify against ground truth, or when the operator suspects their initial hypothesis was wrong. Attach the screenshot, describe what is wrong in plain English. This pattern was validated by the UltimaPeak Round 4 chip-width-wrap fix that three prior prescriptive rounds had failed to resolve (Bug 9). One round only. If the issue persists, escalate to Pattern 3.

3. **Source-code diagnostic + operator disposition.** When prescriptive and screenshot have both failed, or when Lovable claims to have applied a fix that is not reflected in the rendered output. Ask Lovable to paste the file contents verbatim with no modifications. Do not propose fixes in the diagnostic prompt. After Lovable pastes the code, the operator picks one of three dispositions and the issue exits the ladder: **SHIP-AS-IS** (accept current state), **HAND-OFF** (manual fix outside Lovable), or **SCOPE-DOWN** (open a new issue with corrected framing - this counts as a fresh 1+1+1 budget on a structurally different issue, not a 4th attempt on the original).

**Iteration ceiling per issue: 1 + 1 + 1, ending in disposition.** One prescriptive attempt. One screenshot + plain-English attempt. One source-code diagnostic attempt ending in operator disposition (SHIP-AS-IS / HAND-OFF / SCOPE-DOWN). There is no attempt 4 on the same issue. A SCOPE-DOWN opens a new issue with its own 1+1+1 budget. A second prescriptive attempt on the same issue is the Bug 9 failure mode the ladder exists to prevent.

Full patterns and templates in `_reference/lovable-remediation-patterns.md`.

## References

- `_reference/intent-spec-template.md` - the prose-brief template the operator fills in for each new page.
- `_reference/asset-manifest-template.md` - the CSV/JSON format for the asset-role-to-filename mapping. Authored at extraction time; the prompt generator reads from it (Bug 8 prevention).
- `_reference/asset-upload-script-template.ps1` - parameterized PowerShell script for downloading from Figma localhost and uploading to Supabase, with graceful degradation on optional optimization tools (Bug 6 prevention).
- `_reference/lovable-remediation-patterns.md` - the three documented fix-up patterns (prescriptive, screenshot+English, source-code diagnostic) with templates and the iteration ceiling rule (Bug 9 codified).
- `_reference/brand-token-extraction.md` - how to pull brand palette, typography, and tokens from Figma variables for the intent-spec brand block.
- `_reference/em-dash-sweep.md` - the universal pre-output em-dash ban procedure.
- `_reference/operator-workflow.md` - the end-to-end 6-step procedure, expanded with "verify before next step" gates.

## Examples

- `_examples/ultimapeak-pdp/` - the canonical reference implementation. UltimaPeak Performance Gummies PDP (12 sections, 50+ assets) shipped to client in one Lovable paste + 4 fix-up rounds. Contains the full v7.1 intent-spec, the asset-upload script as it actually ran, all 4 fix-up prompts (one prescriptive round per file), the diagnostic-source-code-paste prompt, and a README mapping the iteration arc to the 9 bugs in the findings doc.

## Test artifact reference

The findings doc that drove this skill's design is at `_tests/figma-to-lovable-mode-1-findings.md`. It documents the 9 bugs observed during the UltimaPeak iteration and the validation discipline rules that survive both approaches. Read it as the ground-truth context for why this skill is structured the way it is. The 9 bugs map to skill structure as follows:

- Bug 1 (page-structure carries forward across split prompts) - prevented by Approach B's single-paste design. No split prompts.
- Bug 2 (trusting tool error messages without verification) - codified in `_reference/operator-workflow.md` "verify before next step" gates.
- Bug 3 (skill author hallucinating bugs) - codified in `_reference/lovable-remediation-patterns.md` source-code-diagnostic pattern (read actual state before proposing fixes).
- Bug 4 (duplicate asset name detection) - surfaced in `_reference/asset-manifest-template.md` as a content-review flag, not silent deduplication.
- Bug 5 (Lovable rewrites pasted JSX) - prevented by Approach B itself. The skill ships intent, not JSX, so there is nothing for Lovable to rewrite.
- Bug 6 (optimization steps must degrade gracefully) - codified in `_reference/asset-upload-script-template.ps1` required-vs-enhancement stage classification.
- Bug 7 (responsive breakpoint must match artboard width) - superseded by Approach B (Lovable owns breakpoints).
- Bug 8 (asset role-to-file mappings reconstructed from memory get reversed) - prevented by `_reference/asset-manifest-template.md` discipline (read from manifest, never from memory).
- Bug 9 (screenshot + plain English beats prescriptive CSS for visual fixes) - codified as level 2 of the fix-up escalation ladder in `_reference/lovable-remediation-patterns.md`.

## What this skill does NOT do

- Does not generate images. Image generation lives in `ad-style-generator` or the funnel-builder Nano Banana pipeline.
- Does not push or deploy to a production domain. Lovable's preview is the artifact; deployment is a separate workflow.
- Does not handle multi-page sites with shared navigation. Current scope is single-page PDPs and landing pages.
- Does not run Figma extraction or Supabase uploads autonomously. The skill produces specs and scripts; the operator runs them.
- Does not paraphrase body copy. Every paragraph is verbatim from the operator's input.
- Does not build Mode 2 (competitor screenshot conversion + brand-adapted image generation). Mode 2 is a separate skill in a separate session.
