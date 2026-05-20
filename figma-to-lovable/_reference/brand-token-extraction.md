# Brand token extraction from Figma

How to extract brand identity (palette, typography, semantic tokens) from a Figma file into the brand-identity block of the intent-spec template.

## When the brand has Figma variables

Modern Figma files define brand tokens as variables (color tokens, typography tokens). When available, these are the source of truth - read them directly rather than eyeballing pixel values from screenshots.

### Step 1: identify a representative node

Pick any node in the design that uses the brand's typical colors and typography. The hero section is usually a good choice because it includes the primary background, primary text, and accent color.

### Step 2: call `get_variable_defs`

```
Figma:get_variable_defs nodeId=<representative_node_id>
```

This returns the variable definitions in scope at that node: variable name, type (color / typography / spacing), and resolved value. For colors, the value is a hex code or RGBA. For typography, it is a font family + weight + size.

### Step 3: call `get_design_context` on the page artboard root

```
Figma:get_design_context nodeId=<artboard_root_node_id>
```

This returns the JSX export with Tailwind class names. Compare the actual class usage against the variable defs to confirm which variables are in active use vs defined-but-unused.

### Step 4: extract semantic colors

From the variable defs, identify each of these roles. The Figma variable names usually map directly:

- **Primary background** (the dominant light background color). Look for variables named `bg-primary`, `bg-cream`, `surface-default`, etc.
- **Alternate body background** (a secondary background used on alternating sections). Look for `bg-secondary`, `bg-alt`, `surface-elevated`, etc.
- **Primary text** (near-black, the default body text color). Look for `text-primary`, `fg-default`, `ink-primary`.
- **Accent gradient** (the brand's signature gradient, used for CTAs, badges, highlights). Often a 2-stop gradient. Capture the start and stop hex codes. Look for `accent-gradient-start`, `accent-gradient-stop`, or paired variables like `gold-light` + `gold-dark`.
- **Dark gradient** (premium card backgrounds, dark sections). Capture the 2 stops. Look for `dark-gradient-start`, `dark-gradient-stop`, `surface-dark`.
- **Selected/active state tint** (the lightly-tinted background used on selected bundle cards, active tabs, etc.). Look for `state-selected`, `selected-bg`.
- **Warning red** (error states, alerts). Look for `error`, `warning`, `red-warning`.
- **Verified green** (success, verified badges). Look for `success`, `green-verified`.

### Step 5: extract typography

From the variable defs and the artboard JSX:

- **Primary font family.** Look at headings and body text class strings. Capture the exact family name as it appears in Figma (e.g. `Figtree`, `Inter`, `Manrope`). Note any fallback fonts in the Figma variable definition.
- **Weights used for headings.** Bold (700), extra-bold (800), or black (900). Capture the specific weight as a number.
- **Weights used for body.** Regular (400) or semibold (600). Same.
- **Case rules.** Inspect Figma's text-transform usage. Section titles often render uppercase in supplement / direct-response brands; body copy is usually sentence case. Capture as a prose rule: "Section titles and product names: often uppercase. Body copy: sentence case."

### Step 6: write the brand identity block

Fill the `## Brand identity` section of `_reference/intent-spec-template.md` with the extracted values. Hex codes are exact, not described in prose. Typography names are exact, not approximate.

## When the brand does NOT have Figma variables

Older Figma files or files imported from other tools may not have variables defined. In this case:

### Step 1: sample colors directly from rendered nodes

Use Figma's eyedropper or the right-panel Fill property on individual elements. Capture hex codes verbatim. Do not eyeball from a screenshot; Figma's rendered values are authoritative.

### Step 2: inspect typography on individual text nodes

Click each text element and read the font family, weight, size from the right-panel Text property.

### Step 3: cross-reference with `get_design_context` output

The JSX export will show Tailwind class hints (`text-[#1a1a1a]`, `font-bold`). Use these as a sanity check; the rendered Fill/Text values are still the source of truth when they differ.

### Step 4: flag any token gaps to the operator

If the file is missing a token role (e.g. no defined accent gradient, just one-off gold buttons), flag it. The operator should confirm with the designer or stakeholder rather than improvising a value.

## What NOT to do

- **Do not extract palette from a screenshot.** Screenshot color values are post-rendering (anti-aliasing, JPEG compression, monitor color profile). The Figma source is authoritative.
- **Do not guess at gradient stops.** If a gradient has multiple stops in Figma but the operator captures only 2, the rendered result drifts. Capture every defined stop.
- **Do not paraphrase typography names.** "Looks like a geometric sans" is not a font family. The exact name (Figtree, Inter, Manrope, etc.) goes into the spec; the spec is what Lovable receives.
- **Do not override Figma-authored visual properties on operator intuition.** Bug 3 in the findings doc. If the Figma source says `font-bold`, that is the source of truth even if the operator thinks `font-semibold` would look better.

## Output format

The brand identity block in the intent-spec has this shape. Hex codes, font names, and positioning text are filled in for the specific brand. For a filled real-brand example, see `_examples/ultimapeak-pdp/intent-spec.md` under its `## Brand identity` section.

```markdown
**Brand name:** [BRAND_NAME]
**Product:** [PRODUCT_NAME] ([PRODUCT_CATEGORY])
**Positioning:** [ONE_OR_TWO_SENTENCE_POSITIONING. Mention target audience. Voice cues that distinguish the brand.]

**Brand palette (fixed):**
- Primary background: `[#HEX]`
- Alternate body background: `[#HEX]`
- Primary text: `[#HEX]`
- Accent gradient: linear gradient from `[#HEX]` to `[#HEX]` (used for [LIST_USES])
- Dark gradient (cards, premium sections): linear gradient from `[#HEX]` to `[#HEX]`
- Selected/active state tint: `[#HEX]`
- Warning red: `[#HEX]`
- Verified green: `[#HEX]`

**Typography:**
- Primary: [FONT_FAMILY] ([WEIGHTS_USED_FOR_HEADINGS], [WEIGHTS_USED_FOR_BODY])
- [HEADING_CASE_RULE]
- Body copy: [BODY_CASE_RULE], comfortable reading size, line-height ~1.5

**Visual treatment:**
- [BRAND_SIGNATURE_VISUAL_NOTES_1]
- [BRAND_SIGNATURE_VISUAL_NOTES_2]
- [BRAND_SIGNATURE_VISUAL_NOTES_3]
```

This block lives at the top of the intent-spec (under `## Brand identity`) and is the source of truth for every color and font reference downstream in the spec. Lovable reads this block to set up the Tailwind theme; downstream section blocks reference colors by description ("dark gradient card", "gold accent") rather than by hex.

## Cross-references

- `_reference/intent-spec-template.md` for the brand-identity block placement in the full template
- `_examples/ultimapeak-pdp/intent-spec.md` for the canonical filled-in example
