---
name: brand-analyzer
description: "Phase 3 brand guidelines builder and existing brand analyzer. PRIMARY USE: Create comprehensive brand guidelines for new projects by synthesizing Phase 1 (Business Validation) and Phase 2 (Avatar Research) reports into a complete brand identity document. Trigger on: 'create brand guidelines', 'run Phase 3', 'brand guidelines', 'build brand identity', 'brand guidelines for [brand]'. SECONDARY USE: Analyze, audit, or document existing brands. Trigger on: 'analyze [brand]', 'brand audit', 'brand analysis', 'assess brand health', 'evaluate [brand] brand'."
---

# Brand Analyzer — Phase 3 Brand Guidelines Builder & Brand Analysis Tool

## Overview

This skill has two modes of operation:

**Mode A — Phase 3 Pipeline (Primary):** Build comprehensive brand guidelines for a new project by extracting and synthesizing data from Phase 1 (Business Validation) and Phase 2 (Avatar Research) reports. This is the standard workflow when setting up a new brand within the ContextArchitect pipeline: Business Validation → Avatar Research → **Brand Guidelines** → Copywriting Guide → Funnels → Ad Creatives.

**Mode B — Existing Brand Analysis (Secondary):** Analyze, audit, or document an existing external brand. Provides brand health scoring, consistency evaluation, competitive analysis, and improvement recommendations.

## Mode Detection

**Use Mode A when ANY of these are true:**
- User says "create brand guidelines," "run Phase 3," "build brand guidelines," or "brand guidelines for [brand name]"
- Phase 1 and/or Phase 2 reports are available in the conversation, project knowledge, or referenced by the user
- User is working within the ContextArchitect pipeline (Phases 1-6)
- User provides a business validation report and/or avatar research and asks for brand guidelines

**Use Mode B when ALL of these are true:**
- User says "analyze [brand]," "brand audit," "assess brand health," or "evaluate [brand]"
- No Phase 1 or Phase 2 reports are referenced or available
- The subject is an existing external brand the user wants evaluated

**When ambiguous:** Ask the user whether they want to build brand guidelines from research (Mode A) or analyze an existing brand (Mode B). Do NOT default to Mode B and start asking discovery questions if the user said "create brand guidelines."

---

## MODE A: Phase 3 Pipeline — Build Brand Guidelines from Research

### Purpose

Transform Phase 1 (Business Validation) and Phase 2 (Avatar Research) outputs into comprehensive brand guidelines that serve as the foundational identity document for all downstream work: copywriting guide, funnel development, ad creative, and all brand touchpoints.

The skill extracts everything derivable from the research, derives brand identity decisions from the data, and only asks the user for inputs that genuinely require human creative judgment.

### Required Inputs

1. **Phase 2 Avatar Research Report** (PRIMARY) — provides customer emotional landscapes, visual preferences, language patterns, tone requirements, aspirational identities, and the cross-avatar synthesis that drives voice and visual direction
2. **Phase 1 Business Validation Report** (PRIMARY) — provides market positioning, competitive landscape, product architecture, messaging hierarchy, regulatory boundaries, and founder directives

### Optional Inputs

- **Client braindump** — may contain founder preferences on visual direction, brand name rationale, or specific creative constraints not captured in Phase 1
- **Existing brand assets** — if the brand already has a logo, colors, or other visual identity elements, these should be documented rather than reinvented

### What Happens If Phase 1 or Phase 2 Is Missing

| Available | Behavior |
|-----------|----------|
| Phase 1 + Phase 2 | Full pipeline — extract, derive, minimal questions |
| Phase 2 only | Can build voice, tone, visual direction from avatars. Will need user input on market positioning, competitive context, product architecture |
| Phase 1 only | Can build positioning, architecture, competitive context. Will need user input on customer emotional landscape, visual preferences, language patterns |
| Neither | Do NOT proceed with Mode A. Ask user to provide research outputs, or offer to switch to Mode B if they want a brand analysis instead |

---

### Step 1: Extract from Phase 1 (Business Validation)

Read the business validation report and extract these data points. Each feeds a specific section of the brand guidelines.

| Phase 1 Section | What to Extract | Feeds Into |
|----------------|----------------|------------|
| Executive Summary / Verdict | Business stage, conditions, strategic direction | Brand strategy foundation context |
| Product Portfolio | Products, pricing tiers, hero product, expansion roadmap | Brand architecture, product naming conventions |
| Market Position | Category, price position, competitive set, key differentiator | Positioning statement, "only brand that..." claim |
| Competitive Landscape | Competitor names, positioning, strengths, weaknesses, white space | Reference brands (study/avoid), differentiation strategy |
| Customer Avatars (preliminary) | Segment names, sizes, priority ranking | Audience alignment validation |
| Messaging/Positioning | Messaging hierarchy, recommended hooks, acquisition strategy | Primary brand message, message pillars, hierarchy |
| Regulatory/Compliance | Claim boundaries, what can/cannot be said, risk tolerance | Vocabulary constraints, claim guardrails |
| Founder Directives (🗣️) | Strategic preferences, non-negotiables, creative constraints | Brand governance, flexibility zones |
| Product Expansion Roadmap | Future products, launch sequence, format strategy | Brand architecture, sub-brand potential |
| Survey/Customer Data | Purchase drivers, satisfaction metrics, information gaps | Brand promise validation, proof strategy |

### Step 2: Extract from Phase 2 (Avatar Research)

Read the avatar research report and extract these data points across ALL personas.

| Avatar Section | What to Extract | Feeds Into |
|---------------|----------------|------------|
| Section K (Visual Preferences) | Colors, aesthetics, photography style, deal-breakers per persona | Visual identity direction (cross-avatar synthesis) |
| Section L (Messaging) | Emotional hooks, headlines, CTAs, language do/don't, proof types | Voice and tone, vocabulary, tagline direction |
| Section F (Emotional Landscape) | Dominant emotions, beliefs, internal monologue, triggers | Brand personality, emotional promise |
| Section H (Desires/Aspirational) | HAVE/DO/FEEL/BE per persona | Brand promise, vision statement |
| Section I (Objections) | Primary objections, stigma levels | Trust signal strategy, what brand must address |
| Section D (Media/Platform) | Platform preferences, content consumption patterns | Channel-specific brand expression principles |
| Section G (Decision Architecture) | Top objections, decision triggers, proof requirements | Proof presentation strategy, trust signals |
| Strategic Synthesis | Unifying brand thread, shared patterns, one-brand-five-funnels logic | Core brand values, unifying positioning |
| Creative Engine Registry | Condensed per-avatar tone, hook, CTA, language | Quick-reference for tone adaptation section |
| Segment Assessment | Additional segments (e.g., gift buyers) | Brand application considerations |

### Step 3: Derive Brand Identity Decisions

This is the critical synthesis step. Rather than asking the user to define these from scratch, DERIVE them from the extracted data.

#### 3.1 Derive Brand Archetype

Cross-reference:
- Avatar emotional needs (Section F across all personas) → What archetype addresses these needs?
- Competitive white space (Phase 1 landscape) → What archetype is unclaimed in the category?
- Market positioning (Phase 1) → What archetype fits the price tier and differentiation?
- Avatar aspirational identities (Section H) → What archetype reflects who they want to become?

Use `references/brand_archetypes.md` for the full archetype framework. Identify primary (60-70%) and secondary (30-40%) archetypes. Provide rationale connecting the archetype selection to specific data points from the research.

#### 3.2 Derive Visual Direction

Synthesize Section K (Visual Preferences) across ALL personas to find:
- **Shared visual preferences** — elements that resonate across multiple personas (these become primary visual direction)
- **Visual deal-breakers** — anything flagged as negative by ANY major persona (these become "visual don'ts")
- **Persona-specific adaptations** — visual elements that serve specific segments in targeted creative (noted but don't drive the core identity)

Map the shared preferences to specific visual identity decisions: color palette direction, typography style, photography approach, layout philosophy.

#### 3.3 Derive Voice and Tone

Synthesize Section L (Messaging) and Section D (Authentic Voice) across ALL personas:
- **Shared vocabulary** — words/phrases that resonate across multiple personas → core brand vocabulary
- **Universal avoidance list** — words flagged as negative by ANY persona → brand vocabulary prohibitions
- **Tone spectrum** — map each persona's preferred tone to define the brand's tone range (the brand voice stays consistent; tone adapts by context/audience)
- **Formality level** — derived from audience sophistication + competitive positioning

#### 3.4 Derive Positioning Statement

Combine:
- Phase 1 key differentiator + competitive white space
- Phase 2 unifying brand thread from Strategic Synthesis
- The intersection of what avatars need + what competitors don't provide

Format: "For [target], [Brand] is the [category] that [key differentiator] because [reason to believe]."

#### 3.5 Derive Brand Values

Extract from:
- Phase 2 Strategic Synthesis shared patterns → what all personas value
- Phase 1 founder directives → what the business commits to
- Phase 2 Section I objections → what the brand must stand against (values often emerge from what customers reject in competitors)

For each value: define what it means, how it manifests in practice, and what it explicitly rejects.

#### 3.6 Derive Reference Brands

From Phase 1 competitive landscape, categorize:
- **Brands to study** — competitors or adjacent brands whose specific elements (not whole identity) are worth learning from. Extract the SPECIFIC element to study (e.g., "Thorne: clinical credibility and COA presentation" not just "Thorne")
- **Brands to avoid emulating** — competitors or adjacent brands whose positioning, visual identity, or messaging represents what this brand should NOT be. State WHY each should be avoided.

### Step 4: Gap-Fill Questions

After completing Steps 1-3, identify what CANNOT be derived from the research. These are the only things to ask the user about.

**Typical gap-fill items (ask only what's actually missing):**

| Gap | Why It Can't Be Derived | Example Question |
|-----|------------------------|------------------|
| Brand name rationale | Creative/founder decision | "What's the story behind the name? Any meaning or etymology to document?" |
| Logo direction | Creative decision beyond data | "Do you have an existing logo or logo direction? If not, any strong preferences on style (wordmark, icon, combination)?" |
| Specific color preferences | Research gives direction, not hex codes | "The research points toward [derived direction]. Do you have specific colors in mind, or should I recommend a palette?" |
| Font preferences | Research gives style direction | "Any existing font choices, or should I recommend based on the [derived style] direction?" |
| Founder's vision statement | Personal aspiration beyond data | "Where do you see this brand in 5-10 years? The research suggests [market opportunity], but the vision should reflect your ambition." |
| Existing assets to preserve | User knowledge | "Are there any existing brand elements (logo, colors, fonts, taglines) that must be carried forward?" |

**Rules for gap-fill:**
- Ask ALL gap-fill questions in a SINGLE message, not spread across multiple turns
- Group questions logically
- Provide the derived direction alongside each question so the user can confirm, modify, or override
- If the user says "just make the decisions" or "you decide," proceed with the derived recommendations
- Never ask about things that are clearly answered in the research

### Step 5: Generate Brand Guidelines Document

Use the template at `assets/phase3_brand_guidelines_template.md` to generate the complete document.

#### Output Structure (Five Sections)

**Section 1: Brand Strategy Foundation**
- 1.1 Brand Positioning Statement
- 1.2 Brand Purpose and Mission
- 1.3 Brand Vision
- 1.4 Brand Values (4-5 values, each with definition, practice, rejection)
- 1.5 Brand Personality and Archetype (primary + secondary, with rationale)
- 1.6 Brand Promise (functional + emotional)
- 1.7 Target Audience Summary (condensed from Phase 2, NOT the full avatar profiles)

**Section 2: Verbal Identity**
- 2.1 Brand Voice (3-5 core characteristics with detailed descriptions)
- 2.2 Tone Guidelines (tone spectrum, tone by channel, tone by audience segment)
- 2.3 Messaging Framework (primary message, supporting pillars with proof points, message hierarchy)
- 2.4 Tagline Candidates (3-5 options with rationale, primary recommendation)
- 2.5 Vocabulary and Terminology (words we use, words we avoid, technical term handling, category language)
- 2.6 Writing Style Guide (sentence structure, punctuation, number presentation, competitor references, claims and disclaimers)
- 2.7 Boilerplate Copy (brand description at 25, 50, 100 words; product category descriptions)

**Section 3: Visual Identity**
- 3.1 Logo System (concept direction, variations, usage rules, do's and don'ts)
- 3.2 Color Palette (primary, secondary, accent, neutral — with rationale connecting to avatar preferences and archetype)
- 3.3 Typography (primary, secondary, utility typefaces with hierarchy and usage)
- 3.4 Photography Style (philosophy, people, product, lifestyle, scientific/abstract imagery guidelines)
- 3.5 Iconography and Illustration (style, when to use, category-specific requirements)
- 3.6 Graphic Elements (patterns, data visualization, charts, borders)
- 3.7 Layout Principles (grid philosophy, white space, visual hierarchy, responsive considerations)

**Section 4: Brand Applications (Principles, Not Executions)**
- 4.1 Digital Presence Principles (website philosophy, UX principles, content hierarchy, trust signal placement)
- 4.2 Packaging Principles (philosophy, information hierarchy, sustainability, unboxing experience)
- 4.3 Social Media Principles (platform strategy, content pillars, visual consistency, engagement approach)
- 4.4 Advertising Principles (creative philosophy, proof presentation, hooks, what ads never do)
- 4.5 Content Principles (educational approach, scientific translation, UGC guidelines, partnership criteria)

**Section 5: Brand Governance**
- 5.1 Brand Architecture (master brand to products, naming conventions, sub-brand potential, co-branding)
- 5.2 Brand Consistency (non-negotiable elements, flexibility zones, common mistakes)
- 5.3 Reference Brands (brands to study with specific elements, brands to avoid with rationale)

#### Output Quality Standards

**Length:** Determined by brand complexity. Simple single-product brands may be 5,000-7,000 words. Multi-product brands with complex competitive positioning and multiple personas should be 8,000-12,000 words. The document must be comprehensive enough that anyone using it can produce recognizably on-brand work.

**Format:**
- Clear section headers and subheaders for navigation
- Tables and matrices where appropriate for quick reference
- Specific examples throughout — not just principles, but illustrations of how they apply
- Do's and don'ts formatted for easy scanning
- Color recommendations with hex codes where specified
- Reference brand citations with the SPECIFIC element to learn from

**Tone of the document itself:**
- Authoritative but not rigid
- Practical and actionable
- Reflects the brand voice it's describing (the guidelines should feel like the brand)
- Assumes the reader is intelligent

**Visual descriptions:**
- Since this is a text document, provide detailed verbal descriptions of visual concepts
- Include specific color codes where colors are defined
- Reference real-world brand examples for visual directions
- Describe mood board concepts in enough detail to brief a designer

**Critical success criteria:**
1. **Unifies all personas** — every recommendation resonates across all primary avatars without fragmenting the brand
2. **Anchored in research** — every major decision traces back to specific data points from Phase 1 or Phase 2
3. **Enables downstream phases** — the copywriting guide (Phase 4) should be able to extract voice, tone, and positioning directly from this document
4. **Differentiates from competitors** — visual and verbal identity should be ownable and distinct from the competitive set identified in Phase 1
5. **Allows flexibility** — principles over rigid rules; enable smart adaptation across contexts
6. **Addresses trust barriers** — incorporates trust signal strategy derived from avatar objections

**What to explicitly exclude:**
- Full avatar profiles (those live in the Phase 2 document; include only a condensed summary)
- Website wireframes, social media calendars, ad creative, email sequences (those are Phases 4-6)
- Tactical executions of any kind — this document defines the playing field, not the plays

### Step 6: Deliver and Handoff

After generating the guidelines document:

1. Save as `brand-guidelines-[BRANDNAME]-[YYYY-MM-DD].md`
2. Summarize the key identity decisions made (archetype, positioning, voice pillars, visual direction)
3. Note any areas where the user should make a final creative decision (e.g., logo execution, final color hex selection)
4. Confirm readiness for Phase 4 (Copywriting Guide) — the brand guidelines should contain everything the copywriting-guide skill needs to extract

---

## MODE B: Existing Brand Analysis

Use this mode when analyzing, auditing, or documenting an existing external brand. This workflow does NOT require Phase 1 or Phase 2 reports.

### Step 1: Determine Analysis Type

Identify what type of brand work is needed:

**A. Existing Brand Analysis**
- Analyzing current brand state
- Identifying inconsistencies and gaps
- Output: Brand analysis report with recommendations

**B. Quick Brand Audit**
- Fast assessment of brand health
- Checking for consistency issues
- Output: Quick audit checklist with scores

**C. Brand Guidelines Documentation**
- Documenting existing brand elements for an established brand
- Formalizing standards and rules from existing materials
- Output: Professional brand guidelines reflecting current state

### Step 2: Gather Brand Information

Collect relevant information based on analysis type. Use the questions from `references/brand_analysis_framework.md` as a guide.

**Essential Information:**
- Brand name and tagline
- Mission and vision statements
- Core values
- Target audience details
- Industry and competitive context
- Existing brand materials (if any)

**Visual Identity Information:**
- Logo and variations
- Color palette (with codes)
- Typography (font families)
- Imagery style preferences
- Design elements

**Voice and Messaging:**
- Brand personality traits
- Tone of voice
- Key messages
- Value proposition
- Language preferences

**Additional Context:**
- Brand history and evolution
- Customer perception
- Competitive positioning
- Business goals
- Brand touchpoints

### Step 3: Analyze Brand Archetype

Identify the brand's personality using the 12 archetypes framework from `references/brand_archetypes.md`.

**Analysis Process:**
1. Review brand's core desire and goals
2. Assess personality traits and values
3. Consider target audience aspirations
4. Evaluate competitive positioning
5. Identify primary archetype (60-70% influence)
6. Identify secondary archetype (30-40% influence)

### Step 4: Conduct Brand Analysis

Perform comprehensive analysis using the framework from `references/brand_analysis_framework.md`.

**Key Analysis Areas:**

1. **Brand Identity** — Mission/vision clarity, values authenticity, personality expression, archetype fit
2. **Visual Identity** — Logo effectiveness, color appropriateness, typography hierarchy, imagery consistency
3. **Voice and Messaging** — Voice consistency, tone adaptation, message clarity, value proposition strength
4. **Target Audience Alignment** — Audience definition, brand-audience fit, messaging resonance
5. **Market Position** — Competitive differentiation, unique value proposition, positioning clarity
6. **Brand Consistency** — Cross-channel consistency, touchpoint alignment, quality standards

### Step 5: Generate Output Document

Create the appropriate deliverable based on analysis type:

- **Brand Analysis Report** → Use `assets/brand_analysis_report_template.md`
- **Quick Brand Audit** → Use `assets/quick_brand_audit_template.md`
- **Brand Guidelines (documenting existing)** → Use `assets/brand_guidelines_template.md`

### Step 6: Provide Recommendations

Based on analysis, provide actionable recommendations using the prioritization framework:
- **High Impact + Low Effort**: Quick wins — do immediately
- **High Impact + High Effort**: Strategic initiatives — plan carefully
- **Low Impact + Low Effort**: Nice-to-haves — do when possible
- **Low Impact + High Effort**: Avoid — not worth resources

### Step 7: Create Implementation Roadmap

Provide phased approach:
- **Phase 1 (0-30 days):** Critical fixes, quick wins, documentation updates
- **Phase 2 (1-3 months):** Medium-priority improvements, guideline development, team training
- **Phase 3 (3-6+ months):** Strategic initiatives, major redesigns, comprehensive rollouts

---

## Advanced Features (Both Modes)

### Competitive Brand Analysis

When comparing to competitors:
1. Identify 3-5 key competitors
2. Analyze their positioning and differentiation
3. Map brand attributes on positioning matrix
4. Identify gaps and opportunities
5. Recommend differentiation strategy

### Brand Health Scoring

Provide quantitative assessments (Mode B primarily, but can be used in Mode A for competitive benchmarking):

| Category | Score (1-10) |
|----------|-------------|
| Visual Identity | Logo, colors, typography coherence |
| Brand Foundation | Mission, values, personality clarity |
| Voice & Messaging | Consistency and effectiveness |
| Consistency | Cross-channel alignment |
| Audience Alignment | Target fit and appeal |
| Differentiation | Competitive uniqueness |
| Documentation | Guidelines completeness |

---

## Reference Files

### `references/brand_analysis_framework.md`
Comprehensive framework covering core brand elements, discovery questions, brand consistency checkpoints, guideline categories, and audit checklists. **Used by both Mode A and Mode B.**

### `references/brand_archetypes.md`
Complete guide to Jung's 12 brand archetypes with core desires, goals, strategies, voice characteristics, visual directions, and example brands. **Used by both Mode A (Step 3.1 archetype derivation) and Mode B (Step 3 archetype identification).**

## Asset Templates

### `assets/phase3_brand_guidelines_template.md`
**Mode A output template.** Comprehensive five-section brand guidelines structure designed to receive synthesized Phase 1 + Phase 2 data. Sections: Brand Strategy Foundation, Verbal Identity, Visual Identity, Brand Applications, Brand Governance.

### `assets/brand_guidelines_template.md`
**Mode B output template.** Standard brand guidelines template for documenting existing brand elements.

### `assets/brand_analysis_report_template.md`
**Mode B output template.** Comprehensive analysis report for existing brand evaluation.

### `assets/quick_brand_audit_template.md`
**Mode B output template.** Rapid assessment checklist for brand health evaluation.

---

## Pipeline Context

This skill is Phase 3 in the ContextArchitect brand development pipeline:

```
Phase 1: Business Validation  →  Market, product, competitive, regulatory context
Phase 2: Avatar Research       →  Customer personas with emotional depth, visual/verbal preferences
Phase 3: Brand Guidelines      →  THIS SKILL (Mode A) — synthesizes Phase 1+2 into brand identity
Phase 4: Copywriting Guide     →  Extracts voice, tone, positioning from Phase 3 + avatars from Phase 2
Phase 5: Funnel Development    →  Uses brand guidelines + copywriting guide + avatars
Phase 6: Ad Creatives          →  Uses all above for brand-consistent creative generation
```

**What Phase 4 (Copywriting Guide) expects from this document:**
- Brand personality and archetype (for voice foundation)
- Voice pillars with formality and confidence level
- Visual identity cues that inform visual language in copy
- Positioning and competitive stance (for positioning guardrails)
- Core values and rejected values (for cultural considerations)
- Messaging framework with core message, elevator pitch, taglines

If the brand guidelines document is complete, the copywriting-guide skill should be able to extract everything it needs without additional user input about brand identity.
