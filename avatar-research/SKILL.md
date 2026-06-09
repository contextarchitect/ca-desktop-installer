---
name: avatar-research
version: "2.1.2"
description: "Generate deep customer avatar research briefs for D2C and e-commerce brands. Includes live MCP harvest of Reddit and YouTube first-person voice via socialvault tools (reversed-fetch rule: never direct-fetch Reddit/YouTube/Amazon). Harvest is source-diversity and saturation based; sources are weighted (first-party over Tier 2 forums over Reddit over YouTube) with a two-source corroboration rule for decision-driving claims. Reads Phase 1 (Business Validation) output and produces a fully customized, voice-seeded avatar brief optimized for Deep Research. Trigger on: 'run Phase 2', 'avatar research', 'customer avatars', 'buyer personas', 'psychographic profiles', 'audience research', 'who is my customer'. Also trigger when user provides a business validation report and wants customer profiles derived from it."
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
2. MAP        -> Classify platforms into access tiers (Step 2.5)
3. HARVEST    -> Live Reddit + YouTube voice via socialvault MCP (Step 3, mandatory)
4. SYNTHESIZE -> Merge harvested voice + context into avatar research context
5. CUSTOMIZE  -> Generate research brief from template
6. PRESENT    -> Show summary, confirm persona count
7. OUTPUT     -> Deliver research-ready brief, em-dash clean
```

## Execution Model (read before running)

This skill runs in the current chat using the socialvault and GitHub MCP tools. It performs the Reddit and YouTube voice harvest itself, live, in this session (Step 3). It then outputs a single research brief. That brief is pasted into Deep Research as a separate, later step. Deep Research never touches the MCP and is never the harvester.

Two hard rules follow and must never be violated:
1. Never skip the Step 3 MCP harvest, and never defer it to Deep Research. The harvest is mandatory and is performed here, by you, now. A brief produced without a completed Step 3 harvest is invalid.
2. Never write the Deep Research brief so that Deep Research gathers, searches, browses, or researches Reddit or YouTube by any means. Their first-person voice is already harvested and embedded in the Voice Appendix, which is Deep Research's only Tier 1 input. Folding Reddit or YouTube into the Deep Research scope is the most common failure of this skill and is prohibited.

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

## Step 2.5: Accessibility-Tiered Platform Mapping

Before generating platform research guidance, classify every platform into one of three access tiers. The classification determines whether Deep Research is directed to fetch the platform directly, or whether the skill harvests it via MCP in Step 3.

### The Three Tiers

**Tier 1 -- MCP-Harvested (never direct-fetched)**
Reddit and YouTube. These platforms are no longer reliably reachable via open-web fetch by a research agent. First-person voice from Reddit and YouTube is harvested by the skill itself in Step 3 using the socialvault MCP tools, then injected as provided context into the Deep Research brief. Deep Research must not attempt to fetch Reddit or YouTube directly. This is the reversed-fetch rule.

**Tier 2 -- Directly-Fetchable**
Patient forums, review platforms, and community sites that a research agent can still reach reliably. Examples: Mayo Clinic Connect, Diabetes UK Forum, Diabetes.co.uk, WebMD user reviews, HealthUnlocked, Drugs.com, AgingCare, Patient.info, Trustpilot. Deep Research pulls these itself during the research pass.

**Tier 3 -- Blind Spot**
Amazon. Reviews are not reliably fetchable. Log as a gap in every avatar's source tracking table. Never fabricate Amazon voice. Never infer from demographic proxies what Amazon reviews might say.

### Harvest Map Generation

For each prioritized avatar (primary and secondary), derive a harvest map from the Phase 1 report's community mentions, avatar "Gathers" lines, and the category-specific platform priorities in references/platform-mapping.md. For each avatar produce:

- **Tier 1 targets:** At least three distinct subreddits (bare names, no r/ prefix needed for the tool), the search queries to run in each (sort: top or relevance, timeframe: year), and two or three YouTube search queries targeting the avatar's primary concern or supplement/product angle. Name more communities than seem strictly necessary; saturation in Step 3 decides where to stop, not a fixed count.
- **Tier 2 communities:** At least three distinct fetchable forums or review platforms most relevant to that avatar's stated information sources and community behavior. This is a depth floor, not a single example, so that Tier 1 voice does not structurally dominate the corpus.
- **Tier 3 note:** "Amazon -- logged blind spot."

For deprioritized avatars, note a Tier 1 probe of two or three distinct threads (deeper than a single pull) sufficient to capture genuine voice or to document a gap or product-fit mismatch honestly.

Print this as a headed **ACCESSIBILITY-TIERED HARVEST MAP** before running the live harvest.

## Step 3: Live MCP Harvest

Run the Tier 1 harvest now, against the map derived in Step 2.5. This is a live pass using the socialvault MCP tools, performed by you in this session. It runs before the Deep Research brief is generated, not after. This step is mandatory and must never be skipped or handed to Deep Research. If the socialvault tools are unavailable, stop and report; do not substitute a Deep Research pass for the harvest.

### Required Tools
- `reddit_subreddit_search` (filter: posts, sort: top or relevance, timeframe: year)
- `reddit_post_comments` (on the highest-comment threads returned)
- `youtube_search` (region: US, sortBy: popular)
- `youtube_video_comments` (order: top, keep_creator: false)

### Method

**For each prioritized avatar:**
Use `reddit_subreddit_search` across at least three distinct communities to find high-comment threads on the target queries, then `reddit_post_comments` on the highest-comment threads. Harvest from a minimum of five to eight distinct Reddit threads spanning at least three communities. Run `youtube_search` on the avatar's primary angle, then `youtube_video_comments` on two or three distinct videos with substantial community engagement, not one. Capture every usable verbatim first-person quote from each thread; quote count is not the stopping rule (see Saturation below).

YouTube depth buys vocabulary and objections, not current-market language. Weight depth toward Reddit, which is the freshness source. Two or three videos is enough; do not chase YouTube saturation the way you do Reddit.

**For each deprioritized avatar:**
Run searches across one or two communities and pull comments from two or three distinct threads. Sufficient to capture real voice or to document the gap or mismatch honestly. Do not pad. If the harvested voice reveals a product-fit mismatch -- the avatar's natural vocabulary and concerns do not map to this product -- capture that in their own words and flag it explicitly.

### Hygiene Rules

- Weight comments over OP selftext. The tool returns selftext separately and flags it as potentially covert marketing. Do not treat selftext as organic first-person voice.
- Creator comments and pinned promotional comments on YouTube are dropped by default (keep_creator: false). Leave this default on.
- YouTube date_relative is the only reliable date signal. Do not treat YouTube voice as current-market language. Use Reddit as the freshness source.
- Do not keep deleted comments (keep_deleted: false) unless there is a stated reason.
- Only first-person customer voice counts toward quota. Journalism, blog prose, clinician monologue, brand or creator content do not count.

### Saturation, Quotas, and Guardrail

- **Saturation is the stopping rule, not a quote count.** Keep pulling additional threads within a prioritized avatar until two consecutive threads surface no new theme (no new pain, objection, identity frame, vocabulary, or proof preference). Record the thread at which saturation was reached.
- **Floors:** at least 8 verbatim first-person quotes per prioritized avatar drawn from the five-to-eight-thread spread above; at least 3 per deprioritized avatar, or an honest gap log if none usable are found. The floors are a minimum, not a target; expect prioritized avatars to exceed 8 once saturation is the goal.
- **No single thread or video may supply more than half of any one avatar's first-person quotes.** If it does, the harvest is too narrow; widen it before proceeding.
- **Economy guardrail:** the binding constraint is saturation, not a call cap. Allow up to approximately 20-25 comment-pull calls per prioritized avatar before forcing a stop-and-log. If saturation is reached earlier, stop earlier. If the guardrail is hit before saturation, log that the avatar did not saturate. Never pad with fabricated or paraphrased voice.

### Harvest Log

After completing the harvest, print a **HARVEST LOG** in this format:
HARVEST LOG
Avatar [name] (priority): communities searched [n], distinct Reddit threads pulled [n], distinct YouTube videos [n], comment-pull calls [n], credits [n], usable first-person quotes [n], saturation reached [Y at thread k / N], gaps/flags [...]
...
Totals: calls [n], credits [n]

## Step 4: Voice Appendix and Source Tracking Table

Before generating the Deep Research brief, assemble the full voice corpus that will be embedded in the brief as its pre-seeded source layer.

### Voice Appendix Construction

For each avatar, build a per-avatar voice block with two layers:

**Layer 1 -- Newly harvested Reddit and YouTube first-person quotes (from Step 3)**

Format each quote on one line:
`"[verbatim quote]" | [platform / community or video title] | [date or relative date] | [score or likes if available] | [tier label] | [any hygiene flag]`

Tier labels for this layer: `[CONFIRMED - REDDIT]` or `[CONFIRMED - YOUTUBE - dated]` as appropriate. YouTube voice carries the dated flag by default.

**Layer 2 -- Carried-forward Phase 1 voice relevant to that avatar**

Apply the Phase 1 tier labels. Flag all vendor-hosted or brand-owned quotes as `[CONFIRMED -- BRAND OWNED]` and note they are excluded from the organic first-person count.

### Source Weighting Model

Sources are weighted when the brief constructs profiles. State this model in the appendix so it carries into the brief. Each quote already shows its tier; the weighting is how much that tier counts:

- **W1 First-party:** brand-owned analytics (quiz, sales, email, ad platform). Highest weight; the only data about this brand's actual buyers. Usually absent at this stage, which is why profiles end with first-party validation items.
- **W2 Tier 2 verified or post-purchase voice:** review platforms and patient forums. High weight; closest to actual buyers and lived experience.
- **W3 Reddit:** high weight for raw emotion, identity, and current-market freshness. Treat as community discourse, subject to vocal-minority and brigading skew.
- **W4 YouTube:** lower weight. Multi-year stale and creator-audience skewed. Vocabulary and objections, not current behavior.
- **Vendor and testimonial content:** excluded from the organic first-person count entirely.


### Corroboration Map (Format and Rule)

This defines the corroboration rule and the map format only; no map output is produced at this stage. The authoritative per-avatar map is produced in the final report, because most load-bearing claims emerge from the Deep Research pass. The brief (Step 9, item 2f) is what requires Deep Research to produce and embed the completed map.

The rule: every load-bearing strategic claim (a claim that drives a pricing, entry-SKU, spend, or creative decision) must be supported by two or more independent sources, ideally spanning at least two tiers. Any load-bearing claim resting on a single source is flagged single-source and demoted to the Hypotheses Requiring Validation subsection. Format:

CORROBORATION MAP -- Avatar [name]
Claim: [the strategic claim] | Sources: [source A (tier)], [source B (tier)] | Status: corroborated / single-source (demote)
...


### Source Tracking Table (Pre-Brief Harvested Corpus)

After the voice appendix, produce a per-avatar table of the corpus on hand at this stage. This is the pre-brief harvested corpus, not the final source balance:

| Avatar | Distinct Reddit threads / communities | Distinct YouTube videos | Tier 1 first-person quotes | Phase 1 carried voice (fetchable) | Vendor-hosted (excluded) | Tier 3 Amazon | Saturation reached (Y/N) | Notes |
|---|---|---|---|---|---|---|---|---|

Amazon reads "logged gap" for every row. Vendor-hosted quotes are counted separately and never folded into the first-person total. Tier 2 fetching and the final Tier 1 vs Tier 2 balance happen during Deep Research, not at this stage, and are reported in the brief's post-research source balance table (Step 9), not here. Surface honest thin-avatar flags in the Notes column.

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

Based on geography and category detected, generate the "Where to Find Each Avatar" section for Deep Research, scoped to Tier 2 directly-fetchable sources only. Reddit and YouTube are harvested by this skill in Step 3 and supplied as the Voice Appendix, never listed here as Deep Research targets. Generate it with:

**For each Tier 2 platform category:**
- Specific named communities with member counts (from Phase 1 demand validation data where available)
- Content types that surface genuine opinions
- Demographic skew notes
- Platform-specific language patterns

**The critical principle:** People speak differently on Reddit vs MumsNet vs TikTok vs Facebook Groups, which is why this skill harvests Reddit and YouTube itself in Step 3. The brief directs Deep Research only to the Tier 2 directly-fetchable communities where each persona reveals true motivations; the Reddit and YouTube voice is already captured in the Voice Appendix and must not be re-researched.

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
AVATAR RESEARCH BRIEF BUILDING: [Brand]
Verdict: [verdict] ([confidence])
Segments derived: [count] ([names with priority tier])
Awareness coverage: [stages covered]
High-risk avatars: [names or none]
Phase 1 voice on hand: [count] quotes ([fetchable] fetchable / [vendor] vendor-hosted excluded)
Tier 1 Reddit + YouTube voice: harvested and embedded (Step 3). Tier 2: pulled by Deep Research during the research pass.
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
Harvest Map: [subreddits and YouTube queries per avatar -- brief summary]
Expected Output: [count] avatars x 1,500+ words = [total]+ words
Plus: comparison table, strategic synthesis (500+ words), Creative Engine Registry
Confirm or adjust persona count/selection:
```

## Step 9: Output

Deliver the complete customized avatar research brief as a single document for Deep Research.

The brief must contain all 10 sections:
1. Context (populated from Steps 1-5)
2. Research Methodology (populated from Step 6)
2b. Reversed-Fetch Rule and Accessibility Tiers -- must explicitly state: (a) Do not fetch, search, browse, crawl, or otherwise research Reddit, Amazon, or YouTube by any means, and do not include them in the research scope. First-person voice from Reddit and YouTube is PROVIDED in the embedded Voice Appendix and is the only Tier 1 first-person voice source for this research; treat it as already-gathered provided context, not a target to re-gather. (b) Supplement with the Tier 2 directly-fetchable sources, named per avatar, pulling from at least three distinct Tier 2 sources per prioritized avatar so Tier 1 does not structurally dominate. (c) Amazon is a logged blind spot. Do not fabricate Amazon reviews. If Amazon voice would be cited, mark it as a logged gap instead.
2c. Source Weighting and Corroboration -- must state: (a) construct each profile weighting sources W1 first-party, then W2 Tier 2, then W3 Reddit, then W4 YouTube, with vendor content excluded; where sources conflict, the higher weight governs the claim and the conflict is noted. (b) Every load-bearing claim (pricing, entry-SKU, spend, or creative decision) must cite at least two independent sources, ideally across at least two tiers; a single-source claim goes into Hypotheses Requiring Validation, not the main body. (c) No single Reddit thread or YouTube video may supply more than half of any one avatar's first-person quotes.
2d. Foundational-Citation Integrity -- before relying on any foundational or heavily-cited category study, check it for retraction, correction, or expression of concern. Exclude or flag any that carry one, and state that the check was performed. This prevents a discredited anchor study from silently propagating into positioning.
2e. How We Sourced This Research (client-facing) -- embed the standard methodology section (canonical text below) verbatim. The brief must instruct Deep Research, in imperative terms, that it MUST reproduce this section verbatim as a standalone "How We Sourced This Research" section in the final report, including in full both the weighting rules (how much W1 through W4 each count) and the label legend (what every [CONFIRMED], [CONFIRMED - DATED], [CONFIRMED - BRAND OWNED], [INFERRED], [HYPOTHESISED], and W1 through W4 tag means and how to read it). This section is not optional and must not be summarized or dropped; a final report that omits the label legend or the weighting rules is incomplete and must be regenerated. These reports are shared with clients, who need the key to read the tags.
2f. Post-Research Source Accounting -- the brief must require Deep Research to produce in its final output, per prioritized avatar: (a) a post-research source balance table showing the distinct Tier 2 sources actually pulled (at least three per prioritized avatar) and the Tier 1 vs Tier 2 balance of the final corpus; and (b) the completed Corroboration Map artifact (each load-bearing claim mapped to its two or more independent sources, or marked single-source and demoted to Hypotheses Requiring Validation). The Step 4 weighting model and the 2c rules govern how both are built. The pre-brief Step 4 table is the harvested corpus only; this post-research accounting is where Tier 2 depth and tier balance are actually evidenced.
2g. Writing standards (em-dash ban) -- the brief must state, as a hard writing standard Deep Research must follow in the final report: use no em dashes, en dashes, or horizontal-bar characters anywhere in the output (prose, tables, headings, or labels). Use periods, commas, parentheses, or spaced hyphens instead. This applies to the entire final report without exception.
3. Research Instructions with persona definitions (from Step 2)
4. Awareness Stage Mapping (from Step 2)
5. Avatar Profile Structure (from Step 7, mostly universal)
6. Additional Research Requirements (universal)
7. Output Format (universal with persona count customized)
8. Quality Standards (universal + brand writing standards)
9. Expected Output (customized word count)
10. Final Note (customized brand applications)

**Canonical text for section 2e (How We Sourced This Research), embed verbatim:**

```
How We Sourced This Research

Customer voice is harder to gather cleanly than it was even two years ago. Many of the places real buyers actually talk, Reddit, YouTube, and Amazon among them, now block automated research tools by default, so a general research pass quietly returns thin or empty results from exactly the sources that matter most. To work around that, this report uses a layered sourcing method and labels every quote so you can see precisely where it came from and how much weight it carries. The short version: nothing here is asserted without a traceable source, and where a source could not be reached, we say so rather than guess.

The three source tiers.
Tier 1, harvested directly. Reddit and YouTube. We collect this voice ourselves, up front, using a dedicated harvesting tool, because general research tools can no longer reach it reliably. This is the rawest and most current first-person language in the report.
Tier 2, directly verifiable. Patient forums and review platforms that are still openly accessible, such as Diabetes UK, Mayo Clinic Connect, WebMD, Drugs.com, and AgingCare. This voice sits closest to real buyers and post-purchase experience, which is why it carries high weight.
Tier 3, the known blind spot. Amazon. Its reviews are not reliably accessible to research tools, so instead of guessing, we log Amazon as a documented gap. We never invent or paraphrase reviews we could not actually read.

How much each source counts. Not every source carries equal weight when we build the profiles. W1, your own first-party data (quiz, sales, email, ad platform), outranks everything because it describes your actual customers. W2, Tier 2 verified voice, is high weight and closest to real buyers. W3, Reddit, is high weight for emotion, identity, and current language, but treated as community discussion. W4, YouTube, is lower weight: often older and shaped by who follows a channel. Brand-owned or vendor testimonials are excluded from the voice count entirely.

The two-source rule for decisions. Any claim that drives a real decision, which product to lead with, how to price it, or where to spend, must be supported by at least two independent sources, ideally from different tiers. A claim resting on a single source is not presented as a finding; it moves into Hypotheses Requiring Validation, flagged as a lead to test rather than a conclusion to act on.

The labels you will see. [CONFIRMED] is a named, checkable source with a real quote and a date from the last four years. [CONFIRMED - DATED] is the same but older than four years. [CONFIRMED - BRAND OWNED] is brand or vendor content, used only as an example of language, never as proof of effectiveness. [INFERRED] is a reasoned conclusion drawn from confirmed material, with the reasoning shown. [HYPOTHESISED] is a plausible idea with no direct source yet, and only ever appears in the validation sections. W1 through W4 mark the weighting tier of a given quote.
```

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

### Output Hygiene (em-dash sweep)

Before delivering the brief, scan it and confirm it contains zero em dashes, en dashes, or horizontal-bar characters; replace any with periods, commas, parentheses, or spaced hyphens. The brief you output must itself be em-dash clean, and it must carry the em-dash ban forward to Deep Research via item 2g so the final report is clean too.

### Pre-Submission Quality Checklist

The generated research brief must pass this checklist before being delivered to the user. Do not deliver the brief if any item fails.
```

RESEARCH INTEGRITY CHECKLIST
Source Logs: [ ] Stage 1 source logs are present for all avatars before any profiles [ ] Standard avatars have minimum 5 consumer quotes each [ ] HIGH-RISK avatars have minimum 3 consumer quotes each, or gap acknowledged [ ] All quotes include platform, month/year, and URL or community context [ ] All published data points include direct verbatim quote, URL, and date
Harvest Depth, Weighting, and Source Accounting: [ ] Each prioritized avatar harvested across at least 3 communities and at least 5 distinct threads [ ] At least 8 first-person quotes per prioritized avatar (harvest floor; distinct from the in-profile minimum) [ ] At least 2 distinct YouTube videos per prioritized avatar [ ] Saturation reached, or honest non-saturation logged, per prioritized avatar [ ] No single thread or video supplies more than half of any avatar's first-person quotes [ ] Source weighting model (W1-W4, vendor excluded) stated in the brief [ ] Brief requires Deep Research to produce the post-research source balance table (at least 3 distinct Tier 2 per prioritized avatar; Tier 1 vs Tier 2 balance) and the completed Corroboration Map artifact [ ] Foundational or heavily-cited category studies checked for retraction, correction, or expression of concern
Confidence Tiers: [ ] Every factual claim in every profile body carries a tier label [ ] Every [CONFIRMED] claim includes a verbatim quote (max 30 words), URL, and month/year [ ] No source cited as [CONFIRMED] is brand-owned content -- those are [CONFIRMED -- BRAND OWNED] [ ] All sources older than 4 years carry [CONFIRMED -- DATED] label [ ] No [HYPOTHESISED] content appears in main profile body outside its dedicated subsection
Mandatory Subsections: [ ] "Evidence That Challenges This Avatar Hypothesis" present in every profile [ ] "Research Gaps and Unknowns" present in every profile [ ] "Hypotheses Requiring Validation" present in every profile [ ] HIGH-RISK profiles carry the explicit flag and have honest thin sections where data was absent
Prohibited Inferences: [ ] No GCC-specific symptom data inferred from Western studies without [INFERRED -- cross-regional] label [ ] No GCC national behaviour inferred from expat behaviour [ ] No hijab-specific behaviour inferred from general Muslim-population data [ ] No cross-regional minoxidil or perimenopause data used without explicit flagging [ ] No purchase behaviour inferred from demographic proxies alone [ ] No awareness stage assigned without a sourced basis
Output Completeness: [ ] Stage 1 logs appear before all profiles [ ] All profiles complete with Sections A through L plus three mandatory subsections [ ] Summary Comparison Table present [ ] Strategic Synthesis present (minimum 500 words) [ ] Creative Engine Avatar Registry complete for all avatars [ ] Two new registry fields (Confidence Profile, Key Unknowns) present for all avatars [ ] Confirmed Scientific Anchors appendix present [ ] How We Sourced This Research section present in the final report, including the full label legend (all tag meanings) and the W1 through W4 weighting rules [ ] Final report contains zero em dashes, en dashes, or horizontal-bar characters [ ] Compliance note at end of appendix confirms GCC compliance and writing standards

```

## Compliance and Regulatory Findings

Compliance and regulatory findings surfaced during avatar research -- including but not limited to FDA/FTC enforcement context, DSHEA structure-function rules, warning letter language, scientific expressions of concern, ingredient safety data, and advertising platform policy -- are **research outputs, not creative guardrails**.

The skill's job is to surface them accurately, completely, and in context. How the brand applies that information is the brand's decision.

**Rules that follow from this:**

1. The avatar research brief must present compliance-relevant findings in the Context section and the Confirmed Scientific Anchors appendix as factual information, not as restrictions.

2. The brief must not instruct Deep Research to avoid specific claims, angles, phrases, or language patterns on compliance grounds. It may note that a claim or phrase sits within a category that a named regulatory body has scrutinised, but the notation is informational only.

3. The Language to Avoid list in Section L of each avatar profile is driven by what resonates or alienates this specific avatar psychologically -- not by compliance concerns. Compliance context may be noted in the Research Gaps or Confirmed Scientific Anchors sections but does not populate the Language to Avoid list.

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
