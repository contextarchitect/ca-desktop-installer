# Ad Analysis Output Template

Every ad analysis follows this structure. Sections marked (gated) are produced only when `schwartz-applied.md` exists at the brand repo root (alongside `angle-roadmap.md`).

## Output Format

```
AD ANALYSIS: [Ad name or identifier]

**Source:** [Where this ad came from: brand campaign, swipe file, competitor research]
**Format:** [Static image / Video transcript / Image + transcript / Long-form static / Transcript + visual brief (textual)]
**Date analyzed:** [YYYY-MM-DD]

---

## Summary Scorecard

🪝 **Hook style:** [Pattern name(s)] | Hook Quality: [N]/5 (§8.4) | Authority: [Classic / Doctor's Surprise / Doctor's Skepticism / Study/Research / no-authority]
📐 **Script structure:** [Format name from format-library.md] | Visual style: [Style #N from style-catalogue.md; image ads, or Transcript + visual brief (textual) flagged text-derived]
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
| 1 | [hook line] | 🪝 [hook pattern] / Hook Quality: [score]/5 (§8.4) / Ident-Before-Mechanism: [pass/partial/fail] (§8.5) |
| 2 | [body line] | 🎯 [core feeling cue] |
| ... | ... | ... |

For image ads:
| Element | Description | Tags |
|---------|-------------|------|
| Headline | [text] | 🪝 [hook pattern] / Hook Quality: [score]/5 (§8.4) |
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

## Visual-Layout Replicability (static image ads only)

Populated per the canonical Visual-Layout Replicability Contract in `../references/tagging-framework.md` Dimension 5B. This template provides the output shape only; the contract governs scoring, bucketing, and which sections are produced at each score.

**Visual-Layout Replicability Score:** [1-5, or not-produced reason per tagging-framework.md Dimension 5B]

**Visual Element Classification:** [full table, partial table, or not-produced reason, exactly per tagging-framework.md Dimension 5B]

| Element | Description | Bucket | Clone aspects | Replace aspects | Rationale | Contextual function / compositional role | Replacement guidance (role-level, target-agnostic) |
|---|---|---|---|---|---|---|---|
| [id] | [description] | [bucket per Dimension 5B] | [per Dimension 5B] | [per Dimension 5B] | [rationale] | [per Dimension 5B] | [per Dimension 5B] |

### Entangled Elements Excluded From Clone

[Populate or omit per tagging-framework.md Dimension 5B.]

| Element | Description | Why substitution fails | Do-not-clone note |
|---|---|---|---|
| [id] | [description] | [per Dimension 5B] | [per Dimension 5B] |

Not-produced reason: [per tagging-framework.md Dimension 5B]

---

## Distinctive Device

**`distinctive_device`:** [the single element that makes the ad work and must survive transposition]

---

## Swipe-Fitness Diagnostics

**Score:** [N]/5
**Distinctive element (swipe purposes):** [what other brands could learn from; for the load-bearing element that must survive transposition, see the `distinctive_device` output above]
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
- **Universal-vs-gated separation.** Universal scoring (the 3-value awareness, replicability, swipe-fitness, core feeling, hook, format, style) always applies. Gated scoring (Schwartz 6-value awareness, sophistication 1-5, technique density, 38-method headline tagging) only applies when `schwartz-applied.md` exists at the brand repo root.
- **Missing inputs flag specific dimensions.** Static image only -> Hook Quality scored from headline + caption only; format detection limited; section-by-section tagging limited. Transcript only -> Visual style scoring unavailable. Note these gaps in the output.
- **Custom and Custom-visual are valid tags.** Not every ad fits the named formats and styles. Custom tags surface candidates for future format library / style catalogue additions.

## Input-Type Output Sub-Format

| Input type | Section-by-section tagging format | Visual style scoring | Format detection completeness |
|------------|-----------------------------------|----------------------|-------------------------------|
| Static image only | Element table (Headline / Visual hook / Body copy / CTA) | Yes (Style 1-14 from catalogue) | Limited (no narrative arc visible) |
| Video transcript only | Line table (numbered transcript lines) | Unavailable, mark "transcript-only" | Full (narrative arc readable from transcript) |
| Image + transcript | Both element + line tables | Yes | Full |
| Transcript + visual brief (textual) | Line table for transcript + a described-visuals notes block (text-derived) | Permitted from the described visuals, flagged text-derived not vision-derived | Full (narrative arc readable from transcript) |
| Long-form static (image + Facebook in-feed primary text) | Line table for primary text + element table for image | Yes (typically REDDIT-NATIVE per `../../long-form-static-builder/references/image-spec.md`) | Full |
| Pure video without transcript | Mark all tagging as "transcript required for full analysis" and ask user to provide transcript | Hero-frame element table only | Unavailable |

For the "Transcript + visual brief (textual)" input (a transcript plus a textual description of the visuals, for example a Gemini video brief), Dimension 2B visual-style tagging is permitted from the described visuals but MUST be flagged text-derived, not vision-derived. Dimension 5B (Visual-Layout Replicability) is not produced for this input; its not-produced reason is the exact string 'non-static input' (per Dimension 5B in tagging-framework.md). This row differs from "Video transcript only" (which has no visual layer, so visual style is unavailable) precisely because the textual visual brief carries the described visual layer. [v1.2.0 sd-wave]
