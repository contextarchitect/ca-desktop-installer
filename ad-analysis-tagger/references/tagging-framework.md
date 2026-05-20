# Ad Analysis Tagging Framework

Six tagging dimensions for analyzing winning ads. Every analyzed ad gets tagged on all six dimensions when the input supports it; missing inputs flag specific dimensions as "cannot determine."

## Dimension 1: Hook Style

The hook is the first line of body copy (or the visible-in-feed caption text for static image ads). Tag the hook against:

### 1A: Hook Quality Checklist (`copywriting-guide §8.4 Hook Quality Checklist`)

Score on the 5-point check from §8.4:
- **Opens a loop** (yes/no): does the hook create curiosity rather than close one with a fact statement?
- **One specific claim** (yes/no): does the hook focus on one thing rather than two or three?
- **First-person voice** (yes/no): is the narrator first-person? (Some brand voices intentionally use third-person; mark as "brand-voice override" if so.)
- **Specificity** (yes/no): does the hook use specific numbers, names, ages, conditions rather than vague language?
- **Identity marker** (yes/no): does the hook include something that filters the right viewer in (age, role, situation)?

Total score: 0-5. Hooks scoring 4-5 are strong; 2-3 are workable; 0-1 are weak.

### 1B: Authority Hook Pattern (`copywriting-guide §8.8 Authority Hook Patterns`)

If the hook invokes authority, tag which of the 4 named patterns:
- **Classic**: named specialist endorsement
- **Doctor's Surprise**: authority surprised by the result
- **Doctor's Skepticism**: authority disagreed but data proved them wrong
- **Study/Research**: named research/institution citation

If the hook does NOT invoke authority, tag as "no-authority" (which is correct for many high-converting hooks; not a deficiency).

### 1C: First-Line Pattern

Match against the corpus pattern catalogue:
- **Refusal pattern**: "I refused [X] for [time]." Strong open-loop; identity marker.
- **Witness pattern**: "My [partner/doctor/friend] said [X]." Authority via witness.
- **Specific-condition pattern**: "After [N] years of [condition], I noticed [X]." Time anchor + identity.
- **Cost-of-doing-nothing pattern**: "If you're [over X / dealing with Y], here's what's coming." Identity + future-pacing.
- **Inside-information pattern**: "Most [demographic] don't know this about [topic]." Curiosity gap.
- **Single-word punch**: "Finally." / "Stop." / "Listen." Fragment hooks. Strongest in retargeting.

Most ads use one pattern. Some hybrid two. Multi-pattern hooks usually score worse on the §8.4 "one specific claim" check.

## Dimension 2: Script Structure

Tag against the canonical format library at `../../funnel-builder/references/format-library.md`. The 9 named formats + 1 sub-format:

- Advertorial (9-section long-form)
- Listicle-Logic
- Listicle-Emotion
- Listicle-Product
- PAS (Problem-Agitate-Solution)
- AIDA (Attention-Interest-Desire-Action)
- SPS (Story-Problem-Solution)
- 4P (Picture-Promise-Proof-Push)
- Long-Form (Extended-Argument)
- BAB (Before-After-Bridge)
- Problem Stack
- Fake-Complaint (sub-format)

If the ad doesn't match any of these, tag as "Custom" and describe the actual structure in 1-2 sentences. Custom-tagged ads are interesting: they may represent a new format pattern worth adding to the format library if they replicate.

### 2A: Format-Section Sequence

For ads matching a named format, walk the section sequence and tag each section with its format-specific role:
- For Advertorial: Above the Fold, then Lead, then Background Story, then Root Cause, then Consequences, then Unique Mechanism, then Product Buildup, then Product Reveal, then Close
- For Listicle: Opening, then numbered items, then CTA mid-page, then CTA final, then guarantee
- For PAS / AIDA / SPS / 4P / etc.: see `../../funnel-builder/references/format-library.md` for each format's section sequence

### 2B: Visual Style (image ads only)

For image ads (static or hero image of video ads), tag against the catalogue at `../../ad-style-generator/references/style-catalogue.md`. The 14 named styles:

1. SCIENCE-FRIENDLY
2. BA-EMOTION (Before-After Emotional)
3. INFOGRAPHIC
4. NEWS
5. TUTORIAL
6. RESEARCH
7. COMPARISON (analytical feature-grid)
8. LIFESTYLE
9. TESTIMONIAL
10. LISTICLE (visual)
11. UNBOXING
12. PREMIUM
13. REDDIT-NATIVE
14. US-VS-OTHERS (polemical comparison; distinct from #7 COMPARISON)

If the ad's visual doesn't match any of the 14, tag as "Custom-visual" and describe.

## Dimension 3: Core Feeling

Tag against `copywriting-guide §8.7 The Five Core Feelings Library`. Pick exactly ONE:

1. **Vindication**: "I was right all along; the system was wrong."
2. **Loss aversion**: "I lost something I want back."
3. **Betrayal**: "Someone I trusted misled me."
4. **Desperation**: "I will try anything that might work."
5. **Identity**: "I want to be the kind of person who [does this thing]."

Per §8.7, an ad that tries to serve more than one core feeling dilutes them all. If the ad seems to serve multiple, mark the dominant one and note the dilution as a finding.

## Dimension 4: Awareness and Sophistication Scoring

### 4A: Universal Awareness Stage

Use the universal 3-value field (Problem-aware / Solution-aware / Product-aware, see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction). Determine from:
- Hook framing (problem-stating vs solution-comparing vs product-naming)
- Body content focus (mechanism explanation vs alternative comparison vs price/offer)
- Implied prerequisite knowledge (does the ad assume the viewer knows the category exists?)

### 4B: Gated Schwartz Awareness Stage (only when `phase-4.5-angle-roadmap/schwartz-applied.md` exists for the brand)

If the brand has Schwartz onboarding, also tag against the formal 6-value enum:
- Unaware
- Problem Aware
- Solution Aware
- Product Aware
- Most Aware
- Solution-Switching (compound state)

The gated value provides operational copy mechanics. The universal field is the strategic call.

### 4C: Sophistication Stage Score (gated, only when `phase-4.5-angle-roadmap/schwartz-applied.md` exists)

If the brand has Schwartz onboarding, score the angle's sophistication 1-5 per `../../angle-roadmap/SKILL.md` Step 6.

If the brand does NOT have Schwartz onboarding, sophistication scoring is unavailable. Tag this dimension as "universal-only; sophistication unavailable without Schwartz onboarding."

## Dimension 5: Replicability

Score 1-5: how reusable is this ad's structure across other angles for the same brand?

- **5 (highly replicable)**: structure is brand-agnostic (could swap the angle and the ad pattern still works); hook is template-shaped (refusal pattern, witness pattern, etc.); mechanism explanation is plug-and-play
- **4**: replicable with light adaptation (one or two angle-specific elements need substitution)
- **3 (workable)**: needs moderate rewrite to apply to another angle
- **2**: heavily dependent on this specific angle (root cause, mechanism, narrator situation all interlocked)
- **1 (one-off)**: cannot be templated; the ad worked because of unique-to-this-execution factors (specific narrator's voice, specific timing, specific event)

Most ads in production score 3-4. Score 5 ads are rare and valuable as templates. Score 1-2 ads are worth analyzing for what made them work but should NOT be turned into templates.

### 5A: Replicability Diagnostics

When scoring, identify:
- Which elements are angle-specific (would need rewriting per angle)
- Which elements are brand-specific (would need rewriting per brand)
- Which elements are template-shaped (could be reused as-is)

A score-4 ad with replicability diagnostics becomes a template the brand can reuse on 3-4 other angles.

## Dimension 6: Swipe-Fitness

Score 1-5: would this ad work as a reference in another brand's swipe file?

- **5 (highest swipe value)**: structurally distinctive (does something most ads don't); cleanly executed (no rough edges); generalizable pattern (the technique applies beyond this brand's category)
- **4**: high swipe value with category-specific adaptation
- **3**: useful as reference for brands in the same category
- **2**: too brand-specific or category-specific to swipe
- **1 (no swipe value)**: ad is too generic to learn from, OR too brand-specific to apply elsewhere

Swipe-fitness differs from Replicability. Replicability is "can this brand reuse this structure on other angles?" Swipe-fitness is "can other brands learn from this structure?"

### 6A: Swipe-Fitness Diagnostics

When scoring, identify:
- The single most distinctive element (the thing other brands could learn from)
- The category-specific elements that other brands would need to translate
- Whether the ad demonstrates a NEW pattern (worth adding to ContextArchitect's hook patterns or format library) or a known pattern executed well

Score-5 ads are the basis for swipe-file collections. They become reference material for ad-style-generator when generating ads for the same archetype across categories.

## Cross-Variant Tagging (when applicable)

If the analyzed ad is one variant of a multi-variant test (the brand ran 3 versions of the same angle), additionally tag:

- **Lead Variant**: match against `../../angle-roadmap/SKILL.md` Step 5.5:
  - Variant 1: First-Person Sufferer
  - Variant 2: First-Person Discoverer
  - Variant 3: Third-Person Authority or Witness
- **Multi-Bio-Marker Pivot** (if applicable): which symptom did this variant lead with? Match against the angle card's Multi-Bio-Marker Pivot field.

Cross-variant tagging requires multiple ads from the same angle. Single-ad analysis cannot determine variant; mark as "single-instance, variant unknown."

## Discovery Story Detection

If the ad uses the Discovery Story Format (`copywriting-guide §8.6 The Discovery Story Format`), additionally tag the 7 sequence stages:

1. Distress
2. Unusual decision
3. Discovery
4. Mechanism reveal
5. Application
6. Validation
7. Crossroads

Note which stages are explicit vs implicit vs missing. Missing stages are findings; the discovery story format depends on all 7 landing.

## Identification-Before-Mechanism Compliance

Apply `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`. Score:
- **Pass**: narrator identity established (specific name/age/situation) before any mechanism explanation
- **Partial**: identity established but thin (generic narrator)
- **Fail**: mechanism explained before reader feels seen

Per `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`, identification-before-mechanism is the most common structural error in technical-founder-written copy. Failing this check is a finding regardless of other tagging strengths.
