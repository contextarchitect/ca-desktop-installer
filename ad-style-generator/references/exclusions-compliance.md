# Ad Creative Exclusions & Compliance Rules

Universal rules that apply to ALL ad styles across ALL brands. Brand-specific exclusions are loaded from the funnel configuration document.

---

## Visual Exclusions (All Styles)

**Product Placement:**
- Product NEVER appears in problem/negative/failure contexts
- Product appears ONLY in solution/positive/aspirational contexts
- Product label/branding must be clearly readable (preserve from reference image)
- No competing product bottles or packaging visible in any frame

**Integrity:**
- No misleading scales or proportions in data visualizations
- Before/after images must represent realistic outcomes
- No fabricated testimonials or invented statistics
- Scientific claims must be supportable

**Quality:**
- No halos or artifacts around cut-out elements
- Consistent line weights within single image
- Clean edges on all elements
- No low-resolution product images (use brand reference photography)

## Copy Exclusions (All Styles)

**Medical/Health Claims:**
- No diagnosis language ("you have X condition")
- No absolute cure promises ("eliminates," "cures," "guarantees results")
- Use qualifiers: "may help," "designed to support," "formulated for"
- Country-specific advertising regulations apply

**Competitor References:**
- Generic only ("other products," "traditional solutions")
- Never name specific competitor brands
- No side-by-side with identifiable competitor packaging

**Copywriting Guide Compliance (MANDATORY):**
- No em dashes in any ad copy
- No words from the brand's forbidden vocabulary list
- Contractions used naturally
- Sentence length varies (burstiness principle)
- "You" over "We" in all customer-facing copy

## Regional Compliance

### GCC Markets
- No specific city or country names (Dubai, UAE, Saudi, Qatar) unless brand explicitly permits
- Cultural sensitivity in imagery (modest presentation appropriate to market)
- Arabic text right-to-left if bilingual ads needed
- Religious and cultural holidays respected in seasonal content

### US/EU Markets
- FDA disclaimer requirements for health products
- GDPR considerations for testimonial usage
- FTC disclosure for sponsored/paid content
- Clear "ad" or "sponsored" labeling where required

### Universal
- No discriminatory imagery or copy
- Age-appropriate content for platform
- Accessibility considerations (contrast ratios, text size)

## Style-Specific Exclusions

### SCIENCE-FRIENDLY Exclusions
- No childish elements (sparkles, stars, hearts, rainbow colors)
- No medical gore or graphic imagery
- Maximum 8-10 labels per image (more = cognitive overload)
- No mocking or belittling the problem
- No conflicting emotions (character emotions must match narrative arc)
- No silliness that undermines credibility

### BA-EMOTION Exclusions
- No extreme negative imagery (graphic, disturbing, or shaming)
- Problem side must be empathetic, not humiliating
- No unrealistic transformation promises
- Desaturation should suggest challenge, not depression

### TESTIMONIAL Exclusions
- Never fabricate testimonials
- Demographics must match actual customer base
- Specific outcomes must be achievable/realistic
- No stock photography presented as "real customer"

### COMPARISON Exclusions
- No false equivalencies
- Features compared must be verifiable
- No misleading "missing feature" claims about alternatives
- Generic competitor labels only

### RESEARCH Exclusions
- Citations must be real and verifiable
- No cherry-picked statistics that misrepresent findings
- No fabricated study references
- Peer review claims must be accurate

## Nano Banana Exclusion Layer Templates

When writing the Exclusion Layer of any Nano Banana prompt, always include:

**Universal exclusions (include in every prompt):**
```
EXCLUDE: text errors, misspellings, blurry elements, low resolution,
watermarks, stock photo indicators, competing brand logos or packaging,
product in negative/problem context
```

**Add brand-specific exclusions from funnel config:**
```
EXCLUDE: [ethnicity restrictions], [background restrictions],
[environment restrictions], [any other brand-specific image rules]
```

**Add style-specific exclusions from the relevant style section above.**
