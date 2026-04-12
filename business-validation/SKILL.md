---
name: business-validation
description: "Run rigorous, evidence-based business validation research for e-commerce and D2C brands. Use this skill whenever the user wants to validate a new business concept, assess market viability, research competitors, validate customer segments, or generate a research brief for Deep Research. Trigger on phrases like: 'validate this brand', 'run Phase 1', 'business validation', 'market research', 'is this viable', 'assess this opportunity', 'research this brand', 'run validation'. Also trigger when the user provides a client braindump or intake document and wants analysis. This skill handles the complete workflow from raw client information to a research-ready brief with structured context extraction, gap analysis, and auto-customized research instructions."
---

# Business Validation Skill

## Purpose

Transform a raw client braindump into a fully customized, research-ready business validation brief. This eliminates 40+ minutes of manual prompt customization by automatically extracting structured data, detecting business stage and geography, identifying information gaps, and generating a complete research brief optimized for Deep Research execution.

## When to Use

- User provides a client braindump (PDF, markdown, or pasted text) and wants validation
- User says "run Phase 1" or "business validation" for a brand
- User wants to assess whether a business concept is viable
- User needs a research brief for Deep Research
- User wants market sizing, competitor analysis, or customer segment validation

## Workflow Overview

```
1. EXTRACT  -> Parse braindump into structured fields
2. DETECT   -> Auto-detect stage, geography, category
3. VALIDATE -> Check for missing critical information
4. CUSTOMIZE -> Generate research brief from template
5. PRESENT  -> Show summary, offer depth options
6. OUTPUT   -> Deliver research-ready brief
```

## Step 1: Extract Structured Data from Braindump

Read the client's braindump (uploaded file or pasted text) and extract these fields. If a field is not explicitly stated, attempt to infer it. Mark inferred fields with [INFERRED].

### Required Fields (Block if Missing)

| Field | Description | How to Extract |
|-------|-------------|----------------|
| product_name | Product or brand name | Usually in title or first paragraph |
| product_description | What is being sold, 2-3 sentences | Synthesize from overview section |
| category | Business category | Infer from product type |
| geography | Primary market(s) with percentages | Look for market/geography section |
| revenue_stage | Current revenue or pre-launch | Look for revenue figures |
| pricing | Offer structure and price points | Look for pricing/offer section |
| target_customers | Who the founder thinks buys this | Look for audience/segment section |
| competitors | 2+ known competitors | Look for market/competitor section |

If any Required field is completely absent and cannot be inferred, STOP and ask the user before proceeding.

### Valuable Fields (Improve Quality)

| Field | Description | Default if Missing |
|-------|-------------|-------------------|
| founder_assumptions | 3-5 beliefs about why this works | Infer from positioning and differentiators |
| existing_assets | Funnel URLs, ad campaigns, website | Note as "none provided" |
| top_performing_content | What's working today | Note as "unknown" |
| differentiators | Claimed competitive advantages | Infer from product description |
| customer_segments | Articulated buyer personas | Infer from target customer description |
| product_portfolio | All current products/SKUs with pricing | List from product/pricing section. Note hero product vs supporting products. Default: "single product" if only one mentioned |

### Nice-to-Have Fields

| Field | Description | Assumption if Missing |
|-------|-------------|----------------------|
| unit_economics | COGS, gross margin, contribution margin | Use industry standard for category |
| cac_by_channel | Customer acquisition cost | Note as "not provided, requires investigation" |
| ltv | Lifetime value or repeat purchase rate | Note as "not provided, requires investigation" |
| budget_constraints | Available budget | No assumption made |
| timeline | Launch or scaling timeline | No assumption made |
| founder_background | Experience and expertise | No assumption made |

### Extracting Founder Assumptions

This is the highest-judgment step. Founders rarely state assumptions explicitly. Extract them by:

1. Reading differentiation claims and converting to testable hypotheses
   - "mechanism-led education" -> "Education-led funnels outperform product-first approaches"
   - "patch vs pill" -> "Transdermal delivery is a defensible competitive advantage"

2. Reading positioning statements and identifying implied beliefs
   - "for people who've tried everything" -> "The exhausted/skeptical segment is the highest-value target"
   - "no grogginess" -> "Morning grogginess is a primary purchase driver"

3. Reading offer structure and inferring economic assumptions
   - "30 nights + 54 free" -> "High perceived value through volume drives conversion"
   - Single purchase only -> "One-time purchase model is sustainable without subscriptions"

Always generate exactly 5 assumptions. Prioritize by potential impact on business viability.

**Prioritization guidance for assumptions:** Focus on business model viability over marketing claims. A pricing model assumption or missing revenue mechanic (e.g., no subscription) has higher impact than a positioning thesis. The question is not "is the marketing message right?" but "can this business sustain and scale?"

### Derived Metrics

After extraction, calculate and include any derivable economics:

- **Per-unit pricing** if offer includes bundles/volume (e.g., "84 nights for £24.99 = £0.30/night")
- **Implied AOV range** from pricing tiers
- **Revenue math check** - does stated revenue make sense given pricing and implied order volume?
- **Channel dependency** - if only one channel mentioned, flag as "[INFERRED] single-channel dependency"
- **Revenue model gap** - if no subscription/repeat mechanism mentioned, flag explicitly as a business model risk
- **Product portfolio depth** - How many SKUs? Single hero vs developed range? Note product relationships (bundles, variants, complementary products). This feeds downstream Product Deep Research.

## Step 2: Auto-Detect Stage, Geography, and Category

Read `references/stage-heuristics.md` for detailed decision logic on research priorities based on detected stage, geography, and category.

The key principle: different businesses need fundamentally different research. A pre-launch brand needs problem validation. A scaling brand needs compliance deep-dives and retention analysis. The skill auto-adjusts all research priorities based on what it detects.

## Step 3: Validate Information Completeness

Before generating the research brief, present a completeness check to the user:

```
BRAND VALIDATION SETUP: [brand_name]

Extracted Context:
  Product: [product_name] ([category])
  Market: [geography]
  Stage: [revenue_stage]
  Segments: [count] identified
  Competitors: [count] known
  Assumptions: [count] extracted

Missing Information:
  [HIGH PRIORITY] [field_name] - [why it matters]
  [MEDIUM] [field_name] - [why it matters]

Options:
  1. Proceed with available information (gaps noted as assumptions)
  2. Provide missing information now
  3. Cancel and gather data first
```

### Contradiction Detection

While extracting data, actively scan for contradictions between:
- Ingredient/feature lists vs marketing claims
- Stated target audience vs product positioning
- Revenue claims vs pricing math
- Differentiation claims vs competitor offerings

If contradictions are found, flag them prominently:

```
CONTRADICTION DETECTED:
  [Source A] says: [claim]
  [Source B] says: [contradicting claim]
  Impact: [why this matters]
  Recommendation: [what to do about it]
```

## Step 4: Generate Customized Research Brief

Read `references/research-brief-template.md` and populate it with the extracted data.

The template has 6 sections requiring customization:

1. **Context** - From Step 1 extraction (product, market, revenue, constraints, assumptions)
2. **Research Focus Areas** - From Step 2 stage detection (auto-generated priorities)
3. **Existing Assets** - All URLs, ad links, competitor sites from braindump
4. **Special Instructions** - Geography + category specific (regulatory bodies, data sources, customer voice priorities)
5. **Quality Standards** - Universal (confidence levels, minimum quotes, source requirements)
6. **Output Requirements** - Full template structure adjusted for depth level

### Additional Research Threads (Always Include)

Beyond the stage/geography/category auto-generated focus areas, always include these two research threads in the brief. They address blind spots that founders consistently miss:

**Messaging Effectiveness Testing:**
When the braindump contains a strong positioning thesis (e.g., "education-led", "mechanism-first", "science-backed"), instruct the research to find evidence for how the target audience actually responds to different message types. Specifically:
- Scientific/mechanism explanations vs emotional benefit promises
- Social proof and peer reviews vs authority endorsements
- Problem reframing ("it's not you, it's the system") vs direct solution pitches
- Long-form education vs short-form direct response

This matters because founders often anchor on what convinced THEM, not what converts CUSTOMERS. The research should test whether the founder's messaging thesis matches actual consumer behavior data.

**Segment Value Challenge:**
When the founder identifies a "core" or "highest-value" segment, instruct the research to actively challenge this prioritization. For each segment, the brief should ask:
- Is this segment actually cheaper or more expensive to acquire?
- Do highly skeptical buyers convert at higher or lower rates?
- Are "tried everything" customers actually a distinct addressable segment, or are they just hard-to-convert low-value prospects?
- Which segment has the highest repeat purchase / LTV potential?
- Which segment is competitors ignoring (potential blue ocean)?

The research should propose an alternative prioritization if the evidence supports one, not just validate the founder's stated hierarchy.

## Step 5: Present Summary and Depth Options

Before outputting the final brief, present:

```
RESEARCH BRIEF READY: [brand_name]

Scope:
  Market: [geography] [category] market
  Competitors: [count] known + expansion search
  Segments: [count] to validate
  Regulatory: [depth level] ([specific bodies])
  
Depth Options:
  1. Quick Validation (3-5K word brief, 5-10 min research)
  2. Standard Validation (8-12K word brief, 20-30 min research)
  3. Deep Validation (full brief, 35-40 min research) [DEFAULT]

Select depth or confirm default:
```

**Quick:** Part 1 (Validation) + Part 3 (Competition) only. Verdict + top risks/opportunities.
**Standard:** Parts 1-3. Condensed avatars. Condensed hypothesis testing.
**Deep:** Full template. All sections. Comprehensive analysis.

## Step 6: Output

Deliver the complete customized research brief as a single document the user can paste into Deep Research.

Also generate a summary of customizations and flags:

```
BRIEF GENERATED

Customizations applied:
  - [geography] regulatory lens ([bodies])
  - [stage]-appropriate research priorities
  - [category]-specific focus areas
  - [count] founder assumptions extracted
  - [count] existing assets included

Flags:
  - [contradictions detected]
  - [missing high-priority information]
  - [assumptions needing verification]

Next: Paste this brief into Deep Research.
After research completes:
  → Phase 2 (Avatar Research) — uses validated segments and customer voice
  → Product Deep Research — uses competitive landscape, white space, and hero product validation
  → Both can run in parallel after Phase 1 completes
```

## What This Skill Does NOT Do

- Does not run Deep Research (user triggers that separately)
- Does not commit files to GitHub (project system prompt handles that)
- Does not replace human judgment on research output
- Does not guarantee research quality (depends on research execution)
- Does not research product portfolio strategy (Product Deep Research handles this using Phase 1 output)

## Edge Cases

**No braindump provided:** Offer interactive structured intake interview using Required fields list.

**Brand assessment vs validation:** If brand is well-established (>$500k/month, multiple products, existing team), suggest brand assessment framework instead.

**Multiple products:** Ask user which product to validate first. One at a time.

**Insufficient information:** If fewer than 4 of 8 Required fields extractable, output the structured intake questionnaire showing what's filled and what's missing instead of generating a brief.
