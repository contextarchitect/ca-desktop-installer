---
name: copywriting-guide
description: "Generate a complete Human-Centered Copywriting Guide for any brand by extracting voice, tone, archetype language, and humanization rules from avatar research and brand guidelines. Use this skill whenever the user wants to create a copywriting guide, content writing standards, brand voice guide, humanization guidelines, or AI detection firewall for a brand. Trigger on phrases like: 'run Phase 4', 'copywriting guide', 'writing guide', 'brand voice guide', 'humanization rules', 'content standards', 'how should this brand write'. This skill reads Phase 2 (Avatar Research) output and Phase 3 (Brand Guidelines) as primary inputs and generates a complete, ready-to-use copywriting manual that any LLM can follow to produce human-sounding, brand-consistent copy."
---

# Copywriting Guide Skill

## Purpose

Generate a complete Human-Centered Copywriting Guide by synthesizing avatar research (who we're talking to, how they speak, what resonates) with brand guidelines (who we are, how we sound, what we stand for). The output is a standalone document that any LLM can use as a training manual to produce copy that sounds authentically human, passes AI detection, and connects emotionally with each customer segment.

This is Phase 4 in the brand development workflow: Business Validation → Avatar Research → Brand Guidelines → **Copywriting Guide** → Funnel Development.

## When to Use

- User says "run Phase 4" or "copywriting guide" for a brand
- User has completed avatar research and brand guidelines and needs writing standards
- User wants to create humanization rules, AI detection firewall, or voice guidelines
- User wants to standardize how copy sounds across all brand touchpoints
- User needs a document that teaches LLMs to write in a specific brand voice

## Required Inputs

This skill requires TWO primary inputs:

1. **Phase 2 Avatar Research Output** - provides customer archetypes with language preferences, emotional drivers, tone requirements, vocabulary patterns, and proof type preferences per segment
2. **Phase 3 Brand Guidelines** - provides brand identity, voice pillars, visual identity cues, positioning, values, and competitive differentiation

### Optional Inputs

- **Phase 1 Business Validation Report** - provides market context, regulatory claim boundaries, competitive positioning
- **Client Braindump** - provides product mechanism, pricing, founder's voice preferences
- **Existing copy samples** - if the brand already has content, samples help calibrate the guide to existing voice

## Workflow Overview

```
1. INGEST     -> Read avatar research + brand guidelines
2. EXTRACT    -> Pull voice inputs from both sources
3. MAP        -> Map archetypes to copy requirements
4. GENERATE   -> Populate the copywriting guide template
5. CALIBRATE  -> Add category-specific rules and examples
6. STRUCTURE  -> Add the seven-technique structural layer
7. OUTPUT     -> Deliver complete guide
```

## Step 1: Ingest and Extract

### From Avatar Research (Primary Voice Source)

The avatar research is the most important input because it determines HOW copy should sound for each customer segment.

| Avatar Section | What to Extract | Feeds Into |
|---------------|----------------|------------|
| Section D (Authentic Voice) | Vocabulary patterns, sample quotes, complaint language | Archetype language preferences |
| Section E (Pain/Desire) | Fears, desires, frustrations in their own words | Emotional hooks per archetype |
| Section F (Emotional Landscape) | Dominant emotions, beliefs, trust requirements | Tone calibration per archetype |
| Section G (Buying Behavior) | Decision triggers, proof requirements, risk needs | Proof language, CTA style |
| Section L (Messaging Implications) | Emotional hooks, objections, language to use/avoid, headlines | Direct archetype copy guidance |
| Strategic Synthesis | Segment dynamics, platform strategy, pricing psychology | Content type guidance, positioning |

### From Brand Guidelines (Identity Source)

| Guidelines Section | What to Extract | Feeds Into |
|-------------------|----------------|------------|
| Brand Personality/Archetype | Core personality traits, archetype | Voice foundation |
| Voice and Tone | Voice pillars, formality, confidence level | Voice pillars section |
| Visual Identity | Colors, aesthetic, photography style | Visual language cues |
| Positioning | Market position, pricing tier, competitive stance | Positioning guardrails |
| Values | Core values, rejected values | Cultural considerations |
| Messaging Framework | Core message, elevator pitch, taglines | Approved language, taglines |

### From Business Validation (Claim Boundaries)

| Validation Section | What to Extract | Feeds Into |
|-------------------|----------------|------------|
| Regulatory findings | What can/cannot be claimed | Claim boundaries |
| Hypothesis testing | Validated vs contradicted claims | Mechanism messaging |
| Competitive landscape | Competitor positioning, white space | Competitor comparison rules |

## Step 2: Map Archetypes to Copy Requirements

For each avatar from Phase 2, construct an archetype copy profile:

```
ARCHETYPE: [Name from avatar research]
WHO: [Demographics + psychographics, 1-2 sentences]
CORE EMOTIONS: [From Section F, with intensity 1-10]
TONE: [Derived from their emotional state + brand voice intersection]
LANGUAGE THAT RESONATES: [From Section L "Language to Use" + Section D vocabulary]
LANGUAGE TO AVOID: [From Section L "Language to Avoid" + general brand prohibitions]
SENTENCE STRUCTURE: [Derived from their sophistication level and platform preferences]
CORE PROMISE: [From Section L "Aspirational Identity" or Section H primary want]
EXAMPLE PARAGRAPH: [Write a 4-6 sentence sample targeting this archetype specifically]
```

### Tone Calibration Logic

The tone for each archetype is NOT the same as the brand voice. It's the intersection of brand personality with the archetype's emotional state:

- Brand voice stays consistent (the personality doesn't change)
- Tone shifts based on WHO you're talking to (like how a person adjusts register)
- A "confident, scientific" brand talking to a skeptic uses proof-heavy, no-BS tone
- The same brand talking to a hopeful newcomer uses encouraging, educational tone
- The same brand talking to a price-sensitive buyer emphasizes value and ROI

For each archetype, define the tone shift by answering:
1. What emotional state are they in when they encounter us? (from Section F)
2. What proof type do they need? (from Section G)
3. What's their trust level with this category? (from Section C)
4. What would make them feel understood? (from Section E)

## Step 3: Generate Voice Pillars

Read `references/voice-construction.md` for the voice pillar construction methodology.

Voice pillars come primarily from brand guidelines but are refined by avatar research:

1. **Start with brand guideline voice traits** (typically 3-5 adjectives or principles)
2. **Convert each to a pillar** with definition, sounds-like examples, doesn't-sound-like anti-examples
3. **Test each pillar against every archetype** - does this pillar work for all segments, or does it alienate one?
4. **Add archetype-informed pillars** if the avatar research reveals voice requirements the brand guidelines missed (e.g., "Empathetic Without Being Soft" might emerge from avatar data showing segments need validation)

Each pillar needs:
- Name (3-5 word descriptor)
- Definition (2-3 sentences)
- 3 "Sounds like" example phrases
- 3 "Doesn't sound like" anti-examples
- Application guidance

## Step 4: Construct AI Detection Firewall

Read `references/humanization-rules.md` for the universal humanization rules.

The AI Detection Firewall is the most technically specific section. It contains:

1. **Forbidden vocabulary** (universal list + brand-specific additions)
2. **Burstiness principle** (sentence length variation rules with examples)
3. **Mandatory contractions** (frequency and placement rules)
4. **Conjunction starts** (starting sentences with And, But, Or, So)
5. **Strategic imperfection** (fragments, digressions, self-corrections)
6. **Hedging elimination** (removing tentative language)
7. **Em dash prohibition** (zero tolerance, with alternatives)
8. **Formulaic pattern bans** (forbidden openings and closings)

The universal rules apply to ALL brands. Brand-specific additions come from:
- Avatar research Section D vocabulary patterns (what words the audience actually uses)
- Brand guidelines tone requirements (formal brands allow fewer fragments)
- Category conventions (health brands need different claim language than fashion brands)

## Step 5: Build Content Type Quick Guides

For each major content type, provide a mini-guide showing how voice + archetype + humanization rules combine:

1. **Social media captions** - platform-specific, archetype-specific
2. **Email subject lines and body** - hooks, openings, CTAs
3. **Website headlines** - homepage, product page, landing page
4. **Product page copy** - description, benefits, proof
5. **Customer service / FAQs** - tone shift for support context
6. **Ad copy** - platform-specific (Meta, Google, TikTok)
7. **Advertorial/Listicle content** - education-led funnel copy

Each guide should include:
- Character/word limits for the format
- 1-2 examples written for the primary archetype
- Dos and don'ts specific to that content type
- The archetype to default to if unspecified

## Step 6: Add Category-Specific Messaging Framework

From business validation regulatory findings + brand guidelines positioning:

1. **How to explain the core product mechanism simply** - 1 sentence, 3 sentences, 1 paragraph versions
2. **Common objections with approved response frameworks** - for each archetype's primary objection
3. **Claim boundaries** - what can be said, what requires qualification, what's prohibited
4. **Competitor comparison rules** - how to reference competitors (or not)

## Step 7: Add the Seven-Technique Structural Layer

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

Voice rules govern HOW copy sounds. The seven techniques govern WHAT MOVE the copy is making structurally. Both layers run on every piece of brand content. This step adds a structural framework section to the copywriting guide so writers (human or LLM) know which technique to deploy in which moment.

The seven techniques come from Eugene Schwartz's Breakthrough Advertising. They are:

1. **Intensification** - build desire by making the fulfilled state vivid through multiple specific scenes
2. **Identification** - give the reader a felt identity to step into
3. **Gradualization** - sequence claims so each one earns belief from the one before
4. **Redefinition** - reframe a desire, problem, or alternative so a different solution becomes obviously correct
5. **Mechanization** - give proof a physical, mechanical, named explanation
6. **Concentration** - zoom in on ONE specific competitor or alternative and demolish it
7. **Camouflage** - hide the sales pitch inside a different surface (story, editorial, expose, FAQ)

### The Layering Rule

Pick the technique FIRST. Write the move in the brand's voice SECOND. Run the AI Detection Firewall THIRD. The technique determines what the copy is doing. Voice rules constrain how it gets said. Reverse the order and you end up with on-voice writing that is not advancing any argument.

### Writing Each Technique in Brand Voice

For each technique, the copywriting guide should include a "what this looks like in our voice" worked example drawn from the brand's actual archetype profiles.

**Intensification.** Build 3-5 vivid scenes of the prospect already living the result, each from a different angle. Phase 4's "Show, Don't Tell" rule is intensification by another name; this layer formalizes it.

Voice translation: pick the brand's primary archetype. Write five different specific moments where the prospect is already living the desired state. Different times of day, different locations, different witnesses, different textures. Apply the brand's voice rules (burstiness, contractions, vocabulary) throughout.

**Identification.** Name the identity the prospect steps into when they take action. The brand's archetype profiles already do this at the strategic level (e.g., "the dad who's fully there," "the husband she married, restored"). Identification at the COPY level means revisiting that identity early and at the close of every long-form piece.

**Gradualization.** Sequence claims smallest to biggest. The product claim arrives last, after the prospect has agreed to a chain of harder-to-deny claims. In short copy: small claim (observation) → bigger claim (mechanism) → biggest claim (product). In long copy: the entire advertorial structure does this.

**Redefinition.** Reframe what the prospect currently believes. Examples:
- "Viagra works for the 4 hours after you take it. Daily support works for your body, not for the pill." (Reframes the desire from "tonight" to "your body working again.")
- "97% adherence at clinical doses beats 60% adherence at clinical doses." (Reframes the desire from "best ingredients" to "best ingredients you'll actually take.")

Stay in voice. Reframes do not need exclamation marks; numbers and contrast carry the work.

**Mechanization.** Name the mechanism with a memorable phrase. Walk the steps in plain English. Anchor at least one step to a published study or specific data point. This is the structural form of voice pillar "Knowledgeable, Never Lecturing" if the brand has one.

**Concentration.** Pick ONE alternative the prospect is most likely using. Demolish it with mechanism + numbers, not adjectives. Do not aggregate ("most alternatives are bad"). Specific concentration is required at sophistication Stage 4+; generic dismissal fails.

**Camouflage.** Pick a content surface (advertorial, listicle, expose, FAQ, news-style). Build the sales argument underneath using techniques 1-6. The reader thinks they are reading content; structurally they are reading a sales argument. The brand's archetype profile and voice pillars determine what kind of content surface fits.

### Combining Techniques

The most common combinations across content types:

- **Single-image ad:** Concentration (one alternative attacked) + Mechanization (one mechanism named) + minimal Identification
- **Long-form advertorial:** All seven, in roughly the order above, with Camouflage as the surface
- **Email nurture sequence:** Intensification across multiple emails, one Mechanization email, one Concentration email, one Identification email at the close
- **Social post:** One technique. Pick the one that does the most work for the platform
- **Product page:** Mechanization (primary) + Redefinition (reframe the category) + minimal Identification at the testimonial section

### Pressure Test for Voice + Technique Compliance

After applying any technique, the copy must still pass the brand's full Phase 4 humanization checklist (Step 7 below). Common failure: a technique feels strong in 1966-style hype voice but fails the brand's voice rules. Restate without exclamations, without forbidden vocabulary, without em dashes. The technique is the structural move; the voice is independent.

### Output: A Section in the Final Guide

Add a section to the copywriting guide called "Structural Moves: The Seven Techniques." Include:
- The seven technique definitions (above)
- The layering rule
- One worked example per technique, written in the brand's voice for the brand's primary archetype
- The combinations table
- The pressure test reminder

**If this brand has not yet completed Schwartz onboarding:** see `_frameworks/breakthrough-advertising-brand-onboarding.md` in `contextarchitect/context-architect-brands` for the 30-60 minute scoped session that produces `schwartz-applied.md`.

## Step 8: Generate Humanization Checklist

A 4-phase self-check that any LLM runs after writing content:

**Phase 1: AI Detection Audit** - vocabulary scan, em dash check, burstiness check, hedging removal
**Phase 2: Voice Alignment** - brand voice match, archetype match, confidence check
**Phase 3: Emotional Resonance** - target emotion achieved, empathy present, aspiration without pandering
**Phase 4: Specificity and Differentiation** - no vague statements, concrete scenarios, mechanism clear

## Step 9: Present and Output

Present summary:

```
COPYWRITING GUIDE READY: [brand_name]

Inputs Loaded:
  Avatar Research: [count] archetypes
  Brand Guidelines: [count] voice pillars
  Validation Report: [available/not available]

Guide Contents:
  Voice Pillars: [count] defined
  Archetypes: [count] with full copy profiles
  Content Guides: [count] content types covered
  Humanization Rules: [count] rules in AI Detection Firewall
  Structural Moves: 7 techniques with worked examples

Total Sections: 12 + 2 appendices
Estimated Length: [word count]

Confirm or adjust:
```

Deliver the complete guide as a single markdown document the user can add to any Claude Project as a knowledge base file.

```
GUIDE GENERATED

Sections populated:
  - Brand identity and voice foundation
  - [count] voice pillars with examples
  - AI Detection Firewall ([count] rules)
  - [count] archetype copy profiles with sample paragraphs
  - Structural moves: 7 techniques with worked examples
  - Humanization checklist (4 phases)
  - [count] content type quick guides
  - Category messaging framework with claim boundaries
  - Before/after examples
  - Quick reference card

Next: Add this guide as a knowledge base file to the brand's Claude Project.
All content creation should reference this guide before writing.
```

## What This Skill Does NOT Do

- Does not write actual brand content (it creates the guide that governs content creation)
- Does not replace the avatar research or brand guidelines (it synthesizes them)
- Does not determine brand strategy (it operationalizes decisions already made)

## Edge Cases

**No avatar research available:** Can generate a basic guide from brand guidelines alone, but archetype sections will be generic. Mark as [BASIC GUIDE - UPGRADE WITH AVATAR RESEARCH].

**No brand guidelines available:** Can derive voice basics from avatar research (customer language informs brand voice), but positioning and values will be assumed. Mark as [VOICE-ONLY GUIDE - ADD BRAND GUIDELINES].

**Both inputs available but contradictory:** Brand guidelines say "formal and authoritative" but avatar research shows customers respond to "casual and peer-like." Flag the contradiction and recommend the avatar-informed direction (write for the customer, not the boardroom).

**Regulated category:** If Phase 1 identified regulatory claim boundaries, these MUST appear in the Claim Boundaries section. Health, financial, and legal categories need explicit "never say" lists.
