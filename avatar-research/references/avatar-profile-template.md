# Avatar Profile Template

This is the universal avatar profile structure. Sections A through L apply to every persona regardless of brand, category, or geography. Each avatar must be at least 1,500 words to capture the nuance needed for differentiated marketing.

The skill customizes only: Section A's "Category-Specific Stage" field, Section J's attitude dimensions, and Section 8's writing standards. Everything else is universal.

---

## Research Integrity Framework (Mandatory -- Read Before Building Any Profile)

### The Confidence Tiering System

Every factual claim in every avatar profile must carry a confidence tier label, inline, immediately after the claim, in square brackets. No exceptions.

**[FIRST-PARTY]**
Data from the brand's own first-party sources: quiz data, Meta ad account, Klaviyo, Shopify, or other owned analytics. First-party data takes precedence over all external sources for claims about this brand's specific audience. Label as: `[FIRST-PARTY]`

**[CONFIRMED]**
The claim is directly supported by a named, verifiable external source. Requirements:
- Peer-reviewed journal, published survey with named methodology, named platform data, or direct consumer quote with platform and date of origin
- Published within the last 4 years. Older sources must be labelled `[CONFIRMED -- DATED]` and flagged as potentially stale
- Must include a direct verbatim quote of no more than 30 words, plus a URL or DOI, plus a publication date or month/year of access
- If a direct verbatim quote cannot be produced, the claim must be downgraded to [INFERRED]

**[CONFIRMED -- DATED]**
As above, but the source is older than 4 years. Flag with: "This source is more than 4 years old. Findings may not reflect current conditions."

**[CONFIRMED -- BRAND OWNED]**
The source is a brand's own blog, health content hub, or product page. Acceptable for consumer language and quotes. Not acceptable for clinical claims. Must be labelled to signal lower independence.

**[INFERRED]**
A logical conclusion drawn from one or more Confirmed findings with no single direct source. The inference chain must be stated: "This is inferred from [source/finding] because [reasoning]." Inferred claims are valid and useful -- they must be transparent about their basis.

**[INFERRED -- cross-regional extrapolation]**
A specific sub-tier of [INFERRED] for claims that draw on research from a different region or population (e.g., Western clinical data applied to a GCC context). Must include an explicit caveat that the finding may not transfer.

**[HYPOTHESISED]**
A plausible belief based on general domain knowledge with no sourced backing. Must appear only in a dedicated "Hypotheses Requiring Validation" subsection at the end of the profile. Never in the main profile body as if it were a finding.

**Critical enforcement rule:** A claim with no tier label in the main profile body means the profile is incomplete. A profile where no section has unknowns is a hallucination risk and must be returned for revision.

---

### Source Quality Floor

**Acceptable:**
- Peer-reviewed journal articles (PubMed, Google Scholar, ResearchGate)
- Published market research with named sample size and methodology (Statista, Euromonitor, YouGov, etc.)
- Named platform data: Reddit thread with URL and date, TikTok hashtag with view count and date retrieved, Amazon review section with product URL and date
- Direct consumer quotes from identifiable forums, review platforms, or social media (with platform, month/year, and context)
- Government or regulatory data
- Brand or clinical publications for ingredient or clinical trial data

**Unacceptable -- find a better source before proceeding:**
- Other LLM outputs or AI-generated summaries
- Content farm articles (no named author, no date, generic framing)
- Undated blog posts
- Sources that do not name their research methodology or sample
- Brand-owned health content sites cited for clinical claims (acceptable for consumer voice only, labelled [CONFIRMED -- BRAND OWNED])
- Wikipedia as a primary source

---

### Prohibited Inferences

Do not cross these lines. If research returns no data on these points, acknowledge the gap rather than inferring across it.

1. Do not infer GCC-specific symptom presentation from Western studies without explicit [INFERRED -- cross-regional extrapolation] labelling and a caveat
2. Do not infer GCC national behaviour from GCC expat behaviour or vice versa. Treat separately unless a source explicitly covers both
3. Do not infer hijab-wearer hair behaviour from general Muslim-majority population data. Hijab-specific sources only
4. Do not infer GCC minoxidil usage rates or attitudes from US/UK clinical literature without explicit cross-regional flagging
5. Do not infer perimenopause symptom prioritisation from Western clinical framing without explicit cross-regional flagging
6. Do not infer purchase behaviour from demographic proxies. Purchase behaviour must come from sourced data
7. Do not assign awareness stage without a sourced basis specific to how this segment encounters and researches this category

For GCC-specific research, always check both English and Arabic-language sources. English captures expat sentiment; Arabic captures national sentiment. If they diverge, report both and note the divergence.

---

### High-Risk Avatar Protocol

Before building any profile, assess whether published research on this specific segment is expected to be sparse. If yes, flag the profile as HIGH-RISK at the top of the section.

High-risk conditions include:
- The segment is culturally or demographically specific to a region with limited English-language published research
- The segment's behaviour is shaped by private or taboo social dynamics that rarely surface in public forums
- The brand's first-party data shows the segment exists but doesn't describe its psychology in detail

For HIGH-RISK profiles:
- State the flag explicitly at the top of the profile
- A higher proportion of [INFERRED] and [HYPOTHESISED] content is correct and expected
- Do not supplement absent research with confident prose to make the profile appear complete
- A thin, honest profile is always more useful than a complete, fabricated one

---

## Profile Header

```
Avatar ID: [BRAND]-AVT-[SEQUENTIAL NUMBER]
Confidence Profile: [X% First-Party / X% Confirmed / X% Inferred / X% Hypothesised]
High-Risk Flag: [YES -- state reason / NO]
Stage of Awareness: [Stage Name]
Persona Archetype: [Archetype Name]
Awareness Stage Justification: [2-3 sourced sentences -- each claim must carry a tier label]
```

---

## A: Who Are They (Demographics)

- **Name:** Realistic first name reflecting demographic and cultural background
- **Age Range:**
- **Gender:**
- **Occupation/Role:** Be highly specific. "Nurse practitioner at a dermatology clinic who spends Saturday mornings reading longevity research" not just "healthcare professional"
- **Household Income:** Include all relevant income sources and financial context
- **Marital/Family Status:**
- **Education Level:**
- **Geographic Location:** Region, country, urban/suburban/rural
- **Life Stage:** e.g., "Mid-career, two kids in elementary school, recently started prioritizing health after a friend's health scare"
- **{category_specific_stage}:** {category_specific_stage_description}

## B: What They Do and Like (Psychographics)

- **Top 3 Brands They Wear/Use/Admire:** Lifestyle brands signaling identity and values. Should differ meaningfully between personas.
- **Top 3 Tools/Products/Platforms in Their Current Stack:** What they already use in the space this brand operates
- **Top 3 Media Sources They Follow:** Specific creators, publications, podcasts, channels. Matters for distribution strategy.
- **2-3 Hobbies or Activities Outside This Category:**
- **Top 5 Information Sources:** Where they learn, research, form opinions. Rank by trust and frequency.
- **Top 3-5 Social Media Follows in the Relevant Space:** Specific accounts or account types
- **Technology Relationship:** General comfort with apps/subscriptions. Number of active subscriptions. Comfort with AI tools.

## C: Why Are They (Identity and Values)

- **Core Personality Traits (5):**
- **5 Major Values They Hold:** Distinguish stated values from revealed preferences. What they SAY they value vs what their behavior shows they actually prioritize.
- **Relationship to [Core Solution/Category] as a Concept:** Essential, unnecessary, aspirational, intimidating, something they "should" do, or novel concept?
- **2 Major Wins in Their Journey:** Accomplishments keeping them engaged with this space
- **2 Major Failures or Disappointments:** That still shape decisions and purchasing behavior today
- **Self-Perception Gap:** How they see themselves vs reality. Gold for messaging.
- **Relationship to Expertise/Authority:** Trust expert recommendations? Peer validation? Independent research? Influencer endorsements? Skeptical of everyone?

## D: Where They Speak (Authentic Voice Discovery)

This section is critical for capturing genuine language, concerns, and motivations.

- **Primary Online Communities:** 2-3 specific platforms/communities where this avatar congregates
- **Specific Subreddits/Groups/Forums:** Named communities with approximate size
- **Content That Prompts Engagement:** What types of posts make them comment? What breaks their lurking pattern?
- **Review Behavior:** Do they leave reviews? Where? What prompts a review?
- **Anonymous vs Named Platforms:** Where do they speak freely vs curate an image?
- **Sample Authentic Quotes:** 3-5 direct quotes or closely paraphrased statements from Reddit, YouTube comments, Amazon reviews, forums

QUOTE SOURCING REQUIREMENTS:
- Standard avatars (sufficient English-language forum data exists): minimum 5 direct quotes
- High-risk avatars (sparse research flagged): minimum 3 direct quotes, or explicitly state
  that fewer were available and note this as a gap
- Each quote must include: platform name, month and year (not just year), and URL or
  community context
- Quotes from brand-owned health content sites must be labelled [CONFIRMED -- BRAND OWNED]
- "Accessed [year]" is not sufficient. Month and year are required: "accessed May 2026"
- A quote used in the Stage 1 Source Log must appear verbatim in the profile, not
  re-paraphrased. The Stage 1 log and the profile are the same source material.
- **Vocabulary Patterns:** Specific words, phrases, abbreviations, jargon they use naturally
- **What They Complain About Most:** Recurring themes in negative comments about products, brands, or the category
- **What They Celebrate/Recommend:** What earns genuine enthusiasm in their community?
- **Lurker vs Contributor:** Actively post or mostly read? What prompts posting?

## E: Smart Market Questions (Pain and Desire Mapping)

- **What keeps them awake at 2am, eyes open, staring at the ceiling:** Be visceral and specific to life stage and category experience. The beginner worries about different things than the expert.
- **What are they secretly afraid of that they won't admit to anyone:** The shame, the fear, the vulnerability underneath
- **What are they angry about, and who are they angry at:** Brands that let them down? Influencers who misled? A system that doesn't work? Themselves?
- **Top 3 daily frustrations related to this category:**
- **Their biggest secret desire:** The transformation they want but feel foolish or vulnerable for wanting
- **The Question They're Really Asking:** The deeper existential or identity question beneath their product search
- **Built-in bias or mental shortcut:** What heuristics do they use? Price = quality? Expert = truth? Popular = proven?
- **Common words, phrases, or language unique to them:**
- **Top 3 complaints about existing products/solutions they've tried:**

## F: Going Deep (Emotional Landscape)

- **Top 3 Dominant Negative Emotions Experienced Regularly:** Related to this category. Be specific: frustration, inadequacy, FOMO, shame, anxiety, overwhelm, distrust.
- **Top 3 Positive Emotions If Core Problem Were Solved:**
- **Top 3 Beliefs About This Product Category:** Skeptical? Enthusiastic? Cautious? Overhyped? The future?
- **Biggest Lifestyle Vision:** The life they imagine if this problem were handled. Be specific and sensory.
- **The Story They Tell Themselves About Why They Haven't Solved This Yet:**
- **What Would Have to Be True for Them to Trust This Brand/Category:**
- **Their Relationship to Investing at This Price Point:** Easy decision? Guilt? Need to justify to partner?

## G: Purchasing Habits (Buying Behavior)

- **Top 3 Decision Triggers:** What finally pushes them from browsing to buying?
- **Prior Purchases in This Category:** Specific products, brands, services with approximate spend
- **Monthly Category Budget:** Current total spend across all products/subscriptions in this space
- **Price Tolerance at This Price Point:** Easy, borderline, or difficult? How they'd justify?
- **Subscription Fatigue Level:** How many active subscriptions? Regularly audit and cancel?
- **Free Trial/Sample Expectations:** Refuse to pay without trying? How long a trial?
- **Time Horizon of Expected Results:** How quickly must the product demonstrate value before they cancel or lose faith?
- **Research Behavior Before Purchasing:** Where do they look? How many sources before buying?
- **Social Proof Requirements:** What type convinces THIS persona? Clinical data? Before/after? Expert endorsements? Community buzz? Peer testimonials?
- **Risk Mitigation Needs:** Money-back guarantee essential? Cancel anytime? Starter size? Third-party verification?

## G2: Product Affinity Mapping (Include if brand has multiple products or Product Deep Research is available)

- **Entry Product:** Which product/tier would this avatar try first? Why does this match their awareness stage and risk tolerance?
- **Natural Upsell Path:** What would they buy next if the entry product delivered? What triggers the second purchase?
- **Bundle Appeal:** Which bundle archetype (if any) matches their buying psychology? (e.g., "starter kit" for cautious buyers, "complete system" for committed buyers)
- **Subscription Propensity:** How likely to subscribe vs one-time purchase? What would trigger subscription? What would trigger cancellation?
- **Product They'd Never Buy:** Which product in the range is wrong for this avatar? Why? (Prevents wasted targeting)
- **Gift Potential:** Would this avatar buy brand products as gifts? For whom? On what occasions?

If Product Deep Research output is available, cross-reference product candidates: which products from the Product Registry align with this avatar's JTBD and use moments?

## H: Primary Wants (Desire Framework)

- **Wants to GAIN:** Tangible outcomes. Quantify where possible.
- **Wants to BE:** Identity transformation. Who do they become?
- **Wants to DO:** Activities they can do, do better, or stop doing.
- **Wants to SAVE:** Time, money, energy, cognitive load. Quantify.
- **Wants to AVOID:** Specific negative outcomes. Be visceral.
- **Wants to FEEL:** Emotional states. Go beyond "happy" or "confident."
- **Wants to PROVE:** To themselves or others. What validation are they seeking?

## I: Empathy Map (Sensory Experience)

- **SEEING:** What do they see daily that reinforces their problem or desire?
- **THINKING:** Specific inner monologue. Write actual thoughts in first person.
- **HEARING:** What do others say to them? Partner, friends, colleagues, experts, online. Direct quotes.
- **FEELING:** Physical and emotional sensations tied to specific moments.
- **SAYING:** What they say out loud vs what they think. To partner, friends, strangers online, themselves.
- **DOING:** Observable behaviors. What are they doing at 10pm, 6am, on their commute, during research sessions?

## J: Category-Specific Attitudes

{category_specific_attitudes}

5-7 attitude dimensions customized to the brand's specific category. Examples:

For health/wellness: Relationship to natural vs pharmaceutical, complexity tolerance, trust in delivery mechanism, evidence requirements, self-treatment vs professional guidance preference

For SaaS: Feature depth vs simplicity preference, integration requirements, learning curve tolerance, support expectations, data ownership concerns

For beauty: Ingredient literacy level, routine complexity tolerance, clean/natural vs results-first, influencer trust level, clinical proof requirements

## K: Visual and Aesthetic Preferences

- **Visual Identity Attraction:** What aesthetic draws them? Minimalist? Clinical? Warm? Luxurious? Bold?
- **Interface/Packaging Expectations:** What does a trustworthy product look like to them? Name reference brands.
- **Color Psychology:** What colors signal premium/trustworthy vs cheap/scammy?
- **Design References:** Brands, products, or apps they admire visually. Be specific.
- **Photography/Imagery Style:** Data viz? Lifestyle? Product shots? Real people? Before/after?
- **Visual Dealbreakers:** What signals "not for me" or "this is a scam"?

## L: Messaging Implications (Strategic Output)

- **Primary Emotional Hook:** The single feeling or insight that captures attention
- **Key Objection to Overcome:** Main reason they won't buy
- **Proof Type That Resonates Most:** What evidence is most credible given their psychology?
- **Aspirational Identity to Sell:** Who do they become by using this product?
- **Language to Use:** Words, phrases, framing that resonate. Specific to this persona's vocabulary.
- **Language to Avoid:** Words, phrases, framing that alienate. Include both marketing-speak AND category-specific turn-offs.
- **One-Line Headline That Would Speak Directly to Them:**
- **Awareness-Stage-Appropriate CTA:** Right next step for their awareness level.

### Evidence That Challenges This Avatar Hypothesis [MANDATORY]

Actively search for and include evidence that challenges or complicates the avatar hypothesis. This is not a disclaimer section -- it is a strategic asset. Contradicting evidence that is surfaced and addressed in the brief is far less dangerous than contradicting evidence a competitor or customer surfaces after launch.

Include:
- Data suggesting the segment is smaller than hypothesised
- Evidence that the proposed emotional framing does not resonate with this segment
- Sources showing this segment prefers a different solution category
- Cultural or behavioural factors that create friction with the proposed positioning
- Evidence that this avatar overlaps with another to a degree that may not justify separate treatment
- Expert voices that contradict the brand's central mechanism claim (if any exist)

Where contradicting evidence changes the recommended positioning or creative approach, state that explicitly. Do not bury or minimise it.

---

### Research Gaps and Unknowns [MANDATORY]

List what the research attempted to answer but could not find sourced data for. Include:
- Topics where only [HYPOTHESISED] tier material was available
- Data points that would materially change the avatar profile if found
- Questions the research could not answer at all
- Recommended primary research methods to close the most important gaps (e.g., specific survey questions, community outreach prompts, post-purchase interview questions, social listening queries)

A profile with no unknowns will be treated as a hallucination risk. All genuine research has gaps.

---

### Hypotheses Requiring Validation [MANDATORY]

List all [HYPOTHESISED] tier claims from across the profile in a single collected subsection. Format each as:

`[HYPOTHESISED] [The claim.] Validation method: [How to test this specifically.]`

This separates hypotheses from findings cleanly, prevents [HYPOTHESISED] content from being used as if it were [CONFIRMED] by downstream consumers, and creates a ready-made research agenda for follow-up primary research.

---

---

## Additional Research Requirements (Universal)

### Competitive Context Per Avatar

For each avatar, identify:
1. 2-3 products, brands, or approaches they currently use or have tried
2. Why those solutions didn't fully satisfy (specific gaps this brand fills)
3. What this brand must demonstrate to win them from their current approach
4. **What specifically they liked** about each alternative - not outcomes or results, but product experience: format, ingredients, ease of use, packaging, routine fit, trust signals. Use their exact language where possible. (e.g., "Minoxidil actually showed visible results on my crown" or "I liked that rosemary oil felt natural and chemical-free")
5. **What specifically frustrated or disappointed them** about each alternative - exact complaints in their own words, covering: side effects, dependency concerns, cost, inconvenience, unmet expectations, emotional toll of failure. (e.g., "Minoxidil caused massive initial shedding and I panicked" or "I spent hundreds on supplements that did nothing")
6. **Positioning opportunity per alternative** - based on what they liked and hated, what specific claim, framing, or product attribute would make this avatar switch? What "us vs them" narrative would resonate? (e.g., "Addresses the root cause minoxidil ignores, without the dependency cycle" or "The natural approach that actually works - unlike the oils and teas that gave you false hope")

### Objection Mapping Per Avatar

Top 3 objections at the brand's price point:
- Category objections ("this approach can't really work")
- Price objections ("too expensive for what it is")
- Complexity objections ("I don't want to deal with this")
- Trust objections ("never heard of this brand")
- Segment-specific objections (unique to their experience level/life stage)

### Journey Mapping Per Avatar

1. Likely customer journey from current awareness stage to first purchase
2. Content types, messages, touchpoints that move them forward at each stage
3. Which product/tier they enter at -- and WHY this entry point matches their awareness stage
4. Expansion path: what triggers upgrade, cross-sell, deeper engagement?
5. **Awareness-to-product mapping:** For this avatar at this awareness stage:
   - What is the right first offer? (free content, sample, entry product, hero product, bundle)
   - What proof must they see before purchasing? (matches their proof type from Section L)
   - What is the expected time from first touch to first purchase?
   - What would make them a repeat buyer vs one-time customer?

### Voice and Tone Notes Per Avatar

1. 5-7 example phrases or sentence structures that resonate
2. Emotional register (direct/no-BS, aspirational, data-driven, warm, irreverent)
3. Specific vocabulary preferences (terms they use vs terms that feel corporate)

---

## Output Format Requirements

### Two-Stage Protocol (Mandatory Sequence)

The research must be delivered in this exact order. Do not begin constructing profiles until Stage 1 is complete.

**Stage 1 -- Raw Source Retrieval**

Before building any avatar profile, retrieve and log raw sourced material for each avatar. Present these logs as Section 1 of the output, before any profiles. Label each: `Stage 1 Source Log -- Avatar [Number]: [Name]`

Required per avatar:
- Consumer quotes: minimum 5 for standard avatars, minimum 3 for HIGH-RISK avatars. Format: `[Verbatim quote] | Platform: [name] | Date: [month year] | URL: [url]`
- Published data points: minimum 1 per avatar. Format: `[Finding in your own words] | Source: [name] | Date: [date] | URL: [url] | Direct quote: "[verbatim extract max 30 words]"`
- Active communities identified: minimum 2 per avatar. Format: `[Community name] | Platform: [name] | Size: [member count or view volume] | Date verified: [month year]`

**Stage 2 -- Profile Construction**

Build each avatar profile using only the material gathered and logged in Stage 1. If a section of the profile template cannot be populated from Stage 1 material, leave it partially empty with a note: "Insufficient sourced data. See Research Gaps." Do not supplement from general knowledge to make the profile appear complete.

Quotes used in Stage 1 logs must appear verbatim in the profiles -- not re-paraphrased.

---

### Summary Comparison Table

After all avatars, provide:

| Persona | Gender | Age | Awareness Stage | {category_specific_journey_stage} | Primary Pain | Primary Desire | Key Objection | Emotional Hook | Entry Product | Upgrade Likelihood | Primary Platform |

Note: Replace {category_specific_journey_stage} with the category-specific stage column label defined in Section A for this brand (e.g., "Blood-Sugar Management Journey Stage", "Sleep Solution Journey Stage", "Hair Loss Journey Stage"). If no category-specific stage was defined for this brand, use "Category Journey Stage".

### Strategic Synthesis (500+ words)

1. Segment Dynamics: How messaging differs between experience levels while maintaining brand coherence
2. Demographic Cohort Patterns: Messaging themes uniting age groups, genders, life stages
3. Entry Point Strategy: Optimal entry product/tier for each awareness stage
4. Upgrade Sequence: Logical progression from entry to full ecosystem
5. Competitive Positioning by Avatar: How positioning differs per persona
6. Regional Considerations: Messaging adaptation across geographic/cultural segments
7. Platform Strategy: Optimal channel mix based on where each avatar congregates
8. Pricing Psychology: Which avatars convert easily, which need adjustments, which aren't viable
9. Content Marketing Priorities: Top 5 content pieces for highest-value avatars

### Creative Engine Avatar Registry

For each avatar, produce this structured summary as an appendix. This feeds directly into Creative Engine, funnel builders, email marketing, and ad creative workflows.

```
Avatar ID: [BRAND]-AVT-[SEQUENTIAL_NUMBER]
  e.g., REGROWTH-AVT-001

Name: [archetype name]
Awareness Stage: [stage]
Age Range: [range]
Gender: [gender]
Primary Emotion: [dominant negative emotion from Section F]
Aspirational Identity: [from Section H "Wants to BE"]
Emotional Hook: [from Section L]
Key Objection: [from Section L]
Proof Type: [from Section L -- what evidence is most credible for this avatar]
Entry Product: [from Section G or G2]
Primary Platform: [from Section D -- where they spend the most time]
Visual Preference: [from Section K -- 1 sentence summary]
Tone: [from voice/tone notes -- 2-3 words, e.g., "direct, data-driven, no-BS"]
Headline: [from Section L one-liner]
CTA: [from Section L awareness-stage-appropriate CTA]
Language Do: [3 key phrases from Section L "Language to Use"]
Language Don't: [3 key phrases from Section L "Language to Avoid"]
Confidence Profile: [X% First-Party / X% Confirmed / X% Inferred / X% Hypothesised]
Key Unknowns: [2-3 bullet points from Research Gaps section -- the gaps most likely to affect creative decisions]
```

This registry enables:
- Creative Engine to generate avatar-specific ad creative without parsing full profiles
- Funnel builders to personalize pages by avatar ID
- Email marketing to segment sequences by avatar
- Ad targeting to map avatar psychology to audience parameters

---

### Confirmed Scientific Anchors Appendix [MANDATORY]

At the end of the full output, produce a table of all [CONFIRMED] and [CONFIRMED -- DATED] scientific or clinical claims used across all profiles. This appendix serves as a claims substantiation reference for advertising compliance and legal review.

Format:

| Claim | Verbatim Quote (max 30 words) | Source, Journal/Platform, URL, Date | Tier |
|---|---|---|---|

Include a note at the bottom of the appendix confirming:
- All compliance-relevant findings in this appendix are informational. The brand determines how to apply them. No finding constitutes a creative restriction unless explicitly instructed by the client.
- All [CONFIRMED -- DATED] sources are flagged as potentially stale.
- Brand-specific writing standards (forbidden vocabulary, tone rules) were applied as instructed in Section 8 / {brand_writing_standards}.

---

## Quality Standards

### Specificity Requirement
Ground all insights in realistic, verifiable details. Use real brand names, real community names, real creator names, real price points. Every claim should feel like it came from reading 100 forum threads, not a marketing textbook. Generic insights that could apply to "any consumer" are not acceptable.

### Authentic Voice Requirement
Every avatar must include direct quotes or closely paraphrased language from actual forums, reviews, or social media. Minimum 5 quotes for standard avatars, minimum 3 for HIGH-RISK avatars. Each quote must include platform, month and year, and URL. Invented quotes are not acceptable under any framing.

### Evidence Grounding
Reflect varying relationships to proof across personas. Some trust influencers. Some trust peer-reviewed research. Some trust only personal experience. Map each persona's evidence hierarchy explicitly in Section L. The Proof Type field in the Creative Engine Registry must reflect this hierarchy, not default to "before/after" for every avatar.

### Confidence Visibility
Every profile must carry a Confidence Profile in its header showing the percentage split across [FIRST-PARTY], [CONFIRMED], [INFERRED], and [HYPOTHESISED] tiers. Profiles with more than 30% [HYPOTHESISED] content must be treated as research hypotheses requiring validation, not finished personas ready for immediate creative deployment.

### Mandatory Completeness Check
Before submitting any profile, verify:
- Every factual claim in the main body carries a tier label
- Every [CONFIRMED] claim includes a verbatim quote (max 30 words), URL, and month/year date
- "Evidence That Challenges This Avatar Hypothesis" subsection is present and substantive
- "Research Gaps and Unknowns" subsection is present and honest
- "Hypotheses Requiring Validation" subsection is present and complete
- No [HYPOTHESISED] content appears in the main profile body outside of its dedicated subsection
- No prohibited inference (from the Research Integrity Framework) has been crossed

### Emotional Depth with Practical Utility
Balance visceral emotional insights with actionable marketing implications. Every avatar must produce a usable Creative Engine registry entry with a specific Headline, CTA, Proof Type, and Language Do/Don't list. Research depth without creative utility is incomplete.

### Writing Standards
{brand_writing_standards}

Default if none specified:
- Zero em dashes. Use colons, periods, commas, or parentheses
- Never use: delve into, navigate (metaphorically), leverage, robust, comprehensive, holistic, cutting-edge, paradigm shift, synergy, seamlessly, game-changing
- Vary sentence length. Use fragments for emphasis. Use contractions
- Write like a sharp operator who has lived in this market, not a consultant who just read about it