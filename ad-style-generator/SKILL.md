---
name: ad-style-generator
description: "Generate ad creative briefs and Nano Banana image prompts using a 12-style catalogue mapped to brand identity and avatar psychology. Use when user says 'create an ad', 'ad creative', 'generate ad images', 'ad style for [topic]', 'create a [SCIENCE-FRIENDLY/BA-EMOTION/etc] ad', 'ad campaign for [avatar/product]', or references ad creative development for any brand. Reads brand guidelines, avatar profiles, and copywriting guide to produce brand-consistent ad concepts with complete Nano Banana prompts."
---

# Ad Style Generator Skill

## Purpose

Generate production-ready ad creative briefs with complete Nano Banana Pro image prompts by combining a universal 12-style catalogue with brand-specific identity (colors, typography, avatars, product references) pulled from existing brand documents. No separate brand-specific ad catalogue needed — the skill reads Phase 1-4 outputs and applies them to universal style frameworks.

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

1. **Brand Guidelines (Phase 3)** — colors (hex codes), typography, logo treatment, visual identity rules, positioning
2. **Avatar Profiles (Phase 2)** — target segments, awareness stages, emotional triggers, language preferences
3. **Copywriting Guide (Phase 4)** — voice rules, forbidden vocabulary, tone per archetype
4. **Funnel Config (Phase 5)** — product reference images (REF numbers), image generation rules, visual restrictions

If any of these are missing, note the gap and work with what's available. Brand Guidelines is the minimum requirement.

### From User (Per Request)

Ask the user to specify or help them determine:

1. **Target avatar** — which segment is this ad for?
2. **Objective** — awareness, consideration, conversion, retargeting?
3. **Platform** — Meta/Facebook, Instagram feed, Instagram Stories, TikTok, email, landing page?
4. **Topic/angle** — what is the ad about?
5. **Style preference** — specific style requested, or should the skill recommend?

If the user doesn't specify a style, use the Style Selection Framework in `references/style-catalogue.md` to recommend 2-3 appropriate styles based on the objective, avatar, and platform.

## Workflow

```
STEP 1: CONTEXT LOADING (automatic)
  → Read brand guidelines (colors, fonts, visual identity)
  → Read avatar profiles (target segment details)
  → Read copywriting guide (voice, forbidden vocabulary)
  → Read funnel config (product refs, image rules)

STEP 2: STYLE SELECTION (with user)
  → User specifies style OR skill recommends based on objective/avatar/platform
  → Read the specific style framework from references/style-catalogue.md
  → Confirm approach with user

STEP 3: CREATIVE BRIEF (generate)
  → Concept description (what the ad shows)
  → Ad copy (headline, body, CTA — following copywriting guide rules)
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

1. **No em dashes** — ever, in any ad copy
2. **No forbidden AI vocabulary** — check the brand's list
3. **GCC compliance** (if applicable) — no specific city/country names unless the brand permits
4. **No absolute medical claims** — avoid "cure," "guarantee," "eliminate" without qualifiers
5. **No competitor names** — generic references only ("other products" not specific brands)
6. **Product placement rule** — product appears only in solution/positive contexts, never in problem/negative contexts

## Batch Generation

When the user requests multiple ad concepts:

1. Vary styles across the batch (don't repeat the same style unless requested)
2. Vary angles/concepts within same style if multiple ads use one style
3. Match each concept to the most appropriate avatar
4. Output all concepts in a single downloadable markdown file
5. Name each concept clearly: `[STYLE]-[topic-slug]-[variant].png`

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

## What This Skill Does NOT Do

- Does not generate images (provides Nano Banana prompts; user generates externally)
- Does not place ads on platforms (provides creative assets only)
- Does not create ad campaigns or targeting strategies
- Does not handle video ads (static image ads only — video guidance is in the funnel-builder skill)
- Does not replace the brand's copywriting guide (reads and applies it)
