# Ad Analysis Output Template

Every ad analysis follows this structure. Sections marked (gated) are produced only when `phase-4.5-angle-roadmap/schwartz-applied.md` exists for the brand.

## Output Format

```
AD ANALYSIS: [Ad name or identifier]

**Source:** [Where this ad came from: brand campaign, swipe file, competitor research]
**Format:** [Static image / Video transcript / Image + transcript / Long-form static]
**Date analyzed:** [YYYY-MM-DD]

---

## Summary Scorecard

🪝 **Hook style:** [Pattern name(s)] | §8.4 score: [N]/5 | Authority: [Classic / Doctor's Surprise / Doctor's Skepticism / Study/Research / no-authority]
📐 **Script structure:** [Format name from format-library.md] | Visual style: [Style #N from style-catalogue.md, image ads only]
🎯 **Core feeling:** [Vindication / Loss aversion / Betrayal / Desperation / Identity]
🎚️ **Awareness:** [Problem-aware / Solution-aware / Product-aware] (universal)
   [Schwartz: Unaware / Problem Aware / Solution Aware / Product Aware / Most Aware / Solution-Switching] (gated)
📊 **Sophistication:** Stage [1-5] (gated)
♻️ **Replicability:** [N]/5
📋 **Swipe-fitness:** [N]/5

---

## Section-by-Section Tagging

[Numbered list of ad sections / lines / panels with per-section tags. Format depends on input type.]

For text ads:
| Line | Content | Tags |
|------|---------|------|
| 1 | [hook line] | 🪝 [hook pattern] / §8.4: [score] / §8.5: [pass/partial/fail] |
| 2 | [body line] | 🎯 [core feeling cue] |
| ... | ... | ... |

For image ads:
| Element | Description | Tags |
|---------|-------------|------|
| Headline | [text] | 🪝 [hook pattern] / §8.4: [score] |
| Visual hook | [description] | 📐 [style number from catalogue] |
| Body copy | [text] | [tags] |
| ... | ... | ... |

---

## Identification-Before-Mechanism Compliance

Per `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`:

**Status:** [Pass / Partial / Fail]
**Narrator identity established at:** [line/element where narrator gets specific]
**Mechanism explanation begins at:** [line/element]
**Finding:** [if Fail or Partial, brief diagnosis]

---

## Discovery Story Detection (if applicable)

[Only include this section if the ad uses the Discovery Story Format from `copywriting-guide §8.6 The Discovery Story Format`]

| Stage | Present | Notes |
|-------|---------|-------|
| 1. Distress | [Yes/No/Implied] | [what scene shows the distress] |
| 2. Unusual decision | [Yes/No/Implied] | [what unusual decision was made] |
| 3. Discovery | [Yes/No/Implied] | [what was discovered] |
| 4. Mechanism reveal | [Yes/No/Implied] | [how the mechanism was revealed] |
| 5. Application | [Yes/No/Implied] | [how it was applied] |
| 6. Validation | [Yes/No/Implied] | [what validated the outcome] |
| 7. Crossroads | [Yes/No/Implied] | [the choice presented to the reader] |

---

## Replicability Diagnostics

**Score:** [N]/5
**Angle-specific elements:** [list elements that would need rewriting per angle]
**Brand-specific elements:** [list elements that would need rewriting per brand]
**Template-shaped elements:** [list elements that could be reused as-is]
**Recommendation:** [Can this be a template? On how many other angles?]

---

## Swipe-Fitness Diagnostics

**Score:** [N]/5
**Most distinctive element:** [the thing other brands could learn from]
**Category-specific dependencies:** [what other brands would need to translate]
**New pattern flag:** [Yes/No: is this a pattern worth adding to ContextArchitect's catalogues?]
**Recommended swipe file placement:** [hook-pattern collection / format example / style example / not-recommended]

---

## Cross-Variant Tagging (if applicable)

[Only include if the ad is part of a multi-variant test. Variant names match `_skills/angle-roadmap/SKILL.md` Step 5.5 exactly.]

**Lead Variant detected:** [Variant 1: First-Person Sufferer / Variant 2: First-Person Discoverer / Variant 3: Third-Person Authority or Witness]
**Multi-Bio-Marker Pivot:** [Symptom this variant leads with, if applicable]

---

## Findings and Recommendations

[Bullet list of:
- Structural strengths (what worked)
- Structural weaknesses (what could improve)
- Pattern observations (what this ad teaches about the brand or category)
- Templating recommendation (can this become a reusable pattern?)]
```

## Tagging Conventions

- **Use exact canonical names.** Format names match `../../funnel-builder/references/format-library.md` exactly. Style names match `../../ad-style-generator/references/style-catalogue.md` exactly. Variant names match `../../angle-roadmap/SKILL.md` Step 5.5 exactly. Section names from `copywriting-guide §8.x` carry full title at first use.
- **Cite the section number.** When referencing copywriting-guide §8.x, always include the section number AND the full title (per the §8.5 disambiguation discipline established in Session 9 for the Identification-Before-Mechanism Rule, and applied to all §8.x cross-references).
- **Universal-vs-gated separation.** Universal scoring (the 3-value awareness, replicability, swipe-fitness, core feeling, hook, format, style) always applies. Gated scoring (Schwartz 6-value awareness, sophistication 1-5, technique density, 38-method headline tagging) only applies when `phase-4.5-angle-roadmap/schwartz-applied.md` exists.
- **Missing inputs flag specific dimensions.** Static image only -> Hook Quality scored from headline + caption only; format detection limited; section-by-section tagging limited. Transcript only -> Visual style scoring unavailable. Note these gaps in the output.
- **Custom and Custom-visual are valid tags.** Not every ad fits the named formats and styles. Custom tags surface candidates for future format library / style catalogue additions.

## Input-Type Output Sub-Format

| Input type | Section-by-section tagging format | Visual style scoring | Format detection completeness |
|------------|-----------------------------------|----------------------|-------------------------------|
| Static image only | Element table (Headline / Visual hook / Body copy / CTA) | Yes (Style 1-14 from catalogue) | Limited (no narrative arc visible) |
| Video transcript only | Line table (numbered transcript lines) | Unavailable, mark "transcript-only" | Full (narrative arc readable from transcript) |
| Image + transcript | Both element + line tables | Yes | Full |
| Long-form static (image + Facebook in-feed primary text) | Line table for primary text + element table for image | Yes (typically REDDIT-NATIVE per `../../long-form-static-builder/references/image-spec.md`) | Full |
| Pure video without transcript | Mark all tagging as "transcript required for full analysis" and ask user to provide transcript | Hero-frame element table only | Unavailable |
