---
name: duplicate-pages
version: "2.0.1"
description: >
  Duplicate any high-converting page for a brand - either from a Figma design
  file the brand controls (Mode 1) or from a competitor's live page (Mode 2).
  Mode 1: brand has a Figma file and wants it built in Lovable. Mode 2: brand
  sees a competitor page that works and wants to transpose its layout and
  persuasion architecture onto their own product. Two variants of Mode 2:
  Mode 2A (brand already sells this product, competitor has a better page) and
  Mode 2B (brand does not sell this product yet, transposition doubles as a
  pre-launch demand test). All modes produce a Lovable intent-spec as the
  primary artifact. Trigger on: 'duplicate this page', 'build this in Lovable',
  'rebuild this competitor page in our brand', 'transpose this competitor PDP',
  'copy this page structure for our product', 'build a page like [URL]',
  'convert Figma to Lovable', 'ship this design', 'we want a page like
  [competitor]', 'mock a new product page', 'competitor page transposition',
  'figma to lovable', 'PDP from Figma'.
---

# Duplicate Pages Skill

## What this skill does

Duplicate any high-converting page for a brand. The job is always the same:
there is a page somewhere that works, and you want a version of it for your
brand. This skill handles two input sources:

**Mode 1 - Figma source:** The brand has a Figma design file. The page has
been designed; it needs to be built. The Figma file is the design ground truth.

**Mode 2 - Competitor source:** The brand has identified a competitor's live
page that converts well. There is no Figma file. The competitor's page is the
layout reference. The brand's identity, copy, and product replace everything
expressive. Two variants:
- **Mode 2A:** Brand already sells this product. Competitor has a better page.
  Transpose the layout onto the brand's existing product.
- **Mode 2B:** Brand does not sell this product yet. Transpose the layout AND
  mock the product before it exists. Functions as a demand test before real
  product development.

Both modes produce the same downstream artifact: a Lovable intent-spec that
ships in a single paste. Both modes use the same fix-up escalation ladder
after the first Lovable generation.

## Mode selection
Do you have a Figma file for this page?
├── YES → Mode 1. See _modes/mode-1.md.
└── NO → Continue.
│
Does the brand already sell this product?
├── YES → Mode 2A. See _modes/mode-2.md.
└── NO → Mode 2B. See _modes/mode-2.md.

If the operator is unsure which mode applies, ask one question: "Do you have
a Figma design file, or are you working from a competitor's live page?"

## Shared design philosophy

Both modes are built on the same foundational principle:

**Ship intent, not implementation.** The skill describes WHAT each section
contains and HOW it should feel. Lovable decides HOW to implement it.

Validated by the Mode 1 UltimaPeak PDP test (Approach B). Two approaches were
tested on the same page. Approach A (ship verbatim JSX with instructions
forbidding rewrites) required 6 prompts, produced cropped images and
fixed-pixel layout bugs. Approach B (prose intent-spec, Lovable owns
implementation) required 1 prompt, produced 80%+ production quality, remaining
issues fixed in 1-4 targeted follow-up prompts. The skill ships intent-specs.
It does not ship JSX.

## Shared locked-vs-flexible contract

This contract applies to every Lovable prompt this skill produces, in both
modes.

| Skill controls (locked) | Lovable controls (flexible) |
|------------------------|----------------------------|
| Brand palette (specific hex codes) | Exact spacing values |
| Typography (font family, weights) | Padding / margin / gap |
| Section order and count | Breakpoint choice |
| Component type per section | Aspect ratios for images |
| Component count per section | Image cropping treatment |
| Layout orientation per section | Hover and active states |
| Verbatim copy (operator-approved) | Semantic HTML tag choice |
| Asset URLs | Font scale within type system |
| What the skill explicitly prohibits | Micro-animations |
| Spatial positioning of major elements | Grid vs flex implementation |

The "Do not" block at the end of every intent-spec is as important as the
content. Explicitly prohibit the defaults Lovable would choose if left open.

## Shared fix-up escalation ladder

When Lovable's first generation has visual issues, escalate in this order.
Do not skip levels. Do not iterate the same level more than once per issue.

**Level 1 - Prescriptive fix prompt.** When the issue has a clear structural
fix and the operator has verified the fix against the source (Figma node or
Layer B component table). One round only per issue. If it persists, escalate.

**Level 2 - Screenshot + plain-English prompt.** When prescriptive failed, or
the issue is visual and hard to articulate in CSS. Attach the screenshot,
describe what is wrong in plain English. One round only. If it persists,
escalate.

**Level 3 - Source-code diagnostic + operator disposition.** Ask Lovable to
paste the file contents verbatim. Do not propose fixes. After seeing the code,
operator picks one of three dispositions:
- **SHIP-AS-IS:** accept current state, move on.
- **HAND-OFF:** fix manually outside Lovable.
- **SCOPE-DOWN:** reframe as a new issue with its own 1+1+1 budget.

**Iteration ceiling: 1+1+1 per issue, ending in disposition.** No fourth
attempt on the same issue. A SCOPE-DOWN is not attempt 4; it is a new issue.

Full templates in `_reference/lovable-remediation-patterns.md`.

## Shared em-dash sweep rule

Universal CA rule applied to every artifact this skill produces. After
authoring any intent-spec, copy block, fix-up prompt, or state doc, verify
zero em-dash glyphs before delivering.

Sweep command: `grep -nP '\x{2014}' <file>`. Expected: zero hits.

Note: a pattern that ORs the em-dash glyph with `--` produces false positives
on YAML frontmatter delimiters and Markdown table rows. Scope the sweep to the
em-dash glyph (U+2014) only.

Replace any em-dash with a hyphen or period depending on context.

Procedure detail in `_reference/em-dash-sweep.md`.

## When NOT to use this skill

- Building a funnel page (advertorial, listicle, PAS, AIDA, or any of the
  7 funnel formats) - use `funnel-builder`. Funnel pages are copy-first,
  image-generated via Nano Banana, and deploy via a Lovable implementation
  prompt. They do not
  start from a design source.
- Building a long-form static ad - use `long-form-static-builder`.
- Generating ad images from scratch - use `ad-style-generator` or the
  funnel-builder Nano Banana pipeline.

## Reference files

All reference files are shared across both modes.

- `_reference/intent-spec-template.md` - prose-brief template for Lovable.
- `_reference/asset-manifest-template.md` - asset role-to-filename mapping format.
- `_reference/asset-upload-script-template.ps1` - PowerShell upload script for Mode 1.
- `_reference/lovable-remediation-patterns.md` - fix-up ladder templates.
- `_reference/brand-token-extraction.md` - how to extract brand tokens from Figma variables.
- `_reference/em-dash-sweep.md` - em-dash sweep procedure.
- `_reference/operator-workflow.md` - Mode 1 end-to-end 6-step procedure.

## Examples and test artifacts

- `_examples/ultimapeak-pdp/` - canonical Mode 1 reference implementation.
- `_tests/mode-2b-dogfood-ultimapeak.md` - Mode 2B dogfood run, findings S1-S20.
