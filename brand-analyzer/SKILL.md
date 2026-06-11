---
name: brand-analyzer
version: "1.1.0"
description: "Phase 3 brand guidelines builder and existing brand analyzer. PRIMARY USE: Create comprehensive brand guidelines for new projects by synthesizing Phase 1 (Business Validation) and Phase 2 (Avatar Research) reports into a complete brand identity document. Trigger on: 'create brand guidelines', 'run Phase 3', 'brand guidelines', 'build brand identity', 'brand guidelines for [brand]'. SECONDARY USE: Analyze, audit, or document existing brands. Trigger on: 'analyze [brand]', 'brand audit', 'brand analysis', 'assess brand health', 'evaluate [brand] brand'."
---

# Brand Analyzer - Phase 3 Brand Guidelines Builder & Brand Analysis Tool

## Overview

This skill has two modes of operation:

**Mode A - Phase 3 Pipeline (Primary):** Build comprehensive brand guidelines for a new project by extracting and synthesizing data from Phase 1 (Business Validation) and Phase 2 (Avatar Research) reports. This is the standard workflow when setting up a new brand within the ContextArchitect pipeline: Business Validation → Avatar Research → **Brand Guidelines** → Copywriting Guide → Funnels → Ad Creatives.

**Mode B - Existing Brand Analysis (Secondary):** Analyze, audit, or document an existing external brand. Provides brand health scoring, consistency evaluation, competitive analysis, and improvement recommendations.

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

## MODE A: Phase 3 Pipeline - Build Brand Guidelines from Research

### Purpose

Transform Phase 1 (Business Validation) and Phase 2 (Avatar Research) outputs into comprehensive brand guidelines that serve as the foundational identity document for all downstream work: copywriting guide, funnel development, ad creative, and all brand touchpoints.

The skill extracts everything derivable from the research, derives brand identity decisions from the data, and only asks the user for inputs that genuinely require human creative judgment.

### Required Inputs

1. **Phase 2 Avatar Research Report** (PRIMARY) - provides customer emotional landscapes, visual preferences, language patterns, tone requirements, aspirational identities, and the cross-avatar synthesis that drives voice and visual direction
2. **Phase 1 Business Validation Report** (PRIMARY) - provides market positioning, competitive landscape, product architecture, messaging hierarchy, regulatory boundaries, and founder directives

### Optional Inputs

- **Client braindump** - may contain founder preferences on visual direction, brand name rationale, or specific creative constraints not captured in Phase 1
- **Existing brand assets** - if the brand already has a logo, colors, or other visual identity elements, these should be documented rather than reinvented

### What Happens If Phase 1 or Phase 2 Is Missing

| Available | Behavior |
|-----------|----------|
| Phase 1 + Phase 2 | Full pipeline - extract, derive, minimal questions |
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
| Positioning Guardrails / Moat Map | LEAD/SUPPORT/AVOID disposition per differentiator, the named brand world, the binding rule | GOVERNS Step 3 (see Step 3.0); binds every high-authority slot (positioning, competitive differentiation narrative, mission, vision, all brand values, all core voice characteristics, tagline, primary message, boilerplate, brand promise, only-brand claim, non-negotiables; see the Step 6 mechanical scan for the exhaustive inventory including subslots) |

The Positioning Guardrails / Moat Map (emitted by Phase 1 business-validation 1.1.0 and later) is not just another input. It is a governing constraint over Step 3. Extract it in full. If the Phase 1 report has no Moat Map block (produced before business-validation 1.1.0), see the fallback in Step 3.0.

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

#### 3.0 Apply the Positioning Guardrails (Moat Map gate)

Before deriving any identity element, establish the moat constraint that governs the rest of Step 3. Read the Positioning Guardrails / Moat Map from the Phase 1 report.

- Every high-authority slot may anchor only on LEAD differentiators or non-differentiator brand principles.
- SUPPORT differentiators appear only in 2.3 Messaging support pillars and proof points; they never anchor or appear in any high-authority slot.
- AVOID differentiators do not appear as brand claims anywhere in the guidelines.

Global invariant (applies to every high-authority slot, no exceptions): no high-authority slot may be anchored by or contain a SUPPORT or AVOID differentiator, and there is no "secondary slot" exception. The high-authority slots are positioning, the competitive differentiation narrative (what sets the brand apart), mission, vision, all brand values, all core voice characteristics, tagline, primary message, boilerplate, brand promise, only-brand claim, and non-negotiables. The Step 6 mechanical Moat Map scan holds the canonical, exhaustive inventory of these slots and their document subslots; this list and every other slot list in the skill are realizations of that inventory. SUPPORT differentiators appear only in 2.3 Messaging (supporting pillars) and proof points. AVOID differentiators do not appear as claims at all. Any per-slot rule below is reinforcement of this single invariant, not a separate or weaker rule.

A high-intensity Phase 2 emotional trigger does not override this. When a Phase 2 trigger (Step 2, Section F) is strong, map it to its differentiator's Moat Map disposition before using it. A strong trigger tied to a SUPPORT or AVOID item informs emotional tone and supporting messaging only; it cannot become primary identity. This gate is the defense against promoting a loud but commoditized trigger to identity. See `_frameworks/positioning-guardrails.md`.

Fallback when the Moat Map block is absent (legacy Phase 1 report): do not skip the gate and do not error. Build the dispositions inline from the report's own competitive and differentiation analysis (3.4 Differentiation Assessment STRONG/MODERATE/WEAK and 3.3 White Space, or the equivalent competitive section), applying the exact two-axis logic and fixed order from `_frameworks/positioning-guardrails.md`. For each differentiator, score two axes: can_lead (STRONG and brand-world-safe) and usable_in_copy (false if untrue, unsupported, off-world, or off-strategy). Derive the disposition by fixed order, first match wins: (1) if usable_in_copy is false, AVOID; (2) else if can_lead, LEAD; (3) else SUPPORT. Record this as an inline table (Item | rating | can_lead | usable_in_copy | Disposition | Reason) so the derivation is auditable. Tell the operator the Phase 1 report predates the Moat Map and the dispositions were derived inline, so they can confirm. If the report lacks even the competitive data to derive dispositions, flag the gap to the operator before proceeding rather than guessing.

#### 3.1 Derive Brand Archetype

Cross-reference:
- Avatar emotional needs (Section F across all personas) → What archetype addresses these needs?
- Competitive white space (Phase 1 landscape) → What archetype is unclaimed in the category?
- Market positioning (Phase 1) → What archetype fits the price tier and differentiation?
- Avatar aspirational identities (Section H) → What archetype reflects who they want to become?

Use `references/brand_archetypes.md` for the full archetype framework. Identify primary (60-70%) and secondary (30-40%) archetypes. Provide rationale connecting the archetype selection to specific data points from the research.

#### 3.2 Derive Visual Direction

Synthesize Section K (Visual Preferences) across ALL personas to find:
- **Shared visual preferences** - elements that resonate across multiple personas (these become primary visual direction)
- **Visual deal-breakers** - anything flagged as negative by ANY major persona (these become "visual don'ts")
- **Persona-specific adaptations** - visual elements that serve specific segments in targeted creative (noted but don't drive the core identity)

Map the shared preferences to specific visual identity decisions: color palette direction, typography style, photography approach, layout philosophy.

#### 3.3 Derive Voice and Tone

Core voice characteristics are brand principles describing how the brand communicates; they are not differentiators. Per the Step 3.0 global invariant, a SUPPORT or AVOID differentiator must never become a core voice characteristic (pillar 1 or any later pillar). A SUPPORT differentiator belongs in 2.3 Messaging, not in the voice set.

Synthesize Section L (Messaging) and Section D (Authentic Voice) across ALL personas:
- **Shared vocabulary** - words/phrases that resonate across multiple personas → core brand vocabulary
- **Universal avoidance list** - words flagged as negative by ANY persona → brand vocabulary prohibitions
- **Tone spectrum** - map each persona's preferred tone to define the brand's tone range (the brand voice stays consistent; tone adapts by context/audience)
- **Formality level** - derived from audience sophistication + competitive positioning

#### 3.4 Derive Positioning Statement

Anchor the positioning on a LEAD item per Step 3.0. The differentiator named in the positioning statement must be a LEAD item, never a SUPPORT or AVOID item.

Combine:
- Phase 1 key differentiator + competitive white space
- Phase 2 unifying brand thread from Strategic Synthesis
- The intersection of what avatars need + what competitors don't provide

Format: "For [target], [Brand] is the [category] that [key differentiator] because [reason to believe]."

#### 3.5 Derive Brand Values

No brand value may be a SUPPORT or AVOID differentiator per Step 3.0. Values are LEAD differentiators or brand principles not tied to a commoditized attribute. A commoditized-but-true attribute is expressed in 2.3 Messaging as a supporting pillar or proof point, never as a brand value.

Extract from:
- Phase 2 Strategic Synthesis shared patterns → what all personas value
- Phase 1 founder directives → what the business commits to
- Phase 2 Section I objections → what the brand must stand against (values often emerge from what customers reject in competitors)

For each value: define what it means, how it manifests in practice, and what it explicitly rejects.

#### 3.6 Derive Reference Brands

From Phase 1 competitive landscape, categorize:
- **Brands to study** - competitors or adjacent brands whose specific elements (not whole identity) are worth learning from. Extract the SPECIFIC element to study (e.g., "Thorne: clinical credibility and COA presentation" not just "Thorne")
- **Brands to avoid emulating** - competitors or adjacent brands whose positioning, visual identity, or messaging represents what this brand should NOT be. State WHY each should be avoided.

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

#### Step 5 Moat Map contract (binds generation, not just derivation)

The Step 3.0 gate binds the document slots, not only the Step 3 derivation. When populating the template, these high-authority slots may anchor only on LEAD items; SUPPORT items appear as supporting pillars and proof points only; AVOID items do not appear as claims:
- 1.1 Positioning Statement, the Only-Brand claim, and the Competitive Differentiation narrative
- 1.2 Mission Statement
- 1.3 Brand Vision (Vision Narrative and Vision Statement): an identity-level future-state claim; anchor on LEAD items only
- 1.4 Brand Values: no value may be a SUPPORT or AVOID differentiator. Values are LEAD differentiators or brand principles not tied to a commoditized attribute. A commoditized-but-true attribute is expressed in 2.3 Messaging as a supporting pillar or proof point, never as a brand value.
- 1.6 Brand Promise
- 2.1 Brand Voice core characteristics (names and definitions), their examples, and the Do/Don't rows. No core voice characteristic may be a SUPPORT or AVOID differentiator.
- 2.3 Primary Brand Message, and the Message Hierarchy table where Lead With = LEAD items and Support With = SUPPORT items
- 2.4 Tagline Candidates and Primary Recommendation
- 2.7 Boilerplate (25/50/100 word)

5.2 Non-Negotiable Brand Elements carries regulatory, legal, and safety prohibitions only. A supporting proof point (for example a commoditized-but-true attribute) does not belong there; it lives in 2.3 Messaging. The template annotates each of these slots; honor the annotations.

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
- 3.2 Color Palette (primary, secondary, accent, neutral - with rationale connecting to avatar preferences and archetype)
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
- Specific examples throughout - not just principles, but illustrations of how they apply
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
1. **Unifies all personas** - every recommendation resonates across all primary avatars without fragmenting the brand
2. **Anchored in research** - every major decision traces back to specific data points from Phase 1 or Phase 2
3. **Enables downstream phases** - the copywriting guide (Phase 4) should be able to extract voice, tone, and positioning directly from this document
4. **Differentiates from competitors** - visual and verbal identity should be ownable and distinct from the competitive set identified in Phase 1
5. **Allows flexibility** - principles over rigid rules; enable smart adaptation across contexts
6. **Addresses trust barriers** - incorporates trust signal strategy derived from avatar objections

**What to explicitly exclude:**
- Full avatar profiles (those live in the Phase 2 document; include only a condensed summary)
- Website wireframes, social media calendars, ad creative, email sequences (those are Phases 4-6)
- Tactical executions of any kind - this document defines the playing field, not the plays

### Step 6: Deliver and Handoff

Before presenting the guidelines to the operator, run the strategic coherence review (see `_frameworks/strategic-coherence-review.md`).

Mechanical Moat Map scan (run first; this is the gate, not the per-slot annotations). Using the Moat Map table (the LEAD/SUPPORT/AVOID disposition of every differentiator):
1. Scan every high-authority section block in the generated document, and within each block scan EVERY generated field it contains, not a selected list of fields. Scanning is block-based on purpose: enumerating individual fields always leaves a newer field uncovered, so the unit of coverage is the whole block. This enumeration is the canonical, exhaustive inventory; every other slot list in this skill (the global invariant, the extraction row, the Step 5 contract, the Brand Consistency Checklist, and Pass 2 below) is a shorthand realization of it, and where any of those is narrower this list governs. The high-authority blocks, each scanned in full including every current and future field, are:
   - 1.1 Brand Positioning Statement block: the Positioning Statement, the "Only Brand That..." claim, and the Competitive Differentiation narrative.
   - 1.2 Mission block: the Mission Statement (Brand Purpose is principle-level, but scan it too).
   - 1.3 Brand Vision block: the Vision Narrative and the Vision Statement (an identity-level future-state claim).
   - 1.4 Brand Values block: every value and every field under each value, including In Practice and Explicitly Rejects.
   - 1.6 Brand Promise block.
   - 2.1 Brand Voice block: every core voice characteristic and every field around it, including its illustrative examples, its Do/Don't rows, and the How Voice Flexes Across Contexts table.
   - 2.3 Messaging block: the Primary Brand Message and the Message Hierarchy "Lead With" column.
   - 2.4 Tagline block: every tagline candidate and the Primary Recommendation.
   - 2.7 Boilerplate block: the 25/50/100-word boilerplate and any product/category descriptions.
   - 5.2 Non-Negotiable Brand Elements block.
   - the Brand Consistency Checklist entries.
   The named subfields are reminders of fields easy to miss, not the boundary of the scan: if a block contains a generated field not named here, it is still in scope. The block list is the concrete enumeration, not the definition. The defining property is semantic: any generated field anywhere in the document that makes an identity-level or differentiation claim (states what the brand is, promises, stands for, or what sets it apart) is high-authority and in scope even if its block is not listed above. When in doubt about a field, scan it.
2. For each block, and every generated field within it, identify which differentiators its content draws on.
3. If any field draws on a differentiator marked SUPPORT or AVOID, that is a finding. Rebuild the field from LEAD differentiators and brand principles. SUPPORT differentiators are permitted only in 2.3 Messaging support pillars and proof points; AVOID differentiators nowhere.
This scan checks the finished document against the Moat Map directly and does not depend on any per-slot annotation being individually correct. It is the single point at which the invariant is enforced over the whole document.

- Pass 1 (targeted): confirm every primary-identity slot anchors only on a LEAD item and that no AVOID item appears as a claim.
- Pass 2 (coherence): read each high-authority block (the same block inventory the mechanical scan in step 1 covers, read in full including every field) against the corrected hierarchy and confirm none places a SUPPORT or AVOID item at the authority level of a LEAD item, and that no voice example uses a SUPPORT attribute as the exemplar. The high-authority blocks in this template are: 1.1 Positioning Statement, Only-Brand claim, and Competitive Differentiation narrative; 1.2 Mission; 1.3 Brand Vision (Vision Narrative and Vision Statement); 1.4 Brand Values in full (names, definitions, In Practice, Explicitly Rejects; no value is a SUPPORT or AVOID differentiator); 1.6 Brand Promise; 2.1 Brand Voice core characteristics (names and definitions), examples, Do/Don't rows, and the How Voice Flexes Across Contexts table; 2.3 Primary Brand Message and the Message Hierarchy Lead-With column; 2.4 Tagline Candidates and Primary Recommendation; 2.7 Boilerplate and any product/category descriptions; 5.2 Non-Negotiable Brand Elements; and the Brand Consistency Checklist. Where this list is narrower than the mechanical-scan inventory, that inventory governs.
- A finding is a finding even when the content is factually true.
- Final pass (mandatory): a cold read by a fresh instance with no prior context, given only the braindump, the Phase 1 guardrails, and the generated document. The producing instance cannot clear its own work. See `_frameworks/strategic-coherence-review.md`.
Resolve findings before presenting.

After generating the guidelines document:

1. Save as `brand-guidelines-[BRANDNAME]-[YYYY-MM-DD].md`
2. Summarize the key identity decisions made (archetype, positioning, voice pillars, visual direction)
3. Note any areas where the user should make a final creative decision (e.g., logo execution, final color hex selection)
4. Confirm readiness for Phase 4 (Copywriting Guide) - the brand guidelines should contain everything the copywriting-guide skill needs to extract

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

1. **Brand Identity** - Mission/vision clarity, values authenticity, personality expression, archetype fit
2. **Visual Identity** - Logo effectiveness, color appropriateness, typography hierarchy, imagery consistency
3. **Voice and Messaging** - Voice consistency, tone adaptation, message clarity, value proposition strength
4. **Target Audience Alignment** - Audience definition, brand-audience fit, messaging resonance
5. **Market Position** - Competitive differentiation, unique value proposition, positioning clarity
6. **Brand Consistency** - Cross-channel consistency, touchpoint alignment, quality standards

### Step 5: Generate Output Document

Create the appropriate deliverable based on analysis type:

- **Brand Analysis Report** → Use `assets/brand_analysis_report_template.md`
- **Quick Brand Audit** → Use `assets/quick_brand_audit_template.md`
- **Brand Guidelines (documenting existing)** → Use `assets/brand_guidelines_template.md`

### Step 6: Provide Recommendations

Based on analysis, provide actionable recommendations using the prioritization framework:
- **High Impact + Low Effort**: Quick wins - do immediately
- **High Impact + High Effort**: Strategic initiatives - plan carefully
- **Low Impact + Low Effort**: Nice-to-haves - do when possible
- **Low Impact + High Effort**: Avoid - not worth resources

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
Phase 3: Brand Guidelines      →  THIS SKILL (Mode A) - synthesizes Phase 1+2 into brand identity
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
