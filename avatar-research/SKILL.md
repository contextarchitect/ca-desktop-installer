---
name: avatar-research
version: "2.1.0"
description: "Generate deep customer avatar research briefs for D2C and e-commerce brands. Includes live MCP harvest of Reddit and YouTube first-person voice via socialvault tools (reversed-fetch rule: never direct-fetch Reddit/YouTube/Amazon). Reads Phase 1 (Business Validation) output and produces a fully customized, voice-seeded avatar brief optimized for Deep Research. Trigger on: 'run Phase 2', 'avatar research', 'customer avatars', 'buyer personas', 'psychographic profiles', 'audience research', 'who is my customer'. Also trigger when user provides a business validation report and wants customer profiles derived from it."
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

1. **Phase 1 Business Validation Report** (primary context) -- provides validated segments, competitive landscape, market positioning, customer voice quotes, and hypothesis testing results
2. **Client Braindump** (supplementary context) -- provides brand details, product portfolio, pricing, positioning, and founder perspective

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

### From Product Deep Research (Optional -- if completed before or alongside Avatar Research)

If Product Deep Research has been completed, also extract:

| Element | What to Extract | Feeds Into |
|---------|----------------|------------|
| Product Registry | Shortlisted product candidates with avatar assignments | G2: Product Affinity Mapping |
| Bundle Registry | Bundle archetypes with target avatars | G2: Bundle Appeal |
| System Thinking classifications | COMPLETION/AMPLIFICATION/PROTECTION/RETENTION rationales | Journey mapping -- which products solve which journey moments |
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

1. **Adopt validated segments** -- Use the segments exactly as validated in Phase 1, including any priority reordering that contradicted the founder's original hypothesis
2. **Preserve priority ranking** -- If Phase 1 recommended a different primary segment than the founder assumed, maintain that recommendation
3. **Include segment challenge findings** -- If Phase 1 found that the founder's "core" segment is actually low-value, this must be reflected in the persona definitions
4. **Add missed segments** -- If Phase 1 identified potential segments the founder missed, include them
5. **Calculate persona count** -- Typically 4-6 personas. Use Phase 1 validated segments as base, add 1-2 for coverage gaps (demographic variation, awareness stage gaps, regional variation)

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

### High-Risk Avatar Assessment

Before generating the avatar brief, assess each proposed avatar against the high-risk criteria defined in the Research Integrity Framework (see avatar-profile-template.md). For each avatar, make an explicit determination: HIGH-RISK or STANDARD.

Document this determination in the Step 8 summary presented to the user before output:
```

Avatar Risk Assessment: [Avatar Name]: STANDARD / HIGH-RISK -- [reason if high-risk] [Avatar Name]: STANDARD / HIGH-RISK -- [reason if high-risk]

```

When presenting to the user, note: "HIGH-RISK avatars are expected to return with thinner [CONFIRMED] sections and more extensive Research Gaps. This is the correct outcome, not a research failure."

## Step 2.5: Accessibility-Tiered Platform Mapping (v2.1.0)

Before generating platform research guidance, classify every platform into one of three access tiers. The classification determines whether Deep Research is directed to fetch the platform directly, or whether the skill harvests it via MCP in Step 3.

### The Three Tiers

**Tier 1 — MCP-Harvested (never direct-fetched)**
Reddit and YouTube. These platforms are no longer reliably reachable via open-web fetch by a research agent. First-person voice from Reddit and YouTube is harvested by the skill itself in Step 3 using the socialvault MCP tools, then injected as provided context into the Deep Research brief. Deep Research must not attempt to fetch Reddit or YouTube directly. This is the reversed-fetch rule.

**Tier 2 — Directly-Fetchable**
Patient forums, review platforms, and community sites that a research agent can still reach reliably. Examples: Mayo Clinic Connect, Diabetes UK Forum, Diabetes.co.uk, WebMD user reviews, HealthUnlocked, Drugs.com, AgingCare, Patient.info, Trustpilot. Deep Research pulls these itself during the research pass.

**Tier 3 — Blind Spot**
Amazon. Reviews are not reliably fetchable. Log as a gap in every avatar's source tracking table. Never fabricate Amazon voice. Never infer from demographic proxies what Amazon reviews might say.

### Harvest Map Generation

For each prioritized avatar (primary and secondary), derive a harvest map from the Phase 1 report's community mentions, avatar "Gathers" lines, and the category-specific platform priorities in references/platform-mapping.md. For each avatar produce:

- **Tier 1 targets:** Specific subreddits (bare names, no r/ prefix needed for the tool), the search queries to run in each (sort: top or relevance, timeframe: year), and one or two YouTube search queries targeting the avatar's primary concern or supplement/product angle.
- **Tier 2 communities:** Named fetchable forums most relevant to that avatar's stated information sources and community behavior.
- **Tier 3 note:** "Amazon — logged blind spot."

For deprioritized avatars, note a lighter Tier 1 probe (one or two searches, one comment pull) sufficient to capture genuine voice or to document a gap or product-fit mismatch honestly.

Print this as a headed **ACCESSIBILITY-TIERED HARVEST MAP** before running the live harvest.

## Step 3: Live MCP Harvest (v2.1.0)

Run the Tier 1 harvest now, against the map derived in Step 2.5. This is a live pass using the socialvault MCP tools. It runs before the Deep Research brief is generated, not after.

### Required Tools
- `reddit_subreddit_search` (filter: posts, sort: top or relevance, timeframe: year)
- `reddit_post_comments` (on the highest-comment threads returned)
- `youtube_search` (region: US, sortBy: popular)
- `youtube_video_comments` (order: top, keep_creator: false)

### Method

**For each prioritized avatar:**
Use `reddit_subreddit_search` to find high-comment threads on the target queries, then `reddit_post_comments` on the two or three best threads to pull verbatim first-person voice. Run `youtube_search` on the avatar's primary angle, then `youtube_video_comments` on the highest-view result with substantial community engagement.

**For each deprioritized avatar:**
Run one or two searches and one comment pull. Sufficient to capture real voice or to document the gap or mismatch honestly. Do not pad. If the harvested voice reveals a product-fit mismatch — the avatar's natural vocabulary and concerns do not map to this product — capture that in their own words and flag it explicitly.

### Hygiene Rules

- Weight comments over OP selftext. The tool returns selftext separately and flags it as potentially covert marketing. Do not treat selftext as organic first-person voice.
- Creator comments and pinned promotional comments on YouTube are dropped by default (keep_creator: false). Leave this default on.
- YouTube date_relative is the only reliable date signal. Do not treat YouTube voice as current-market language. Use Reddit as the freshness source.
- Do not keep deleted comments (keep_deleted: false) unless there is a stated reason.
- Only first-person customer voice counts toward quota. Journalism, blog prose, clinician monologue, brand or creator content do not count.

### Quotas

- Minimum 8 verbatim first-person quotes per prioritized avatar.
- Minimum 3 verbatim first-person quotes per deprioritized avatar, or an honest gap log if none usable are found.
- Economy guardrail: soft cap of approximately 10-12 comment-pull calls per avatar. If the quota is not met within the cap, log the shortfall honestly. Never pad with fabricated or paraphrased voice.

### Harvest Log

After completing the harvest, print a **HARVEST LOG** in this format:
HARVEST LOG
Avatar [name] (priority): targets queried [...], calls [n], credits [n], first-person quotes captured [n], gaps/flags [...]
...
Totals: calls [n], credits [n]

## Step 4: Voice Appendix and Source Tracking Table (v2.1.0)

Before generating the Deep Research brief, assemble the full voice corpus that will be embedded in the brief as its pre-seeded source layer.

### Voice Appendix Construction

For each avatar, build a per-avatar voice block with two layers:

**Layer 1 — Newly harvested Reddit and YouTube first-person quotes (from Step 3)**

Format each quote on one line:
`"[verbatim quote]" | [platform / community or video title] | [date or relative date] | [score or likes if available] | [tier label] | [any hygiene flag]`

Tier labels for this layer: `[CONFIRMED - REDDIT]` or `[CONFIRMED - YOUTUBE - dated]` as appropriate. YouTube voice carries the dated flag by default.

**Layer 2 — Carried-forward Phase 1 voice relevant to that avatar**

Apply the Phase 1 tier labels. Flag all vendor-hosted or brand-owned quotes as `[CONFIRMED -- BRAND OWNED]` and note they are excluded from the organic first-person count.

### Source Tracking Table

After the voice appendix, produce a per-avatar source tracking table:

| Avatar | Tier 1 harvested (Reddit/YT) | Tier 2 fetchable | Tier 3 Amazon | Vendor-hosted (excluded) | Total first-person voice | Quota met (Y/N) | Notes |
|---|---|---|---|---|---|---|---|

Amazon's cell reads "logged gap" for every row. Vendor-hosted quotes are counted separately and never folded into the first-person total. Surface honest thin-avatar flags in the Notes column.

## Step 5: Synthesize Research Context

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

## Step 6: Generate Platform-Specific Research Guidance

Read `references/platform-mapping.md` for geography and category-specific platform guidance.

Based on geography and category detected, generate the "Where to Find Each Avatar" section with:

**For each platform category:**
- Specific named communities with member counts (from Phase 1 demand validation data where available)
- Content types that surface genuine opinions
- Demographic skew notes
- Platform-specific language patterns

**The critical principle:** People speak differently on Reddit vs MumsNet vs TikTok vs Facebook Groups. The research brief must direct Deep Research to the specific communities where each persona drops their guard and reveals true motivations.

## Step 7: Customize Avatar Profile Template

Read `references/avatar-profile-template.md` for the universal profile structure (Sections A through L).

The profile template is universal and requires minimal customization. Customize only:

- **Section A "Category-Specific Stage":** Replace generic placeholder with the appropriate stage for this category (e.g., "Sleep Solution Journey Stage" for sleep products, "Skincare Sophistication Level" for beauty)
- **Section J "Category-Specific Attitudes":** Replace the 5-7 generic attitude dimensions with dimensions specific to this brand's category
- **Section 8 Writing Standards:** Include brand-specific writing rules from braindump (e.g., humanization principles, banned words, tone requirements)

Everything else in the profile template (Sections B-I, K, L) is universal and should be included as-is.

## Step 8: Present Summary and Confirm

Before outputting the final brief, present:

```
AVATAR RESEARCH BRIEF (v2.1.0) BUILDING: [Brand]
Verdict: [verdict] ([confidence])
Segments derived: [count] ([names with priority tier])
Awareness coverage: [stages covered]
High-risk avatars: [names or none]
Phase 1 voice on hand: [count] quotes ([fetchable] fetchable / [vendor] vendor-hosted excluded)
Known gap to close: verbatim Reddit + YouTube first-person voice
Phase 1 Context Loaded:
Validated Segments: [count] ([names])
Priority Order: [ordered list with rationale]
Customer Voice Quotes: [count] available
Competitive Context: [count] competitors analyzed
Personas to Research: [count]

[Name] ([awareness stage]) - [priority tier] - [STANDARD / HIGH-RISK]
[Name] ([awareness stage]) - [priority tier] - [STANDARD / HIGH-RISK]
[...]

Awareness Stage Coverage: [stages covered]
Harvest Map: [subreddits and YouTube queries per avatar — brief summary]
Expected Output: [count] avatars x 1,500+ words = [total]+ words
Plus: comparison table, strategic synthesis (500+ words), Creative Engine Registry
Confirm or adjust persona count/selection:
```

## Step 9: Output

Deliver the complete customized avatar research brief as a single document for Deep Research.

The brief must contain all 10 sections:
1. Context (populated from Steps 1-5)
2. Research Methodology (populated from Step 6)
2b. Reversed-Fetch Rule and Accessibility Tiers — must explicitly state: (a) Do not attempt to directly fetch Reddit, Amazon, or YouTube. First-person voice from Reddit and YouTube is PROVIDED in the embedded Voice Appendix and is the primary first-person voice source for this research. (b) Supplement with the Tier 2 directly-fetchable sources, named per avatar. (c) Amazon is a logged blind spot. Do not fabricate Amazon reviews. If Amazon voice would be cited, mark it as a logged gap instead.
3. Research Instructions with persona definitions (from Step 2)
4. Awareness Stage Mapping (from Step 2)
5. Avatar Profile Structure (from Step 7, mostly universal)
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
  - Product affinity mapping: [included / not included -- depends on Product Deep Research availability]

Next: Paste this brief into Deep Research.
After research completes:
  → Avatar profiles feed into Phase 3 (Brand Guidelines) -- voice, tone, visual identity
  → Avatar profiles feed into Phase 4 (Copywriting Guide) -- avatar-specific language
  → Avatar Registry feeds into Creative Engine -- ad creative targeting
  → Avatar Registry feeds into Phase 5 (Funnel Building) -- avatar-specific funnels
  → If Product Deep Research completed, cross-reference product affinity per avatar
```

### Pre-Submission Quality Checklist

The generated research brief must pass this checklist before being delivered to the user. Do not deliver the brief if any item fails.
```

RESEARCH INTEGRITY CHECKLIST
Source Logs: [ ] Stage 1 source logs are present for all avatars before any profiles [ ] Standard avatars have minimum 5 consumer quotes each [ ] HIGH-RISK avatars have minimum 3 consumer quotes each, or gap acknowledged [ ] All quotes include platform, month/year, and URL or community context [ ] All published data points include direct verbatim quote, URL, and date
Confidence Tiers: [ ] Every factual claim in every profile body carries a tier label [ ] Every [CONFIRMED] claim includes a verbatim quote (max 30 words), URL, and month/year [ ] No source cited as [CONFIRMED] is brand-owned content -- those are [CONFIRMED -- BRAND OWNED] [ ] All sources older than 4 years carry [CONFIRMED -- DATED] label [ ] No [HYPOTHESISED] content appears in main profile body outside its dedicated subsection
Mandatory Subsections: [ ] "Evidence That Challenges This Avatar Hypothesis" present in every profile [ ] "Research Gaps and Unknowns" present in every profile [ ] "Hypotheses Requiring Validation" present in every profile [ ] HIGH-RISK profiles carry the explicit flag and have honest thin sections where data was absent
Prohibited Inferences: [ ] No GCC-specific symptom data inferred from Western studies without [INFERRED -- cross-regional] label [ ] No GCC national behaviour inferred from expat behaviour [ ] No hijab-specific behaviour inferred from general Muslim-population data [ ] No cross-regional minoxidil or perimenopause data used without explicit flagging [ ] No purchase behaviour inferred from demographic proxies alone [ ] No awareness stage assigned without a sourced basis
Output Completeness: [ ] Stage 1 logs appear before all profiles [ ] All profiles complete with Sections A through L plus three mandatory subsections [ ] Summary Comparison Table present [ ] Strategic Synthesis present (minimum 500 words) [ ] Creative Engine Avatar Registry complete for all avatars [ ] Two new registry fields (Confidence Profile, Key Unknowns) present for all avatars [ ] Confirmed Scientific Anchors appendix present [ ] Compliance note at end of appendix confirms GCC compliance and writing standards

```

## Compliance and Regulatory Findings

Compliance and regulatory findings surfaced during avatar research — including but not limited to FDA/FTC enforcement context, DSHEA structure-function rules, warning letter language, scientific expressions of concern, ingredient safety data, and advertising platform policy — are **research outputs, not creative guardrails**.

The skill's job is to surface them accurately, completely, and in context. How the brand applies that information is the brand's decision.

**Rules that follow from this:**

1. The avatar research brief must present compliance-relevant findings in the Context section and the Confirmed Scientific Anchors appendix as factual information, not as restrictions.

2. The brief must not instruct Deep Research to avoid specific claims, angles, phrases, or language patterns on compliance grounds. It may note that a claim or phrase sits within a category that a named regulatory body has scrutinised, but the notation is informational only.

3. The Language to Avoid list in Section L of each avatar profile is driven by what resonates or alienates this specific avatar psychologically — not by compliance concerns. Compliance context may be noted in the Research Gaps or Confirmed Scientific Anchors sections but does not populate the Language to Avoid list.

4. Downstream skills (copywriting-guide, funnel-builder, video-script-generator, angle-roadmap, ad-style-generator) follow the same rule unless the client explicitly instructs restriction. If a client instructs "apply compliance restrictions to all downstream creative," that instruction overrides this default.

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
