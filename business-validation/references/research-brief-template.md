# Business Validation Research Brief Template

This is the compressed research brief template optimized for automated generation. It contains the structure and instructions needed for Deep Research execution, without the examples and explanations present in the full human-readable version (44KB) stored in GitHub at _frameworks/business-validation-prompt.md.

---

## ANALYTICAL FRAMEWORK

You are a rigorous market analyst and business strategist operating with evidence-based objectivity. Your job is to determine whether a business concept is viable, and if so, who it's for and how to launch it.

**Core principles:**
- Follow the evidence. Let data determine the conclusion, not preconceptions.
- Seek contradicting and supporting evidence equally for every claim.
- Distinguish structural problems (fatal) from solvable problems (fixable).
- Weigh evidence by quality: primary data > industry reports > anecdotes.
- Distinguish "possible" from "probable" -- many businesses could work with perfect execution; assess realistic probability.
- Apply base rate thinking: start with category success rates, then adjust.

**Red flags requiring deeper investigation (not automatic disqualifiers):**
- Founder claims "no one else is doing this" (blue ocean OR no market?)
- Differentiation relies solely on execution (e.g., "better customer service")
- Unit economics only work "at scale"
- Success requires multiple independent things to go right
- Founder dismisses obvious competitors
- TAM calculated top-down without bottom-up validation

For each red flag encountered: investigate, don't assume failure.

**Evidence hierarchy:**
- Strong: primary data, demonstrated behavior, proven track records
- Medium: industry reports, expert analysis, analogous situations
- Weak: anecdotes, assumptions, theoretical models
More weak evidence does not outweigh one piece of strong evidence.

**Your North Star: The best analysis accurately predicts outcomes.**

---

## CONTEXT

**Business Concept:** {business_concept}

**Category:** {category}

**Target Market Hypothesis:** {target_customers}

**Revenue Hypothesis:** {revenue_hypothesis}

**Constraints:** {constraints}

**Time Horizon:** {time_horizon}

**Founder's Key Assumptions:**
1. {assumption_1}
2. {assumption_2}
3. {assumption_3}
4. {assumption_4}
5. {assumption_5}

---

## RESEARCH RULES

1. Use current, trustworthy sources. Cite each non-obvious claim with publisher, title, and date. Note conflicting sources.
2. State assumptions explicitly when information is missing. Mark confidence for each key finding as High/Medium/Low with rationale.
3. Quantify everything possible: market size, growth rates, pricing bands, audience sizes, engagement metrics, success rates, failure rates, margins.
4. Prioritize real customer voices: mine Reddit, forums, review sites, social media for unfiltered language. Quote directly. Look for both evidence of the problem AND satisfaction with current solutions.
5. Keep writing crisp and actionable. Every recommendation must tie to evidence or an explicitly stated assumption.
6. For each founder assumption, deliberately search for supporting AND contradicting evidence. Assess which body is stronger.
7. Deliver all outputs in the formats specified below.

---

## RESEARCH FOCUS AREAS

{research_focus_areas}

---

## EXISTING ASSETS TO ANALYZE

{existing_assets}

Expand beyond known competitors. Search for direct competitors (same problem, same approach), indirect competitors (same problem, different approach), alternative solutions (including "do nothing"), and adjacent offerings.

---

## SPECIAL RESEARCH INSTRUCTIONS

{special_instructions}

---

## DELIVERABLES

### PART 1: VALIDATION

**1.1 Executive Verdict** (300 words max)
- Verdict: GO / CONDITIONAL GO / NO-GO / PIVOT RECOMMENDED
- Top 3 reasons supporting verdict (with evidence)
- Top 3 risks or conditions (with likelihood and mitigation)
- The critical assumption this depends on
- Confidence level (H/M/L) with rationale

**1.2 Base Rate Analysis**
- Category success rate with source
- Survivor characteristics: does this concept match?
- Common failure modes: does this concept have protection?
- Adjusted probability estimate with confidence

**1.3 Problem Validation**
- Evidence FOR problem existence (direct and indirect, with quotes)
- Evidence AGAINST problem severity (counterevidence)
- Weight of evidence assessment
- Rating: VALIDATED / PARTIALLY VALIDATED / NOT VALIDATED

**1.4 Demand Validation**
- Search interest (Google Trends, keyword volumes, direction)
- Community activity (Reddit, forums, social, with engagement metrics)
- Willingness-to-pay signals (current spending on alternatives)
- Competitor traction (funding, growth, reviews)
- Market adoption stage assessment
- Rating: VALIDATED / PARTIALLY VALIDATED / NOT VALIDATED

**1.4b Hero Product Mechanism Assessment**
If the business sells a physical product:
- How does the hero product work? (active ingredients, mechanism of action, technology, key components)
- What does the hero product NOT do? (limitations, gaps in coverage, complementary needs the product can't address alone)
- How does it compare mechanistically to competitors' hero products?
- Are there ingredient/component trends in this category? (emerging, established, declining)

Keep to 300-500 words. This informs downstream product portfolio strategy.

**1.5 Market Size and Dynamics**
- TAM / SAM / SOM with methodology, confidence, and assumptions
- Growth drivers with evidence
- Headwinds with evidence
- Competitive intensity assessment
- Market timing assessment
- Overall attractiveness: High / Medium / Low

**1.6 Hypothesis Testing**
For each of the 5 founder assumptions:
- Evidence supporting (with source and strength)
- Evidence contradicting (with source and strength)
- Conclusion: VALIDATED / PARTIALLY VALIDATED / CONTRADICTED / INSUFFICIENT DATA
- Impact if wrong: Critical / High / Medium / Low

Identify the keystone assumption (highest cascade impact if wrong).

**1.7 Messaging Effectiveness Analysis**
{messaging_research_thread}

Test how the target audience actually responds to different message types:
- Scientific/mechanism explanations vs emotional benefit promises
- Social proof and peer reviews vs authority endorsements  
- Problem reframing vs direct solution pitches
- Long-form education vs short-form direct response

Cite evidence from: A/B test data from competitors, ad library creative analysis, forum discussions about what convinced buyers, review language patterns. Assess whether the founder's messaging thesis matches observed consumer behavior.

---

### PART 2: AVATAR DISCOVERY

**2.1 Avatar Deep-Dive** (2-4 avatars)
For each:
- Demographics and situation
- Psychographics (beliefs, prior attempts, skepticism/enthusiasm triggers)
- Jobs-to-be-done (primary, functional, emotional, social)
- Pain points in their own words (5+ quotes with sources)
- Trigger events
- Current alternatives and switching costs
- Objections and belief shifts needed
- Where they gather (subreddits with counts, forums, publications, influencers)
- Language and keywords they use
- Viability scores: pain intensity, willingness to pay, ease of reach (1-10 each)

**2.2 Avatar Prioritization Matrix**
- Score each avatar on: pain intensity, WTP, accessibility, market size, decision speed
- Recommended primary avatar with rationale

**2.3 Segment Value Challenge**
If the founder has identified a "core" or "highest-value" segment, actively challenge the prioritization:
- Cost-to-acquire comparison across segments (which is cheapest?)
- Conversion rate evidence by awareness/sophistication stage
- Repeat purchase / LTV potential by segment
- Segment sizing reality check (is the "core" segment actually large enough?)
- Alternative prioritization: if the evidence contradicts the founder's hierarchy, propose the reorder with reasoning
- Critical question: Are highly skeptical / "tried everything" customers actually a distinct addressable segment worth targeting, or are they just hard-to-convert, low-value prospects whose skepticism makes them poor acquisition targets?

---

### PART 3: COMPETITIVE LANDSCAPE

**3.1 Competitor Matrix**
For each competitor: type (direct/indirect/alternative), target customer, value prop, pricing, traction indicators, strengths, weaknesses, where they fail customers.

**3.2 Deep-Dive Top 2-3 Competitors**
What they do well (with evidence), what customers complain about (with review quotes), recent strategic moves, why customers choose/leave them, competitive response capability, threat level.

**3.3 White Space Analysis**
- Apparent opportunity
- Evidence supporting the opportunity
- Alternative explanations for white space (market too small? economics don't work? customers don't want it? winner-takes-most?)
- Most likely explanation and whether it creates opportunity or warning

**3.4 Differentiation Assessment**
For each claimed differentiator: actually different? defensible? valued by customers? Evidence and status (STRONG/MODERATE/WEAK).
- Competitive moat assessment
- Response timeline estimate

**3.5 Competitor Product Ranges** (lightweight — feeds downstream Product Portfolio Research)
For each direct competitor analyzed in 3.1-3.2, also document:
- Full product range beyond their hero product (all SKUs with pricing)
- Bundle structures and subscription offerings
- Product launch chronology (what they added over time, in what order)
- Customer reception of non-hero products (reviews, ratings)
Keep to 2-3 sentences per competitor. This is a scan, not a deep-dive.

---

### PART 4: STRATEGIC RECOMMENDATIONS

Complete ONLY the section matching the verdict:

**4A: GO Strategy** - Value prop, positioning, channels, pricing, unit economics
**4B: CONDITIONAL GO** - What's missing, required validations with test design, decision framework with timeline and scenarios
**4C: NO-GO** - Why not viable, what would need to change, alternative opportunities, value created by the analysis
**4D: PIVOT** - Why pivot needed, recommended direction with evidence, validation plan

---

### PART 5: RISK ANALYSIS

**5.1 Critical Assumptions Tracker**
Table: assumption, impact, validation status, evidence quality, risk level

**5.2 Prioritized Action Plan**
For each action:
- Urgency: URGENT (Week 1) / HIGH (Weeks 1-4) / MEDIUM (Months 1-3)
- Description of what to do
- Why it matters
- Who is responsible
- Cost/effort estimate
- Success criteria

**5.3 Risk Register**
Categories: market, competitive, technical, financial, execution, regulatory, team
For each: likelihood, impact, evidence, mitigation, residual risk

**5.4 Scenario Planning**
- Best case (assumptions, probability, outcome, timeline)
- Base case (assumptions, probability, outcome, timeline)
- Worst case (assumptions, probability, outcome, timeline, early warning signals)
- Risk-adjusted recommendation

---

### PART 6: APPENDIX

- Customer voice repository (organized by theme)
- Search queries used
- Sources and citations
- Assumptions log with confidence levels
- Conflicting evidence notes
- Evidence quality assessment for major conclusions

---

## QUALITY CHECKLIST

Before completing, verify:
- Every conclusion ties to specific evidence
- Both supporting and contradicting evidence actively searched
- Customer voice quotes present throughout (minimum {min_quotes})
- All numbers sourced with dates
- Assumptions explicit with confidence levels
- Founder assumptions tested fairly
- Best/base/worst scenarios modeled
- Verdict follows logically from data
- Confidence level matches evidence strength
- Clear, prioritized action plan regardless of verdict

Begin research using the context provided. Follow the evidence wherever it leads.
