---
name: copywriting-guide
version: "1.3.0"
description: "Generate a complete Human-Centered Copywriting Guide for any brand by extracting voice, tone, archetype language, and humanization rules from avatar research and brand guidelines. Use this skill whenever the user wants to create a copywriting guide, content writing standards, brand voice guide, humanization guidelines, or AI detection firewall for a brand. Trigger on phrases like: 'run Phase 4', 'copywriting guide', 'writing guide', 'brand voice guide', 'humanization rules', 'content standards', 'how should this brand write'. This skill reads Phase 2 (Avatar Research) output and Phase 3 (Brand Guidelines) as primary inputs and generates a complete, ready-to-use copywriting manual that any LLM can follow to produce human-sounding, brand-consistent copy."
---

# Copywriting Guide Skill

## Purpose

Generate a complete Human-Centered Copywriting Guide by synthesizing avatar research (who we're talking to, how they speak, what resonates) with brand guidelines (who we are, how we sound, what we stand for). The output is a standalone document that any LLM can use as a training manual to produce copy that sounds authentically human, passes AI detection, and connects emotionally with each customer segment.

This is Phase 4 in the brand development workflow: Business Validation → Avatar Research → Brand Guidelines → **Copywriting Guide** → Funnel Development.

## When to Use

- User says "run Phase 4" or "copywriting guide" for a brand
- User has completed avatar research and brand guidelines and needs writing standards
- User wants to create humanization rules, AI detection firewall, or voice guidelines
- User wants to standardize how copy sounds across all brand touchpoints
- User needs a document that teaches LLMs to write in a specific brand voice

## Required Inputs

This skill requires TWO primary inputs:

1. **Phase 2 Avatar Research Output** - provides customer archetypes with language preferences, emotional drivers, tone requirements, vocabulary patterns, and proof type preferences per segment
2. **Phase 3 Brand Guidelines** - provides brand identity, voice pillars, visual identity cues, positioning, values, and competitive differentiation

### Optional Inputs

- **Phase 1 Business Validation Report** - provides market context, regulatory claim boundaries, competitive positioning
- **Client Braindump** - provides product mechanism, pricing, founder's voice preferences
- **Existing copy samples** - if the brand already has content, samples help calibrate the guide to existing voice

## Workflow Overview

```
0. MOAT GATE    -> Read moat dispositions; bind which differentiators canonical examples may lead on
1. INGEST       -> Read avatar research + brand guidelines
2. EXTRACT      -> Pull voice inputs from both sources
3. MAP          -> Map archetypes to copy requirements
4. GENERATE     -> Populate the copywriting guide template
5. CALIBRATE    -> Add category-specific rules and examples
6. STRUCTURE    -> Apply structural layers (gated Schwartz + universal copywriting rules)
7. HUMANIZE     -> Run the AI Detection Firewall
8. OUTPUT       -> Deliver complete guide
```

## Step 0: Positioning Guardrails (Moat Map Gate)

Read this before extracting any messaging or writing any example. It governs which differentiators the guide's canonical examples and approved messaging may lead on. It is not Schwartz-gated; it applies to every brand. It governs brand-specific canonical examples and approved messaging only; it does not constrain the universal structural rules (Step 8) or the universal mechanics and forbidden-vocabulary lists of the AI Detection Firewall (Step 4), which are brand-agnostic copy mechanics. The exemption is for those mechanics and prohibition lists only: any brand-copy example sentence generated to illustrate a firewall rule is a canonical example like any other and is subject to this gate.

Establish the LEAD / SUPPORT / AVOID disposition of each differentiator, in this source priority:
1. The Phase 1 Positioning Guardrails / Moat Map, if the Phase 1 report is available.
2. Otherwise, the dispositions already embedded in the Phase 3 Brand Guidelines (brand-analyzer 1.1.0 and later carry LEAD / SUPPORT / AVOID into the guidelines).
3. Otherwise, derive each disposition inline from the available competitive and differentiation analysis using the canonical two-axis fixed order: score can_lead (STRONG and brand-world-safe) and usable_in_copy (false if untrue, unsupported, off-world, or off-strategy); then first match wins: usable_in_copy false gives AVOID, else can_lead gives LEAD, else SUPPORT. Tell the operator the dispositions were derived inline.
4. If none of the above yields dispositions, the run is ungrounded, and the gate fails closed on differentiator-led content. Without grounding there is no basis to tell LEAD from SUPPORT or AVOID, so do not present any canonical example, core promise, voice pillar exemplar, content example, or approved message that leads on a differentiator. Generate only non-differentiator emotional/identity examples, and leave every differentiator-led slot as an explicit placeholder ("[differentiator-led example pending moat input]"). Add the loud notice in Step 9.5.

The invariant (stated once here; every step below reinforces it, none weakens it):
- Canonical examples and approved primary messaging may lead only on a LEAD differentiator or on a non-differentiator emotional or identity driver. This covers archetype core promises and example paragraphs (Step 2), voice pillar "sounds like" exemplars (Step 3), content-type example copy (Step 5), the category messaging framework's approved messages and mechanism explanation (Step 6), and the worked technique examples (Step 7, when present).
- A SUPPORT differentiator (commoditized but true) may appear only as a supporting proof point inside a piece of copy, never as a canonical example, a core promise, a voice pillar exemplar, or a primary approved message.
- An AVOID differentiator does not appear.

This is the defense against the canonical-example failure: a true but commoditized attribute, the kind any competitor also has, becoming the example the whole brand voice is taught from. Proof strength and quotability are not moat defensibility.

See the canonical `_frameworks/positioning-guardrails.md` in `contextarchitect/context-architect-brands` for the full filter definition.

## Step 1: Ingest and Extract

### From Avatar Research (Primary Voice Source)

The avatar research is the most important input because it determines HOW copy should sound for each customer segment.

| Avatar Section | What to Extract | Feeds Into |
|---------------|----------------|------------|
| Section D (Authentic Voice) | Vocabulary patterns, sample quotes, complaint language | Archetype language preferences |
| Section E (Pain/Desire) | Fears, desires, frustrations in their own words | Emotional hooks per archetype |
| Section F (Emotional Landscape) | Dominant emotions, beliefs, trust requirements | Tone calibration per archetype |
| Section G (Buying Behavior) | Decision triggers, proof requirements, risk needs | Proof language, CTA style |
| Section L (Messaging Implications) | Emotional hooks, objections, language to use/avoid, headlines | Direct archetype copy guidance |
| Strategic Synthesis | Segment dynamics, platform strategy, pricing psychology | Content type guidance, positioning |

### From Brand Guidelines (Identity Source)

| Guidelines Section | What to Extract | Feeds Into |
|-------------------|----------------|------------|
| Brand Personality/Archetype | Core personality traits, archetype | Voice foundation |
| Voice and Tone | Voice pillars, formality, confidence level | Voice pillars section |
| Visual Identity | Colors, aesthetic, photography style | Visual language cues |
| Positioning | Market position, pricing tier, competitive stance | Positioning guardrails |
| Values | Core values, rejected values | Cultural considerations |
| Messaging Framework | Core message, elevator pitch, taglines | Approved language, taglines |

When extracting taglines, approved language, and positioning, carry their Moat Map dispositions (Step 0). A SUPPORT or AVOID item extracted from Phase 3 is recorded for reference but is not promoted to a canonical example or a primary approved message in this guide.

### From Business Validation (Claim Boundaries)

| Validation Section | What to Extract | Feeds Into |
|-------------------|----------------|------------|
| Regulatory findings | What can/cannot be claimed | Claim boundaries |
| Hypothesis testing | Validated vs contradicted claims | Mechanism messaging |
| Competitive landscape | Competitor positioning, white space | Competitor comparison rules |

## Step 2: Map Archetypes to Copy Requirements

For each avatar from Phase 2, construct an archetype copy profile:

```
ARCHETYPE: [Name from avatar research]
WHO: [Demographics + psychographics, 1-2 sentences]
CORE EMOTIONS: [From Section F, with intensity 1-10]
TONE: [Derived from their emotional state + brand voice intersection]
LANGUAGE THAT RESONATES: [From Section L "Language to Use" + Section D vocabulary]
LANGUAGE TO AVOID: [From Section L "Language to Avoid" + general brand prohibitions]
SENTENCE STRUCTURE: [Derived from their sophistication level and platform preferences]
CORE PROMISE: [From Section L "Aspirational Identity" or Section H primary want]
EXAMPLE PARAGRAPH: [Write a 4-6 sentence sample targeting this archetype specifically]
```

CORE PROMISE and EXAMPLE PARAGRAPH lead on a LEAD differentiator or a non-differentiator emotional/identity driver (Step 0), never on a SUPPORT or AVOID differentiator. An emotional or identity lead is the common, allowed case; the gate bites only when an example leads on a commoditized (SUPPORT) or off-strategy (AVOID) differentiator.

### Tone Calibration Logic

The tone for each archetype is NOT the same as the brand voice. It's the intersection of brand personality with the archetype's emotional state:

- Brand voice stays consistent (the personality doesn't change)
- Tone shifts based on WHO you're talking to (like how a person adjusts register)
- A "confident, scientific" brand talking to a skeptic uses proof-heavy, no-BS tone
- The same brand talking to a hopeful newcomer uses encouraging, educational tone
- The same brand talking to a price-sensitive buyer emphasizes value and ROI

For each archetype, define the tone shift by answering:
1. What emotional state are they in when they encounter us? (from Section F)
2. What proof type do they need? (from Section G)
3. What's their trust level with this category? (from Section C)
4. What would make them feel understood? (from Section E)

## Step 3: Generate Voice Pillars

Read `references/voice-construction.md` for the voice pillar construction methodology.

Voice pillars come primarily from brand guidelines but are refined by avatar research:

1. **Start with brand guideline voice traits** (typically 3-5 adjectives or principles)
2. **Convert each to a pillar** with definition, sounds-like examples, doesn't-sound-like anti-examples
3. **Test each pillar against every archetype** - does this pillar work for all segments, or does it alienate one?
4. **Add archetype-informed pillars** if the avatar research reveals voice requirements the brand guidelines missed (e.g., "Empathetic Without Being Soft" might emerge from avatar data showing segments need validation)

Each pillar needs:
- Name (3-5 word descriptor)
- Definition (2-3 sentences)
- 3 "Sounds like" example phrases
- 3 "Doesn't sound like" anti-examples
- Application guidance

Voice pillar "sounds like" exemplars must not be built around a SUPPORT or AVOID differentiator (Step 0).

## Step 4: Construct AI Detection Firewall

Read `references/humanization-rules.md` for the universal humanization rules.

The AI Detection Firewall is the most technically specific section. It contains:

1. **Forbidden vocabulary** (universal list + brand-specific additions)
2. **Burstiness principle** (sentence length variation rules with examples)
3. **Mandatory contractions** (frequency and placement rules)
4. **Conjunction starts** (starting sentences with And, But, Or, So)
5. **Strategic imperfection** (fragments, digressions, self-corrections)
6. **Hedging elimination** (removing tentative language)
7. **Em dash prohibition** (zero tolerance, with alternatives)
8. **Formulaic pattern bans** (forbidden openings and closings)

The universal rules apply to ALL brands. Brand-specific additions come from:
- Avatar research Section D vocabulary patterns (what words the audience actually uses)
- Brand guidelines tone requirements (formal brands allow fewer fragments)
- Category conventions (health brands need different claim language than fashion brands)

## Step 5: Build Content Type Quick Guides

For each major content type, provide a mini-guide showing how voice + archetype + humanization rules combine:

1. **Social media captions** - platform-specific, archetype-specific
2. **Email subject lines and body** - hooks, openings, CTAs
3. **Website headlines** - homepage, product page, landing page
4. **Product page copy** - description, benefits, proof
5. **Customer service / FAQs** - tone shift for support context
6. **Ad copy** - platform-specific (Meta, Google, TikTok)
7. **Advertorial/Listicle content** - education-led funnel copy

Each guide should include:
- Character/word limits for the format
- 1-2 examples written for the primary archetype
- Dos and don'ts specific to that content type
- The archetype to default to if unspecified

## Step 6: Add Category-Specific Messaging Framework

From business validation regulatory findings + brand guidelines positioning:

1. **How to explain the core product mechanism simply** - 1 sentence, 3 sentences, 1 paragraph versions
2. **Common objections with approved response frameworks** - for each archetype's primary objection
3. **Claim boundaries** - what can be said, what requires qualification, what's prohibited
4. **Competitor comparison rules** - how to reference competitors (or not)

Approved messages and the mechanism explanation lead on LEAD differentiators or non-differentiator drivers; a SUPPORT differentiator appears only as a supporting proof point, never as the primary approved message (Step 0).

## Step 7: Add the Seven-Technique Structural Layer

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

Voice rules govern HOW copy sounds. The seven techniques govern WHAT MOVE the copy is making structurally. Both layers run on every piece of brand content. This step adds a structural framework section to the copywriting guide so writers (human or LLM) know which technique to deploy in which moment.

The seven techniques come from Eugene Schwartz's Breakthrough Advertising. They are:

1. **Intensification** - build desire by making the fulfilled state vivid through multiple specific scenes
2. **Identification** - give the reader a felt identity to step into
3. **Gradualization** - sequence claims so each one earns belief from the one before
4. **Redefinition** - reframe a desire, problem, or alternative so a different solution becomes obviously correct
5. **Mechanization** - give proof a physical, mechanical, named explanation
6. **Concentration** - zoom in on ONE specific competitor or alternative and demolish it
7. **Camouflage** - hide the sales pitch inside a different surface (story, editorial, expose, FAQ)

### The Layering Rule

Pick the technique FIRST. Write the move in the brand's voice SECOND. Run the AI Detection Firewall THIRD. The technique determines what the copy is doing. Voice rules constrain how it gets said. Reverse the order and you end up with on-voice writing that is not advancing any argument.

### Writing Each Technique in Brand Voice

For each technique, the copywriting guide should include a "what this looks like in our voice" worked example drawn from the brand's actual archetype profiles.

Each worked example leads on a LEAD differentiator or a non-differentiator driver, not a SUPPORT or AVOID differentiator (Step 0).

**Intensification.** Build 3-5 vivid scenes of the prospect already living the result, each from a different angle. Phase 4's "Show, Don't Tell" rule is intensification by another name; this layer formalizes it.

Voice translation: pick the brand's primary archetype. Write five different specific moments where the prospect is already living the desired state. Different times of day, different locations, different witnesses, different textures. Apply the brand's voice rules (burstiness, contractions, vocabulary) throughout.

**Identification.** Name the identity the prospect steps into when they take action. The brand's archetype profiles already do this at the strategic level (e.g., "the dad who's fully there," "the husband she married, restored"). Identification at the COPY level means revisiting that identity early and at the close of every long-form piece.

**Gradualization.** Sequence claims smallest to biggest. The product claim arrives last, after the prospect has agreed to a chain of harder-to-deny claims. In short copy: small claim (observation) → bigger claim (mechanism) → biggest claim (product). In long copy: the entire advertorial structure does this.

**Redefinition.** Reframe what the prospect currently believes. Examples:
- "Viagra works for the 4 hours after you take it. Daily support works for your body, not for the pill." (Reframes the desire from "tonight" to "your body working again.")
- "97% adherence at clinical doses beats 60% adherence at clinical doses." (Reframes the desire from "best ingredients" to "best ingredients you'll actually take.")

Stay in voice. Reframes do not need exclamation marks; numbers and contrast carry the work.

**Mechanization.** Name the mechanism with a memorable phrase. Walk the steps in plain English. Anchor at least one step to a published study or specific data point. This is the structural form of voice pillar "Knowledgeable, Never Lecturing" if the brand has one.

**Concentration.** Pick ONE alternative the prospect is most likely using. Demolish it with mechanism + numbers, not adjectives. Do not aggregate ("most alternatives are bad"). Specific concentration is required at sophistication Stage 4+; generic dismissal fails.

**Camouflage.** Pick a content surface (advertorial, listicle, expose, FAQ, news-style). Build the sales argument underneath using techniques 1-6. The reader thinks they are reading content; structurally they are reading a sales argument. The brand's archetype profile and voice pillars determine what kind of content surface fits.

### Combining Techniques

The most common combinations across content types:

- **Single-image ad:** Concentration (one alternative attacked) + Mechanization (one mechanism named) + minimal Identification
- **Long-form advertorial:** All seven, in roughly the order above, with Camouflage as the surface
- **Email nurture sequence:** Intensification across multiple emails, one Mechanization email, one Concentration email, one Identification email at the close
- **Social post:** One technique. Pick the one that does the most work for the platform
- **Product page:** Mechanization (primary) + Redefinition (reframe the category) + minimal Identification at the testimonial section

### Pressure Test for Voice + Technique Compliance

After applying any technique, the copy must still pass the brand's full Phase 4 humanization checklist (Step 9 below). Common failure: a technique feels strong in 1966-style hype voice but fails the brand's voice rules. Restate without exclamations, without forbidden vocabulary, without em dashes. The technique is the structural move; the voice is independent.

### Output: A Section in the Final Guide

Add a section to the copywriting guide called "Structural Moves: The Seven Techniques." Include:
- The seven technique definitions (above)
- The layering rule
- One worked example per technique, written in the brand's voice for the brand's primary archetype
- The combinations table
- The pressure test reminder

**If this brand has not yet completed Schwartz onboarding:** see `_frameworks/breakthrough-advertising-brand-onboarding.md` in `contextarchitect/context-architect-brands` for the 30-60 minute scoped session that produces `schwartz-applied.md`.

## Step 8: Universal Structural Copywriting Rules

These rules govern HOW any piece of copy is built, regardless of brand, archetype, or whether Schwartz onboarding has been completed. They are universal. Every long-form piece, every ad, every email passes through these checks.

The seven techniques (Step 7, gated) tell you WHAT MOVE the copy is making. The Universal Structural Rules (this step) tell you HOW TO BUILD any move so it actually lands. Both layers apply when Schwartz onboarding is present; only this step applies otherwise.

### 8.1 The Bridge Principle

Every transition between sections must be earned with an explicit transition sentence. The transitions that matter most:

- Hook to Identification ("This is what made me realize I wasn't alone in this.")
- Identification to Agitation ("And here's what I didn't see coming.")
- Agitation to Mechanism ("That's when I learned what was actually happening.")
- Mechanism to Product ("Which is exactly what [product name] was designed to do.")
- Product to Social Proof ("And I'm not the only one who's seen these results.")
- Social Proof to CTA ("Here's how to get started yourself.")

Missing bridges are the #1 failure mode in long-form copy. The reader hits an unearned section break and disengages. A bridge can be one sentence; it must exist.

**Self-test:** Read the copy out loud. At every section change, ask: "did the previous paragraph earn the next one?" If the answer is "the next paragraph just starts," there's a missing bridge.

### 8.2 The Open-Loop Principle

Every paragraph either opens a new loop, deepens tension on an existing loop, or closes one. Paragraphs that do none of those three things are dead weight.

An open loop is a curiosity gap that creates psychological debt - the reader must keep going to close it. Examples:

- "I refused the medication for three years. Here's what I did instead." (Opens: what did you do?)
- "My doctor laughed when I told him. Six months later, he wasn't laughing." (Opens: what changed?)
- "There's one ingredient most supplements skip. It's the one that actually matters." (Opens: which one?)

The "best copy can start at any line" test: cut the opening hook. Read line two as if it were the new hook. If line two opens a loop strong enough to carry the rest, the copy is structurally healthy. If line two is descriptive ("This product is for people who..."), the copy was carried entirely by the hook and will collapse without it.

### 8.3 The Time-Delay Introduction Rule

When introducing results, always anchor a specific time delay before describing the outcome.

Wrong: "The cream works."
Right: "After three weeks, I noticed my skin felt different."

Wrong: "Your blood pressure normalizes."
Right: "Around week six, my blood pressure readings started dropping into the normal range."

Without a time anchor, the reader has no expectation framework. They cannot picture themselves at the result because they cannot picture WHEN. Time anchors are mandatory in:

- Results sections of advertorials
- Testimonial integrations
- "What to expect" content
- Any first-person transformation narrative

### 8.4 Hook Quality Checklist

Every hook (caption, first line, headline) passes through this five-point check:

1. **Opens a loop, doesn't close one.** A statement of fact closes the loop ("Our supplement contains 500mg of beetroot extract"). A statement of consequence opens it ("I refused the medication for three years.").

2. **One specific claim, not multiple.** Hooks that try to do two things accomplish neither. Pick one.

3. **First person over third person where the brand voice allows.** "I refused..." beats "Many people refuse...". Exceptions: explicit narrator-VSL formats where third-person is structural, and brand voice guidelines that require third-person formality. When the brand voice prescribes third-person, keep the rest of the rule (one claim, specificity, identity marker, open loop) and apply it within the approved POV.

4. **Specificity over vagueness.** Name the medication. Name the symptom. Give the number. "147/92" beats "high blood pressure." "Lisinopril" beats "blood pressure medication."

5. **Identity marker present.** The hook should include something that filters the right viewer in (age, role, situation). "I'm a 61-year-old who watched my father die of a stroke" gives age + family context. "After 32 years as a nurse" gives role + tenure.

Static hooks add two more constraints:
- Sound-off friendly (works visually + caption-only)
- 9 words maximum for the caption layer (the visible-in-feed text)

### 8.5 Identification-Before-Mechanism Rule

Identification (mirroring the prospect's symptoms, lifestyle, failed solutions) MUST precede mechanism reveal. Mechanism that arrives before the reader feels seen does not convert.

The order is non-negotiable:

1. Show the reader you understand what they're going through (identification)
2. Show them the failed solutions they've already tried (depositioning)
3. THEN explain the mechanism that actually works

Reverse the order - lead with mechanism - and the reader bounces because they have no reason to trust the explanation. Identification earns the right to explain.

This is the most common structural error in technical-founder-written copy. The founder knows the mechanism cold and wants to explain it. The reader needs to feel seen first.

### 8.6 The Discovery Story Format

A named copy format that sits parallel to PAS / AIDA / SPS / etc. Structure:

1. **Distress.** Character is in extremis (medical scare, failure stack, desperation).
2. **Unusual decision.** Character makes an unusual choice driven by the desperation (drives 6 hours, stays up till 6 AM researching, accepts a stranger's recommendation, visits a folk practitioner).
3. **Discovery.** The unusual decision exposes them to the solution (an Amish farmer, an old book, a former colleague's offhand comment, a specialist they wouldn't normally consult).
4. **Mechanism reveal.** What the discovery actually is, in plain English with one analogy.
5. **Application.** First trial, first results.
6. **Validation.** Authority confirms, doctor confirms, time confirms.
7. **Crossroads.** Reader is shown the same choice the character faced.

The discovery story is the strongest format for readers who already recognize the problem or are actively comparing possible fixes. The desperation + unusual-discovery combination earns the right to explain a novel mechanism. Reference: Sufian Long-form Static Image Ads, lines 145-260.

Use this format when:
- The mechanism is novel and needs earning
- The audience is skeptical of supplements / treatments / solutions in this category
- The brand has a folk / heritage / discovery story (real or analogous)
- The avatar profile shows a "tried everything" failed-solution stack

### 8.7 The Five Core Feelings Library

Every long-form piece of copy serves one core feeling. Identify it before writing. The five proven core feelings for direct-response copy:

1. **Vindication.** "I was right all along; the system was wrong." Copy serves this feeling by validating the reader's suspicion that conventional advice failed them. Authority figures admit the establishment view was wrong. The reader's instinct is the hero.

2. **Loss aversion.** "I lost something I want back." Copy serves this feeling by making the loss vivid and specific (the marriage that drifted, the energy that faded, the confidence that left). Recovery, not gain, is the promise.

3. **Betrayal.** "Someone I trusted misled me." Copy serves this feeling by naming who betrayed the reader (the doctor who pushed pills, the industry that hid the truth, the brand that overpromised). The reader is justified in being angry.

4. **Desperation.** "I will try anything that might work." Copy serves this feeling by lowering the perceived stakes of trying the new thing (90-day guarantee, free trial, "if I'm wrong, send it back"). The reader's exhaustion is the engine.

5. **Identity.** "I want to be the kind of person who [does this thing]." Copy serves this feeling by surfacing the aspirational self the reader is trying to become (the dad who's fully there, the woman who feels like herself again, the man who took control). The product is the bridge to that identity.

A piece of copy that tries to serve more than one core feeling dilutes them all. Pick one. Build everything around it. Reference: Sufian Long-form Static Image Ads, lines 145-172.

### 8.8 Authority Hook Patterns

Four named patterns for invoking authority. Pick one per piece; combining them feels like overstuffing.

1. **Classic.** Named specialist endorses or aligns with the message. ("Dr. [Name], a cardiologist with 30 years of experience, says the same thing I just told you.") Use when the brand has access to a real named authority.

2. **Doctor's Surprise.** Authority is surprised by your results. ("My doctor looked at the readings twice. He asked what I'd been doing.") The reader gets to enjoy authority confirmation without the brand needing a paid endorser. Use when the avatar is anti-establishment but still wants validation.

3. **Doctor's Skepticism.** Authority disagreed but data proved them wrong. ("She told me beetroot wouldn't make a difference. Six months later, my numbers said otherwise.") Adds vindication on top of authority. Use when the avatar feels dismissed by the medical system.

4. **Study/Research.** Named research from a named institution. ("A 2022 study from the University of Maryland measured exactly this effect across 287 participants.") Adds external proof to the brand's claims. Use when the avatar reads research and wants citations they can verify.

Reference: Sufian Anatomy of a Winning Ad, lines 178-212.

## Step 9: Generate Humanization Checklist

A 4-phase self-check that any LLM runs after writing content:

**Phase 1: AI Detection Audit** - vocabulary scan, em dash check, burstiness check, hedging removal
**Phase 2: Voice Alignment** - brand voice match, archetype match, confidence check
**Phase 3: Emotional Resonance** - target emotion achieved, empathy present, aspiration without pandering
**Phase 4: Specificity and Differentiation** - no vague statements, concrete scenarios, mechanism clear

## Step 9.5: Moat Map Scan (pre-output gate)

Run this against the Step 0 dispositions before presenting the guide. It is the single point where the invariant is enforced over the whole generated guide, and it reads the actual generated text rather than trusting any label.

For every canonical example and approved-messaging element the guide generated (archetype core promises and example paragraphs from Step 2, voice pillar "sounds like" exemplars AND "doesn't sound like" anti-examples from Step 3, content-type example copy from Step 5, the category messaging framework's approved messages and mechanism explanation from Step 6, the worked technique examples from Step 7 if present, any before/after bad examples, and any brand-copy example sentence used to illustrate a Step 4 firewall rule), do two reads: (1) identify the differentiator the element's lead framing rests on and check its Step 0 disposition; (2) scan the full text of the element for every differentiator it mentions anywhere, lead or secondary.

Findings:
- Any positive canonical example, core promise, voice pillar exemplar, or primary approved message whose lead framing rests on a SUPPORT or AVOID differentiator is a finding. Rebuild it on a LEAD differentiator or a non-differentiator emotional/identity driver; a SUPPORT attribute may remain only as a supporting proof point inside the copy, not as the lead.
- Any element that mentions an AVOID differentiator anywhere - lead or secondary, as claim, proof, or comparison, and including inside a "doesn't sound like" anti-example or a before/after bad example - is a finding; remove the AVOID framing entirely. Per Step 0, an AVOID differentiator does not appear at all, not merely "not as the lead." In an anti-example, warn against the mistake by describing it, not by reproducing the AVOID claim verbatim.
- A "doesn't sound like" anti-example or before/after bad example MAY legitimately use a SUPPORT differentiator as the thing it warns against (for example, "don't lead on [commoditized attribute]"); that is the anti-example doing its job and is not a finding. The SUPPORT finding fires only when a SUPPORT differentiator leads a positive canonical example.

This scan checks every generated element by the property of the differentiator it actually rests on (and, for AVOID, by any mention), regardless of how vivid or proof-heavy the element is. It does not apply to the universal structural rules (Step 8) or to the universal mechanics and forbidden-vocabulary lists of the firewall (Step 4), which are brand-agnostic; it DOES apply to any brand-copy example sentence generated inside the firewall section.

If the run is ungrounded (Step 0 item 4), the gate fails closed: confirm that no presented canonical example, core promise, voice pillar exemplar, content example, or approved message leads on a differentiator, and that every differentiator-led slot is an explicit placeholder. State at the head of the output: no moat grounding was available, differentiator-led canonical examples are withheld as placeholders, and a Phase 1 Moat Map or moat-graded Phase 3 Brand Guidelines should be supplied before the guide is used to anchor brand voice.

## Step 10: Present and Output

Present summary:

```
COPYWRITING GUIDE READY: [brand_name]

Inputs Loaded:
  Avatar Research: [count] archetypes
  Brand Guidelines: [count] voice pillars
  Validation Report: [available/not available]

Guide Contents:
  Voice Pillars: [count] defined
  Archetypes: [count] with full copy profiles
  Content Guides: [count] content types covered
  Humanization Rules: [count] rules in AI Detection Firewall
  Universal Structural Rules: 8 rules (Bridge, Open-Loop, Time-Delay, Hook Quality, Identification-Before-Mechanism, Discovery Story, Five Core Feelings, Authority Hooks)
  Structural Moves: [include this line ONLY if `schwartz-applied.md` exists; 7 techniques with worked examples]

Total Sections: 12 + 2 appendices (13 + 2 if `schwartz-applied.md` exists)
Estimated Length: [word count]

Confirm or adjust:
```

Deliver the complete guide as a single markdown document the user can add to any Claude Project as a knowledge base file.

```
GUIDE GENERATED

Sections populated:
  - Brand identity and voice foundation
  - [count] voice pillars with examples
  - AI Detection Firewall ([count] rules)
  - [count] archetype copy profiles with sample paragraphs
  - Universal Structural Rules (The Bridge Principle, The Open-Loop Principle, The Time-Delay Introduction Rule, Hook Quality Checklist, Identification-Before-Mechanism Rule, The Discovery Story Format, The Five Core Feelings Library, Authority Hook Patterns)
  - Structural moves: [include this line ONLY if `schwartz-applied.md` exists; 7 techniques with worked examples]
  - Humanization checklist (4 phases)
  - [count] content type quick guides
  - Category messaging framework with claim boundaries
  - Before/after examples
  - Quick reference card

Moat Map scan (Step 9.5): [PASSED - all canonical examples and approved messaging lead on LEAD or non-differentiator drivers, no AVOID differentiator appears anywhere | UNGROUNDED - no moat grounding; differentiator-led examples withheld as placeholders, notice emitted at head of guide]

Next: Add this guide as a knowledge base file to the brand's Claude Project.
All content creation should reference this guide before writing.
```

## What This Skill Does NOT Do

- Does not write actual brand content (it creates the guide that governs content creation)
- Does not replace the avatar research or brand guidelines (it synthesizes them)
- Does not determine brand strategy (it operationalizes decisions already made)

## Edge Cases

**No avatar research available:** Can generate a basic guide from brand guidelines alone, but archetype sections will be generic. Mark as [BASIC GUIDE - UPGRADE WITH AVATAR RESEARCH].

**No brand guidelines available:** Can derive voice basics from avatar research (customer language informs brand voice), but positioning and values will be assumed. Mark as [VOICE-ONLY GUIDE - ADD BRAND GUIDELINES].

**Both inputs available but contradictory:** Brand guidelines say "formal and authoritative" but avatar research shows customers respond to "casual and peer-like." Flag the contradiction and recommend the avatar-informed direction (write for the customer, not the boardroom).

**Regulated category:** If Phase 1 identified regulatory claim boundaries, these MUST appear in the Claim Boundaries section. Health, financial, and legal categories need explicit "never say" lists.
