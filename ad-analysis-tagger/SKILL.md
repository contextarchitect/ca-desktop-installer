---
name: ad-analysis-tagger
version: "1.1.0"
description: "Take any winning ad (transcript / image / both) and produce a structured tagged breakdown across six dimensions: hook style (matched against copywriting-guide §8.4 + §8.8), script structure (matched against funnel-builder format-library.md 9 formats + Fake-Complaint sub-format), core feeling (matched against copywriting-guide §8.7), awareness/sophistication scoring (universal 3-value + gated Schwartz 6-value enum), replicability (1-5 score for templatability), and swipe-fitness (1-5 score for swipe-file value). Use when user says 'tag this ad', 'analyze this ad', 'why did this ad work', 'tag this for swipe file', 'audit this ad', 'replicability of this ad', or references ad analysis / tagging / swipe-file work. Reads angle-roadmap, copywriting-guide, funnel-builder/format-library.md, ad-style-generator/style-catalogue.md, and the awareness-vocabulary framework doc as cross-reference inputs. The most cross-skill-dense skill in the ContextArchitect catalogue."
---

# Ad Analysis Tagger Skill

## Purpose

Take a winning ad (one that converted in production, or a swipe-file reference, or a competitor ad worth understanding) and produce a structured tagged breakdown that explains WHY it worked. Tagging surfaces the structural reasons for performance so the same patterns can be deliberately reused on other angles, other variants, or other brands' campaigns.

Without tagging, "what made this ad work" stays in the operator's head and doesn't propagate. With tagging, the patterns become explicit, comparable, and reusable.

This is Phase 6.5 in the brand development workflow: Business Validation -> Avatar Research -> Brand Guidelines -> Copywriting Guide -> Angle Roadmap -> Funnel Pages / Ad Creative -> **Ad Analysis** -> Swipe File / Templates -> Future Angle Cards.

## When to Use

- User wants to analyze a specific ad (winning or losing) to understand its structure
- User has a swipe-file ad they want to understand and learn from
- User wants to audit a competitor's ad
- User wants to assess whether an ad's structure can be templated for other angles
- User wants to assess whether an ad belongs in their swipe file
- User says "tag this ad", "analyze this ad", "why did this ad work", "tag this for swipe file", "replicability of this ad"

## When NOT to Use

- For generating new ad concepts (use `ad-style-generator` instead)
- For producing creative briefs (use `ad-style-generator`)
- For analyzing landing page funnels (use `funnel-builder`'s pressure-test methodology)
- For analyzing video scripts at the script-construction level (use `video-script-generator` once that skill ships in Session 13)
- For brand-level audits (use `brand-analyzer`)

This skill is specifically for ad-level structural analysis with the goal of pattern extraction.

## Required Inputs

### From User (Per Request)

1. **The ad itself** in one of these forms:
   - Static image (uploaded image file)
   - Video transcript (text)
   - Image + transcript (both, for video ads)
   - Long-form static (image + Facebook in-feed primary text)
   - Pure video without transcript: ask user to provide transcript first OR proceed with limited analysis flagging the gap

2. **Brand context**: which brand is this ad from / for? When the brand is ContextArchitect-managed, brand context loading determines awareness stage (universal 3-value field, see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction) and the gated Schwartz dimensions. When the ad is external/swipe-file, ask user for category (supplements, beauty, finance, etc.) so style and format expectations are calibrated.

3. **Analysis purpose**: what does the user want to learn?
   - Why did this ad work (template extraction)
   - Is this swipe-file worthy (swipe-fitness scoring)
   - Can we template this for other angles (replicability scoring)
   - Audit for weaknesses (find structural gaps)

### From Brand Documents (Read Conditionally)

If the ad is from a ContextArchitect-managed brand:

4. **Angle Roadmap (Phase 4.5)**: the angle card this ad descends from. Confirms angle inheritance; flags drift if the ad doesn't match the angle card's stated core feeling, mechanism, or alternative attack.

5. **Brand Guidelines (Phase 3)**: for visual style baseline (what the brand's typical ad aesthetic looks like).

6. **Copywriting Guide (Phase 4)**: for voice baseline (what brand voice this ad should match).

7. **Schwartz onboarding file** (`phase-4.5-angle-roadmap/schwartz-applied.md`): if it exists, gated dimensions of the analysis are unlocked (Schwartz 6-value awareness enum, sophistication scoring, technique density, 38-method headline tagging).

If the ad is external (swipe file, competitor research), brand documents are NOT required. The skill performs universal-only analysis (no gated dimensions).

## Workflow

```
STEP 1: INPUT INTAKE
  -> Receive ad (image / transcript / both)
  -> Identify input type and flag any gaps
  -> Identify brand context (managed brand vs external)
  -> Confirm analysis purpose

STEP 2: CROSS-REFERENCE LOADING (conditional)
  -> If managed brand: load angle-roadmap, brand guidelines, copywriting guide
  -> If `schwartz-applied.md` exists: load gated dimensions
  -> If external: skip cross-reference loading

STEP 3: SIX-DIMENSION TAGGING
  -> Apply tagging-framework.md across all 6 dimensions
  -> For each dimension: tag against canonical references
    - Dimension 1 (Hook): copywriting-guide §8.4 + §8.8 + first-line patterns
    - Dimension 2 (Script structure): funnel-builder format-library.md + ad-style-generator style-catalogue.md
    - Dimension 3 (Core feeling): copywriting-guide §8.7
    - Dimension 4 (Awareness/sophistication): universal 3-value + gated Schwartz when available (see _frameworks/awareness-vocabulary.md for the universal-vs-gated distinction)
    - Dimension 5 (Replicability): 1-5 score with diagnostics (overall concept portability). For static image ads, ALSO produce Visual-Layout Replicability exactly per the canonical contract in `references/tagging-framework.md` Dimension 5B. All scoring rules, buckets, thresholds, output-by-score behavior, and not-produced states live in that contract; follow it directly and do not restate any of it here.
    - Dimension 6 (Swipe-fitness): 1-5 score with diagnostics
  -> Plus conditional sections: Identification-Before-Mechanism compliance, Discovery Story detection, Cross-Variant tagging

STEP 4: STRUCTURED OUTPUT
  -> Use output-template.md format
  -> Summary scorecard at top
  -> Section-by-section tagging
  -> Findings and recommendations

STEP 5: DELIVERY
  -> Output as markdown
  -> If user requested analysis for swipe-file or template purposes, include explicit recommendation in Findings section
  -> Save as `[ad-name]-analysis.md` if running batch analyses
```

## Cross-Reference Disciplines

This skill is the densest cross-skill consumer in ContextArchitect. The following disciplines apply rigorously:

### §8.5 Disambiguation Discipline (Session 9)

Every reference to `copywriting-guide §8.5` carries the full title `(Identification-Before-Mechanism Rule)` to disambiguate from the gated Schwartz technique #2 Identification. This discipline is now load-bearing across 5 skills (copywriting-guide as source, plus funnel-builder + angle-roadmap + ad-style-generator + this skill).

### Awareness-Vocabulary Disambiguation (Session 14)

The first-use qualifier referencing `_frameworks/awareness-vocabulary.md` appears at the FIRST strategic-decision use of awareness vocabulary in any universal section. In this skill, that's:
- The Required Inputs section item #2 (when describing brand context loading)
- The Workflow Step 3 Dimension 4 reference
- The tagging-framework.md reference file (Dimension 4A Universal Awareness Stage)

Subsequent references in the same section don't repeat the qualifier.

### Format Name Canonical Match

Format names match the canonical list at `../funnel-builder/references/format-library.md` exactly:
- Advertorial / Listicle-Logic / Listicle-Emotion / Listicle-Product / PAS / AIDA / SPS / 4P / Long-Form / BAB / Problem Stack / Fake-Complaint

Capitalization, hyphenation, and naming exact match. "Long Form" without hyphen is wrong; "Problem-Stack" with hyphen is wrong.

### Style Name Canonical Match

Style names match the canonical list at `../ad-style-generator/references/style-catalogue.md` exactly:
- Styles 1-14 by their full caps-with-hyphens names (SCIENCE-FRIENDLY, BA-EMOTION, INFOGRAPHIC, NEWS, TUTORIAL, RESEARCH, COMPARISON, LIFESTYLE, TESTIMONIAL, LISTICLE, UNBOXING, PREMIUM, REDDIT-NATIVE, US-VS-OTHERS)

### Variant Name Canonical Match

Variant names match `../angle-roadmap/SKILL.md` Step 5.5 exactly:
- "Variant 1: First-Person Sufferer"
- "Variant 2: First-Person Discoverer"
- "Variant 3: Third-Person Authority or Witness"

This skill is the second downstream consumer of the Lead Variants section (after ad-style-generator US-VS-OTHERS in Session 11). Future skills consuming Lead Variants should follow the same canonical-match discipline.

## Schwartz Structural Layer (Gated Tagging Dimensions)

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages (in the gated 6-value sense), the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

When the brand has Schwartz onboarding, the analysis includes 4 additional tagging dimensions:

### Schwartz Awareness Stage (6-value enum)

Tag against the formal enum (Unaware / Problem Aware / Solution Aware / Product Aware / Most Aware / Solution-Switching) from `../angle-roadmap/SKILL.md` Step 6. The universal 3-value scoring (Dimension 4A) is always done; the 6-value gated scoring is additional.

### Sophistication Stage Score

Score 1-5 per `../angle-roadmap/SKILL.md` Step 6. Most mature D2C categories sit at Stage 4 baseline.

### Technique Density

Apply the technique density rule from `../ad-style-generator/SKILL.md` Schwartz Structural Layer:
- Unaware: 1 technique
- Problem Aware: 2 techniques (Mechanization + Intensification)
- Solution Aware: 2 techniques (Concentration + Mechanization)
- Product Aware (incl. Solution-Switching): 3 techniques (Concentration + Redefinition + Identification)
- Most Aware: 1 technique (Identification or social proof)

Tag the actual technique density observed in the ad and compare to the rule. Mismatches are findings.

### 38-Method Headline Tagging

If the ad has a headline (most do), tag against the 12 most-used Schwartz headline methods from `../ad-style-generator/SKILL.md` (#1 Promise a Benefit, #2 Reveal a New Mechanism, #4 Question Headline, #6 Specific Number Headline, #11 Promise of Inside Information, #14 Statement of Astonishment, #19 Reframed Alternative, #20 Promise of Simplicity, #21 Numbered List, #25 Customer Quote, #28 Headline as Demonstration, #34 Single-Word Punch).

If the headline doesn't match any of the 12 most-used methods, tag as "method-less" or describe what method it does use from the full 38-method inventory.

### Pressure Test for Tagged Ads

Run the four-check pressure test from `../ad-style-generator/SKILL.md` when running gated analysis:
1. Angle inheritance: does the ad match its angle card?
2. Technique density correct for awareness stage
3. Headline uses a Schwartz method (or is method-less)
4. Concentration target named (Stage 4-5 only)

Pressure test findings go in the output Findings section.

## Quality Checklist

Before delivering an analysis:

**Universal dimensions (always):**
- [ ] All 6 dimensions tagged (or explicitly marked unavailable due to input limitations)
- [ ] Hook §8.4 score is 0-5 with sub-checks itemized
- [ ] Format tag matches canonical name from `../funnel-builder/references/format-library.md` (or "Custom" with description)
- [ ] Visual style tag matches canonical name from `../ad-style-generator/references/style-catalogue.md` (image ads only; or "Custom-visual")
- [ ] Core feeling is exactly one of the five from §8.7 (or dilution flagged as finding)
- [ ] Universal awareness uses 3-value field with framework doc reference at first use
- [ ] Replicability score 1-5 with diagnostics (angle-specific / brand-specific / template-shaped breakdown)
- [ ] Visual-Layout Replicability produced exactly per the canonical contract in tagging-framework.md Dimension 5B (static image ads only): score, classification, entangled-elements handling, and not-produced states all governed by the contract, not restated here.
- [ ] Swipe-fitness score 1-5 with diagnostics (most distinctive / category-specific / new pattern flag)
- [ ] Identification-Before-Mechanism compliance scored (pass/partial/fail with finding)
- [ ] Discovery Story detection if applicable (7-stage breakdown)
- [ ] Cross-variant tagging if applicable (Lead Variant from `../angle-roadmap/SKILL.md` Step 5.5 + Multi-Bio-Marker Pivot)
- [ ] §8.5 references carry full title "Identification-Before-Mechanism Rule"
- [ ] Em-dash policy: zero em dashes in the analysis output

**Gated dimensions (only if `schwartz-applied.md` exists for the brand):**
- [ ] Schwartz 6-value awareness enum tagged
- [ ] Sophistication Stage Score 1-5 assigned
- [ ] Technique density tagged and compared to rule
- [ ] Headline tagged against 38-method framework (or method-less)
- [ ] Pressure test (4 checks) run with findings

## What This Skill Does NOT Do

- Does not generate new ads (provides analysis of existing ads only; for generation use `ad-style-generator`)
- Does not produce creative briefs (analysis is the deliverable, not a brief)
- Does not transcribe video automatically (user provides transcript or skill flags the gap)
- Does not score ad performance directly (replicability and swipe-fitness are structural assessments, not performance predictions)
- Does not commit files to GitHub
- Does not modify the source ad (analysis is a separate deliverable)
