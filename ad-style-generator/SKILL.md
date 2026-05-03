---
name: ad-style-generator
description: "Generate ad creative briefs and Nano Banana image prompts using a 12-style catalogue mapped to brand identity and avatar psychology. Use when user says 'create an ad', 'ad creative', 'generate ad images', 'ad style for [topic]', 'create a [SCIENCE-FRIENDLY/BA-EMOTION/etc] ad', 'ad campaign for [avatar/product]', or references ad creative development for any brand. Reads brand guidelines, avatar profiles, copywriting guide, and angle roadmap to produce brand-consistent ad concepts with complete Nano Banana prompts."
---

# Ad Style Generator Skill

## Purpose

Generate production-ready ad creative briefs with complete Nano Banana Pro image prompts by combining a universal 12-style catalogue with brand-specific identity (colors, typography, avatars, product references) pulled from existing brand documents. No separate brand-specific ad catalogue needed - the skill reads Phase 1-4.5 outputs and applies them to universal style frameworks.

## When to Use

- User wants to create ad images or ad campaigns for any brand
- User requests a specific ad style (e.g., "create a SCIENCE-FRIENDLY ad about...")
- User needs ad concepts for a specific avatar or awareness stage
- User wants a batch of ad variations across multiple styles
- User needs social media, email, or funnel supporting visuals

## Critical Architecture Rule: Image Generation via Nano Banana Only

**All ad images are generated in Nano Banana Pro. Never in any other tool.**

This skill produces:
1. Ad creative brief (concept, copy, layout description)
2. Complete Nano Banana Pro prompt (ready to paste into Nano Banana)

The user then generates the image externally in Nano Banana and uses it wherever needed (ads platform, funnel pages, social media, email).

## Required Inputs

### From Brand Documents (Read First)

1. **Brand Guidelines (Phase 3)** - colors (hex codes), typography, logo treatment, visual identity rules, positioning
2. **Avatar Profiles (Phase 2)** - target segments, awareness stages, emotional triggers, language preferences
3. **Copywriting Guide (Phase 4)** - voice rules, forbidden vocabulary, tone per archetype
4. **Angle Roadmap (Phase 4.5)** - the angle card driving this ad concept. If the brand has completed Schwartz onboarding (i.e., `phase-4.5-angle-roadmap/schwartz-applied.md` exists in the brand repo), the angle card will also carry Awareness Stage and Sophistication Stage Score; these determine the technique density and headline strategy (see Schwartz Structural Layer below). If the file does not exist, treat the angle card as the standard Phase 4.5 output.
5. **Funnel Config (Phase 5)** - product reference images (REF numbers), image generation rules, visual restrictions

If any of these are missing, note the gap and work with what's available. Brand Guidelines is the minimum requirement.

### From User (Per Request)

Ask the user to specify or help them determine:

1. **Target avatar** - which segment is this ad for?
2. **Objective** - awareness, consideration, conversion, retargeting?
3. **Platform** - Meta/Facebook, Instagram feed, Instagram Stories, TikTok, email, landing page?
4. **Topic/angle** - which angle from the roadmap is this ad executing?
5. **Style preference** - specific style requested, or should the skill recommend?

If the user doesn't specify a style, use the Style Selection Framework in `references/style-catalogue.md` AND the Style-to-Schwartz mapping (below) to recommend 2-3 appropriate styles based on the objective, avatar, awareness stage, and sophistication score.

## Workflow

```
STEP 1: CONTEXT LOADING (automatic)
  → Read brand guidelines (colors, fonts, visual identity)
  → Read avatar profiles (target segment details)
  → Read copywriting guide (voice, forbidden vocabulary)
  → Read angle card (awareness stage, sophistication score, required Schwartz move)
  → Read funnel config (product refs, image rules)

STEP 2: STYLE SELECTION (with user)
  → User specifies style OR skill recommends based on:
    - Objective + avatar + platform (existing logic)
    - Awareness stage + sophistication score → required technique (Style-to-Schwartz mapping)
  → Read the specific style framework from references/style-catalogue.md
  → Confirm approach with user

STEP 3: CREATIVE BRIEF (generate)
  → Concept description (what the ad shows)
  → Headline using a Schwartz method tagged on the brief
  → Body copy (following copywriting guide rules + technique density rule for awareness stage)
  → Layout description (composition, color zones, typography placement)
  → Avatar-visual alignment check

STEP 4: NANO BANANA PROMPT (generate)
  → Complete prompt using Three-Layer Model:
    - Visible Layer: scene description with brand colors, fonts, layout
    - Constraint Layer: aspect ratio, style, quality requirements
    - Exclusion Layer: what to avoid (brand restrictions + style exclusions)
  → Include product reference images where applicable
  → Specify exact dimensions for target platform

STEP 5: DELIVERY
  → Output creative brief + Nano Banana prompt
  → If batch (multiple concepts), output as downloadable markdown file
  → User generates images in Nano Banana externally
```

## Brand Element Mapping

When reading brand documents, extract and map these elements to replace what would be hardcoded in a brand-specific catalogue:

| Element | Source Document | Maps To |
|---------|----------------|---------|
| Primary color (hex) | Brand Guidelines | Main accent, CTA backgrounds, chart fills |
| Secondary color (hex) | Brand Guidelines | Supporting elements, secondary data |
| Neutral palette | Brand Guidelines | Backgrounds, text, borders |
| Primary font | Brand Guidelines | All typography in ads |
| Logo file/treatment | Brand Guidelines | Header placement rules |
| Avatar names + demographics | Avatar Profiles | "Best For" targeting |
| Avatar emotional triggers | Avatar Profiles | Concept angle selection |
| Avatar awareness stage | Avatar Profiles | Style selection weighting |
| Angle awareness + sophistication | Angle Roadmap | Style-to-Schwartz mapping; technique density |
| Product REF numbers | Funnel Config | Product placement in ads |
| Image restrictions | Funnel Config | Exclusion layer in prompts |
| Forbidden vocabulary | Copywriting Guide | Ad copy constraints |
| Voice pillars | Copywriting Guide | Copy tone calibration |

## Platform Dimensions

Include the correct dimensions in every Nano Banana prompt:

| Platform | Dimensions | Aspect Ratio |
|----------|-----------|--------------|
| Instagram Feed | 1080x1080px | 1:1 |
| Instagram Stories/Reels | 1080x1920px | 9:16 |
| Facebook Feed | 1200x628px | 1.91:1 |
| Facebook Carousel | 1080x1080px | 1:1 |
| TikTok | 1080x1920px | 9:16 |
| Email Header | 600x300px | 2:1 |
| Landing Page Hero | 1920x1080px | 16:9 |
| Landing Page Inline | 1200x800px | 3:2 |

## Ad Copy Rules

All ad copy MUST follow the brand's copywriting guide. Additionally:

1. **No em dashes** - ever, in any ad copy
2. **No forbidden AI vocabulary** - check the brand's list
3. **GCC compliance** (if applicable) - no specific city/country names unless the brand permits
4. **No absolute medical claims** - avoid "cure," "guarantee," "eliminate" without qualifiers
5. **No competitor names** - generic references only ("other products" not specific brands)
6. **Product placement rule** - product appears only in solution/positive contexts, never in problem/negative contexts

## Batch Generation

When the user requests multiple ad concepts:

1. Vary styles across the batch (don't repeat the same style unless requested)
2. Vary angles/concepts within same style if multiple ads use one style
3. Match each concept to the most appropriate avatar
4. Output all concepts in a single downloadable markdown file
5. Name each concept clearly: `[STYLE]-[topic-slug]-[variant].png`

## Schwartz Structural Layer (Style Selection + Headlines)

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

This section adds two structural inputs to ad creative selection:

1. **Style-to-Schwartz mapping** - which technique each of the 12 styles primarily executes, so style selection is driven by what the angle needs structurally, not just by visual preference.
2. **The 38-method headline framework** - a method-tagged inventory for headline development, with a stage-fit table showing which methods work for which awareness stage.

These come from Eugene Schwartz's Breakthrough Advertising. Apply them after Step 2 (Style Selection) and during Step 3 (Headline writing within the Creative Brief).

### Style-to-Schwartz Mapping

The 12 catalogue styles each emphasize one or two of the seven Schwartz techniques. Pick the style by the technique the angle most needs.

| Style | Primary Technique | Secondary | Best for |
|-------|-------------------|-----------|----------|
| SCIENCE-FRIENDLY | Mechanization | Gradualization | Stage 3-4 angles where the mechanism is news |
| BA-EMOTION | Intensification | Identification | Stage 2-3 angles where the prospect needs to see themselves living the result. (Meta-adapted to AFTER-state only.) |
| INFOGRAPHIC | Mechanization | Camouflage | Mechanism explanation in a visual content format |
| NEWS | Camouflage | Concentration | Sales pitch inside an editorial format |
| TUTORIAL | Mechanization | Gradualization | Education-led content |
| RESEARCH | Mechanization | Concentration | Stage 4-5 angles where proof density is the value |
| COMPARISON | Concentration | Redefinition | Stage 4 angles where a specific alternative needs demolishing |
| LIFESTYLE | Identification | Intensification | Most Aware audiences |
| TESTIMONIAL | Identification | Intensification | All angles benefit; especially Most Aware and Solution-Switching audiences |
| LISTICLE | Camouflage | Mechanization | Multi-point arguments inside content format |
| UNBOXING | Identification | Intensification | Product-aware audience moments |
| PREMIUM | Identification | Redefinition | Brand identity reinforcement; better for retargeting than cold |

**The seven techniques (definitions):**

1. **Intensification** - vivid, varied scenes of the prospect already living the result
2. **Identification** - a felt identity the prospect steps into
3. **Gradualization** - sequenced claims, smallest-to-biggest
4. **Redefinition** - reframe a desire, problem, or alternative
5. **Mechanization** - named, mechanical, plain-English explanation of how the solution works
6. **Concentration** - zoom in on ONE alternative and demolish it specifically
7. **Camouflage** - sales pitch hidden inside a content surface (story, editorial, expose)

### Technique Density by Awareness Stage

How much Schwartz to load into a single ad image is constrained by the prospect's awareness state. This rule applies to BOTH the headline and the body copy.

| Awareness Stage | Technique density rule |
|-----------------|----------------------|
| Unaware | One technique maximum, usually Identification or a story hook. The ad's whole job is to surface the problem. |
| Problem Aware | Two techniques: Mechanization (name the mechanism) + Intensification (one specific scenario). |
| Solution Aware | Two techniques: Concentration (which alternative we are different from) + Mechanization. |
| Product Aware (incl. Solution-Switching) | Three techniques: Concentration (specific alternative they currently use) + Redefinition (recast the desire) + light Identification (the post-switch identity). |
| Most Aware | One technique, usually pure Identification or social proof. Mechanism heaviness loses this audience. |

Over-loaded ads scatter. Under-loaded ads do not work hard enough.

### The 38-Method Headline Framework

Schwartz catalogued 38 methods to strengthen a headline. They cluster into five groups: benefit-led, news-led, question-led, demonstration-led, and identification-led. The most useful methods for D2C advertising are below. Tag every headline with its primary method on the creative brief.

**Most-used methods for D2C:**

- **#1 Promise a Benefit.** Direct statement of what the prospect gets. Example shape: "Wake up rested. Initiate again. Without a pill."
- **#2 Reveal a New Mechanism.** Names a process the prospect has not heard before. Example shape: "There's a stress loop that's been sabotaging your testosterone. Here's how it works."
- **#4 Question Headline.** A question the prospect cannot answer without engaging. Example shape: "Why do men over 35 crash at 3pm even after 8 hours of sleep?"
- **#6 Specific Number Headline.** A number the prospect can verify or remember. Example shape: "97% of men who try this take it every single morning."
- **#11 Promise of Inside Information.** Signals the prospect is about to learn something kept from most people. Example shape: "What 90% of supplement companies don't want you to check on the label."
- **#14 Statement of Astonishment.** A verifiable fact framed as surprising. Example shape: "Your father had 25% more testosterone at your age."
- **#19 Reframed Alternative.** Names what the prospect currently uses and recasts its function. Example shape: "Your morning energy drink is making you tired by 3pm. Here's the math."
- **#20 Promise of Simplicity.** Signals the protocol is shorter than the prospect expects. Example shape: "One gummy. Every morning. That's the entire protocol."
- **#21 Numbered List.** Headline promises a list the prospect can scan. Example shape: "3 signs your body is stuck in the stress-T loop."
- **#25 Customer Quote.** A direct testimonial framed as the headline. Example shape: "My wife asked what I was taking before I noticed anything had changed."
- **#28 Headline as Demonstration.** Headline implies the ad will show something. Example shape: "Watch what 30 days of daily support does to morning energy."
- **#34 Single-Word Punch.** A fragment that lands harder than a full sentence. Example shape: "Finally."

The full 38-method inventory lives in Schwartz's Chapter 4. The 12 above cover roughly 90% of D2C use cases.

### Headline Stage-Fit Table

Match the method to the awareness stage. This is a guide, not a rule - some methods work across multiple stages. The check fails when a method cannot earn attention at the prospect's stage.

| Awareness Stage | Methods that work |
|-----------------|-------------------|
| Unaware | #25 Customer Quote (story-coded), #14 Astonishment, #4 Question (rhetorical), #28 Demonstration |
| Problem Aware | #1 Benefit, #2 New Mechanism, #4 Question (problem-coded), #6 Specific Number, #11 Inside Information |
| Solution Aware | #2 New Mechanism (differentiated), #6 Specific Number, #19 Reframed Alternative, #20 Simplicity |
| Product Aware (Solution-Switching) | #19 Reframed Alternative (concentrated), #11 Inside Information, #14 Astonishment |
| Most Aware | #25 Customer Quote, #1 Benefit (specific), #6 Specific Number (social proof) |

### Sophistication-Fit Check

If the angle is at sophistication Stage 4 or 5, the headline often needs to do extra work:

- **Stage 4:** the headline should contain a Mechanization cue ("hidden loop," "the real cause") so it differentiates from category claims. Without the cue, the headline reads as another commodity claim and bounces.
- **Stage 5:** the headline should lead with Identification with category exhaustion. Example shape: "Tired of supplements that don't work? Here's why this one is different."

### Headline Generation Procedure

When the user requests headline variants, run this procedure in Step 3 of the workflow:

1. Pull the angle card's awareness stage and sophistication score.
2. Pick 3-5 Schwartz methods from the stage-fit table that fit the awareness stage.
3. Generate one headline per method, in brand voice (per the copywriting guide).
4. If sophistication is Stage 4+, confirm each headline includes the appropriate Schwartz cue (mechanism cue for Stage 4, exhaustion identification for Stage 5).
5. Run the brand's full Phase 4 humanization pass on each headline (no em dashes, no forbidden vocab, voice register intact).
6. Submit the top 3 with method tags on the creative brief.

### Pressure Test for Ad Concepts

When auditing an ad concept (existing or proposed), run these four checks:

1. **Angle inheritance.** Does the concept's lead emotion, mechanism, and alternative attack match the angle card it descends from? Drift is the most common cause of weak performance.
2. **Technique density correct for awareness stage.** Apply the density rule above. Over-loaded ads scatter; under-loaded ads underwork.
3. **Headline uses a Schwartz method (or it's method-less).** Method-less headlines ("Take control of your health") fail at Stage 3+. If the concept has a method-less headline, propose 2-3 method-tagged alternatives.
4. **Concentration target named (Stage 4-5 only).** At Stage 4-5, most ads need a specific alternative to attack. Generic "most supplements don't work" is not concentration.

If any check fails, surface the finding and propose a concrete revision.

**If this brand has not yet completed Schwartz onboarding:** see `_frameworks/breakthrough-advertising-brand-onboarding.md` in `contextarchitect/context-architect-brands` for the 30-60 minute scoped session that produces `schwartz-applied.md`.

## Quality Checklist

Before delivering any ad concept:

- [ ] Brand colors correct (exact hex codes from brand guidelines)
- [ ] Typography matches brand font
- [ ] Avatar-visual alignment verified (demographics, context match target)
- [ ] Product placement only in positive contexts
- [ ] Ad copy follows copywriting guide rules
- [ ] Forbidden vocabulary checked
- [ ] Image restrictions from funnel config applied
- [ ] Dimensions correct for target platform
- [ ] Nano Banana prompt uses Three-Layer Model
- [ ] Product reference images specified where applicable

**Schwartz Structural Layer (only if `schwartz-applied.md` exists for this brand):**
- [ ] Style choice matches the technique the angle needs (Style-to-Schwartz mapping)
- [ ] Technique density correct for the awareness stage (density rule)
- [ ] Headline tagged with a Schwartz method on the brief
- [ ] If sophistication Stage 4: headline contains a mechanism or inside-information cue
- [ ] If sophistication Stage 5: headline identifies with category exhaustion
- [ ] Concentration target (if applicable to angle) is named specifically, not generalized

## What This Skill Does NOT Do

- Does not generate images (provides Nano Banana prompts; user generates externally)
- Does not place ads on platforms (provides creative assets only)
- Does not create ad campaigns or targeting strategies
- Does not handle video ads (static image ads only - video guidance is in the funnel-builder skill)
- Does not replace the brand's copywriting guide (reads and applies it)
