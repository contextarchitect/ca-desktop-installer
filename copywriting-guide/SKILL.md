---
name: copywriting-guide
version: "1.5.2"
description: "Generate a complete Human-Centered Copywriting Guide for any brand by extracting voice, tone, archetype language, and humanization rules from avatar research and brand guidelines. Use this skill whenever the user wants to create a copywriting guide, content writing standards, brand voice guide, humanization guidelines, or AI detection firewall for a brand. Trigger on phrases like: 'run Phase 4', 'copywriting guide', 'writing guide', 'brand voice guide', 'humanization rules', 'content standards', 'how should this brand write', 'humanize', 'de-AI', 'AI tells'. This skill reads Phase 2 (Avatar Research) output and Phase 3 (Brand Guidelines) as primary inputs and generates a complete, ready-to-use copywriting manual that any LLM can follow to produce human-sounding, brand-consistent copy."
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
- **Phase 4.5 Angle Roadmap** (`angle-roadmap.md` at the brand repo root) - provides the Root Cause Narrative and the Solution Mechanism Narrative, the per-avatar angle cards, and each card's Moat Map fields. It feeds Step 0's dispositions when the Phase 1 Moat Map is unavailable, Step 6's mechanism explanation, and the rebuild of Change policy trigger 2, which names it as an input. **Its absence degrades a rebuild; it does not block one.** Build from Phases 1, 2 and 3, and record in the delivery summary that no angle roadmap was available, so the next reader knows the mechanism framing came from the guidelines rather than from a derived roadmap.

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
3. Otherwise, the Moat Map fields carried on the Phase 4.5 angle cards, if `angle-roadmap.md` exists at the brand repo root. Each card records a Lead Differentiator and a Moat Disposition, and a roadmap built from a Phase 1 Moat Map carries that map's dispositions forward. Use them, and tell the operator the dispositions came from the angle roadmap rather than from Phase 1 directly, because a roadmap built WITHOUT a Phase 1 Moat Map carries dispositions that were themselves derived and are one inference further from the evidence.
4. Otherwise, derive each disposition inline from the available competitive and differentiation analysis using the canonical two-axis fixed order: score can_lead (STRONG and brand-world-safe) and usable_in_copy (false if untrue, unsupported, off-world, or off-strategy); then first match wins: usable_in_copy false gives AVOID, else can_lead gives LEAD, else SUPPORT. Tell the operator the dispositions were derived inline.
5. If none of the above yields dispositions, the run is ungrounded, and the gate fails closed on differentiator-led content. Without grounding there is no basis to tell LEAD from SUPPORT or AVOID, so do not present any canonical example, core promise, voice pillar exemplar, content example, or approved message that leads on a differentiator. Generate only non-differentiator emotional/identity examples, and leave every differentiator-led slot as an explicit placeholder ("[differentiator-led example pending moat input]"). Add the loud notice in Step 9.5.

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

Read `references/humanization-rules.md` for the universal humanization rules, and read `assets/output-structure.md` for the template the guide is assembled to. The template is where the firewall's shape is fixed, and generating without reading it is how Section 3 drifts.

**The firewall in the generated guide is two things, and they do not overlap.**

- **The universal rule set** is Appendix C, `references/humanization-rules.md` embedded verbatim. It is NOT restated, summarized or rewritten in Section 3. It is identical in every brand's guide, which is what lets a universal change be a file copy (Step 10).
- **Section 3** carries only what this brand adds on top: brand-specific forbidden words, brand-specific approved vocabulary, category claim rules, positioning tone rules, geography notes, and brand-voiced examples for the rules that need a voice to illustrate them.

The 17 canonical rules, numbered as they are numbered in the appendix, so a reference to "Rule 12" means the same thing everywhere:

1. **Forbidden vocabulary** (universal list + brand-specific additions)
2. **Burstiness principle** (sentence length variation rules with examples)
3. **Mandatory contractions** (frequency and placement rules)
4. **Conjunction starts** (starting sentences with And, But, Or, So)
5. **Strategic imperfection** (fragments, digressions, self-corrections)
6. **Hedging elimination** (removing tentative language)
7. **Em dash prohibition** (zero tolerance, with alternatives; covers U+2014, U+2013 and U+2015)
8. **Formulaic pattern bans** (forbidden openings and closings)
9. **"You" over "we"** (the 2:1 ratio, assessed over the whole piece)
10. **Show, don't tell** (a concrete scenario for every abstract claim)
11. **Direct-response forbidden constructions** (the RMBC Stage 4.1 set: three line-level bans enforced in the appendix, three structural bans checkable standalone)
12. **The parallel stack** (Rule 12, highest priority: two or more consecutive lines or sentences sharing an opening word or a sentence skeleton, forced triads, the same closer after several sections)
13. **The false contrast** (Rule 13: "It's not X. It's Y." and its variants, banned when nobody claimed X, allowed and required to be tagged as a Redefinition when X is a belief the reader actually holds)
14. **Closers and kickers** (Rule 14: restating one-liners, "let that sink in," a quotable last line on every section, reassurance kickers)
15. **Staging** (Rule 15: run-ups and signposting, rhetorical questions as openers or transitions, deep-sounding aphorisms, arguing with no one; an objection may be answered only if it is in the brand's objection inventory)
16. **Inflation and cycling** (Rule 16: synonym cycling, false ranges, -ing riders, vague association, inflated significance)
17. **Formatting and output hygiene** (Rule 17: emoji, the exclamation-mark ceiling, bold as decoration, straight quotes, zero chatbot residue)

**Severity tiers.** The firewall is applied by tier, not uniformly. Rules 7, 12, 13, 14, 15 and the chatbot-residue item in Rule 17 justify an edit on a single sighting. Rules 2, 3, 4, 5, 10 and 16 are weak alone and need company before you act, where company means two or more DISTINCT tier-2 rules inside one section (or inside the whole piece when it has no sections), counted by rule and not by hit: a person does any one of them on purpose, and an editor who acts on every sighting flattens the voice instead of humanizing it. The tier block and the do-not-sanitize list that follows it are stated once at the top of `references/humanization-rules.md` and travel with it into the generated guide.

The universal rules apply to ALL brands and live in Appendix C. Brand-specific additions are Section 3's whole content, and they come from:
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

From business validation regulatory findings + brand guidelines positioning, and from the Phase 4.5 angle roadmap where one exists:

**Read the angle roadmap FIRST when it is present.** Its Root Cause Narrative is the named hidden cause the copy is allowed to build on, and its Solution Mechanism Narrative is the named thing built to beat it. Those two narratives are the mechanism this section explains; do not re-derive a mechanism from business validation when a roadmap has already named one, because two names for one mechanism is Rule 16 synonym cycling at the strategy level and the reader never learns either. Where the roadmap and business validation disagree on what the mechanism IS, that is a contradiction to surface to the operator, not one to resolve silently.

**When no angle roadmap exists,** derive the mechanism explanation from business validation and brand guidelines as below, and record its absence in the delivery summary so the next reader knows the framing was not roadmap-grounded.

1. **How to explain the core product mechanism simply** - 1 sentence, 3 sentences, 1 paragraph versions
2. **Common objections with approved response frameworks** - for each archetype's primary objection
3. **Claim boundaries** - what can be said, what requires qualification, what's prohibited
4. **Competitor comparison rules** - how to reference competitors (or not)

Approved messages and the mechanism explanation lead on LEAD differentiators or non-differentiator drivers; a SUPPORT differentiator appears only as a supporting proof point, never as the primary approved message (Step 0).

## Step 7: Add the Seven-Technique Structural Layer

**Gating check (run before this section).** Look for `schwartz-applied.md` at the brand repo root (alongside `angle-roadmap.md`). If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

**The silence rule governs the GUIDE, not the operator.** When this gate closes on a guide that ALREADY HAS a Section 6A, the section is being deleted rather than skipped, and a deletion goes through the trigger-1 sequence in `assets/output-structure.md`: list what 6A held, get an item-by-item disposition, then delete. Section 6A is entirely brand-specific worked examples, so deleting it on a file-existence check alone discards brand work. Surface that to the operator and keep it out of the guide. The two are not in tension; they have different readers.

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

### 8.0 The RMBC Frame

The general frame this whole guide sits inside is **RMBC: Research, Mechanism, Brief, Copy**, executed in that order, never skipped ahead. About eighty percent of the final copy's quality is decided before a single line is written, in R, M and B. The writer who rushes to Copy is the writer who rewrites five times.

Where each stage lives in this pipeline:

- **Research** collects the evidence: verbatim complaint and desire language, failed-solution history, identity markers, specific moments, objections, beliefs and misconceptions, proof assets. That is Phase 2 avatar research.
- **Mechanism** names the hidden villain (Unique Mechanism of the Problem, the ContextArchitect name is Root Cause Narrative) and the one thing built to beat it (Unique Mechanism of the Solution, Solution Mechanism Narrative). That is angle-roadmap Step 1A and Step 1B.
- **Brief** assembles the argument so writing becomes filling in bullets in order. That is funnel-builder's 17-field copy brief.
- **Copy** is the wording, and only the wording. That is this skill: Section 8.9 (Claim-Proof Adjacency), Section 8.10 (body first, lead last), the AI Detection Firewall of Step 4, and the line-level rules.

Two consequences worth stating in the generated guide:

1. **A copy problem is usually not a copy problem.** Copy that is technically clean and still flat is almost always a thin Research stage or an unnamed Mechanism. Fix it upstream. A humanization pass cannot manufacture material that was never gathered.
2. **The lead is written last.** You cannot write the opening until the argument it opens exists (Section 8.10).

The macro-order of the argument, and where each format enters it, is owned by funnel-builder Core Principles ("The Persuasive Spine and Entry Point" in `../funnel-builder/SKILL.md`). Do not restate that order here or in the generated guide.

For the sentence, paragraph, transition and argument-order rules of the Copy stage, see `references/line-level-rules.md`. It is a universal appendix and is embedded verbatim in the generated guide (Step 10).

### 8.1 The Bridge Principle

Every transition between sections must be earned with an explicit transition sentence. The transitions that matter most:

- Hook to Identification ("This is what made me realize I wasn't alone in this.")
- Identification to Agitation ("And here's what I didn't see coming.")
- Agitation to Mechanism ("That's when I learned what was actually happening.")
- Mechanism to Product ("Which is exactly what [product name] was designed to do.")
- Product to Social Proof ("And I'm not the only one who's seen these results.")
- Social Proof to CTA ("Here's how to get started yourself.")

Missing bridges are the #1 failure mode in long-form copy. The reader hits an unearned section break and disengages. A bridge can be one sentence; it must exist.

**Bucket-brigade connectors** are the workhorse technique for building these bridges and keeping momentum inside a section. They are short, curiosity-carrying phrases that hand the reader from one line to the next: "But it gets worse...", "And that's when...", "So here's what happened...", "Which is exactly why...". Use them both at section transitions (as the bridge sentence's opener) and mid-section to stop the reader from settling. They are a tool for this principle, not a separate rule.

**The connector test.** A connector carries a fact or a stake. It never announces one. Delete the connector and read the sentence again: if the sentence lost information, it was a connector; if it only lost throat-clearing, it was a stall and the copy is better without it. The announcing connectors that fail this test are banned by name in `references/humanization-rules.md` Rule 8 (forbidden openings) and in the transition rules of `references/line-level-rules.md`; those two lists are the same list, and neither belongs in a bridge.

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

### 8.9 Claim-Proof Adjacency

Every claim carries its proof beside it, not paragraphs away. Proof is meaningless until the reader knows what it is proving, and a claim left naked while the reader waits for evidence reads as hype.

Wrong: a "clinically shown" claim in the hook, with the study cited eight paragraphs later in a "The Science" section most readers never reach.
Right: the claim and its proof point sit in the same beat. "Around week six my readings dropped into the normal range. A 2022 University of Maryland study measured the same effect across 287 people."

The rule applies to every claim type: results, mechanism, authority, social proof. When you make a claim, the proof is the next sentence or the next line, not a distant section. This is the line-level companion to Gradualization (Step 7): gradualization sequences claims; adjacency keeps each claim's proof welded to it.

### 8.10 The First-Draft-to-Final Process (body first, lead last)

This is the universal drafting workflow for any long-form piece, regardless of brand or format. The core rule: **write the body first and the lead last.** You cannot write a great opening until you know the whole argument you are opening.

1. **Vomit draft.** Write the body top to bottom from the outline, fast, no editing, no lead. Follow the bullets in order.
2. **Write the lead last.** Now that the argument exists, write the opening 3-4 paragraphs to set it up. This is why, roughly 90% of the time, the lead comes last.
3. **Read it out loud, start to finish.** Mark anything you stumble on or anything that sounds written-not-spoken.
4. **Cut 15-20%.** Kill throat-clearing, redundant proof, and any sentence that does not move the reader forward. The first cut is the biggest lift.
5. **Check claim-proof adjacency (§8.9).** Walk every claim; is the proof right next to it?
6. **Check the spine** against the canonical persuasive-spine statement in funnel-builder Core Principles ("The Persuasive Spine and Entry Point" in `../funnel-builder/SKILL.md`); do not re-enumerate the order here. For non-funnel formats the same macro-order still applies through the argument body.
7. **Forbidden-construction pass.** Hunt the banned list (`references/humanization-rules.md`) and remove every instance.
8. **Sleep on it, final read.** Fresh eyes catch the last clunkers.

This process is the single canonical home for the body-first-lead-last workflow. Format-specific skills instantiate it rather than restate it: `funnel-builder` Stage 1's writing order (body sections first, then lead, then headline, then deletion/spine/forbidden passes) is this process applied to the 9-section advertorial, and cross-references here.

## Step 9: Generate Humanization Checklist

A 5-phase self-check that any LLM runs after writing content. Phase 1 runs first and is mechanical, ordered strongest tell first.

**Phase 1: AI Detection Audit, strongest tells first.** Seven literal checks. Each is a scan of the finished text, not a re-read of the rules, and each is written so a person and a script produce the same answer.

**Scope, fixed before any check runs.** The scanned text is the delivered copy only: headline, body, captions and CTAs. It excludes planning notes and the Redefinition register. Word counts for the length branches are counts of the scanned text.

**When the artifact being produced is itself a copywriting guide, not a piece of copy.** Rules 1 through 17 and this Step's seven checks are written against "the delivered copy," and a guide is instructional prose plus many short, deliberately labeled BAD and GOOD examples, and brand-specific forbidden-word lists, that must contain the very patterns the rules forbid in order to do their job. Resolved once, here, so every rebuild applies the same answer instead of each one interpreting it fresh (found in the 2026-09-09 HimFresh rebuild pilot): run all seven checks mechanically over the guide's brand-authored prose exactly as written, with no scan-time exemption for labeled examples or forbidden-word lists, matching Rule 13's own instruction that no exemption applies at scan time. A guide's own worked examples and lists get NO guide-specific exemption from any check. Whatever a check already does with a hit anywhere else in copy is what it does with a hit inside a guide, no more and no less:

- **Check (i)'s hits clear exactly as they always do: the escalation test** (cover the openers, read what follows, count the facts; see "Reading the checks against the rules they serve" below). A labeled BAD example built to demonstrate an opener stack is what that test is for.
- **Check (iii) has no clearance beyond an exact, valid Redefinition register entry.** If a guide's own brand-authored prose deploys one of the five forms as an allowed Redefinition, not quoted from Appendix C, which is excluded from the scan below, it needs its own register entry the same as any other copy would. None of HimFresh's Section 3.6 examples do this; recorded here for whichever future guide's brand-authored prose does.
- **Check (vii) adjudicates only sense-restricted entries; everything else is a hard hit, full stop, with no exception for a word's own definitional appearance in the brand's Section 3.1 list.** This is a real, narrow gap that this fix does not close: a Section 3.1 list necessarily names the words it forbids, the same way Appendix C's own Rule 1 table does, and the current design has no carve-out for a list mentioning a word versus copy using it. Until that gap is closed, Section 3.1 is a standing, known false positive against its own check: it reports as a finding exactly as the check's own rule requires, it is NOT adjudicated or cleared, and Phase 1 is not reported as fully clean while that finding sits open. Note in the delivery that the open finding is the list naming itself, not the word deployed as copy, and that it is NOT adjudicated or cleared, so the next reader does not mistake a known, named gap for an unreviewed one. This is the same class of stated limit as check (iii)'s five-form pattern above, a known gap said out loud, not a new exemption invented to make the check pass.
- **Checks (ii), (iv), (v) and (vi) have no adjudication path at all, in a guide exactly as in ordinary copy.** Their pass conditions are hard counts with no stated carve-out (zero em dashes/en dashes/horizontal bars for (vi), for (v) the emoji ceiling (zero by default; a platform brief may raise it only by naming a number, and a brief that asks for emoji without a number is treated as asking for at most one, with the assumption recorded in the deliverable), the fixed exclamation ceiling for (iv), zero staccato runs for (ii)), the same treatment the quotation rule below already gives (iv), (v) and (vi). A guide illustrating one of these four describes the pattern instead of reproducing a live instance of it, the convention Appendix C's own Rule 7 example already uses, writing "[em dash]" rather than the character it warns against.

The two universal, verbatim appendices (C and D) are excluded from the scan entirely, the same exclusion and the same reason as the dash sweep: they are embedded source text, not brand-authored copy, and scanning them would report every worked example inside them as a finding against the very document that defines the rule. State the appendix exclusion explicitly wherever this scan is reported, with a byte count, so it reads as a stated exclusion rather than a silent skip. The Redefinition register's own piece-boundary question, whether the whole guide is one piece or each worked example is its own piece for word-count purposes, has no separate answer here: a guide is scanned as the one piece its file boundary defines, the same unit Step 9 is run against.

**Quotations are NOT removed from the scan.** The appendix's quotation exemption is narrow and it is not a scope rule. It covers Rules 1, 8, 12, 13, 14, 15 and 16, which is why checks (i), (iii) and (vii) skip verified direct quotations. **Checks (iv), (v) and (vi) run over the complete delivered copy including every quotation**, because Rule 7 requires the dash to be replaced wherever it appears and Rule 17's emoji and exclamation limits are properties of the delivered piece, not of its unquoted parts. A testimonial carrying an em dash or an emoji is a finding.

**"Verified direct quotation" is not "anything between quote marks."** The exemption applies only to a quotation whose source is recorded, the same evidence bar Rule 13's register sets. Scare quotes, emphasis quotes and invented dialogue are ordinary copy and every check runs on them.

**Candidates versus findings.** Checks report CANDIDATES. A candidate becomes a finding when the rule it belongs to says so, at the tier that rule sits in. This distinction is what keeps a mechanical scan from overruling a rule that has a legitimate case, and it is why a clean scan is not the same as a clean piece.

**Every check ships with a planted control.** Before you trust a zero, plant the pattern the check looks for, confirm the check reports it, then remove the plant. A check that has never fired has not been shown to work, and a silent zero from a broken check is worse than no check at all. On a check with two configuration branches, plant the control on the branch you are actually running.

| # | Literal check | Pass condition | Planted control the writer confirms fired |
|---|---------------|----------------|-------------------------------------------|
| (i) | Three or more consecutive sentences or lines sharing an opening word | zero runs survive adjudication | insert "No stomach. No liver. No waste." and confirm the run is reported |
| (ii) | Three or more consecutive sentences under eight words | zero runs | insert three consecutive five-word sentences and confirm the run is reported |
| (iii) | Every Rule 13 form: `not [word or phrase]. It's`, `isn't ... it's`, `not just X but Y`, `X rather than Y`, and the clipped tail `Not X. Y.` | every hit matches a Redefinition register entry exactly on the `line` field AND that entry passes the field check for the branch the piece is on (below) | three plants, all three confirmed reported: (a) "It's not magic. It's chemistry." with no register entry at all; (b) an entry whose `line` matches but whose evidence field is empty; (c) an entry whose evidence field is present but generic |
| (iv) | Exclamation marks in the complete delivered copy | **one total, whatever the length**, AND zero anywhere in the body when the copy is 300 words or over. Body is everything that is not the headline or a CTA line. Under 300 words the single mark may sit anywhere; at 300 and over it may only sit in a headline or a CTA | add one exclamation mark past the applicable limit and confirm the count crosses it |
| (v) | Emoji count in the complete delivered copy | zero by default. A platform brief may raise it only by naming a number; **a brief that asks for emoji without a number is treated as asking for at most one**, and the assumption is recorded with the deliverable | insert one emoji past the applicable limit and confirm it is reported, on whichever branch is running |
| (vi) | Em dash (U+2014), en dash (U+2013) and horizontal bar (U+2015) count, over the complete delivered copy including quotations | zero of each | insert one of each and confirm all three are reported |
| (vii) | Forbidden vocabulary: every entry in the Rule 1 table plus the brand-specific additions | zero unadjudicated hits | insert "leverage" and "pivotal" and confirm both are reported |

**Reading the checks against the rules they serve.**

- **(i) is a floor, not the rule.** Rule 12 bans a stack at TWO consecutive lines; check (i) starts at three because three is where a literal scan is right often enough to be trusted. A two-line stack passes (i) and is still a Rule 12 finding, read by eye. In the other direction, a three-line run that Rule 12 legitimately permits (the meaning has three parts and each part is new) is a candidate that adjudication clears, not an automatic fail. Run the escalation test on every run (i) reports: cover the openers, read what follows, and count the facts.
- **(i) catches the opener stack only.** The skeleton stack (the same grammatical frame under different opening words) has no literal check. Never report a clean (i) as a clean Rule 12.
- **(ii) enforces Rule 12, not Rule 2.** The staccato run is a named form of the parallel stack in Rule 12's own list (the stack expressed in length), which is why it is acted on at a single sighting. Rule 2 governs how short sentences are DISTRIBUTED across a piece, is assessed over the piece, and is weak alone in tier 2. Both are true at once and neither overrides the other.
- **(iii) exempts nothing at scan time.** It flags every Rule 13 form and clears a hit only on an exact character-for-character match to an entry of the Redefinition register (see the appendix, Rule 13). A hit with no matching entry is a finding. A register entry written after the scan to clear the scan is not a register entry.
- **(iii) reads whichever register form the length calls for (v1.5.1, ruling R7).** Establish the branch first, from the word count of the delivered copy as the appendix defines it: 300 words and over is the persisted four-field file; under 300 words is one line per allowed contrast in the planning notes. Then run the check for THAT branch. Getting the branch wrong is itself a finding, because it decides which fields are required.
- **(iii) is a two-part check, and the second part is the one that gets skipped.** An exact `line` match alone does NOT clear a hit. The appendix rejects entries whose evidence is missing or generic, so the check has to reject them too, or the self-check certifies exactly the entries Rule 13 was written to catch. Required fields by branch:

  | Branch | Fields that must be present and specific |
  |---|---|
  | 300 words and over | `line` (exact), `belief` (in the reader's terms), `source` (a named record AND a position inside it, not a bare document name), `excerpt` (verbatim words from that record) |
  | Under 300 words | `line` (exact), `belief`, `source` (a named document) |

  "Generic" fails the same as empty on any of them: "the reader probably thinks this" is not a belief, "customer research" with no record named is not a source, and an excerpt that does not contain the belief is not an excerpt. On the long branch a `source` with no locator is a finding even when a document is named, because the locator is what makes the excerpt checkable.
- **(iii)'s planted control has three plants, not one.** A control that only ever plants a MISSING entry cannot detect a check that ignores the field requirements, and a check that ignores them reports a clean zero on a register full of fabrications. Plant all three: no entry, an entry with an empty evidence field, and an entry with a generic one. Plant them on the branch the piece is actually running.
- **(iii)'s five listed forms are a filter, not a proof.** `not [word or phrase]. It's`, `isn't ... it's`, `not just X but Y`, `X rather than Y`, and the clipped tail `Not X. Y.` are the shapes a literal scan can reasonably catch, not an exhaustive grammar of Rule 13's false contrast. A real HimFresh instance (2026-09-09 rebuild pilot) escaped all five: it used "isn't" where the pattern expects literal "not," split across two sentences rather than joined by one comma, and was found only by re-reading the text against Rule 13's plain-English shape ("It's not X. It's Y." and its variants), not by the scan. **A zero from check (iii) is not evidence of zero false contrasts; it is evidence of zero matches to five specific shapes.** Read the finished text against Rule 13 by eye at least once regardless of what the scan reports. This is a known limit of the check, stated so it is not mistaken for a guarantee; widening the five forms is out of scope for this fix and is left for whoever picks up check (iii) next.
- **The short-form register is not itself scanned, and that is deliberate.** The scan scope above excludes the planning notes, so the register cannot clear itself by appearing in the copy. It is read as evidence, not scanned as text. The lighter form is a smaller entry, never an exemption, and a flagged line with no entry is a finding at every length.
- **(vii) separates literal from semantic.** Entries with a parenthetical sense restriction ("unlock (except literal)", "key (as adjective)", "quietly (figurative sense)", "navigate (except literal)") cannot be settled by a string match. The scan reports every occurrence; the writer adjudicates the restricted ones and records which occurrences were cleared and why. Everything without a restriction is a hard hit.

**What the seven do not cover.** Rule 17's chatbot residue and its straight-quote requirement are tier-1 items enforced on the read, not among the seven; a mechanical form of both is the funnel-builder scan work filed as BACKLOG #70. Do not report Phase 1 as complete evidence that Rule 17 passed.

**Phase 2: Voice Alignment** - brand voice match, archetype match, confidence check
**Phase 3: Emotional Resonance** - target emotion achieved, empathy present, aspiration without pandering
**Phase 4: Specificity and Differentiation** - no vague statements, concrete scenarios, mechanism clear
**Phase 5: Voice Preservation** - the do-not-sanitize check, run against the edits Phases 1 through 4 produced, not against the original draft. Confirm that no edit removed the odd specific detail, the mixed feeling, a real aside or self-correction, a first-person choice the writer can explain, or verbatim customer language including its grammar. Confirm the fact rule held: no edit added a claim, number, name, study, quote or testimonial that was not in the source material. An edit that removed a tell and a human at the same time is a failed edit. Restore the human and find another way to remove the tell.

## Step 9.5: Moat Map Scan (pre-output gate)

Run this against the Step 0 dispositions before presenting the guide. It is the single point where the invariant is enforced over the whole generated guide, and it reads the actual generated text rather than trusting any label.

For every canonical example and approved-messaging element the guide generated (archetype core promises and example paragraphs from Step 2, voice pillar "sounds like" exemplars AND "doesn't sound like" anti-examples from Step 3, content-type example copy from Step 5, the category messaging framework's approved messages and mechanism explanation from Step 6, the worked technique examples from Step 7 if present, any before/after bad examples, and any brand-copy example sentence used to illustrate a Step 4 firewall rule), do two reads: (1) identify the differentiator the element's lead framing rests on and check its Step 0 disposition; (2) scan the full text of the element for every differentiator it mentions anywhere, lead or secondary.

Findings:
- Any positive canonical example, core promise, voice pillar exemplar, or primary approved message whose lead framing rests on a SUPPORT or AVOID differentiator is a finding. Rebuild it on a LEAD differentiator or a non-differentiator emotional/identity driver; a SUPPORT attribute may remain only as a supporting proof point inside the copy, not as the lead.
- Any element that mentions an AVOID differentiator anywhere - lead or secondary, as claim, proof, or comparison, and including inside a "doesn't sound like" anti-example or a before/after bad example - is a finding; remove the AVOID framing entirely. Per Step 0, an AVOID differentiator does not appear at all, not merely "not as the lead." In an anti-example, warn against the mistake by describing it, not by reproducing the AVOID claim verbatim.
- A "doesn't sound like" anti-example or before/after bad example MAY legitimately use a SUPPORT differentiator as the thing it warns against (for example, "don't lead on [commoditized attribute]"); that is the anti-example doing its job and is not a finding. The SUPPORT finding fires only when a SUPPORT differentiator leads a positive canonical example.

This scan checks every generated element by the property of the differentiator it actually rests on (and, for AVOID, by any mention), regardless of how vivid or proof-heavy the element is. It does not apply to the universal structural rules (Step 8) or to the universal mechanics and forbidden-vocabulary lists of the firewall (Step 4), which are brand-agnostic; it DOES apply to any brand-copy example sentence generated inside the firewall section.

If the run is ungrounded (Step 0 item 5), the gate fails closed: confirm that no presented canonical example, core promise, voice pillar exemplar, content example, or approved message leads on a differentiator, and that every differentiator-led slot is an explicit placeholder. State at the head of the output: no moat grounding was available, differentiator-led canonical examples are withheld as placeholders, and a Phase 1 Moat Map or moat-graded Phase 3 Brand Guidelines should be supplied before the guide is used to anchor brand voice.

## Step 10: Present and Output

Present summary:

```
COPYWRITING GUIDE READY: [brand_name]

Inputs Loaded:
  Avatar Research: [count] archetypes
  Brand Guidelines: [count] voice pillars
  Validation Report: [available/not available]
  Angle Roadmap (Phase 4.5): [available, [count] angle cards / NOT AVAILABLE - mechanism framing derived from Phase 1 and Phase 3, not roadmap-grounded]

Guide Contents:
  Voice Pillars: [count] defined
  Archetypes: [count] with full copy profiles
  Content Guides: [count] content types covered
  Humanization Rules: 17 universal rules in the AI Detection Firewall + [count] brand-specific additions
  Universal Structural Rules: the RMBC Frame (8.0) plus 10 rules (Bridge, Open-Loop, Time-Delay, Hook Quality, Identification-Before-Mechanism, Discovery Story, Five Core Feelings, Authority Hooks, Claim-Proof Adjacency, First-Draft-to-Final Process)
  Universal Appendices: humanization-rules v1.5.1, line-level-rules v1.5.1 (embedded verbatim, digest-verified)
  Brand Extensions: [include this line ONLY if the brand has an Appendix E; [count] sections carried verbatim]
  Structural Moves: [include this line ONLY if `schwartz-applied.md` exists at the brand repo root; 7 techniques with worked examples]

Total Sections: 12 + 4 appendices (13 sections if `schwartz-applied.md` exists at the brand repo root; 5 appendices if this brand carries an Appendix E of brand extensions)
Estimated Length: [word count]

Confirm or adjust:
```

### Provenance stamp

The generated guide's first lines, above the title, carry a provenance stamp:

```
generated-by: copywriting-guide v1.5.2
appendices: humanization-rules v1.5.1 sha256:<first 16 hex>, line-level-rules v1.5.1 sha256:<first 16 hex>
generated: [YYYY-MM-DD]
```

Read each appendix version from the `<!-- universal appendix: ... -->` comment on line 1 of the corresponding reference file, and compute each digest from the file on disk at generation time. Do not type either from memory. A version alone says which release was intended; the digest is what says the bytes actually arrived, and it is the only part of the stamp that can be falsified by a bad copy.

### The appendices

The guide carries two UNIVERSAL appendices, each embedded **verbatim**, byte for byte:

- **Appendix C: Universal Humanization Rules** - the full text of `references/humanization-rules.md`.
- **Appendix D: Universal Line-Level Rules** - the full text of `references/line-level-rules.md`.

**Appendix E: Brand Extensions follows D when the brand has one.** It is conditional and it is NOT universal: it holds the sections this brand accumulated that the template does not produce, carried verbatim with the date each was added and where it came from. It is defined in `assets/output-structure.md` under "Appendix E: Brand Extensions". **A rebuild that drops it has failed even if every other check passes**, because Appendix E is the only thing standing between a version bump and the loss of hand-added brand work (ruling R9). Before presenting a rebuilt guide, check it explicitly: if the superseded guide carried an Appendix E, the new one carries it too, entry for entry; and if the comparison step surfaced content the template does not produce, that content is IN Appendix E and not merely noted. Appendix E is never regenerated and never paraphrased. When the brand has no extensions, Appendix E is absent and is not mentioned.

Do not paraphrase, summarize, reorder, trim or brand-adapt either appendix. Brand-specific firewall additions live in the guide's AI Detection Firewall section and layer on top of Appendix C; the appendix text itself is identical in every brand's guide. That identity is the whole point: it is what makes a universal change a file copy rather than a regeneration.

**What the appendices carry, and what they do not (v1.5.1, ruling R8).** Both files are embedded verbatim into brand guides and vendored into ContextOS prompts that do not carry the rest of the skill library, so every sentence in them is addressed to a brand's copywriter. Anything that instead tells ContextArchitect how to run its own process lives here, not there. Both files are self-contained: neither links out to another document, neither carries a relative path, and cross-references inside an appendix point only to other rules in the same file. Nothing in an appendix may depend on a document that might not travel with it.

Moved out of the two files at v1.5.1, and kept here rather than deleted:

- **Where the Rule 11 structural bans are additionally enforced when the skill library is present.** These are deeper guidance, not a precondition for applying the ban, which is why the appendix now states the three bans and stops. One mechanism per argument: the single-mechanism rule (Step 7 Concentration and Step 8 of this skill, angle-roadmap Mechanism Derivation "Singular" criterion, funnel-audit frame rule 11). One ask per CTA: the one-ask rule (funnel-builder QA, funnel-audit frame rule 13). No claim without adjacent proof: Claim-Proof Adjacency (Step 8.9 of this skill).
- **The structural provenance of Rule 11's second line-level ban.** "No burying the product or over-educating before the reader cares" is the line-level tell of the Identification-Before-Mechanism structural rule at Step 8.5 of this skill.
- **The Redefinition register's deferred validator.** A validator that checks field presence, locator shape and excerpt-in-source is deferred tooling, in the same family as BACKLOG #71 and to be built with it. The appendix states the limit as a limit; it does not name the tooling, the session or the backlog id.
- **The macro-order authority.** The named attention-to-offer spine and the entry point each format takes into it are owned by funnel-builder, the single authority. Where `references/line-level-rules.md` and that spine ever appear to disagree, the spine wins and the appendix is the file to correct. The appendix keeps the writer-facing half of this: its five lines are invariants, not a section order, and they are not sufficient to lay out a long-form page.
- **What a brand's guide adds on top of Appendix C.** Beyond the 17 rules (16 universal humanization rules plus the direct-response forbidden-constructions set at Rule 11), each brand's guide adds brand-specific forbidden words drawn from avatar research "language to avoid"; brand-specific approved vocabulary drawn from avatar "language that resonates"; category-specific claim rules from regulatory findings in business validation; positioning-specific tone rules, where premium brands restrict casual language and budget brands restrict pretentious language; and geography-specific language notes, UK versus US English and regional colloquialisms. That is Section 3's content and it is generated by Step 4 above; it is not appendix text.

**Boundaries.** Each UNIVERSAL appendix body (C and D, and only C and D) starts at its `<!-- universal appendix: NAME vX.Y.Z -->` line and ends at its `<!-- end universal appendix: NAME vX.Y.Z -->` line. Both markers are part of the file and are copied with it. They exist so the body can be extracted from the finished guide without guessing where it starts and stops.

**Appendix E has no markers, no reference file, no version and no digest, and that is correct.** It is brand-owned content with no canonical source to compare against, so there is nothing a digest could prove. Everything in the two paragraphs below applies to Appendices C and D ONLY. Applying the marker or digest rules to Appendix E would force a choice between failing a guide that is correct and dropping the appendix to make the gate pass, and the second of those is the data loss ruling R9 exists to prevent.

**Assemble by copy, not by generation.** Do not retype, re-emit or reflow either appendix. Concatenate the file. An LLM asked to reproduce 25 kB byte for byte inside a longer document will normalize something, and the failure is silent: the version stamp still reads correctly while the body has quietly changed.

**Verification gate, before the guide is presented. Appendices C and D.** For each of the two universal appendices: extract the text between its two markers from the assembled guide, compute its sha256, and compare that digest to the digest of the reference file on disk. Equal digests, or the guide is not delivered. A mismatch is not a formatting nit; it means the propagation contract this whole structure rests on has already failed on its first use. Record both digests in the stamp so the next reader can re-run the comparison without access to this skill.

**Verification gate, Appendix E: preservation, not digest.** Appendix E is checked entry for entry against the superseded guide, because that is the only source it has. If the superseded guide carried an Appendix E, every entry in it appears in the new one, with its date and origin intact. If the comparison step of Change policy trigger 2 surfaced content the current template does not produce, that content IS an Appendix E entry in the delivered guide, not a note in a report. A missing entry fails delivery exactly as a digest mismatch does. When the brand has no extensions and the superseded guide had no Appendix E, this gate passes trivially and Appendix E is absent from the output.

### Anti-drift rule

Brand sections are regenerated only when brand inputs change: avatar research, brand guidelines, business validation, moat dispositions, positioning.

**A universal change is not a regeneration.** When `humanization-rules.md` or `line-level-rules.md` changes upstream, propagate it by replacing the appendix body with the new file and updating the `appendices:` line of the provenance stamp. No LLM re-runs the brand sections, and no brand copy is rewritten as a side effect. Regenerating a whole guide to pick up a universal change is the drift mechanism this structure exists to remove.

**But "nothing else is touched" is only true for a change that stays inside the appendix.** Some surfaces of the guide restate appendix semantics rather than merely referring to them, and a change to those semantics leaves them contradicting the appendix that was just copied in. Classify the change before propagating it:

Classify the change by one question: **could a guide surface that restates this rule now be wrong?**

| Class | Change to an appendix | What it touches |
|---|---|---|
| **Editorial** | Rewording that leaves every rule's meaning, scope and thresholds where they were | Appendix body and the `appendices:` stamp line. Nothing else. |
| **Semantic** | Anything that changes what a rule requires, permits or is called. Includes but is not limited to a threshold, ratio or ceiling, rule numbering, tier assignment, the Rule 1 vocabulary table, the Redefinition register format, adding or removing a banned form, and changing a carve-out's conditions | Appendix body and stamp, PLUS every surface in the dependency manifest below. |

When you cannot tell which it is, it is semantic.

**Dependency manifest.** These surfaces restate appendix semantics and go stale when the semantics move:

- **Section 3**, for its brand-voiced examples of Rules 2, 5, 12 and 13, and for any brand vocabulary row that mirrors a Rule 1 category.
- **Section 5**, the humanization checklist, for the seven checks' thresholds and pass conditions.
- **Section 6**, for the connector test and any structural rule that restates a line-level or humanization rule.
- **Section 11 and Section 12**, for any rule count, rule number or non-negotiable they name.
- **Appendix A**, for the per-pair annotations naming which rules each before/after example applies.
- **Appendix B**, the quick reference card, for its non-negotiables table.

Refresh those named surfaces, and only those, in the same pass as the appendix copy. That is still not a regeneration: the brand's voice, archetypes, messaging framework and before/after examples are untouched.

**On the skill's own version (ruling R10, 2026-09-09).** A copywriting-guide version bump does NOT regenerate sections by number. Wholesale section regeneration is retired: it was measured on 2026-09-09 that every section this template calls universal carries brand-specific content in every existing guide, so regenerating one by number destroys brand work. A skill version change is propagated by REBUILDING the guide from the brand's Phase 1, 2, 3 and 4.5 inputs using the current skill, then comparing the rebuilt guide against the superseded one and surfacing to the operator anything present in the old and absent from the new. The full policy, including Appendix E, is in `assets/output-structure.md` under Change policy. That is a different event from an appendix change and does not imply one.

**On a guide written against an older layout.** There is no migration step and no by-title remap. Existing guides carry four different section orders across four generator dates, and one was extended by hand past anything this template produces, so a mechanical remap has no layout to remap to. Rebuild the guide from inputs, compare it against the superseded one, and carry anything the template does not produce into Appendix E. The superseded guide is preserved in git history.

Deliver the complete guide as a single markdown document the user can add to any Claude Project as a knowledge base file.

```
GUIDE GENERATED

Sections populated:
  - Brand identity and voice foundation
  - [count] voice pillars with examples
  - AI Detection Firewall (17 universal rules + [count] brand-specific additions)
  - [count] archetype copy profiles with sample paragraphs
  - Universal Structural Rules (The RMBC Frame, The Bridge Principle, The Open-Loop Principle, The Time-Delay Introduction Rule, Hook Quality Checklist, Identification-Before-Mechanism Rule, The Discovery Story Format, The Five Core Feelings Library, Authority Hook Patterns, Claim-Proof Adjacency, The First-Draft-to-Final Process)
  - Structural moves: [include this line ONLY if `schwartz-applied.md` exists at the brand repo root; 7 techniques with worked examples]
  - Humanization checklist (5 phases, Phase 1 is seven literal checks)
  - [count] content type quick guides
  - Category messaging framework with claim boundaries
  - Before/after examples
  - Quick reference card
  - Appendix C: Universal Humanization Rules v1.5.1 (embedded verbatim, sha256 matched)
  - Appendix D: Universal Line-Level Rules v1.5.1 (embedded verbatim, sha256 matched)
  - Appendix E: Brand Extensions [include this line ONLY if the brand has extensions; [count] sections carried verbatim, each dated and attributed]

Provenance stamp: generated-by copywriting-guide v1.5.2; appendices humanization-rules v1.5.1 + line-level-rules v1.5.1, both digest-verified against the reference files

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
