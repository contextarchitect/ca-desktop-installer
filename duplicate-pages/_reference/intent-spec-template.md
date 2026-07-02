# Intent-spec template

This is the prose-brief template the operator fills in for each new Lovable page. It produces a single-paste prompt that Lovable converts to a production-quality implementation.

The structure follows the v7.1 baseline that shipped the skill's canonical test-pass PDP (see `_examples/ultimapeak-pdp/intent-spec.md` for the canonical filled-in example). That example predates the v3 asset transport, so treat it as a structural reference only, not a transport reference (its transport is covered by the historical banner in that directory's README).

**Fill in every `[BRACKETED_PLACEHOLDER]`. Remove the instructional commentary lines (the lines starting with `>`) before pasting to Lovable. Run the em-dash sweep (`_reference/em-dash-sweep.md`) before paste.**

---

# [BRAND_NAME] [PAGE_TYPE] - full page build

Build a complete [PAGE_TYPE] for [BRAND_NAME] [PRODUCT_NAME] based on the section-by-section brief below. The goal is a production-quality [PAGE_TYPE] that visually matches the brief's structure and brand identity while being responsive and polished at all viewports.

## How to use this brief

> This block is verbatim from v7.1. Keep it as the preamble for every Lovable paste. It sets the locked-vs-flexible contract before anything else.

- **Content (copy) and assets are fixed** - use the copy verbatim and use exactly the assets provided (attached files for Mode 1, listed temp URLs for Mode 2). Do not paraphrase the body copy in testimonials, FAQs, or any descriptive text. Do not substitute or omit any of the provided image assets.
- **Brand palette is fixed** - use the colors specified in the brand section.
- **Section structure and order are fixed** - all [N_SECTIONS] sections in the order listed, each containing the elements described.
- **Layout details are your call** - exact spacing, padding, margins, breakpoints, image aspect ratios, hover states, grid vs flex, semantic HTML choices, micro-animations. You know how to ship responsive production UIs at all viewports; do that. The brief describes WHAT each section contains and HOW it should feel; you decide HOW to implement it.

The Figma design this is based on was authored at [FIGMA_ARTBOARD_WIDTH]px desktop. The brief reflects its intent. Your implementation should look visually equivalent to the Figma intent at desktop, and respond gracefully on tablet and mobile.

## Brand identity

> Fill from `_reference/brand-token-extraction.md` output. Palette hex codes are exact, not described. Typography names exact, not approximate.

**Brand name:** [BRAND_NAME]
**Product:** [PRODUCT_NAME] ([PRODUCT_CATEGORY])
**Positioning:** [ONE_OR_TWO_SENTENCE_POSITIONING. Direct, voice-specific. Mention target audience.]

**Brand palette (fixed):**
- Primary background: `[#HEX]`
- Alternate body background: `[#HEX]`
- Primary text: `[#HEX]`
- Accent gradient: linear gradient from `[#HEX]` to `[#HEX]` (used for [LIST_USES])
- Dark gradient (if applicable): linear gradient from `[#HEX]` to `[#HEX]`
- Selected/active state tint: `[#HEX]`
- Warning red: `[#HEX]`
- Verified green: `[#HEX]`
- [ADD_OTHER_BRAND_SPECIFIC_TOKENS]

**Typography:**
- Primary font: [FONT_FAMILY] ([WEIGHTS_USED_FOR_HEADINGS], [WEIGHTS_USED_FOR_BODY])
- [HEADING_CASE_RULE: e.g. "Section titles and product names: often uppercase"]
- Body copy: [CASE_RULE], comfortable reading size, line-height ~1.5

**Visual treatment:**
- [BRAND_SPECIFIC_VISUAL_NOTES. e.g. "Dark gradient cards for premium sections", "Gold gradient for CTA emphasis", "Generous spacing".]

## Assets

Assets reach Lovable one of two ways, depending on the mode:

- **Mode 1 (Figma source):** the assets are attached to this prompt. Reference each one by its provided filename (matching the manifest `target_filename`). Lovable persists attached files in the project.
- **Mode 2 (competitor source):** the assets are provided as temporary URLs in the section briefs below. On first render, download each one and store it locally in the project - do not hot-link the temporary URL.

Where the brief says "asset to provide" without an attachment or URL, render a sensible image placeholder (gray box with appropriate aspect ratio and alt text) - the client will swap in real imagery after.

## Page structure - [N_SECTIONS] sections in this order

> One block per section. The block describes what elements exist, what assets they reference, what copy they render, and where they sit spatially. Spatial position is locked at the "LEFT/MIDDLE/RIGHT" or "ABOVE/BELOW" level, not at the pixel level.

### 1. [SECTION_NAME]

[Brief description of section's purpose and feel. Then a structural description of elements:]

- [ELEMENT_1: what it is, what asset it references (attached filename for Mode 1, temp URL for Mode 2), what copy it contains]
- [ELEMENT_2: ...]

[If the section has columns or a layout structure, name the columns LEFT/MIDDLE/RIGHT and describe what each contains. Do not specify column widths or grid templates; that is Lovable's call.]

### 2. [SECTION_NAME]

[Same pattern.]

### [N]. [SECTION_NAME]

[Continue for every section.]

## What I want you to optimize for

> Verbatim from v7.1. Keep this block locked.

- Visual equivalence to the brief at desktop
- Responsive quality at all viewports (360px-1920px+)
- Conversion (CTAs, [LIST_BRAND_SPECIFIC_CONVERSION_ELEMENTS])
- Brand consistency ([LIST_BRAND_SIGNATURE_ELEMENTS])
- Modern polish (hover states, transitions, [LIST_BRAND_SPECIFIC_ANIMATIONS])

## What I trust you to decide

> Verbatim from v7.1. Keep this block locked.

Spacing, padding, breakpoints, aspect ratios, grid vs flex, hover states, semantic HTML, font scale, micro-animation.

## What I do NOT want

> Verbatim from v7.1. Keep this block locked.

- Cropped or compressed hero images at any viewport
- Elements overflowing their containers
- Paraphrased or shortened body copy
- Substituting different images for the assets provided (attached files or listed URLs)
- Skipping or rearranging any of the [N_SECTIONS] sections
- Changing the brand palette
- Generic AI-looking filler text

Build all [N_SECTIONS] sections in this single pass. If the response would exceed your output limit, build sections 1-[SPLIT_INDEX] in this response and tell me you need a follow-up for sections [SPLIT_INDEX+1]-[N_SECTIONS].

---

## Pre-paste checklist for the operator

Before pasting this filled-in template to Lovable:

- [ ] Every `[BRACKETED_PLACEHOLDER]` replaced with a real value or explicitly marked "asset to provide"
- [ ] All `>` instructional commentary lines deleted
- [ ] Mode 1: every referenced asset is exported and its filename matches the manifest `target_filename` (`_reference/asset-manifest-template.md`), assigned to an attachment batch of at most 10 per prompt (the initial prompt attaches up to 10 alongside the spec; follow-up prompts attach the remainder). The Step 5 gate in `_reference/operator-workflow.md` verifies every manifest row's asset was attached across the initial plus follow-up prompts.
- [ ] Mode 2: every asset URL in the brief is a live temporary URL carrying a download-and-store instruction
- [ ] No paraphrased copy: every body paragraph is verbatim from the operator's source content document
- [ ] Em-dash sweep run: `grep -nP '\x{2014}' <filled-spec.md>` returns zero hits (full procedure in `_reference/em-dash-sweep.md`)
- [ ] Section count in the page-structure block matches the actual number of section blocks below it
- [ ] Brand palette hex codes match `_reference/brand-token-extraction.md` output, not improvised values

## Notes on length

The full v7.1 reference intent-spec was ~28KB across 12 sections (see `_examples/ultimapeak-pdp/intent-spec.md`). Lovable's chat input accepts up to roughly 50KB comfortably, so a typical PDP fits in a single paste. If the filled spec exceeds 40KB, consider whether sections can be tightened (verbatim copy is non-negotiable; structural prose can be reduced).

## Notes on section-block density

Density correlates with first-pass quality. Sparse blocks ("hero with image and CTA") produce sparse output. Dense blocks (every element listed, every asset paired with its semantic role, spatial positioning explicit) produce production-quality output. Err on the side of density. The v7.1 baseline (see `_examples/ultimapeak-pdp/intent-spec.md`) averages 80-150 words per section block; sections with multiple sub-components (hero, comparison tables) can run 200-400 words.

## Notes on what stays out of the spec

- Tailwind class names. The spec describes intent in prose; Lovable picks classes.
- Pixel measurements. The Figma artboard width is mentioned once (as Lovable's reference for desktop intent); column widths, gap values, font sizes are not specified.
- Component file names. Lovable decides the React component structure.
- State management or interactivity logic. The spec describes the surface ("tabs cycle through 3 panels"), not the implementation ("useState hook with index 0").
