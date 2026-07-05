# Ad Analysis Tagging Framework

Six tagging dimensions for analyzing winning ads. Every analyzed ad gets tagged on all six dimensions when the input supports it; missing inputs flag specific dimensions as "cannot determine."

## Dimension 1: Hook Style

The hook is the first line of body copy (or the visible-in-feed caption text for static image ads). Tag the hook against:

### 1A: Hook Quality Checklist (rubric embedded in tagging-framework.md; canonical source: copywriting-guide skill §8.4)

Score on the 5-point check in the Hook Quality Checklist (rubric embedded in tagging-framework.md; canonical source: copywriting-guide skill §8.4) [v1.1.1 xref-fix]:
- **Opens a loop** (yes/no): does the hook create curiosity rather than close one with a fact statement?
- **One specific claim** (yes/no): does the hook focus on one thing rather than two or three?
- **First-person voice** (yes/no): is the narrator first-person? (Some brand voices intentionally use third-person; mark as "brand-voice override" if so.)
- **Specificity** (yes/no): does the hook use specific numbers, names, ages, conditions rather than vague language?
- **Identity marker** (yes/no): does the hook include something that filters the right viewer in (age, role, situation)?

Total score: 0-5. Hooks scoring 4-5 are strong; 2-3 are workable; 0-1 are weak.

### 1B: Authority Hook Pattern (rubric embedded in tagging-framework.md; canonical source: copywriting-guide skill §8.8)

If the hook invokes authority, tag which of the 4 named Authority Hook Patterns (rubric embedded in tagging-framework.md; canonical source: copywriting-guide skill §8.8) [v1.1.1 xref-fix]:
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

Most ads use one pattern. Some hybrid two. Multi-pattern hooks usually score worse on the Hook Quality Checklist "one specific claim" check (canonical source: copywriting-guide skill §8.4) [v1.1.1 xref-fix].

## Dimension 2: Script Structure

Tag against the canonical format library at `../../funnel-builder/references/format-library.md`. The 9 named formats + 1 sub-format:

- Advertorial (9-section long-form)
- Listicle (Logic)
- Listicle (Emotion)
- Listicle (Product)
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

Dimension 2B is the single authority for visual-style assignment across the ContextArchitect ad skills. Any consumer (for example competitor-ad-intelligence) reads the style assigned here and does not re-assign it. A "Custom-visual" determination here is the authoritative candidate-new-style signal; consumers add only the across-the-set bucketing view on top of this assignment and do not raise an independent candidate-new-style flag. [v1.2.0 sd-wave]

## Dimension 3: Core Feeling

Tag against the Five Core Feelings Library (rubric embedded in tagging-framework.md; canonical source: copywriting-guide skill §8.7) [v1.1.1 xref-fix]. Pick exactly ONE:

1. **Vindication**: "I was right all along; the system was wrong."
2. **Loss aversion**: "I lost something I want back."
3. **Betrayal**: "Someone I trusted misled me."
4. **Desperation**: "I will try anything that might work."
5. **Identity**: "I want to be the kind of person who [does this thing]."

Per the Five Core Feelings Library (canonical source: copywriting-guide skill §8.7), an ad that tries to serve more than one core feeling dilutes them all. If the ad seems to serve multiple, mark the dominant one and note the dilution as a finding.

## Dimension 4: Awareness and Sophistication Scoring

### 4A: Universal Awareness Stage

Use the universal 3-value field (Problem-aware / Solution-aware / Product-aware, see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction). Determine from:
- Hook framing (problem-stating vs solution-comparing vs product-naming)
- Body content focus (mechanism explanation vs alternative comparison vs price/offer)
- Implied prerequisite knowledge (does the ad assume the viewer knows the category exists?)

### 4B: Gated Schwartz Awareness Stage (only when `schwartz-applied.md` exists at the brand repo root)

If the brand has Schwartz onboarding, also tag against the formal 6-value enum:
- Unaware
- Problem Aware
- Solution Aware
- Product Aware
- Most Aware
- Solution-Switching (compound state)

The gated value provides operational copy mechanics. The universal field is the strategic call.

### 4C: Sophistication Stage Score (gated, only when `schwartz-applied.md` exists at the brand repo root)

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

### Dimension 5B: Visual-Layout Replicability Contract (canonical, static image ads only)

This block is the single source of truth for Visual-Layout Replicability scoring, bucketing, and output. SKILL.md and output-template.md reference this contract and do not restate its rules. If any rule needs to change, change it here only.

**What it measures.** How directly this ad's visual LAYOUT can be cloned onto another brand's product. Distinct from Dimension 5 overall Replicability (which measures whether the CONCEPT ports across angles and brands). An ad can score low on one and high on the other.

**Target-agnostic scoring (single rule).** All 5B scoring is target-agnostic: judge layout portability against a hypothetical same-category brand, never against a specific target brand. The tagger has no target-brand input, so a per-source-ad 5B analysis is cacheable and transposes to many brands (tag once, transpose to many). Target-specific physical-form compatibility is explicitly OUT of scope here; it is owned by the consumer's `product_form_compat` field (competitor-ad-intelligence Step B.6). Every "survives substitution" check below means survives substitution onto a hypothetical same-category brand, and all replacement guidance is role-level, not keyed to any one brand. Where the bucket definitions below say a slot is "rewritten in the target brand's voice" or that a STRIP-REPLACE/MIXED element becomes "the target brand's equivalent", those phrases name the CONSUMER's downstream replacement ACTION performed off-tagger during transposition (a role-level mapping), not a tagger scoring input: the tagger records only the source-side role, and the consumer maps that role to its own brand. So 5B scoring and bucketing stay target-agnostic even though the downstream action they describe is brand-specific. [v1.2.0 sd-wave]

**The 1-5 scale.**
- 5: Fully templated. Swap product, setting, and copy and the grammar holds unchanged. The mandatory replacement of source brand identity, product, copy, and claims (the STRIP-REPLACE and ADAPT rows that EVERY clone requires) does NOT count against a 5; that replacement is the baseline every clone-with-substitution performs. Score 5 means no layout or supporting element needs change beyond that baseline swap.
- 4: Mostly templated. All four boundary checks pass, but at least one supporting element needs substitution or adaptation BEYOND the baseline source-identity replacement (for example, a graphic element or a compositional detail that does not carry over cleanly even after the normal product/copy swap). Score 4 preserves one-to-one content slots; any required slot addition or removal fails boundary check #2 and caps the score at 3.
- 3: Partially templated. Passes the floor gate but at least one boundary check fails; some grammar is reusable while other elements are entangled with the specific product, claim, or talent.
- 2: Largely bespoke. Fails the floor gate; a recognizable layout structure exists but is source-bound (legible slots and composition that work only because of this specific product, claim, or talent); cloning produces a hollow shell.
- 1: Fully bespoke. Fails the floor gate; no coherent transferable visual grammar or reusable composition exists at all.

**Floor gate (evaluate FIRST, before any boundary check).** Score 3 or above requires at least one named, content-independent visual grammar element that survives substitution onto a hypothetical same-category brand (a layout slot, a composition pattern, a framing/POV, or a treatment that holds regardless of product or claim). If no meaningful layout grammar survives, the score is 1-2, not 3. Do not run the boundary checks for a layout that fails the floor gate.

**Boundary checks (evaluate only after the floor gate passes).** Apply all four:
1. Spatial hierarchy survives substitution onto a hypothetical same-category brand without redesign.
2. Content slots map one-to-one to a same-category brand's replacement content without adding or removing slots.
3. Camera/framing/POV survives without reshooting the concept.
4. Overlay and graphic treatments survive without redrawing.

Scoring from the checks:
- All four pass AND no element needs change beyond the baseline source-identity replacement (STRIP-REPLACE and ADAPT rows only): score 5.
- All four pass (including one-to-one slot mapping) BUT at least one supporting element needs change BEYOND that baseline (a change not accounted for by the normal STRIP-REPLACE/ADAPT swap, and not involving adding or removing a content slot): score 4.

Rule of thumb: mandatory source-identity replacement never triggers score 4; only additional, non-baseline layout changes do. A clean branded static that clones perfectly after the normal swap is a 5, not a 4.
- Floor gate passed but one or more checks fail: score 3.
- Floor gate failed: score 1-2 (never 3). Choose within 1-2 deterministically: score 2 when a recognizable layout structure exists but is source-bound (its slots and composition are legible but work only because of this specific product, claim, or talent); score 1 when no coherent transferable visual grammar or reusable composition exists at all.

**The four buckets (used at score 3, 4, and 5).** Every classified visual element is exactly one of:
- CLONE: layout grammar reproduced directly (composition, spatial hierarchy, framing, graphic treatment, bubble/badge styling, POV/angle, content-slot positions). CLONE reproduces geometry, hierarchy, framing, and visual treatment ONLY. It NEVER means copying literal source pixels, source text, headlines, body copy, or claims. Words that fill a cloned text slot are always rewritten in the target brand's voice; only the slot's position, size, and styling clone.
- ADAPT: setting and props whose function is product-contextual authenticity, not structural grammar. For each, name the contextual function it serves (e.g. 'gym floor = fitness/health product context') so downstream knows what kind of setting to substitute.
- STRIP-REPLACE: source brand and product identity (competitor packshots, logos, packaging form, brand palette and fonts, brand naming, proprietary UI screenshots, claims badges, product-specific demonstrations, AND source copy content: headlines, body text, claims, competitor wording). Never cloned as source pixels or source words even when compositionally central. For each, name the compositional role it fills (e.g. 'center product hero', 'trust badge') so downstream replaces it with the target brand's equivalent in the same role.
- MIXED: an element that is both cloneable layout grammar and source-specific content (a headline block, a body-copy list, a branded text overlay). Never forced into a single bucket. A MIXED row populates BOTH clone_aspects (the layout grammar reproduced: slot position, size, styling, hierarchy) AND replace_aspects (the source content rewritten in the target brand's voice: the actual words, claims, or branding). No CLONE or MIXED element ever applies 'reproduce directly' to source text, claims, or branded pixels.

**Output by score.**
- Score 4-5: full Visual Element Classification table (all four buckets), and the entangled-elements exclusion section states 'Not applicable (full clone, no entangled elements)' at score 5, or 'Not applicable (score 4; see bucket table for the minor element's ADAPT/STRIP-REPLACE/MIXED handling)' at score 4.
- Score 3: PARTIAL classification. The bucket table contains SURVIVING elements ONLY (the reusable grammar, classified into the four buckets). All entangled non-surviving elements go ONLY in the dedicated 'Entangled Elements Excluded From Clone' section, never in the bucket table. For each entangled element, the exclusion record states why substitution fails (its entanglement with the specific product, claim, or talent) and the do-not-clone instruction for downstream (for example, transpose the concept only, do not reuse the layout).
- Score 1-2: no classification. Not-produced reason: 'visual-layout replicability 1-2, concept-only target'.
- Non-static input: no score, no classification. Not-produced reason: 'non-static input'.

These two not-produced reasons are distinct and must not be interchanged.

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
- The distinctiveness read for swipe purposes: what other brands could learn from. For the single load-bearing element, reference the named `distinctive_device` output (see the Distinctive Device section below) rather than restating a separate, differently worded element. [v1.2.0 sd-wave]
- The category-specific elements that other brands would need to translate
- Whether the ad demonstrates a NEW pattern (worth adding to ContextArchitect's hook patterns or format library) or a known pattern executed well

Score-5 ads are the basis for swipe-file collections. They become reference material for ad-style-generator when generating ads for the same archetype across categories.

## Distinctive Device (named output: `distinctive_device`)

Every analyzed ad produces exactly ONE named `distinctive_device` output, defined as: the single element that makes the ad work and must survive transposition. This is the canonical producer field for the ad's load-bearing device. It is stated once here and emitted in the output template; no other section restates or re-derives it, and downstream consumers (competitor-ad-intelligence and CE) read this exact field name. In CE it becomes a typed column, so the name is fixed here. [v1.2.0 sd-wave]

The `distinctive_device` differs in PURPOSE from the swipe-fitness distinctiveness read above: swipe-fitness asks what other brands could learn from (swipe-file value), while `distinctive_device` names the element that must be preserved when the ad is transposed to another brand. When both are recorded, the swipe-fitness diagnostic references `distinctive_device` for the load-bearing element instead of naming a second one, so there is one producer field, not two.

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
