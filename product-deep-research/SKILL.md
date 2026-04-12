---
name: product-deep-research
description: "Generate deep research prompts for e-commerce product portfolio strategy — hero product deep-dives, adjacent product discovery, range architecture, and bundling. Trigger on: 'product research', 'what products should we add', 'complementary products', 'adjacent products', 'product range', 'product expansion', 'bundling strategy', 'what else can we sell', 'range architecture', 'SKU expansion', 'product portfolio', 'product deep dive'. Also trigger after Phase 1 (Business Validation) when exploring product strategy before or alongside Phase 2. Reads Phase 1 report as primary context and generates a customized product research prompt for Deep Research. Covers JTBD mapping, competitor product landscapes, system thinking (COMPLETION/AMPLIFICATION/PROTECTION/RETENTION), prioritization rubrics, MVP roadmaps, and Creative Engine integration."
---

# Product Deep Research Skill

## Purpose

Transform a Phase 1 Business Validation report (and optionally a client braindump) into a fully customized, research-ready product portfolio research brief. This skill bridges the gap between "is this business viable?" (Phase 1) and "what should the complete product offering look like?" — covering hero product deep-dives, adjacent product discovery, range architecture, bundling strategy, and a prioritized MVP roadmap.

## How This Complements Business Validation (Phase 1)

Phase 1 answers: **"Should this business exist? Is the market real?"**
This skill answers: **"What products should this brand sell, and in what order?"**

Phase 1 produces: market validation, competitive landscape, avatar discovery, hypothesis testing.
This skill consumes that output and produces: hero product analysis, adjacent product candidates, range architecture, bundling strategy, and a prioritized build plan.

The key insight: Phase 1 deliberately avoids deep product strategy because it's focused on business viability. But once viability is established, the next critical question is product portfolio design — and that requires its own dedicated research with a different analytical framework.

## When to Use

- User has completed Phase 1 and wants to explore what products to build/sell
- User says "product research", "what else should we sell", "product expansion"
- User wants to evaluate complementary or adjacent product opportunities
- User needs a hero product deep-dive beyond what Phase 1 covered
- User wants bundling, pricing, or range architecture research
- User is planning product line expansion for an existing brand
- Brand has a hero product and needs to build a system around it

## When NOT to Use

- Business viability hasn't been validated yet → use business-validation skill (Phase 1)
- User wants customer avatar profiles → use avatar-research skill (Phase 2)
- User wants brand positioning/guidelines → use brand-analyzer skill (Phase 3)
- User wants to validate a new business concept from scratch → Phase 1

## Required Inputs

**Primary (required):**
1. **Phase 1 Business Validation Report** — provides market context, competitive landscape, validated segments, and hero product positioning

**Secondary (improves quality significantly):**
2. **Client braindump or intake document** — provides brand details, product portfolio, pricing, founder perspective
3. **Brand guidelines** (if Phase 3 complete) — provides emotional territory, brand personality, positioning constraints

If Phase 1 is not available, the skill can still generate a brief but will require the user to provide hero product details, target market, pricing, and competitive context manually via interview.

## Workflow Overview

```
1. INGEST     → Read Phase 1 report + any supplementary context
2. EXTRACT    → Pull hero product data, market context, competitive landscape, avatar data
3. DETECT     → Auto-detect category, geography, brand stage, product complexity
4. LOAD       → Read category-specific reference file from references/categories/
5. INTERVIEW  → Ask targeted questions to fill gaps (adaptive, 3-5 questions max)
6. CUSTOMIZE  → Generate research brief from template + category reference
7. PRESENT    → Show summary, confirm scope
8. OUTPUT     → Deliver research-ready brief for Deep Research
```

## Step 1: Ingest Phase 1 Output

Read the business validation report and extract these specific elements:

### From Phase 1 Report

| Section | What to Extract | Feeds Into |
|---------|----------------|------------|
| Executive Verdict | GO/CONDITIONAL GO status, key conditions | Research framing — only research product expansion for validated businesses |
| Problem Validation (1.3) | Core problem being solved, evidence quality | Hero product deep-dive context |
| Market Size (1.5) | TAM/SAM/SOM, growth drivers, headwinds | Market sizing for adjacent categories |
| Hypothesis Testing (1.6) | Validated vs contradicted assumptions | Product strategy constraints |
| Avatar Discovery (2.1) | Validated segments, JTBD, pain points, trigger events | JTBD-driven product discovery (Track 1) |
| Competitor Matrix (3.1) | Competitor product ranges, pricing, positioning | Competitor product landscape (Track 2) |
| Deep-Dive Competitors (3.2) | What competitors do well/poorly, customer complaints | Gap analysis for product opportunities |
| White Space Analysis (3.3) | Identified opportunities and alternative explanations | Adjacent product hypotheses |
| Differentiation Assessment (3.4) | Brand's defensible advantages | Product strategy alignment |
| Strategic Recommendations (4) | Positioning, channels, pricing guidance | Range architecture constraints |

### From Client Braindump (if available)

| Element | What to Extract |
|---------|----------------|
| Current product portfolio | All existing SKUs, pricing, descriptions |
| Hero product details | Ingredients/components, manufacturing, sourcing |
| Product roadmap | Any planned products or expansion ideas |
| Supply chain context | Manufacturing capabilities, supplier relationships |
| Margin structure | COGS, gross margin, shipping economics |
| Brand constraints | What the brand would never sell, category boundaries |

## Step 2: Extract and Structure Context

After reading inputs, build this structured context:

```
PRODUCT RESEARCH CONTEXT: [brand_name]

Hero Product:
  Name: [product_name]
  Category: [category]
  Price: [price_point]
  Core Problem Solved: [from Phase 1 problem validation]
  Key Differentiator: [from Phase 1 differentiation assessment]
  
Market Context:
  Geography: [primary market]
  Stage: [pre-launch / early / scaling]
  Market Size: [TAM/SAM from Phase 1]
  Growth Rate: [from Phase 1]
  
Customer Context:
  Primary Avatar: [from Phase 1 avatar discovery]
  Key JTBD: [top 3 jobs-to-be-done]
  Unmet Needs: [pain points not solved by hero product]
  
Competitive Context:
  Top Competitors: [from Phase 1]
  Competitor Product Ranges: [what competitors sell beyond their hero]
  White Space: [identified opportunities]
  
Brand Constraints:
  Positioning: [brand positioning statement]
  Emotional Territory: [brand personality]
  Category Boundaries: [what the brand would/wouldn't sell]
  Price Architecture: [current pricing and target range]
```

## Step 3: Auto-Detect and Load Category Reference

Detect the brand's product category from the Phase 1 report, then load the matching category reference file from `references/categories/`. These files contain category-specific JTBD moment maps, system thinking examples, regulatory checklists, and research emphasis guidance.

**Available category references:**

| Category | File | When to Load |
|----------|------|--------------|
| Health & Wellness / Supplements | `health-wellness.md` | Supplements, vitamins, functional foods, wellness devices |
| Beauty & Skincare / Haircare | `beauty-haircare.md` | Skincare, haircare, cosmetics, personal care |
| Food & Beverage | `food-beverage.md` | CPG food, drinks, specialty ingredients |
| Fitness & Sports | `fitness-sports.md` | Workout gear, sports nutrition, recovery, athleisure |
| Fashion & Apparel | `fashion-apparel.md` | Clothing, accessories, footwear, jewelry |
| Home & Lifestyle | `home-lifestyle.md` | Home goods, kitchen, organization, decor |

If the brand doesn't fit any category file, use the default framework in `references/research-prompt-template.md` without a category overlay. The skill still works — it just won't have category-specific JTBD moments and regulatory detail pre-loaded.

If the brand spans multiple categories (e.g., a wellness brand selling supplements AND skincare), load the primary category reference and note the secondary in the research brief so Deep Research covers both.

### Stage Detection

| Stage | Product Research Scope |
|-------|----------------------|
| Pre-launch | Hero product deep-dive ONLY. Product expansion research is premature. Generate a focused brief covering Track 1 (JTBD for hero validation) and Track 2 (competitor product landscape for positioning). Skip Tracks 3-6. |
| Early ($1-50k/month) | Hero optimization + 1-2 natural extensions. 3-5 product candidates. 60-day MVP plan. |
| Scaling ($50k+/month) | Full range architecture. 8-15 candidates. 90-day MVP plan. Full bundling strategy. |
| Established ($500k+/month) | Full portfolio strategy. 15-25 candidates. 6-month roadmap. Sub-brand evaluation. |

### System Thinking Framework

This is the core analytical lens for all product expansion decisions. Every proposed adjacent product must answer: **"How does this make the hero product work better or the customer's life easier?"**

Four strategic rationales:

1. **COMPLETION** — Fills a gap the hero product cannot address
2. **AMPLIFICATION** — Enhances hero product efficacy through complementary mechanisms
3. **PROTECTION** — Prevents degradation or loss of hero product benefits
4. **RETENTION** — Creates genuine replenishment cycles or subscription anchors that increase LTV

Products that don't fit any rationale are flagged as "STRATEGIC FIT: UNCLEAR." The research should note the evidence and let the brand decide rather than discarding.

Each category reference file contains concrete examples of these four rationales specific to that category. Load and inject into the research brief.

## Step 4: Adaptive Interview

Ask targeted questions to fill gaps not covered by Phase 1. Keep it to 3-5 questions maximum. Skip questions where Phase 1 already provides the answer.

### Always Ask (unless already clear from context):

**1. Product expansion intent:**
"What's driving the product expansion? Are you looking to increase AOV through bundling, improve retention through consumables, expand into adjacent categories, or build a complete system around the hero product?"

**2. Supply chain reality:**
"What are your manufacturing constraints? Do you work with a single manufacturer who could produce adjacent products, or would new products require new supplier relationships?"

**3. Brand boundaries:**
"Are there product categories you would never enter? Any brand positioning constraints that limit what you can sell?" (Skip if brand guidelines provide this)

### Ask If Not Clear from Phase 1:

**4. Current product portfolio:**
"Beyond the hero product, what else do you currently sell or have in development?"

**5. Margin and pricing targets:**
"What gross margin do you target? Is there a price ceiling for the brand, or a sweet spot you want to stay within?"

Use the ask_user_input tool when available to structure choices:

- Question: "What's the primary goal of product expansion?"
  - Options: "Increase AOV through bundles", "Improve retention/LTV", "Build a complete product system", "Expand into adjacent categories"
  - multiSelect: true

- Question: "How many new products are you looking to research?"
  - Options: "1-2 natural extensions", "3-5 range builders", "Full range architecture (8-15+)", "Let the research decide"

## Step 5: Generate Customized Research Brief

Read `references/research-prompt-template.md` and populate it with extracted context, interview data, and the loaded category reference content.

The template has these sections requiring customization:

1. **Researcher Role and Rules** — Evidence standards, citation requirements, claim boundaries
2. **Business Context** — From Step 2 structured context
3. **System Thinking Framework** — Category-adapted COMPLETION/AMPLIFICATION/PROTECTION/RETENTION lens (from category reference file)
4. **Research Tracks** — 6 mandatory tracks, emphasis adjusted by category and stage
5. **Product Card Format** — Standardized evaluation template for each candidate
6. **Prioritization Rubric** — Weighted scoring with category-appropriate criteria
7. **Creative Engine Integration** — Output format compatible with downstream tools
8. **Deliverables Format** — Output structure and quality requirements

### Research Track Scope by Stage

| Track | Pre-launch | Early | Scaling | Established |
|-------|-----------|-------|---------|-------------|
| 1: Customer JTBD Map | Hero-focused only | MEDIUM | HIGH (full journey) | HIGH (multi-persona) |
| 2: Competitor Product Landscape | Hero positioning only | MEDIUM | HIGH | HIGH + acquisition targets |
| 3: Product Candidate Set | SKIP | 3-5 candidates | 8-15 candidates | 15-25 candidates |
| 4: Prioritization & MVP Roadmap | SKIP | Top 2, 60-day plan | Top 5, 90-day plan | Top 8, 6-month plan |
| 5: Bundling & Pricing Strategy | SKIP | Basic bundles | Full bundle architecture | Multi-tier + subscription |
| 6: Brand Coherence & Risk | SKIP | Basic alignment | Full brand fit audit | Sub-brand evaluation |

### Creative Engine Integration

When generating the research brief, include this instruction in the deliverables section so Deep Research outputs data in a format that feeds directly into Creative Engine and downstream tools:

```
## DOWNSTREAM INTEGRATION FORMAT

In addition to the main research document, produce a structured product data appendix
formatted as follows. This feeds into the brand's creative and advertising systems.

### Product Registry (one entry per candidate)

For each product candidate in the final shortlist (top N from Track 4), produce:

Product ID: [BRAND]-[CATEGORY_CODE]-[SEQUENTIAL_NUMBER]
  e.g., REGROWTH-HC-001, PROTOCEL-SUP-003

Product Name: [name]
Tagline: [one-line value proposition in customer language]
Category: [product category]
Strategic Rationale: [COMPLETION / AMPLIFICATION / PROTECTION / RETENTION]
Hero Relationship: [one sentence on how this product connects to the hero]
Primary Avatar: [avatar name from Phase 1]
Use Moment: [when in the customer journey this product is used]
Price Point: [target price]
Key Benefits: [3 bullet points, compliant language only]
Visual Direction: [2-3 sentences describing how this product should look in ads/content]
Bundle Affinity: [which other products this naturally bundles with]

### Bundle Registry (one entry per bundle archetype)

Bundle Name: [name]
Products Included: [product IDs]
Target Price: [price]
Discount Structure: [% off individual]
Positioning: [one sentence]
Target Avatar: [primary avatar for this bundle]
Cross-sell Trigger: [when to present — PDP, cart, post-purchase, email]
```

This structured output enables:
- Creative Engine to generate ad creative referencing specific products and bundles
- Brand context documents to include the full product range
- Funnel building to reference products by ID in advertorials and listicles
- Email marketing to build product-specific sequences

## Step 6: Present Summary and Confirm Scope

Before outputting the final brief:

```
PRODUCT RESEARCH BRIEF READY: [brand_name]

Hero Product: [product_name] ([price])
Market: [geography] [category]
Stage: [stage] → [research scope]
Category Reference: [loaded file or "default framework"]

Research Scope:
  Track 1 — Customer JTBD Map: [emphasis level]
  Track 2 — Competitor Product Landscape: [# competitors to map]
  Track 3 — Product Candidates: [target count] candidates
  Track 4 — Prioritization: Top [N] with [timeframe] MVP plan
  Track 5 — Bundling Strategy: [scope]
  Track 6 — Brand Coherence & Risk: [scope]
  
System Thinking Lens: COMPLETION / AMPLIFICATION / PROTECTION / RETENTION
Category-Specific Focus: [key category considerations from reference file]
Creative Engine Integration: Product Registry + Bundle Registry appendix included

Depth Options:
  1. Focused (hero extensions only, 5-8K word output, 10-15 min research)
  2. Standard (range architecture, 12-18K word output, 25-35 min research) [DEFAULT]
  3. Comprehensive (full portfolio strategy, 18-28K word output, 40-50 min research)

Confirm scope or adjust:
```

## Step 7: Output

Deliver the complete customized research brief as a single document optimized for Deep Research.

Also generate a summary:

```
BRIEF GENERATED: [brand_name] Product Portfolio Research

Customizations applied:
  - [category] reference loaded ([filename])
  - [stage]-appropriate scope ([candidate count] candidates, [timeline] MVP plan)
  - [geography] regulatory context encoded
  - System Thinking Framework with [category]-specific examples
  - Creative Engine integration format included
  - [count] competitor product ranges to map
  - [count] avatar JTBD threads encoded

Context from Phase 1:
  - [count] validated segments informing JTBD map
  - [count] competitors with product ranges to analyze
  - [count] white space opportunities to investigate
  - Key brand constraints encoded

Flags:
  - [any gaps, contradictions, or risks identified]

Next: Paste this brief into Deep Research.
After research completes:
  → Product Registry feeds into Creative Engine brand context
  → Product candidates inform Phase 2 (Avatar Research) depth
  → Bundle strategy feeds into Phase 5 (Funnel Building)
  → Risk register informs Phase 3 (Brand Guidelines) constraints
```

## What This Skill Does NOT Do

- Does not validate whether the business should exist (that's Phase 1)
- Does not generate customer avatars (that's Phase 2)
- Does not create brand guidelines (that's Phase 3)
- Does not run Deep Research (user triggers that separately)
- Does not make final product decisions (provides research framework, not answers)
- Does not generate product concepts itself (instructs Deep Research to generate evidence-based candidates)

## Edge Cases

**Phase 1 not available:** Conduct a structured interview to gather hero product details, market context, competitive landscape, and customer segments. Quality will be lower than with Phase 1 input. Note this clearly in the output.

**Pre-launch brand:** Generate a hero-focused brief only (Track 1 and Track 2). Skip Tracks 3-6. Frame as "hero product deep-dive" rather than "product expansion."

**Single-product brand wanting to stay single-product:** Redirect to bundling and variant research only (sizes, formats, subscription packaging) rather than new product categories. Tracks 3 and 5 only.

**Brand with 10+ existing products:** Frame as "range optimization" rather than "expansion." The research should evaluate what to keep, kill, or reposition, not just what to add.

**Category not in reference files:** Use the default framework from the research prompt template. Note that category-specific JTBD moments and regulatory detail are generic and the user should verify regulatory requirements independently.

**Multi-category brand:** Load the primary category reference. Note the secondary category in the brief so Deep Research covers regulatory and JTBD considerations for both.

## References

- `references/research-prompt-template.md` — Complete research prompt template with all 6 tracks and Creative Engine integration format
- `references/categories/health-wellness.md` — Health, wellness, supplements category reference
- `references/categories/beauty-haircare.md` — Beauty, skincare, haircare category reference
- `references/categories/food-beverage.md` — Food and beverage category reference
- `references/categories/fitness-sports.md` — Fitness, sports, athleisure category reference
- `references/categories/fashion-apparel.md` — Fashion, apparel, accessories category reference
- `references/categories/home-lifestyle.md` — Home goods, lifestyle, organization category reference
