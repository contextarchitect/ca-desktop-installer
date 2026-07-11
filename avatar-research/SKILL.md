---
name: avatar-research
version: "3.0.0"
description: "Generate deep customer avatar research briefs for D2C and e-commerce brands. Includes live MCP harvest of Reddit, YouTube, and screened Amazon verified-purchase voice via the Mindcase tools, plus supplementary Instagram and Twitter (reversed-fetch rule: never direct-fetch a harvested platform). Harvest is source-diversity and saturation based; sources are weighted (first-party over Tier 2 forums and screened Amazon over Reddit over YouTube, with Instagram and Twitter supplementary) with a two-source corroboration rule for decision-driving claims. The accessibility-tier model, the reversed-fetch rule, and the weighting model live in the canonical framework `_frameworks/source-accessibility-tiers.md`. Reads Phase 1 (Business Validation) output and produces a fully customized, voice-seeded avatar brief optimized for Deep Research. Trigger on: 'run Phase 2', 'avatar research', 'customer avatars', 'buyer personas', 'psychographic profiles', 'audience research', 'who is my customer'. Also trigger when user provides a business validation report and wants customer profiles derived from it."
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
2. MAP        -> Classify platforms into access tiers (Step 2.5, per the framework doc)
3. HARVEST    -> Live Reddit + YouTube + screened Amazon voice via Mindcase MCP (Step 3, mandatory)
4. SYNTHESIZE -> Merge harvested voice + context into avatar research context
5. CUSTOMIZE  -> Generate research brief from template
6. PRESENT    -> Show summary, confirm persona count
7. OUTPUT     -> Deliver research-ready brief, em-dash clean
```

## Execution Model (read before running)

[v3.0.0 amendment] This skill runs in the current chat using the Mindcase harvest tools (the `_tools/mindcase/` MCP server, or the `mindcase` CLI) and the GitHub MCP tools. It performs the Reddit, YouTube, and screened Amazon voice harvest itself, live, in this session (Step 3), with Instagram and Twitter as supplementary sources. It then outputs a single research brief. That brief is pasted into Deep Research as a separate, later step. Deep Research never touches the harvest tools and is never the harvester. The accessibility-tier model, the reversed-fetch rule, and the source-weighting model are defined once in `_frameworks/source-accessibility-tiers.md`; this skill applies them and does not restate them.

Two hard rules follow and must never be violated:
1. Never skip the Step 3 MCP harvest, and never defer it to Deep Research. The harvest is mandatory and is performed here, by you, now. A brief produced without a completed Step 3 harvest is invalid.
2. Never write the Deep Research brief so that Deep Research gathers, searches, browses, or researches any Tier 1 harvested platform (Reddit, YouTube, Amazon, and the supplementary Instagram and Twitter) by any means. Their first-person voice is already harvested and embedded in the Voice Appendix, which is Deep Research's only Tier 1 input. Folding a harvested platform back into the Deep Research scope is the most common failure of this skill and is prohibited (the reversed-fetch rule, per the framework doc).

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

[v3.0.0 amendment] The accessibility-tier model, the reversed-fetch rule, the per-platform reach routes, and the weighting model are defined once, canonically, in `_frameworks/source-accessibility-tiers.md`. Read it before building the harvest map. Do not restate the tier definitions here; this step only applies them to produce the concrete harvest map below. The one operational delta to keep front of mind: Amazon is no longer a blind spot -- its verified-purchase reviews are harvested and mechanically screened in Step 3, and Instagram and Twitter enter as supplementary sources, so none of Reddit, YouTube, Amazon, Instagram, or Twitter is ever a Deep Research target.

### Harvest Map Generation

For each prioritized avatar (primary and secondary), derive a harvest map from the Phase 1 report's community mentions, avatar "Gathers" lines, and the category-specific platform priorities in references/platform-mapping.md. For each avatar produce:

- **Tier 1 primary targets:** At least three distinct subreddits (bare names, no r/ prefix needed for the tool), the search queries to run in each (sort: top, timeframe: year -- note the tool applies the year window only under sort=top), and two or three YouTube search queries targeting the avatar's primary concern or supplement/product angle. Plus at least one Amazon angle: the hero product and one or two competitor products, named by keyword for ASIN discovery. Name more communities and products than seem strictly necessary; saturation in Step 3 decides where to stop, not a fixed count.
- **Tier 1 supplementary targets (optional):** one or two Instagram hashtags or Twitter queries for the avatar's category, noted as supplementary. These never gate saturation; skip them if primary saturation is already reached.
- **Tier 2 communities:** At least three distinct fetchable forums or review platforms most relevant to that avatar's stated information sources and community behavior. This is a depth floor, not a single example, so that Tier 1 voice does not structurally dominate the corpus.
- **Tier 3 note:** "Facebook organic pages -- excluded (FB probe)."

For deprioritized avatars, note a Tier 1 probe of two or three distinct threads (deeper than a single pull) sufficient to capture genuine voice or to document a gap or product-fit mismatch honestly.

Print this as a headed **ACCESSIBILITY-TIERED HARVEST MAP** before running the live harvest.

## Step 3: Live MCP Harvest

[v3.0.0 amendment] Run the Tier 1 harvest now, against the map derived in Step 2.5. This is a live pass using the Mindcase harvest tools (the `_tools/mindcase/` MCP server on Claude Desktop, or the `mindcase` CLI on the VPS), performed by you in this session. It runs before the Deep Research brief is generated, not after. This step is mandatory and must never be skipped or handed to Deep Research. If the Mindcase tools are unavailable, stop and report; do not substitute a Deep Research pass for the harvest.

The tools are semantic, not passthrough: every provider quirk and the mandatory Amazon contamination screen live inside them, so you cannot skip a screen or a sort by calling the API directly. Each tool returns trimmed rows plus a derived `state`; ground truth is cached to disk by the tool. Trust the tool's shaped output, not the raw provider docs.

### Required Tools

Primary voice (harvested, weighted):
- `reddit_search_posts` (subreddit, keyword; sort defaults to top, timeframe defaults to year; posts arrive pre-ranked by experiential likelihood via `pull_order` / `experiential_score`)
- `reddit_post_comments` (post_url; returns the comment tree with `depth`, `parent_id`, `is_op`)
- `youtube_search_videos` (query; relevance fetch, engagement-sorted post-hoc -- there is no native sort)
- `youtube_video_comments` (video_url; likes-sorted post-hoc, `exclude_creator` defaults true)
- `amazon_search_products` (keywords, for ASIN discovery) then `amazon_reviews_screened` (asin_or_url; runs the contamination screen and exposes `ingest_rows`)

Supplementary voice (reduced weight, never gates saturation):
- `instagram_posts`, `instagram_comments`
- `twitter_search`, `twitter_replies`

Account:
- `check_balance` (remaining wallet balance; used by the degraded-harvest rule below)

Facebook has no tool and is excluded (see Step 2.5 and the framework doc). Do not reach for `run_agent` to harvest any of the platforms above: it refuses every provider group that has a dedicated tool, precisely so the quirk shaping and the Amazon screen cannot be bypassed.

### Method

**For each prioritized avatar:**
Use `reddit_search_posts` across at least three distinct communities to find experiential threads on the target queries. The tool returns posts already ranked by experiential likelihood, so pull comments in `pull_order` (1 first) rather than by raw comment count. Regardless of score, skip posts whose `title` or `flair` identifies them as pinned or sticky, an announcement, a guide / wiki / FAQ / rules post, or a recurring daily / weekly / monthly help / selfie / megathread. Key this skip only on those visible `title` and `flair` fields; the trimmed row exposes no sticky / pinned boolean, so do not rely on a pinned flag. The ranker occasionally lets a sticky guide outrank experiential threads (live-observed 2026-07-11), so apply this skip yourself. A tool-side demotion of these posts is tracked in BACKLOG #29. Then run `reddit_post_comments` on the selected threads. Harvest from a minimum of five to eight distinct Reddit threads spanning at least three communities. Run `youtube_search_videos` on the avatar's primary angle, then `youtube_video_comments` on two or three distinct videos with substantial community engagement, not one. Run `amazon_search_products` on the hero product plus one or two competitor keywords, then `amazon_reviews_screened` per discovered ASIN (see the Amazon rule below). Capture every usable verbatim first-person quote; quote count is not the stopping rule (see Saturation below).

YouTube depth buys vocabulary and objections, not current-market language. Weight depth toward Reddit and screened Amazon, which are the freshness sources. Two or three videos is enough; do not chase YouTube saturation the way you do Reddit.

**Amazon depth comes from breadth, not one deep pull.** A standard `amazon_reviews_screened` pull returns up to about 100 reviews per ASIN, so depth comes from multiple ASINs (hero plus competitors), not a single deep harvest. Ingest ONLY `ingest_rows`. That field is populated only when the harvest state is `complete` AND the pool screened CLEAN. If `ingest_allowed` is false, or `state` is not `complete`, do NOT ingest anything: consult `audit` for the verdict and reasons, and either re-run the harvest or log the exclusion in the source accounting exactly as the decision record requires (a FLAGGED pool is excluded with its flag reasons and row counts logged, never silently dropped). Never read `audit.admitted_rows`, `audit.quarantined_rows`, or `audit.partial_rows` as ingestible voice; `audit` is inspection data only.

**Instagram and Twitter (supplementary):** run at most one or two calls per avatar if primary saturation has not already been reached. Their rows inform vocabulary and objections only, at reduced weight; they never gate saturation and never, alone, satisfy corroboration. Skip them entirely once the primary sources have saturated.

**For each deprioritized avatar:**
Run searches across one or two communities and pull comments from two or three distinct threads. Sufficient to capture real voice or to document the gap or mismatch honestly. Do not pad. If the harvested voice reveals a product-fit mismatch -- the avatar's natural vocabulary and concerns do not map to this product -- capture that in their own words and flag it explicitly.

### Hygiene Rules

- [v3.0.0 amendment] Weight comments over OP body. Reddit posts carry their body under `text` and comments carry `is_op`; do not treat a post body or an OP-authored comment as organic third-party first-person voice. Weight the community's replies over the poster's own framing.
- Creator comments on YouTube are dropped by default (`exclude_creator` defaults true, applied post-hoc via each row's `author_is_owner` flag). Leave this default on.
- YouTube comment dates are year-reliable but day-imprecise (relative-derived), so treat YouTube voice as dated, not current-market language. Use Reddit and screened Amazon as the freshness sources.
- Amazon: ingest only `ingest_rows`; never fabricate or paraphrase reviews. A FLAGGED or non-`complete` pool is excluded with its reason logged, per the Amazon rule above.
- Only first-person customer voice counts toward quota. Journalism, blog prose, clinician monologue, brand or creator content do not count.

### Saturation, Quotas, and Guardrail

[v3.0.0 amendment] Saturation is judged on the primary sources only (Reddit, YouTube, screened Amazon). Instagram and Twitter are supplementary and never gate saturation.

- **Saturation is the stopping rule, not a quote count.** Keep pulling additional primary sources (threads, videos, ASINs) within a prioritized avatar until two consecutive primary sources surface no new theme (no new pain, objection, identity frame, vocabulary, or proof preference). Record the source at which saturation was reached.
- **Floors:** at least 8 verbatim first-person quotes per prioritized avatar drawn from the five-to-eight-thread spread above plus at least one screened-CLEAN Amazon pool where the category has one; at least 3 per deprioritized avatar, or an honest gap log if none usable are found. The floors are a minimum, not a target; expect prioritized avatars to exceed 8 once saturation is the goal.
- **No single thread, video, or ASIN may supply more than half of any one avatar's first-person quotes.** If it does, the harvest is too narrow; widen it before proceeding.
- **Economy guardrail:** the binding constraint is saturation, not a call cap. Allow up to approximately 20-25 comment-pull calls per prioritized avatar before forcing a stop-and-log. If saturation is reached earlier, stop earlier. If the guardrail is hit before saturation, log that the avatar did not saturate. Never pad with fabricated or paraphrased voice.

### Degraded Harvests (never ingest a non-complete result)

[v3.0.0 amendment] Every harvest tool returns a derived `state`: `complete`, `partial_wallet`, `failed`, or `indeterminate`. Only `complete` is ingestible (and Amazon additionally needs a CLEAN screen). The tool already withholds primary rows for any non-`complete` state and moves the partials into `audit.partial_rows`, so never reconstruct a harvest from `audit`.

- If any harvest returns `state` other than `complete` (or `harvest_complete: false`), do NOT ingest its rows. It is degraded, not usable voice.
- `partial_wallet` or a `failed` state with `audit.wallet_signals` present means the wallet ran dry mid-harvest. Run `check_balance`, top up or wait as the operator directs, then re-run the harvest. Do not treat the partial rows as a completed pull.
- `indeterminate` is the fail-closed default (an unmapped or novel provider shape). Re-run; if it persists, log it as a harvest gap for that source rather than ingesting anything.
- Log every degraded harvest in the source accounting (which avatar, which source, which state) so a thin corpus is visibly a harvest failure, not a real absence of voice.

### RMBC Extraction Categories (tag while harvesting)

As you pull each usable quote, tag it into an extraction category so the Voice Appendix (Step 4) and the Deep Research profiles (Sections A-L) are pre-sorted. These are the RMBC Stage 1.2 categories reconciled against this skill's existing harvest and profile structure. Most already have a home; add the two thin ones as explicit tags.

| RMBC extraction category | Where it already lives (tag toward it) |
|---|---|
| 1. Verbatim complaint language | Section D "What They Complain About Most", Section E complaints |
| 2. Verbatim desire language | Section E "biggest secret desire", Section H desire framework |
| 3. Failed-solution history | Competitive Context Per Avatar (items 1-5), Section C failures |
| 4. Identity markers | Section C (Identity and Values), Section H "Wants to BE", Section L Aspirational Identity |
| 5. Specific moments (ADD as explicit tag) | Currently implicit in Section I Empathy Map + Section E. Tag concrete scenes explicitly: the named moment where pain peaks (the mirror before a meeting, the untagged photo). Named moments beat symptom lists and feed the downstream "Specific Opening Moment" brief field. |
| 6. Objections and skepticism | Objection Mapping Per Avatar, Section L Key Objection |
| 7. Beliefs and misconceptions | Section F beliefs, Section E "built-in bias", "the story they tell themselves" (this is the Root Cause Narrative seed: what they wrongly blame) |
| 8. Product facts and proof assets | Boundary: product facts are Product Deep Research / Business Validation, not avatar voice. Capture only the proof *preferences* (Section G Social Proof Requirements, Confirmed Scientific Anchors appendix). Do not fabricate product facts here. |
| 9. Emotional drivers | Section F Emotional Landscape, Section E emotional questions |
| 10. Market sophistication signals | Awareness Stage assignment (Step 2), Section F beliefs |
| Mechanism seeds (ADD as explicit tag) | New. A scratch list of possible hidden problem-causes and solution-explanations you notice while reading voice. This is the raw material for the Mechanism-Seed Test below and for `../angle-roadmap` Step 1 Mechanism Derivation. Not a finding; a lead to hand upstream. |

### Research Completion Test (5-part done-gate)

Harvest and synthesis are not "done" when you are tired of them. They are done when the corpus passes all five gates below. This is the RMBC Stage 1.4 completion test as an explicit done-gate for this skill.

1. **Avatar Test.** Can you describe the buyer as one specific person, including the moment their pain peaks, without inventing anything? (Feeds Section A + the Specific Moments tag.)
2. **Verbatim Test.** Do you have real customer quotes filed by category? The RMBC floor is 15-20 quotes across the research; this skill's per-avatar floors (at least 8 first-person quotes per prioritized avatar, at least 3 per deprioritized) satisfy it in aggregate. Use the per-avatar floors as the operative numbers; do not treat 15-20 as a competing third count.
3. **Why-It-Failed Test.** Can you explain, in the customer's own logic, why everything they tried before did not work? (Feeds Competitive Context Per Avatar items 4-5.)
4. **Mechanism-Seed Test.** Can you name at least one plausible hidden cause of the problem AND one specific reason this product addresses it? Record these as the Mechanism Seeds tagged above. If you cannot, the research is not ready to hand to angle-roadmap's Mechanism Derivation.
5. **Diminishing-Returns Test.** This is the SAME rule as the Saturation stopping rule above, not a second one: research is done when new sources stop surprising you (two consecutive threads surface no new theme). If you are still getting surprised, keep going. Do not restate saturation as a separate gate; this gate simply names it as the completion criterion.

Pass all five and stop collecting. More research past this point is procrastination. If the Mechanism-Seed Test cannot be passed, flag it: the brand may lack a derivable mechanism, which is a finding angle-roadmap needs, not a failure to hide.

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

**Layer 1 -- Newly harvested first-person quotes (from Step 3)**

[v3.0.0 amendment] Format each quote on one line:
`"[verbatim quote]" | [platform / community, video title, or product title] | [date or relative date] | [score, likes, or rating if available] | [tier label] | [any hygiene flag]`

Tier labels for this layer: `[CONFIRMED - REDDIT]`, `[CONFIRMED - YOUTUBE - dated]`, or `[CONFIRMED - AMAZON - screened]` for a review drawn from a screened-CLEAN Amazon `ingest_rows` pool. YouTube voice carries the dated flag by default. Supplementary Instagram and Twitter quotes, if any were captured, carry `[CONFIRMED - IG - supplementary]` or `[CONFIRMED - TWITTER - supplementary]` and are never counted toward the primary first-person floors. Never label an Amazon quote `[CONFIRMED - AMAZON - screened]` unless it came from `ingest_rows`; a quarantined or FLAGGED-pool row must not appear as confirmed voice.

**Layer 2 -- Carried-forward Phase 1 voice relevant to that avatar**

Apply the Phase 1 tier labels. Flag all vendor-hosted or brand-owned quotes as `[CONFIRMED -- BRAND OWNED]` and note they are excluded from the organic first-person count.

### Source Weighting Model

[v3.0.0 amendment] Sources are weighted when the brief constructs profiles. The canonical weighting model is `_frameworks/source-accessibility-tiers.md`; state it in the appendix so it carries into the brief. Each quote already shows its tier; the weighting is how much that tier counts:

- **W1 First-party:** brand-owned analytics (quiz, sales, email, ad platform). Highest weight; the only data about this brand's actual buyers. Usually absent at this stage, which is why profiles end with first-party validation items.
- **W2 Tier 2 verified or post-purchase voice:** review platforms and patient forums. High weight; closest to actual buyers and lived experience. **Screened-CLEAN Amazon verified-purchase voice enters here at W2-equivalent** (post-purchase voice, once the contamination screen passes). A FLAGGED Amazon pool is excluded from the weighting model entirely, with its reasons logged.
- **W3 Reddit:** high weight for raw emotion, identity, and current-market freshness. Treat as community discourse, subject to vocal-minority and brigading skew.
- **W4 YouTube:** lower weight. Multi-year stale and creator-audience skewed. Vocabulary and objections, not current behavior.
- **Supplementary (below W4): Instagram and Twitter.** Reduced weight; vocabulary and objections only. Never gate saturation and never, alone, support a load-bearing claim.
- **Vendor and testimonial content, and FLAGGED Amazon pools:** excluded from the organic first-person count entirely.


### Corroboration Map (Format and Rule)

This defines the corroboration rule and the map format only; no map output is produced at this stage. The authoritative per-avatar map is produced in the final report, because most load-bearing claims emerge from the Deep Research pass. The brief (Step 9, item 2f) is what requires Deep Research to produce and embed the completed map.

The rule: every load-bearing strategic claim (a claim that drives a pricing, entry-SKU, spend, or creative decision) must be supported by two or more independent sources, ideally spanning at least two tiers. Any load-bearing claim resting on a single source is flagged single-source and demoted to the Hypotheses Requiring Validation subsection. Format:

CORROBORATION MAP -- Avatar [name]
Claim: [the strategic claim] | Sources: [source A (tier)], [source B (tier)] | Status: corroborated / single-source (demote)
...


### Source Tracking Table (Pre-Brief Harvested Corpus)

[v3.0.0 amendment] After the voice appendix, produce a per-avatar table of the corpus on hand at this stage. This is the pre-brief harvested corpus, not the final source balance:

| Avatar | Distinct Reddit threads / communities | Distinct YouTube videos | Amazon ASINs screened (CLEAN / FLAGGED) | Tier 1 primary first-person quotes | Supplementary IG/Twitter quotes | Phase 1 carried voice (fetchable) | Vendor-hosted (excluded) | Saturation reached (Y/N) | Notes |
|---|---|---|---|---|---|---|---|---|---|

Amazon now carries a real screened harvest: record ASINs pulled and their screen verdicts (CLEAN pools feed `ingest_rows`; FLAGGED pools are logged excluded with reasons, never counted). Supplementary Instagram and Twitter quotes are tallied separately and never folded into the primary first-person total. Vendor-hosted quotes are likewise counted separately and never folded in. Tier 2 fetching and the final Tier 1 vs Tier 2 balance happen during Deep Research, not at this stage, and are reported in the brief's post-research source balance table (Step 9), not here. Surface honest thin-avatar flags, and any degraded (non-`complete`) harvests, in the Notes column.

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

[v3.0.0 amendment] Based on geography and category detected, generate the "Where to Find Each Avatar" section for Deep Research, scoped to Tier 2 directly-fetchable sources only. Reddit, YouTube, and screened Amazon (plus supplementary Instagram and Twitter) are harvested by this skill in Step 3 and supplied as the Voice Appendix, never listed here as Deep Research targets. Facebook organic pages are excluded entirely. Generate it with:

**For each Tier 2 platform category:**
- Specific named communities with member counts (from Phase 1 demand validation data where available)
- Content types that surface genuine opinions
- Demographic skew notes
- Platform-specific language patterns

**The critical principle:** People speak differently on Reddit vs MumsNet vs TikTok vs Amazon reviews, which is why this skill harvests Reddit, YouTube, and screened Amazon itself in Step 3. The brief directs Deep Research only to the Tier 2 directly-fetchable communities where each persona reveals true motivations; the Reddit, YouTube, and Amazon voice is already captured in the Voice Appendix and must not be re-researched.

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
Tier 1 Reddit + YouTube + screened Amazon voice: harvested and embedded (Step 3), Instagram/Twitter supplementary. Tier 2: pulled by Deep Research during the research pass.
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

### RMBC research-document reconciliation

The RMBC manual (Stage 1.3) describes a 12-section "finished research document." This skill's final Deep Research report already covers it; the mapping is below, and only one element is a genuine addition. Fill the gap; do not build a parallel 12-section document.

| RMBC research-doc section | Where it already lives in this skill's output |
|---|---|
| 1. Product Summary | Brief Context (Steps 1-5), braindump product portfolio |
| 2. The Avatar | Profile Section A + full persona |
| 3. Verbatim Pain Bank | Voice Appendix (Step 4) + Sections D/E |
| 4. Verbatim Desire Bank | Voice Appendix + Section H |
| 5. Specific Moments | Section I Empathy Map + the Specific Moments extraction tag (Step 3) |
| 6. Failed Solutions | Competitive Context Per Avatar |
| 7. False Beliefs / Misconceptions | Section F beliefs, Section E |
| 8. Product Facts & Ingredients | Boundary: Product Deep Research / Business Validation, not avatar voice |
| 9. Proof Assets | Confirmed Scientific Anchors appendix |
| 10. Objections | Objection Mapping Per Avatar, Section L |
| 11. Competitive Landscape | Competitive Context Per Avatar + Phase 1 |
| 12. Raw Mechanism Candidates (ADD) | New. The Mechanism Seeds tagged in Step 3. Instruct Deep Research to surface, per prioritized avatar, a short scratch list of plausible hidden problem-causes and solution-explanations noticed in the voice. This is a lead for `../angle-roadmap` Step 1 Mechanism Derivation, explicitly marked as unvalidated (tier `[HYPOTHESISED]` unless a source supports it), never presented as a finding. |

The brief must contain all 10 sections:
1. Context (populated from Steps 1-5)
2. Research Methodology (populated from Step 6)
2b. Reversed-Fetch Rule and Accessibility Tiers -- [v3.0.0 amendment] must explicitly state: (a) Do not fetch, search, browse, crawl, or otherwise research Reddit, YouTube, Amazon, Instagram, or Twitter by any means, and do not include them in the research scope. First-person voice from Reddit, YouTube, and screened Amazon is PROVIDED in the embedded Voice Appendix and is the Tier 1 first-person voice source for this research (with Instagram and Twitter as supplementary provided context); treat all of it as already-gathered provided context, not a target to re-gather. (b) Supplement with the Tier 2 directly-fetchable sources, named per avatar, pulling from at least three distinct Tier 2 sources per prioritized avatar so Tier 1 does not structurally dominate. (c) Facebook organic pages are excluded. Do not fabricate any harvested-platform voice. If Amazon voice beyond the provided screened pool would be cited, mark it as a logged gap instead of inventing it.
2c. Source Weighting and Corroboration -- [v3.0.0 amendment] must state: (a) construct each profile weighting sources W1 first-party, then W2 Tier 2 and screened-CLEAN Amazon (W2-equivalent), then W3 Reddit, then W4 YouTube, with Instagram and Twitter supplementary below W4 and vendor content plus FLAGGED Amazon pools excluded; where sources conflict, the higher weight governs the claim and the conflict is noted. (b) Every load-bearing claim (pricing, entry-SKU, spend, or creative decision) must cite at least two independent sources, ideally across at least two tiers; a single-source claim goes into Hypotheses Requiring Validation, not the main body. A supplementary Instagram or Twitter source does not, by itself, satisfy the two-source rule. (c) No single Reddit thread, YouTube video, or Amazon ASIN may supply more than half of any one avatar's first-person quotes.
2d. Foundational-Citation Integrity -- before relying on any foundational or heavily-cited category study, check it for retraction, correction, or expression of concern. Exclude or flag any that carry one, and state that the check was performed. This prevents a discredited anchor study from silently propagating into positioning.
2e. How We Sourced This Research (client-facing) -- [v3.0.0 amendment] embed the standard methodology section (canonical text below) verbatim. The brief must instruct Deep Research, in imperative terms, that it MUST reproduce this section verbatim as a standalone "How We Sourced This Research" section in the final report, including in full both the weighting rules (how much W1 through W4 each count, plus screened Amazon at W2-equivalent and Instagram/Twitter supplementary) and the label legend (what every [CONFIRMED], [CONFIRMED - DATED], [CONFIRMED - AMAZON - screened], [CONFIRMED - BRAND OWNED], [INFERRED], [HYPOTHESISED], and W1 through W4 tag means and how to read it). This section is not optional and must not be summarized or dropped; a final report that omits the label legend or the weighting rules is incomplete and must be regenerated. These reports are shared with clients, who need the key to read the tags.
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

Customer voice is harder to gather cleanly than it was even two years ago. Many of the places real buyers actually talk, Reddit, YouTube, and Amazon among them, block general automated research tools by default, so an ordinary research pass quietly returns thin or empty results from exactly the sources that matter most. To work around that, this report uses a layered sourcing method with a dedicated harvesting tool, and labels every quote so you can see precisely where it came from and how much weight it carries. The short version: nothing here is asserted without a traceable source, and where a source could not be reached, we say so rather than guess.

The source tiers.
Tier 1, harvested directly. Reddit, YouTube, and Amazon. We collect this voice ourselves, up front, using a dedicated harvesting tool, because general research tools can no longer reach it reliably. This is the rawest and most current first-person language in the report. Amazon is no longer a blind spot: we harvest verified-purchase reviews and mechanically screen each product's pool for incentivized or templated review bursts. A pool that passes the screen is used as post-purchase voice; a pool that fails is set aside and disclosed as excluded, with the reason logged, never quietly dropped and never invented. Instagram and Twitter are also harvested, as supplementary sources at reduced weight.
Tier 2, directly verifiable. Patient forums and review platforms that are still openly accessible, such as Diabetes UK, Mayo Clinic Connect, WebMD, Drugs.com, and AgingCare. This voice sits closest to real buyers and post-purchase experience, which is why it carries high weight.
Excluded. Facebook organic brand pages. We tested them and found effectively no first-person product experience there (the comment streams are keyword-bait and giveaway traffic, not testimonials), so Facebook is not used as a source. We never invent or paraphrase voice we could not actually gather.

How much each source counts. Not every source carries equal weight when we build the profiles. W1, your own first-party data (quiz, sales, email, ad platform), outranks everything because it describes your actual customers. W2, Tier 2 verified voice, is high weight and closest to real buyers; screened Amazon verified-purchase voice sits at this same W2-equivalent level once its pool passes the screen. W3, Reddit, is high weight for emotion, identity, and current language, but treated as community discussion. W4, YouTube, is lower weight: often older and shaped by who follows a channel. Instagram and Twitter are supplementary, below W4, used for vocabulary rather than decisions. Brand-owned or vendor testimonials, and any Amazon pool that failed the screen, are excluded from the voice count entirely.

The two-source rule for decisions. Any claim that drives a real decision, which product to lead with, how to price it, or where to spend, must be supported by at least two independent sources, ideally from different tiers. A claim resting on a single source is not presented as a finding; it moves into Hypotheses Requiring Validation, flagged as a lead to test rather than a conclusion to act on.

The labels you will see. [CONFIRMED] is a named, checkable source with a real quote and a date from the last four years. [CONFIRMED - DATED] is the same but older than four years. [CONFIRMED - AMAZON - screened] is a verified-purchase Amazon review from a pool that passed the contamination screen. [CONFIRMED - BRAND OWNED] is brand or vendor content, used only as an example of language, never as proof of effectiveness. [INFERRED] is a reasoned conclusion drawn from confirmed material, with the reasoning shown. [HYPOTHESISED] is a plausible idea with no direct source yet, and only ever appears in the validation sections. W1 through W4 mark the weighting tier of a given quote.
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
Harvest Depth, Weighting, and Source Accounting: [ ] Each prioritized avatar harvested across at least 3 communities and at least 5 distinct threads [ ] At least 8 first-person quotes per prioritized avatar (harvest floor; distinct from the in-profile minimum) [ ] At least 2 distinct YouTube videos per prioritized avatar [ ] Amazon harvested where the category has product reviews: hero plus at least one competitor ASIN, only ingest_rows ingested, and every FLAGGED or non-complete pool logged excluded with its reason [ ] No degraded harvest (state other than complete) was ingested; each is logged in the source accounting [ ] Saturation (judged on primary sources: Reddit, YouTube, screened Amazon) reached, or honest non-saturation logged, per prioritized avatar [ ] No single thread, video, or ASIN supplies more than half of any avatar's first-person quotes [ ] Source weighting model (W1-W4, screened Amazon at W2-equivalent, Instagram/Twitter supplementary, vendor and FLAGGED-Amazon excluded) stated in the brief [ ] Brief requires Deep Research to produce the post-research source balance table (at least 3 distinct Tier 2 per prioritized avatar; Tier 1 vs Tier 2 balance) and the completed Corroboration Map artifact [ ] Foundational or heavily-cited category studies checked for retraction, correction, or expression of concern [ ] 5-part Research Completion Test passed per prioritized avatar (Avatar, Verbatim, Why-It-Failed, Mechanism-Seed; Diminishing-Returns is the saturation rule, not a separate check) [ ] Raw Mechanism Candidates / mechanism seeds surfaced per prioritized avatar for handoff to angle-roadmap, marked unvalidated
Confidence Tiers: [ ] Every factual claim in every profile body carries a tier label [ ] Every [CONFIRMED] claim includes a verbatim quote (max 30 words), URL, and month/year [ ] No source cited as [CONFIRMED] is brand-owned content -- those are [CONFIRMED -- BRAND OWNED] [ ] Every Amazon-sourced quote is drawn from a screened-CLEAN ingest_rows pool and labelled [CONFIRMED -- AMAZON -- screened]; no quarantined or FLAGGED-pool row appears as confirmed voice [ ] All sources older than 4 years carry [CONFIRMED -- DATED] label [ ] No [HYPOTHESISED] content appears in main profile body outside its dedicated subsection
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
