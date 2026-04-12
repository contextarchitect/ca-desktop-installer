---
name: avatar-research
description: "Generate deep customer avatar research briefs for D2C and e-commerce brands. Use this skill whenever the user wants to create customer avatars, psychographic profiles, buyer personas, or audience research briefs for Deep Research. Trigger on phrases like: 'run Phase 2', 'avatar research', 'customer avatars', 'buyer personas', 'psychographic profiles', 'audience research', 'who is my customer'. This skill reads Phase 1 (Business Validation) output as primary context and generates a fully customized avatar research prompt optimized for Deep Research. Also trigger when user provides a business validation report and wants customer profiles derived from it."
---

# Avatar Research Skill

## Purpose

Transform Phase 1 (Business Validation) output + client braindump into a fully customized, research-ready avatar brief. The skill extracts validated segments, competitive insights, customer voice data, and market positioning from the validation report, then generates a comprehensive research prompt that produces deeply researched, emotionally nuanced, strategically actionable customer profiles.

## When to Use

- User says "run Phase 2" or "avatar research" for a brand
- User has completed Phase 1 (Business Validation) and wants customer profiles
- User wants psychographic buyer personas for marketing, funnels, or ad creative
- User provides a business validation report and wants avatars derived from it
- User wants to understand customer segments at emotional and behavioral depth

## Required Inputs

This skill requires TWO inputs:

1. **Phase 1 Business Validation Report** (primary context) — provides validated segments, competitive landscape, market positioning, customer voice quotes, and hypothesis testing results
2. **Client Braindump** (supplementary context) — provides brand details, product portfolio, pricing, positioning, and founder perspective

If Phase 1 is not available, the skill can still generate an avatar brief but will note reduced quality. The validation report is what makes the avatars evidence-based rather than assumption-based.

## Workflow Overview

```
1. INGEST     -> Read Phase 1 report + braindump
2. EXTRACT    -> Pull validated segments, positioning, voice data, competitive context
3. SYNTHESIZE -> Merge into avatar research context
4. CUSTOMIZE  -> Generate research brief from template
5. PRESENT    -> Show summary, confirm persona count
6. OUTPUT     -> Deliver research-ready brief
```

## Step 1: Ingest Phase 1 Output

Read the business validation report and extract these specific sections. Each feeds a different part of the avatar brief.

### From Phase 1 Report (High Priority)

| Section | What to Extract | Feeds Into |
|---------|----------------|------------|
| Executive Verdict | Verdict, conditions, critical risks | Context framing |
| Avatar Discovery (2.1) | Validated segments with demographics, psychographics, pain points, viability scores | Persona definitions (Section 3) |
| Avatar Prioritization (2.2) | Priority ranking, rationale, segment value challenge results | Persona ordering and distribution |
| Customer Voice Quotes | All direct quotes with sources | Pain point validation, platform mapping |
| Hypothesis Testing (1.6) | Assumption validation results, especially segment and messaging findings | Persona refinement |
| Competitive Landscape (3.1-3.3) | Competitor positioning, white space, where competitors fail customers | Competitive context per avatar |
| Market Size (1.5) | TAM/SAM/SOM, growth drivers, segment sizes | Target market opportunity |
| Demand Validation (1.4) | Search interest, community activity, platform data | Platform-specific research guidance |

### From Product Deep Research (Optional — if completed before or alongside Avatar Research)

If Product Deep Research has been completed, also extract:

| Element | What to Extract | Feeds Into |
|---------|----------------|------------|
| Product Registry | Shortlisted product candidates with avatar assignments | G2: Product Affinity Mapping |
| Bundle Registry | Bundle archetypes with target avatars | G2: Bundle Appeal |
| System Thinking classifications | COMPLETION/AMPLIFICATION/PROTECTION/RETENTION rationales | Journey mapping — which products solve which journey moments |
| Hero Product Mechanism | How the hero product works, its limitations | Competitive context per avatar |

This enrichment is optional. The skill works fully without it but produces deeper, more actionable avatars when product strategy context is available.

### From Braindump (Supplementary)

| Field | What to Extract | Feeds Into |
|-------|----------------|------------|
| Product portfolio | All products with pricing and descriptions | Product portfolio section |
| Brand positioning | Core differentiator, value prop | Brand positioning context |
| Existing assets | Funnel URLs, ad library links | Competitive context for research |
| Pricing structure | All tiers, offers, discounts | Price positioning section |
| Geography | Primary markets with percentages | Geographic focus, platform priorities |

## Step 2: Extract and Validate Segments

The Phase 1 report contains preliminary avatar sketches. The skill must:

1. **Adopt validated segments** — Use the segments exactly as validated in Phase 1, including any priority reordering that contradicted the founder's original hypothesis
2. **Preserve priority ranking** — If Phase 1 recommended a different primary segment than the founder assumed, maintain that recommendation
3. **Include segment challenge findings** — If Phase 1 found that the founder's "core" segment is actually low-value, this must be reflected in the persona definitions
4. **Add missed segments** — If Phase 1 identified potential segments the founder missed, include them
5. **Calculate persona count** — Typically 4-6 personas. Use Phase 1 validated segments as base, add 1-2 for coverage gaps (demographic variation, awareness stage gaps, regional variation)

### Segment-to-Persona Mapping

For each Phase 1 validated segment, create a persona definition with:
- Archetype name (from Phase 1 if available)
- Gender and age range (from Phase 1 demographics)
- Awareness stage assignment (from Phase 1 sophistication analysis)
- 3-5 sentence description covering: situation, behavior, experience level, budget, current approach, strategic importance
- Priority ranking with rationale from Phase 1 evidence

### Awareness Stage Distribution

Assign each persona to exactly one Eugene Schwartz awareness stage. Requirements:
- Cover at least 3 of 5 stages across all personas
- Two personas may share one stage (choose the stage with highest strategic value)
- Assignment must be justified by Phase 1 psychographic data, not assumed

## Step 3: Synthesize Research Context

Build the avatar brief context by merging Phase 1 findings with braindump details.

### Brand Positioning Context

Construct from Phase 1 competitive analysis + braindump:
- **Primary differentiator:** Use Phase 1's differentiation assessment (not founder's claim if contradicted)
- **Price positioning:** Include specific price points, per-unit economics (from Phase 1 derived metrics), competitor pricing for reference
- **Geographic focus:** From braindump geography field
- **Key positioning points:** Draw from Phase 1 validated differentiators only (STRONG or MODERATE status)

### Product Portfolio

From braindump: list each product/service with price, one-sentence description, use case, target persona.

### Target Market Opportunity

From Phase 1 market sizing: TAM/SAM/SOM, growth rate, demographic breakdown, behavioral economics, failure/churn drivers.

### Validated Pain Points

From Phase 1 customer voice repository: select 8-10 strongest direct quotes with sources. Prioritize:
1. Quotes showing the problem exists and is painful
2. Quotes showing current solutions failing
3. Quotes revealing emotional state (frustration, resignation, hope)
4. Quotes containing natural language the target audience uses

## Step 4: Generate Platform-Specific Research Guidance

Read `references/platform-mapping.md` for geography and category-specific platform guidance.

Based on geography and category detected, generate the "Where to Find Each Avatar" section with:

**For each platform category:**
- Specific named communities with member counts (from Phase 1 demand validation data where available)
- Content types that surface genuine opinions
- Demographic skew notes
- Platform-specific language patterns

**The critical principle:** People speak differently on Reddit vs MumsNet vs TikTok vs Facebook Groups. The research brief must direct Deep Research to the specific communities where each persona drops their guard and reveals true motivations.

## Step 5: Customize Avatar Profile Template

Read `references/avatar-profile-template.md` for the universal profile structure (Sections A through L).

The profile template is universal and requires minimal customization. Customize only:

- **Section A "Category-Specific Stage":** Replace generic placeholder with the appropriate stage for this category (e.g., "Sleep Solution Journey Stage" for sleep products, "Skincare Sophistication Level" for beauty)
- **Section J "Category-Specific Attitudes":** Replace the 5-7 generic attitude dimensions with dimensions specific to this brand's category
- **Section 8 Writing Standards:** Include brand-specific writing rules from braindump (e.g., humanization principles, banned words, tone requirements)

Everything else in the profile template (Sections B-I, K, L) is universal and should be included as-is.

## Step 6: Present Summary and Confirm

Before outputting the final brief, present:

```
AVATAR RESEARCH BRIEF READY: [brand_name]

Phase 1 Context Loaded:
  Verdict: [verdict] ([confidence])
  Validated Segments: [count] ([names])
  Priority Order: [ordered list with rationale]
  Customer Voice Quotes: [count] available
  Competitive Context: [count] competitors analyzed

Personas to Research: [count]
  1. [Name] ([awareness stage]) - [strategic importance]
  2. [Name] ([awareness stage]) - [strategic importance]
  [...]

Awareness Stage Coverage: [stages covered]
Missing Coverage: [any gaps noted]

Expected Output: [count] avatars x 1,500+ words = [total]+ words
Plus: comparison table, strategic synthesis (500+ words)

Confirm or adjust persona count/selection:
```

## Step 7: Output

Deliver the complete customized avatar research brief as a single document for Deep Research.

The brief must contain all 10 sections:
1. Context (populated from Steps 1-3)
2. Research Methodology (populated from Step 4)
3. Research Instructions with persona definitions (from Step 2)
4. Awareness Stage Mapping (from Step 2)
5. Avatar Profile Structure (from Step 5, mostly universal)
6. Additional Research Requirements (universal)
7. Output Format (universal with persona count customized)
8. Quality Standards (universal + brand writing standards)
9. Expected Output (customized word count)
10. Final Note (customized brand applications)

Also generate a summary:

```
BRIEF GENERATED

Context from Phase 1:
  - [count] validated segments adopted
  - [count] customer voice quotes embedded
  - Priority reordering: [yes/no, details if yes]
  - Phase 1 contradictions reflected: [list]

Customizations applied:
  - [geography]-specific platform mapping
  - [category]-specific attitude dimensions
  - Brand writing standards included
  - [count] personas defined across [count] awareness stages
  - Product affinity mapping: [included / not included — depends on Product Deep Research availability]

Next: Paste this brief into Deep Research.
After research completes:
  → Avatar profiles feed into Phase 3 (Brand Guidelines) — voice, tone, visual identity
  → Avatar profiles feed into Phase 4 (Copywriting Guide) — avatar-specific language
  → Avatar Registry feeds into Creative Engine — ad creative targeting
  → Avatar Registry feeds into Phase 5 (Funnel Building) — avatar-specific funnels
  → If Product Deep Research completed, cross-reference product affinity per avatar
```

## What This Skill Does NOT Do

- Does not run Deep Research (user triggers separately)
- Does not replace Phase 1 (avatar quality depends on validation quality)
- Does not generate the avatars themselves (that's Deep Research's job)
- Does not commit files to GitHub

## Edge Cases

**No Phase 1 report available:** Skill can generate a brief using only the braindump, but will warn that segments are assumption-based rather than evidence-based. Persona definitions will be thinner and marked as [UNVALIDATED].

**Phase 1 verdict was NO-GO:** If the business was rejected in Phase 1, ask the user whether they still want avatars (perhaps for a pivot or adjacent opportunity). Proceed if confirmed but note the context.

**Phase 1 had minimal avatar section:** Some validation reports have detailed avatars (like Londira's); others have brief segment mentions. If Phase 1 avatar section is thin, the skill should extract segment signals from hypothesis testing, customer voice data, and competitive analysis to build persona definitions.

**Very different segment count:** If Phase 1 identified 2 segments but user wants 6 personas, add demographic/psychographic variations within validated segments rather than inventing new unvalidated ones.
