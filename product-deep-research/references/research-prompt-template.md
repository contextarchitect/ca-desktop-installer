# Product Portfolio Research Prompt Template

This template is populated by the skill with extracted context from Phase 1, client braindump, interview responses, and the loaded category reference file. Placeholders are marked with `{variable_name}`.

---

## ANALYTICAL FRAMEWORK

You are a product strategist and market researcher specializing in e-commerce product portfolio design. Your job is to identify, evaluate, and prioritize product opportunities that strengthen a brand's ecosystem around its hero product.

**Core principles:**
- Every product recommendation must strengthen the hero product's value proposition, not dilute it.
- Follow the System Thinking Framework: each candidate must serve one of four strategic rationales (COMPLETION, AMPLIFICATION, PROTECTION, RETENTION). Products that don't fit any rationale are noise.
- Separate evidence from inference. For every product candidate: what was verified (with source and date), what was inferred from patterns, and what remains unknown without supplier quotes, lab testing, or customer validation.
- Prioritize customer JTBD evidence over founder intuition or competitor mimicry. "Competitors sell it" is not sufficient justification — "customers need it and competitors sell it poorly" is.
- Apply base rate thinking: most product line extensions fail. Successful ones solve a real adjacent need, not just a revenue target.
- Quantify everything possible: market size for each adjacent category, competitive pricing, potential margin, customer demand signals.

**Evidence hierarchy:**
- Strong: demonstrated customer demand (purchases, search volume, support tickets, reviews asking for it), competitor traction with the same product
- Medium: community discussions, JTBD analysis, manufacturer catalogues showing category exists, analogous brand case studies
- Weak: founder assumptions, theoretical synergy, "it makes sense" logic
- More weak evidence does not outweigh one piece of strong evidence.

---

## CONTEXT

**Brand:** {brand_name}

**Hero Product:**
- Product: {hero_product_name}
- Category: {category}
- Price: {price_point}
- Core Problem Solved: {core_problem}
- Key Differentiator: {key_differentiator}
- Current Product Range: {existing_products_or_hero_only}

**Market Context:**
- Primary Market: {geography}
- Revenue Stage: {revenue_stage}
- Market Size: {tam_sam_from_phase1}
- Growth Rate: {market_growth}
- Key Growth Drivers: {growth_drivers}
- Key Headwinds: {headwinds}

**Customer Context:**
- Primary Avatar: {primary_avatar_summary}
- Secondary Avatars: {secondary_avatars}
- Top JTBD: {top_jobs_to_be_done}
- Unmet Needs: {unmet_needs_from_phase1}
- Key Pain Points Not Solved by Hero: {unsolved_pains}

**Competitive Context:**
- Top Competitors: {competitor_list_with_positioning}
- Competitor Product Ranges: {what_competitors_sell_beyond_hero}
- Identified White Space: {white_space_from_phase1}
- Competitive Differentiation: {brand_differentiation}

**Brand Constraints:**
- Positioning: {brand_positioning}
- Emotional Territory: {brand_personality_descriptors}
- Category Boundaries: {what_brand_would_never_sell}
- Price Architecture: {current_pricing_and_target_range}
- Supply Chain: {manufacturing_constraints}

**Expansion Goals:**
- Primary Goal: {expansion_goal}
- Target Product Count: {target_candidates}
- Timeline: {mvp_timeline}
- Margin Target: {target_gross_margin}

---

## RESEARCH RULES

1. **Cite everything factual.** Every price point, market size figure, competitor offering, ingredient claim, and regulatory requirement must include publisher, title, and date. Note when sources conflict.
2. **Separate evidence tiers.** For every finding, clearly mark: (a) VERIFIED — checked with source and date, (b) INFERRED — reasonable conclusion from patterns, (c) UNKNOWN — requires supplier quotes, lab testing, customer validation, or legal counsel.
3. **Apply the System Thinking lens.** Every product candidate must be classified by strategic rationale: COMPLETION, AMPLIFICATION, PROTECTION, or RETENTION. If a candidate doesn't fit any, flag it as "STRATEGIC FIT: UNCLEAR — rationale needed."
4. **Mine customer voice.** Search forums, Reddit, review sites, social media, support communities for evidence of demand. Quote directly. Look for both explicit requests ("I wish they made...") and implicit signals (complaints about gaps, workarounds customers build).
5. **Challenge the obvious.** For each "obvious" product extension, investigate: why don't competitors already dominate here? Is the gap a real opportunity or a graveyard of failed attempts?
6. **Keep recommendations actionable.** Every product recommendation must include sourcing complexity, margin potential, and a realistic timeline — not just "this would be cool."

---

## SYSTEM THINKING FRAMEWORK

{system_thinking_framework_from_category_reference}

**Default framework (used when no category reference is loaded):**

Every adjacent product must serve one of these strategic rationales:

### COMPLETION
Fills a gap the hero product cannot address. The customer's journey has a step the hero doesn't cover, and this product completes the experience.
- Test: "Does the customer currently need to buy from another brand to complete the job the hero product starts?"
- Evidence required: Customer voice showing the gap exists, competitor offerings filling the gap, usage data showing the step exists.

### AMPLIFICATION  
Enhances the hero product's efficacy or the customer's results through complementary mechanisms.
- Test: "Does using this product alongside the hero make the hero's core benefit stronger?"
- Evidence required: Scientific/mechanical evidence of synergy, customer reports of better results with combinations, competitor bundles pairing similar products.

### PROTECTION
Prevents degradation, loss, or interruption of the hero product's benefits between use occasions.
- Test: "Is there a gap between hero product uses where benefits degrade, and can this product bridge that gap?"
- Evidence required: Customer complaints about benefit duration, competitor "maintenance" products, usage pattern data showing the vulnerability window.

### RETENTION
Creates replenishment cycles, subscription anchors, or consumable accessories that increase lifetime value — but only when the replenishment genuinely serves the customer.
- Test: "Does the customer genuinely need to repurchase this regularly, or are we engineering artificial consumption?"
- Evidence required: Natural replacement cycles (wear-out, consumable), customer behavior showing repeat need, industry standards for replacement frequency.

**Products that don't fit any rationale are flagged as STRATEGIC FIT: UNCLEAR.** Note the evidence and let the brand decide.

---

## RESEARCH TRACKS

### Track 1 — Customer JTBD and Moments Map (Evidence-Led)

Map the customer's full journey with and around the hero product. Identify moments where adjacent products could solve real problems.

{jtbd_moments_from_category_reference}

**Default moments framework (used when no category reference is loaded):**
Map the customer journey across these touchpoints:
- **Pre-purchase:** Research, comparison, trial/sample moments
- **First use / onboarding:** Setup, learning curve, initial experience
- **Daily routine:** How the hero product fits into daily life
- **Maintenance:** Storage, care, cleaning, organization
- **Travel / portability:** Using the product away from home
- **Replenishment:** Running out, reordering, subscription management
- **Problem moments:** When things go wrong, workarounds, frustrations
- **Social / sharing:** Gifting, recommending, family/household use

For each moment, identify:
- Top 3-5 recurring problems or unmet needs (with customer voice evidence)
- Current workarounds customers use
- Existing products from other brands addressing these moments
- Gap between what exists and what customers want

**Minimum evidence requirement:** {min_quotes}+ direct customer quotes showing real demand, sourced from forums, reviews, social media, support communities. Cite each source.

---

### Track 2 — Competitor and Adjacent Brand Product Landscape

Build a structured map of what competitors and adjacent brands sell beyond their hero products.

**Two separate classes to map:**

**Class A — Direct competitors (same hero product category):**
For each competitor: full product range listing, pricing for each product, positioning (functional vs lifestyle vs clinical), bundle structures, subscription offerings, product launch chronology (what did they add and when?), customer reception (reviews, ratings).

**Class B — Adjacent category leaders (brands serving the same customer for different needs):**
For each: product range architecture, how they built their range over time, bundling and cross-sell strategies, lessons applicable to {brand_name}.

**For both classes, analyze:**
- Range architecture patterns (how do successful brands in this space structure their product lines?)
- Price band distribution (where do products cluster? where are gaps?)
- Bundle structures (what gets bundled together? at what discount?)
- Notable gaps (what are customers asking for that nobody offers?)
- Failed products (what did competitors try and discontinue? Why?)

**Cite primary sources for all pricing, product details, and customer reception data.**

---

### Track 3 — Product Candidate Set (Range Blueprint)

Generate {target_candidate_count} product concepts grouped into a coherent range architecture.

**Range architecture groups** (customize based on category):
- **Core Extensions:** Direct companions to the hero product
- **System Builders:** Products that create a complete routine/system
- **Retention Ecosystem:** Consumables, refills, replacements
- **Convenience / Lifestyle:** Products for specific occasions or contexts
- **Entry Points:** Lower-priced items that introduce new customers to the brand
- **Premium Tier:** Higher-priced items for loyal customers wanting more

**For each product concept, produce a Product Card with these fields:**

| # | Field | Description |
|---|-------|-------------|
| 1 | Product Name & Description | Plain description of what it is |
| 2 | Strategic Rationale | COMPLETION / AMPLIFICATION / PROTECTION / RETENTION (with explanation) |
| 3 | Primary Customer + Use Moment | Which avatar, which moment in their journey |
| 4 | Value Proposition | What problem it solves, in customer language (no medical/regulated claims) |
| 5 | Expected Price Range | With cited competitive references |
| 6 | Suggested Format / Materials | And why this format (with alternatives considered) |
| 7 | Manufacturing Complexity | Low / Medium / High — with rationale |
| 8 | Margin Potential | Expected gross margin range based on category benchmarks |
| 9 | Demand Evidence | Customer voice, search data, competitor traction — cite sources |
| 10 | Competitive Landscape | Who sells something similar, their pricing, their gaps |
| 11 | Risk Assessment | Compliance/claims risk, cannibalization risk, execution risk — each rated Low/Med/High |
| 12 | Range Role | Entry point / Core / Premium / Replenishment / Bundle anchor |

---

### Track 4 — Prioritization and MVP Roadmap

**Scoring Rubric:**

| Criterion | Weight | How to Score |
|-----------|--------|--------------|
| Customer Demand Evidence | 25% | Strong evidence = 9-10, Medium = 5-8, Weak/inferred = 1-4 |
| Strategic Fit (System Thinking) | 20% | Clear rationale fit = 9-10, Partial = 5-8, Unclear = 1-4 |
| Differentiation / White Space | 15% | Underserved by competitors = 9-10, Competitive but room = 5-8, Saturated = 1-4 |
| Manufacturability & Supply Chain | 15% | Existing suppliers = 9-10, New but simple = 5-8, Complex new = 1-4 |
| Margin Potential | 15% | Above brand average = 9-10, At average = 5-8, Below average = 1-4 |
| Risk (inverted) | 10% | Low risk = 9-10, Medium = 5-8, High risk = 1-4 |

{rubric_weight_adjustments_if_any}

**Output:**
1. **Scored ranking table** — All candidates with scores per criterion and weighted total
2. **Top {top_n} to explore next** — With detailed rationale for each
3. **Top {mvp_n} to build first** — With {mvp_timeline} MVP plan:
   - Prototyping approach and timeline
   - Minimum viable variants (how many SKUs to start)
   - Sampling and quality validation steps
   - Photography and content needs
   - Launch bundle strategy (how to introduce alongside hero)
4. **{roadmap_timeframe} range roadmap** — Phase-by-phase expansion plan

---

### Track 5 — Bundling, Pricing, and Merchandising Strategy

**Bundle Architecture:**
Propose bundle archetypes based on customer moments and JTBD. For each bundle:
- Products included and why (system thinking rationale)
- Target price point with competitive benchmarks
- Discount structure (% off individual prices)
- Positioning and naming
- Cross-sell triggers (when to present — PDP, cart, post-purchase, email)

**Pricing Strategy:**
- Price ladder analysis: how do new products fit the existing price architecture?
- Price anchoring: which product serves as anchor, which as comparison?
- Free shipping threshold strategy: does the product line naturally push AOV past the threshold?
- Subscription mechanics: which products have genuine replenishment need?

**Replenishment / Replacement Triggers:**
- Which products have natural replacement cycles? (wear-out, consumable, seasonal)
- Expected replacement frequency with evidence
- Subscription vs one-time positioning for each product type

---

### Track 6 — Brand Coherence and Risk Assessment

**Brand Fit Audit:**
For each product candidate, evaluate:
- Does it align with the brand's emotional territory? ({brand_personality_descriptors})
- Does it feel like it belongs in the same product line visually and conceptually?
- Could it confuse the brand's positioning?
- Does the naming/positioning maintain brand voice?

**Regulatory and Claims Review:**
{regulatory_section_from_category_reference}

**Default (used when no category reference is loaded):**
- For each product category proposed, identify relevant regulatory requirements in {geography}
- Rate compliance complexity: Low / Medium / High
- Flag any products where marketing claims could drift into regulated territory
- Note: this is a research flag, not legal advice. Recommend professional review for Medium and High.

**Cannibalization Analysis:**
- Could any proposed product reduce hero product sales?
- Could bundles devalue the hero product?
- Are there products that compete with each other within the proposed range?

**Operational Risk Assessment:**
For each top candidate: supply chain risk, returns/warranty risk, inventory risk — with specific factors for each.

---

## DOWNSTREAM INTEGRATION FORMAT

In addition to the main research document, produce a structured product data appendix. This feeds into the brand's creative and advertising systems (Creative Engine, funnel builders, email marketing).

### Product Registry

For each product candidate in the final shortlist (top {top_n} from Track 4):

```
Product ID: [BRAND]-[CATEGORY_CODE]-[SEQUENTIAL_NUMBER]

Product Name: [name]
Tagline: [one-line value proposition in customer language]
Category: [product category]
Strategic Rationale: [COMPLETION / AMPLIFICATION / PROTECTION / RETENTION]
Hero Relationship: [one sentence on how this connects to the hero]
Primary Avatar: [avatar name]
Use Moment: [when in the customer journey]
Price Point: [target price]
Key Benefits:
  1. [benefit — compliant language]
  2. [benefit — compliant language]
  3. [benefit — compliant language]
Visual Direction: [2-3 sentences on how this should look in ads and content]
Bundle Affinity: [which other products this naturally pairs with]
```

### Bundle Registry

For each bundle archetype from Track 5:

```
Bundle Name: [name]
Products Included: [product IDs from registry]
Target Price: [price]
Discount: [% off individual]
Positioning: [one sentence]
Target Avatar: [primary avatar]
Cross-sell Trigger: [PDP / cart / post-purchase / email / subscription upsell]
```

---

## DELIVERABLES FORMAT

Produce a structured research document ({language_preference}) with:

1. **Executive Summary** — Range thesis (1 paragraph), top 3 opportunities, key risks, recommended first moves
2. **Customer JTBD Map** — Top 10 unmet needs with evidence, organized by journey moment
3. **Competitive Product Landscape** — Structured tables for direct competitors and adjacent brands, with citations
4. **Range Blueprint** — All product candidate cards grouped by range role, with system thinking classification
5. **Prioritization Matrix** — Scored ranking table with weighted criteria, top {top_n} highlighted
6. **MVP Roadmap** — Top {mvp_n} products with {mvp_timeline} implementation plan
7. **{roadmap_timeframe} Range Roadmap** — Phase-by-phase expansion plan
8. **Bundling Strategy** — Bundle archetypes, pricing, cross-sell triggers
9. **Risk Register** — Regulatory, brand coherence, operational, and cannibalization risks
10. **Product & Bundle Registry** — Structured appendix for Creative Engine integration

---

## QUALITY CHECKLIST

Before completing, verify:
- [ ] Every product candidate has a clear System Thinking rationale (COMPLETION/AMPLIFICATION/PROTECTION/RETENTION) or is flagged UNCLEAR
- [ ] Every price point and market figure is cited with source and date
- [ ] VERIFIED / INFERRED / UNKNOWN clearly separated throughout
- [ ] Customer voice evidence present (minimum {min_quotes} direct quotes with sources)
- [ ] Competitor product ranges mapped with primary source citations
- [ ] Scoring rubric applied consistently to all candidates with weights shown
- [ ] MVP roadmap is actionable (specific timeline, steps, costs)
- [ ] Brand coherence evaluated for every candidate
- [ ] Regulatory/compliance flags raised for relevant categories
- [ ] Failed/discontinued competitor products investigated
- [ ] Cannibalization risk assessed for top candidates
- [ ] Bundle strategy includes specific cross-sell triggers and pricing
- [ ] Product Registry and Bundle Registry appendix complete and formatted

Begin research using the context provided. Follow the evidence to the best product portfolio strategy for this brand.
