---
name: angle-roadmap
version: "1.6.0"
description: "Synthesize Phase 1 (Business Validation) and Phase 2 (Avatar Research) outputs into a Brand Angle Roadmap: root cause narrative with analogy, solution mechanism narrative, scored emotional triggers, layered desire chains, alternative solution positioning, and structured angle cards. The roadmap becomes the required input for ad-style-generator and funnel-builder skills - it bridges avatar research to creative execution. Trigger on: 'build angle roadmap', 'define angles', 'angle development', 'run Phase 4.5', 'marketing angles for [brand]', 'root cause narrative', 'what angles should we run'. Also trigger when the user has completed Phase 2 and wants to move toward ad/funnel creation but hasn't defined angles yet."
---

# Angle Roadmap Skill

## Purpose

Transform existing research outputs (Phase 1 + Phase 2) into a structured Brand Angle Roadmap that bridges avatar research to creative execution. The roadmap defines the reusable strategic angles that drive all downstream ad creative and funnel development.

An angle is the specific combination of emotional trigger, desire, root cause framing, and mechanism framing that a piece of marketing uses to connect with one avatar. A brand typically has 5-15 angles across its avatars. These angles are what you test in ads - and whichever wins, the funnel and PDP messaging align to it.

This is Phase 4.5 in the brand development workflow: Business Validation -> Avatar Research -> Brand Guidelines -> Copywriting Guide -> **Angle Roadmap** -> Funnel Pages / Ad Creative.

## When to Use

- User has completed Phase 2 (Avatar Research) and wants to create ads or funnels
- User says "define angles", "build angle roadmap", "what angles should we run"
- User is about to use ad-style-generator or funnel-builder and hasn't defined angles yet
- User wants to formalize the root cause + mechanism narrative for a brand
- User wants to prioritize which marketing messages to test first

## Why This Exists

The angle roadmap drives three downstream skills:

- `ad-style-generator` (ad creative briefs and image prompts)
- `funnel-builder` (advertorial and listicle landing pages)
- `long-form-static-builder` (Facebook in-feed ad primary text, 2,500-3,500 words plus a Reddit-native image spec)

All three require knowing WHAT to say (the angle), not just WHO to say it to (the avatar) and HOW to say it (the copywriting guide). Without defined angles, the quality of ads, funnels, and long-form-static copy depends entirely on the operator's marketing instinct. This skill captures that instinct as a structured, reusable asset.

Each angle card gets used multiple times across these downstream skills. The same angle drives a long-form-static ad (the in-feed primary text), a landing page that traffic clicks through to, and the supporting visual ad creative. Reusing one angle across formats keeps messaging coherent end to end.

## Required Inputs

### Must Have

1. **Phase 2 Avatar Research Report** - the primary raw material. Contains emotional triggers, desires, objections, language patterns, competitive context, and purchasing behavior across all avatars.

2. **Product information** - how the product works, its ingredients/features, and why it solves the problem. This can come from: Phase 1 Business Validation report (product section), client braindump, separate product documentation, or brand guidelines (positioning section).

3. **Root cause knowledge** - why the problem exists. This usually comes from: the founder (most common - ask them), Phase 1 report (competitive landscape often reveals this), existing brand documentation, or if genuinely unknown the skill generates a focused research prompt (see Step 1 fallback).

### Nice to Have

4. **Brand Guidelines (Phase 3)** - for positioning context and competitive framing
5. **Copywriting Guide (Phase 4)** - for voice/tone constraints on narratives
6. **Existing ads or funnels** - if the brand has run marketing before, knowing what's been tried helps avoid redundant angles

## Workflow

```
STEP 0: POSITIONING GUARDRAILS (MOAT MAP GATE)
  -> Read Phase 1 Moat Map; establish which differentiators may lead

STEP 1: ROOT CAUSE & MECHANISM NARRATIVES
  -> Mechanism Derivation: derive the Root Cause Narrative / Solution Mechanism Narrative via the 6-step process, then run the 5-criterion strength test (kill on 2+ fails); apply the fallback ladder if no unique mechanism; HARD RULE = never fabricate
  -> 1A: Root cause narrative (scientific, 4th-grade, analogy, copywriting section)
  -> 1B: Solution mechanism narrative (same 4 layers + product mapping)
  -> 1C: UGC creator brief (5 components for spoken delivery)

STEP 2: EMOTIONAL TRIGGER SCORING
  -> Extract from Phase 2, consolidate, score, rank across avatars

STEP 3: DESIRE CHAIN LAYERING
  -> Restructure Phase 2 desires into "I want -> so I can -> deepest core" chains

STEP 4: ALTERNATIVE SOLUTION POSITIONING
  -> Structure from Phase 2 competitive context into attack angles

STEP 5: ANGLE CARD GENERATION
  -> Combine Steps 1-4 into structured angle cards (5-15 per brand)
  -> Each card carries a Recommended Format (from funnel-builder/references/format-library.md)
  -> Each card identifies multi-bio-marker pivots when applicable

STEP 5.5: LEAD VARIANTS
  -> For each angle, produce 3 POV variants (first-person sufferer, first-person discoverer, third-person authority/witness)

STEP 6: STRUCTURAL SCORING (conditional)
  -> Run only if `schwartz-applied.md` exists at the brand repo root
  -> Apply the gated framework in Step 6 below; skip the step entirely otherwise

STEP 7: PRIORITIZATION & OUTPUT
  -> Rank angles by testing priority, deliver as Brand Angle Roadmap document
```

## Step 0: Positioning Guardrails (Moat Map Gate)

Read this before scoring any trigger. It governs which angles may lead and which may be priority 1. It is not Schwartz-gated; it applies to every brand.

Read the Positioning Guardrails / Moat Map from the Phase 1 report: the LEAD / SUPPORT / AVOID disposition of every differentiator, the named brand world, and the binding rule.

The invariant (stated once here; every step below reinforces it, none weakens it):
- An angle may lead on a LEAD differentiator or on a genuine non-differentiator emotional or identity hook (one that makes no differentiation claim and hands differentiation to the funnel and brand downstream). Priority-1 and primary cold-traffic-budget angles may use either of those leads. A SUPPORT or AVOID differentiator may never be the differentiator a primary-slot angle rests on.
- A SUPPORT differentiator (commoditized but true) may appear only in supporting or retargeting angles, never as the lead of a priority-1 angle. A high emotional-trigger score does not change this.
- An AVOID differentiator is not angle material; do not build an angle that leads on it.

Trigger intensity and moat defensibility are different axes. Step 2 scores how visceral a trigger is; Step 0 records how defensible the differentiator behind it is. Prioritization (Step 7) needs both, and this is the exact separation whose absence lets a loud but commoditized trigger reach priority 1.

Fallback when the Moat Map block is absent (legacy Phase 1 report): do not skip the gate and do not error. Derive each differentiator's disposition inline from the Phase 1 competitive and differentiation analysis using the two-axis fixed order: score can_lead (STRONG and brand-world-safe) and usable_in_copy (false if untrue, unsupported, off-world, or off-strategy); then by fixed order, first match wins: usable_in_copy false gives AVOID, else can_lead gives LEAD, else SUPPORT. Tell the operator the dispositions were derived inline because the report predates the Moat Map.

If neither a Moat Map nor any Phase 1 competitive/differentiation analysis is available (for example, angle-roadmap is run without a Phase 1 report at all), do not guess dispositions. Flag the gap and ask the operator to supply the Phase 1 Moat Map or competitive analysis. Until that grounding exists, the gate fails safe: no angle may be assigned a priority-1 or primary cold-traffic slot, and no differentiator may be tagged LEAD, SUPPORT, or AVOID. Angles may still be generated and tested as supporting/retargeting until the moat input is provided.

See the canonical `_frameworks/positioning-guardrails.md` in `contextarchitect/context-architect-brands` for the full filter definition.

## Step 1: Root Cause & Mechanism Narratives

This is the most important step. Every advertorial depends on sections 4-6 (root cause -> consequences -> mechanism), and every ad depends on being able to communicate WHY the problem exists and WHY this solution works - in a way that a tired person scrolling at midnight understands instantly.

Step 1 produces three artifacts: the root cause narrative (1A), the solution mechanism narrative (1B), and the UGC creator brief (1C). The first two feed downstream copy work (advertorials, ads, listicles). The third feeds downstream video work, where a UGC creator records a 60-90 second clip explaining the root cause + mechanism in their own words on camera.

### Mechanism Derivation (run before 1A and 1B)

1A and 1B tell you how to *narrate* the root cause and the mechanism in four layers each. This section tells you how to *derive* them from research in the first place, and how to test whether the derived mechanism is strong enough to build a brand on. Run this derivation first; then narrate the winner in 1A (problem) and 1B (solution).

**Terminology.** This skill uses the ContextArchitect names Root Cause Narrative and Solution Mechanism Narrative; the RMBC framework calls these the Unique Mechanism of the Problem (UMP) and Unique Mechanism of the Solution (UMS), per the canonical precedence in the angle-card schema's "Canonical sources and terminology" section. The Root Cause Narrative (1A) is the surprising hidden CAUSE that reframes blame; the Solution Mechanism Narrative (1B) is why the product uniquely defeats that cause. The Pain Matrix (Step 5 sub-step 8) already routes on these two; this section is where they are actually built. Narrate the Root Cause Narrative before the Solution Mechanism Narrative.

#### The 6-step derivation process

Starting from finished avatar research + product facts:

1. **Isolate the ONE throbbing problem.** From the avatar's pain data, pick the single biggest, most emotional pain. Not three. One. Everything hangs off this. (This becomes the "One Throbbing Pain" the downstream Copy Brief carries.)
2. **Find the hidden cause (this becomes the Root Cause Narrative).** Ask: what is the real, underlying reason this problem exists, especially a reason the buyer does not already know about? Pull from the avatar's false beliefs / misconceptions and the product facts. The best Root Cause Narrative reframes the problem off the buyer's fault ("not your genetics, not stress") and onto a hidden external villain they can now defeat.
3. **Name the villain.** Give the cause a concrete, visualizable identity. "Mineral buildup" is okay. "A microscopic mineral cast that suffocates your follicles" is a mechanism. Make it something they can picture and hate. (This is the same standard the 1A analogy already asks for: visual, externalizes blame, implies a fix.)
4. **Connect the product to the villain (this becomes the Solution Mechanism Narrative).** Ask: what specifically does the product do that neutralizes that exact cause? Pull the one or two ingredients/actions that directly kill the Step 3 villain. This must be a logical, one-to-one match: villain to the thing that defeats the villain.
5. **Name the solution mechanism.** Give the product's process a proprietary-feeling name or a vivid metaphor (see naming rules below). "Chelation" is a fact; "a molecular magnet that pulls the mineral cast off your follicles" is a Solution Mechanism Narrative. This is the branded Mechanism Name that 1B carries.
6. **Pressure-test believability.** Walk the chain out loud: hidden cause -> why it defeated everything else they tried -> why this product uniquely addresses it -> therefore the result is inevitable. If any link needs a leap of faith, the mechanism is weak. Fix the link or find a new one.

#### The 5-criterion mechanism strength test

Score every mechanism candidate against these five. A strong mechanism passes all five. **Kill rule: discard any candidate that fails two or more.**

1. **Believable** - a normal, skeptical person accepts the logic without a leap of faith. Grounded in something real (an ingredient, a study, a physical fact).
2. **Specific** - concrete and visualizable, not abstract. "Suffocates follicles with a mineral cast" beats "damages hair health."
3. **Novel** - the buyer has not heard this exact framing before. If competitors already say it, it is not unique; dig deeper or reframe.
4. **Singular** - ONE cause and ONE solution mechanism. Two competing mechanisms cancel each other out and confuse the reader. Pick the strongest culprit.
5. **Emotionally reframing** - it moves blame off the buyer and onto a defeatable villain. This is what makes it feel like relief.

This universal strength test runs on every brand, gated or not. It is distinct from and complementary to the Schwartz-gated Four-Hole Pressure Test (Step 6D): the 5-criterion test decides whether a mechanism is worth building on at all; the Four-Hole test checks a finished angle card's structural fit.

#### Mechanism naming rules

When you name the solution mechanism (derivation Step 5, narrated as the 1B Mechanism Name):

- Use a vivid physical metaphor ("molecular magnet," "mineral cast," "the suffocation cycle") OR coin a proprietary term (Capitalized Name + "Complex / System / Method / Formula").
- Keep it 2-4 words, sayable out loud, and picturable.
- The name should imply the villain or the benefit, not just sound clever.

#### When the product has NO genuinely unique mechanism (fallback ladder)

Common and not fatal. Work down this ladder in preference order; take the highest rung that is true:

1. **Unique the problem (lead with the Root Cause Narrative).** Even a generic product can attach to a unique problem mechanism. You do not need a unique ingredient if you are the first to name the hidden cause.
2. **Unique the combination.** No single ingredient is new, but this specific blend / ratio / sequence is. Name the combination as the mechanism.
3. **Unique the process / application.** Same ingredients, novel way of using them (timing, order, delivery).
4. **Unique the origin.** A specific sourcing, formulation story, or context (for example, formulated for hard water in the GCC) carries the mechanism.
5. **Category position as last resort.** "The first X built specifically for Y." Weaker than a true how-it-works mechanism, but better than a naked claim.

#### HARD RULE (non-negotiable)

**Never fabricate a mechanism that is not grounded in real product facts.** A made-up mechanism is compliance-adjacent risk: it produces refunds, chargebacks, and regulatory trouble. If the fallback ladder cannot reach a true rung, do not invent one. Flag the gap to the operator instead. This rule is not overridable by a strong trigger score or a tempting angle.

### 1A: Root Cause Narrative

Ask the user (or extract from documents): **What is actually causing the problem your product solves?**

If the user knows the root cause, develop the narrative. If they don't, generate a focused research prompt (see `references/root-cause-research-prompt.md`).

**Four layers of the root cause narrative:**

1. **Scientific explanation** - the factual, evidence-based explanation of why the problem exists. Include the key contributing factors. This doesn't appear in marketing copy directly, but it's the foundation everything else is built on. Cite credible sources where possible.

2. **4th-grade explanation** - rewrite the scientific explanation so a child could understand it. Strip all jargon. Use only common words. If you have to use a technical term, define it immediately in plain language. This is the version that gets adapted into marketing copy. (Same principle as System 1 simplicity in the funnel-builder skill. See `../funnel-builder/references/advertorial-framework.md` Section 4.)

3. **Real-world analogy** - a concrete, visual metaphor that makes the root cause instantly understandable and emotionally resonant. The analogy must: be something the avatar has seen or experienced in daily life, create a visual image (not abstract), externalize blame (the problem isn't the avatar's fault - it's this external force), and imply a fixable situation (the analogy should suggest the solution direction). Test: if you described this analogy to someone at a dinner party, would they say "oh, that makes sense" within 5 seconds?

4. **Copywriting-ready section** - a 150-300 word section written in direct-response style that could be dropped into an advertorial's root cause section. Short sentences. Short paragraphs. Uses the analogy. Externalizes blame. Creates urgency through consequences. Written at the emotional register the avatar uses (from Phase 2 voice data).

**Output format for root cause:**

```
ROOT CAUSE NARRATIVE: [Brand Name]

Problem: [1 sentence - what the avatar experiences]

Scientific Explanation:
[2-3 paragraphs with contributing factors]

4th-Grade Explanation:
[1 paragraph, no jargon]

Analogy:
[The analogy in 2-3 sentences]
Why this analogy works: [1 sentence - visual, externalizes blame, implies fix]

Copywriting Section:
[150-300 words, direct-response style, ready to adapt for advertorials]
```

### 1B: Solution Mechanism Narrative

The mechanism is NOT the product. It's the PRINCIPLE behind why the solution works - the insight that bridges root cause to product. The product is the vehicle that delivers the mechanism, but the mechanism must make sense on its own before the product is ever introduced.

**Same four layers:**

1. **Scientific explanation** - how does the fix actually work at a biological/mechanical/systemic level? What does the mechanism do to the root cause?

2. **4th-grade explanation** - plain language version. "It does X, which stops Y, which lets Z happen again." (Same principle as System 1 simplicity in the funnel-builder skill. See `../funnel-builder/references/advertorial-framework.md` Section 4.)

3. **Real-world analogy** - extends or mirrors the root cause analogy. If the root cause is "weed killer in the garden," the mechanism is "clearing the toxins so the soil can grow again." The two analogies should feel like natural complements.

4. **Copywriting-ready section** - 100-200 words that could follow the root cause section in an advertorial. Delivers the "aha" moment. Should feel like relief and hope after the tension of the root cause. Reader should think: "That actually makes sense. Why hasn't anyone told me this before?"

**Output format for mechanism:**

```
SOLUTION MECHANISM NARRATIVE: [Brand Name]

Mechanism Name: [optional branded name, e.g., "The Root Revival Mechanism"]

Scientific Explanation:
[How the fix works]

4th-Grade Explanation:
[Plain language]

Analogy:
[Extends the root cause analogy]

Copywriting Section:
[100-200 words, direct-response style]

Product-to-Mechanism Mapping:
[For each key product feature/ingredient, one line showing:
Feature -> triggers this mechanism -> which addresses this part of the root cause]
```

### 1C: UGC Creator Brief

The UGC creator brief is a third Step 1 artifact that translates the root cause + mechanism narratives into a format a real UGC creator can record on camera in 60-90 seconds. UGC ads generated downstream depend on this brief existing - without it, every UGC video request requires re-deriving the root cause + mechanism content from scratch.

Unlike the copywriting sections in 1A and 1B, this is NOT for written copy. It is a script-style brief written for spoken delivery: shorter sentences, conversational register, room for the creator to ad-lib while staying anchored to the core narrative.

**Five components of the UGC creator brief:**

1. **Hook line (5-9 words spoken)** - the first sentence the creator says. Camera-on, no preamble. Should pass the spirit of `copywriting-guide §8.4 Hook Quality Checklist` (open loop, identity marker, specificity) translated for spoken delivery.

2. **Identity reveal (1-2 sentences)** - who the creator is, in plain language, in a way the avatar can latch onto. "I'm 47. Three kids. I started losing weight after my second pregnancy and never got it back." Establishes narrator identity for `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`.

3. **Root cause in 30 seconds (script)** - the 4th-grade explanation from 1A, adapted for spoken delivery. Use the analogy. Use "you" or "your body" not "the body." Add natural verbal pauses ("...so what's happening is..."). Aim for 60-80 words.

4. **Mechanism in 20 seconds (script)** - the 4th-grade explanation from 1B, adapted for spoken delivery. Continue the analogy from the root cause. Aim for 40-60 words.

5. **Close prompt (1 sentence)** - one sentence that hands off to the brand's CTA without being a sales pitch. "I just thought you should know what I figured out." OR "I'm not selling anything. I just wish someone had explained this to me a year ago." The CTA itself comes from the funnel/ad context, not from the UGC clip.

**Output format for UGC creator brief:**

```
UGC CREATOR BRIEF: [Brand Name]

Brief duration: [60-90 seconds spoken]
Recommended creator profile: [Demographics that match the avatar - age range, life stage, region/accent if relevant]

Hook line (5-9 words):
"[Camera-on opener]"

Identity reveal (1-2 sentences):
"[Narrator establishment]"

Root cause script (~60-80 words, ~30 seconds spoken):
"[The 4th-grade explanation, conversational, with the analogy]"

Mechanism script (~40-60 words, ~20 seconds spoken):
"[The 4th-grade mechanism explanation, conversational, continuing the analogy]"

Close prompt (1 sentence):
"[Hand-off line, not a sales pitch]"

Total estimated runtime: [X seconds]
```

The UGC creator brief is consumed by the future video-script-generator skill (Session 13) and by ad-style-generator when generating UGC-style ad concepts. It does NOT replace those skills' video-specific outputs - it is the source narrative they adapt.

### Step 1 Fallback: When Root Cause Is Unknown

If the user cannot articulate the root cause, generate a focused Deep Research prompt using `references/root-cause-research-prompt.md`. This is a SHORT, focused prompt (not a full Phase-level research brief) that asks Deep Research to investigate: what is actually causing the problem at a scientific/biological/mechanical level, what are the key contributing factors, and why do common solutions fail to address it.

After research returns, resume Step 1A with the findings.

**This fallback should be rare.** Most founders know why their product works. If the user seems unsure, try asking these probing questions first before resorting to research:
- "What does your product actually do differently from competitors?"
- "If a customer asked you WHY their problem exists, what would you tell them?"
- "What do other products in this space get wrong about the cause?"

Often the founder knows the root cause but hasn't articulated it formally.

## Step 2: Emotional Trigger Scoring

Phase 2 avatar profiles contain emotional data spread across Sections E (pain/desire mapping), F (emotional landscape), and L (messaging implications). This step consolidates that data into a single scored, ranked list.

**For each avatar, extract:**
- Negative emotions from Section E and F (fears, frustrations, shame, anger, etc.)
- The primary emotional hook from Section L
- Raw quotes that demonstrate each emotion's intensity

**Score each trigger on a 1-10 scale based on:**
- **Frequency** - how often does this emotion appear across the avatar's quotes and data?
- **Intensity** - how visceral is the language? ("I want to crawl into a hole and die" = 9-10. "It's kind of frustrating" = 3-4.)
- **Actionability** - can this emotion be directly addressed by the product? A trigger that the product genuinely resolves scores higher than one it can only acknowledge.

For each trigger, also record the Moat Map disposition of the differentiator it is tied to (LEAD / SUPPORT / AVOID, per Step 0), or "non-differentiator" if the trigger is a pure emotional or identity driver, or "ungrounded" if no Moat Map or derivable competitive analysis exists (Step 0 fail-safe). Trigger score measures intensity, not defensibility. A SUPPORT or AVOID trigger may score high and still be barred from leading a priority-1 angle (Step 7). Record disposition next to the score so prioritization has both axes.

**Output format:**

```
EMOTIONAL TRIGGER SCORECARD: [Brand Name]

Cross-Avatar Triggers (appear across multiple avatars):
1. [Trigger Name] - [Score]/10
   Avatars affected: [list]
   Moat disposition: [LEAD / SUPPORT / AVOID / non-differentiator / ungrounded] ([differentiator it is tied to])
   Key quotes: ["...", "...", "..."]

2. [Trigger Name] - [Score]/10
   ...

Avatar-Specific Triggers:
[Avatar Name]:
1. [Trigger] - [Score]/10 - Moat disposition: [LEAD / SUPPORT / AVOID / non-differentiator / ungrounded] - ["quote"]
2. [Trigger] - [Score]/10 - Moat disposition: [LEAD / SUPPORT / AVOID / non-differentiator / ungrounded] - ["quote"]
...
```

Rank cross-avatar triggers first (these are the highest-impact angles because they work across segments), then avatar-specific triggers.

## Step 3: Desire Chain Layering

Phase 2 Section H captures desires in a structured framework (gain, be, do, save, avoid, feel, prove). This step restructures them into layered chains that reveal the DEEPEST motivation - the one that actually drives purchasing behavior.

**For each avatar, construct 2-3 desire chains:**

```
Surface desire: "I want to [tangible outcome]"
  -> So I can: [functional benefit]
    -> So I can: [emotional/identity benefit]
      -> Deepest core: [the real motivation - usually about identity, belonging, worthiness, or control]
```

**Finding the deepest core:** Keep asking "why does that matter?" until you hit an emotion that can't be reduced further. It's almost always one of: feeling worthy of love, reclaiming identity, belonging, being seen, having control over their life, or proving something to themselves.

**Identify the single CORE DESIRE per avatar** - the one deepest-core motivation that unifies all the surface desires. This becomes the emotional destination of every angle targeting this avatar.

**Output format:**

```
DESIRE CHAINS: [Brand Name]

[Avatar Name]:
Core Desire: "[the deepest motivation in one sentence]"

Chain 1: [Surface desire]
  -> [functional]
    -> [emotional]
      -> [deepest core]

Chain 2: ...

[Next Avatar]:
...
```

## Step 4: Alternative Solution Positioning

Phase 2's Competitive Context Per Avatar section (items 1-6) contains what alternatives the avatar has tried, what they liked, what they hated, and positioning opportunities. This step structures that data into "us vs them" attack angles.

**For each major alternative solution mentioned across avatars:**

```
Alternative: [Product/approach name]
What avatars liked: [specific positives in their language]
What avatars hated: [specific complaints in their language]
Why it ultimately fails: [connected to root cause - this alternative doesn't address X]
Our positioning against it: [one sentence framing that acknowledges the valid part and attacks the gap]
```

**Then synthesize into 2-4 "us vs them" narratives** - these are reusable attack angles that can appear in ads ("Why [alternative] isn't working for your [problem]") and funnel root cause sections ("You've probably tried [alternative]. Here's why it only treats the symptoms...").

**Output format:**

```
ALTERNATIVE SOLUTION POSITIONING: [Brand Name]

Individual Alternatives:
1. [Alternative name]
   Liked: [...]
   Hated: [...]
   Root cause gap: [...]
   Our positioning: [...]

2. ...

Attack Narratives (reusable):
1. "[Title]" - [1-2 sentence summary of the narrative]
   Works for avatars: [list]
   Best ad formats: [image ad, UGC, VSL intro, etc.]

2. ...
```

## Step 5: Angle Card Generation

This is where everything comes together. Each angle card combines one emotional trigger + one desire chain + one root cause framing + one mechanism framing + one alternative attack into a complete marketing angle.

**Read `references/angle-card-schema.md` for the full card structure.**

**How to generate angles:**

1. Start with the highest-scored cross-avatar emotional triggers (Step 2)
2. For each trigger, pair it with the desire chain that best matches (Step 3)
3. Identify the core feeling driving this angle (enum canonical source: `copywriting-guide §8.7 The Five Core Feelings Library`). One core feeling per angle; do not blend. Write it to the card's `Core Feeling` field (see `references/angle-card-schema.md`).
4. Select the root cause framing that connects to this trigger (Step 1) - the same root cause can be framed differently depending on which emotion you're leading with
5. Select the mechanism framing that resolves this specific trigger
6. Select the alternative attack that's most relevant to this trigger/desire combination (Step 4)
7. Determine the awareness stage this angle is best suited for (use the universal 3-value field: Problem-aware / Solution-aware / Product-aware, see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction)
8. **Run the Pain Matrix to determine Lead Framing Route.** The Pain Matrix routes which mechanism layer leads in downstream copy. It uses two inputs that are now both populated: trigger score (from Step 2) and awareness stage (from sub-step 7 above).

   **Inputs:**

   - **Pain intensity** (from Step 2 trigger scorecard): the primary trigger score for this angle, on the 1-10 scale (Frequency × Intensity × Actionability). High Pain = score >= 8 AND raw quotes show visceral language. Low Pain = score <= 6 OR raw quotes lack visceral specificity. Score 7 is borderline; default to Low unless raw quotes are unambiguously visceral.

   - **Awareness stage** (from sub-step 7 above): the universal 3-value field. High Awareness = Solution-aware OR Product-aware. Low Awareness = Problem-aware.

   **Visceral language definition (used in the High Pain gate):** raw quotes show one or more of:
   - Specific sensory detail (burning, throbbing, "like sandpaper")
   - Specific time anchor ("every morning at 6am", "3 hours into my shift")
   - Specific relational impact ("my wife wouldn't sleep in the same bed")
   - Specific identity threat ("I'm becoming my father")

   **Routing table:**

   | Pain intensity | Awareness | Lead Framing Route |
   |---|---|---|
   | High (score >= 8 + visceral) | Low (Problem-aware) | **UMP** (Unique Mechanism of Problem) - reader must feel the pain before solution lands |
   | High (score >= 8 + visceral) | High (Solution-aware or Product-aware) | **UMS** (Unique Mechanism of Solution) - reader knows the pain; needs reason to believe THIS solution |
   | Low (score <= 6) | High (Solution-aware or Product-aware) | **aspiration** - pain alone cannot drive action; lead with the post-product identity |
   | Low (score <= 6) | Low (Problem-aware) | **curiosity** (defer or recategorize) - this quadrant is rarely a strong angle. Either return to Step 2 to surface a more visceral trigger for this avatar, or recategorize the angle as cold-traffic discovery (in which case Lead Framing Route = curiosity and Pain Matrix routing does not apply downstream) |

   **Lead Framing Route population is MANDATORY for every angle card produced.** Every card must have a Lead Framing Route field populated with one of the 5 allowed values (UMP / UMS / aspiration / curiosity / N/A). This is the sentinel that signals to downstream consumers that the Pain Matrix step was run for this card.

   - **Deliberate routing decision:** UMP, UMS, aspiration, or curiosity, based on the routing table above.
   - **Deliberate skip:** "N/A" if the operator considered the Pain Matrix and chose to skip routing for this angle (e.g., the routing decision is genuinely ambiguous, or the angle explicitly tests a non-routed lead).

   The 5-value enum signals that the Pain Matrix step ran for this card: if Lead Framing Route is populated with any of these values, downstream consumers know sub-step 8 ran. Legacy versus defect is keyed on `Schema Version`, not on Lead Framing Route absence (see funnel-builder Step 0.5 and the schema's Card Structure). If Lead Framing Route is absent AND `Schema Version` is absent, the card is legacy (predates the versioned schema) and downstream consumers use standard defaults silently.

   If Lead Framing Route is absent but `Schema Version` is present, the card is current-schema and the missing field is a defect signal (sub-step 8 was skipped accidentally). Treat this as an integrity failure to be flagged in the angle roadmap's QA review.

   **Write the result to the angle card's Lead Framing Route field** (see `references/angle-card-schema.md` for the field's location in the schema).

   The Pain Matrix is NOT Schwartz-gated. It applies to every angle on every brand, regardless of whether the brand has completed Schwartz onboarding.

9. **Recommend a format from funnel-builder's format library.** Read `../funnel-builder/references/format-library.md` for the 9 named formats plus the Fake-Complaint sub-format. Select based on the angle's awareness stage and resistance level (category maturity + price-tier + alternative-stack). The format selection matrix in format-library.md drives this decision. Add the selected format name to the angle card's "Recommended Format" field.
10. **Consider multi-bio-marker pivots.** If the same root cause produces multiple felt symptoms (e.g., low testosterone manifests as energy/libido/recovery/focus/mood), identify the primary bio-marker for this angle and the secondary pivots. The Rosabella corpus showed that the same angle can run profitably across 4-7 different symptom entries when the underlying root cause + mechanism are unified. If the brand's product addresses only one symptom, mark this field "N/A - single-symptom angle."
11. Provide headline direction (2-3 example headlines, each passing `copywriting-guide §8.4 Hook Quality Checklist` - open loop, one specific claim, identity marker, specificity, first-person where brand voice allows).
12. Record which differentiator this angle leads on, in two card fields. Set **Lead Differentiator** to the exact Phase 1 Moat Map label/id the angle's core claim rests on, or to the sentinel "none (pure emotional/identity hook, no differentiation claim)" if the angle makes no differentiation claim, or to the sentinel "ungrounded (no Phase 1 Moat Map or derivable competitive analysis)" if the Step 0 fail-safe applies. Set **Moat Disposition** (re-derived from that differentiator's Moat Map row) to exactly one of LEAD / SUPPORT / AVOID / non-differentiator / ungrounded - use "non-differentiator" when Lead Differentiator is the none sentinel, and "ungrounded" when it is the ungrounded sentinel. Per the Step 0 invariant: an angle leading on a SUPPORT differentiator is a supporting or retargeting angle and is not eligible for priority 1; an angle leading on an AVOID differentiator is not produced; an ungrounded angle is supporting or retargeting only (not priority 1, cold_traffic: false) until the moat input is supplied.

(If `schwartz-applied.md` exists at the brand repo root, Step 6 below adds a structured awareness/sophistication framework on top of step 7 above. If it does not exist, treat the awareness stage choice as a generic strategic call.)

**Angle naming convention:** Each angle gets a short, evocative name that captures the core narrative. Think of it as the "campaign theme" name. Examples: "The Internal Sabotage," "The Dependency Trap," "The Stolen Identity," "The Silent Storm."

**How many angles to generate:**
- Minimum 5, maximum 15
- At least 2 angles per primary avatar
- At least 1 angle per awareness stage the brand targets
- Mix of emotional-led angles (lead with trigger) and logic-led angles (lead with root cause)

## Step 5.5: Lead Variants

Each angle card produces 3 POV variants. Same root cause, same mechanism, same alternative attack - different narrator. The variants are the testing surface: production runs all three, and the winning POV becomes the canonical version of the angle for that brand.

The three-lead rule comes from Zakaria Video17, 18, 28. The pattern observed across mature D2C testing data: the same angle delivered through three different narrators converts at different rates by 2-5x depending on the lead emotion + avatar pairing. Picking one POV without testing leaves performance on the table.

In the variant descriptions below, "awareness" is used in the universal 3-value sense (Problem-aware / Solution-aware / Product-aware, see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction). Operators with Schwartz onboarding should use the formal 6-value enum from Step 6 below as a stricter overlay; the variant fits described here are universal first-pass guidance.

### The Three POV Variants

**Variant 1: First-Person Sufferer**

A specific avatar-matched persona who is currently in the problem. Voice register: frustrated, exhausted, sometimes hopeful, sometimes vindicated. Opens with their lived experience. The reader's identification is direct ("this is me, right now").

Best for: problem-aware audiences, high-intensity triggers (score 8+), brands with avatars who actively self-narrate their struggle (mom-blogger demographic, fitness-failure demographic, chronic-condition demographic).

Avoid when: the avatar's emotional register is one of denial or shame about the problem, in which case Variant 3 (third-person witness) avoids the cringe-of-recognition that blocks engagement.

**Variant 2: First-Person Discoverer**

A specific persona who solved the problem and is sharing what worked. Voice register: relieved, evangelical, matter-of-fact, sometimes "I can't believe I figured this out." Opens with the after-state and works backward to the discovery.

Best for: solution-aware audiences, brands with strong transformation stories, retargeting campaigns where the audience is already warmed.

Avoid when: the audience is too early-stage (problem-aware with low resistance) and would dismiss a solved-it narrator as "easy for them to say."

**Variant 3: Third-Person Authority or Witness**

An external voice - a specialist, doctor, researcher, OR a partner/friend/family member who watched the transformation. Voice register: clinical (authority), observational (witness), often surprised by data. Opens with what they observed, not what they felt.

Best for: high-resistance audiences who distrust first-person testimonials, mature categories where readers have heard many competing claims, brands with named medical authority assets.

Avoid when: the brand voice is intentionally peer-to-peer (DTC mom-brand voice, lifestyle-influencer voice) and external authority would feel out of place.

### Variant Selection Procedure

For each angle card:

1. Identify the avatar's primary emotional register from Phase 2 Section F (Emotional Landscape).
2. Match Variant 1's voice to that register if the avatar self-narrates their struggle openly.
3. If the avatar denies, minimizes, or feels shame about the problem, default to Variant 3 as the lead variant.
4. Variant 2 is the cross-cut variant - it works for most audiences as a secondary test, but rarely as the primary variant unless the audience is solution-aware.
5. Each variant gets a specific narrator (name, age, situation), specific voice register, and specific lead opening line. These three details go on the angle card under the "Lead Variants" field (see `references/angle-card-schema.md`).

**Important:** every variant must apply `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)` - the narrator must be specific enough that the reader feels seen before any mechanism explanation lands. A generic "people are realizing..." narrator fails this rule regardless of which POV you pick.

(If `schwartz-applied.md` exists at the brand repo root, the Required Schwartz Move from Step 6 below adds a constraint to which variants fit best for the angle's awareness x sophistication intersection. If it does not exist, treat variant selection as a Phase 2 emotional-register call only.)

### Output

For each angle card, the Lead Variants section produces 9 specific lines: 3 narrators x 3 fields (narrator, voice register, lead opening). The angle-card-schema.md template specifies the exact format.

## Step 6: Schwartz Scoring (Awareness + Sophistication)

**Gating check (run before this section).** Look for `schwartz-applied.md` at the brand repo root (alongside `angle-roadmap.md`). If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

Every angle card carries two structural scores from Eugene Schwartz's Breakthrough Advertising framework. These scores determine downstream creative execution: which headline strategy, which advertorial section gets the most weight, which ad style fits the angle.

Score each angle on the two axes below, and add the scores as fields on the angle card. The scores are not optional. Every angle in the roadmap carries them.

### 6A: Awareness Stage

The awareness stage describes where the prospect sits relative to their problem and the available solutions. Schwartz defines five stages, ordered from least to most aware:

| Stage | The prospect... | Headline rule | Opening rule |
|-------|-----------------|---------------|--------------|
| Unaware | Does not know they have the problem | Lead with story, news, or a vivid scenario | Open with experience, not diagnosis |
| Problem Aware | Knows the problem; does not know solutions exist | Name the problem precisely; promise a mechanism | Open with the problem they already feel |
| Solution Aware | Knows solutions exist; not yet sold on any | Differentiate the mechanism from what they've heard | Open with what is different about THIS approach |
| Product Aware | Knows your product specifically; not yet committed | Lead with offer, proof, or unique mechanism | Open with the reason this product over alternatives |
| Most Aware | Is sold on category and ready to act | Lead with offer, social proof, or testimonial | Open with a specific reason to act now |

**The Solution-Switching variant.** Some brands' angle cards include "Solution-Switching" as a label. This is not a Schwartz stage; it is a compound state where the prospect knows competing products (Product Aware) AND is actively dissatisfied with them. Headline strategy follows Product Aware (name the alternative; differentiate; redefine the desire). Emotional register is closer to Problem Aware (frustration, betrayal). When you encounter this label, treat it as Product Aware + dissatisfaction, not as a separate stage.

### 6B: Sophistication Stage

The sophistication stage describes where the MARKET sits, not the prospect. It is the cumulative claims-fatigue of the audience based on how many competing brands have already pitched them. Schwartz's five stages:

| Stage | The market has... | Required move |
|-------|-------------------|---------------|
| 1 | Never heard the claim before | State the claim simply |
| 2 | Heard the claim; competing brands escalating it | Make a bigger claim |
| 3 | Heard escalating claims; starting to distrust them | Name a NEW MECHANISM that delivers the claim |
| 4 | Heard mechanism claims; distrusting those too | Prove the mechanism with named research, transparency, or specificity |
| 5 | Exhausted by the entire category | Identify with the exhaustion; elevate to a new dimension the category has not reached |

Most mature D2C categories sit at Stage 4 by default. Some sub-segments (research-driven optimizers, prescription refugees, late-stage skeptics) sit at Stage 5. New categories or genuinely under-marketed mechanisms can sit at Stage 3.

**Mismatch is the most common cause of weak angles.** A Stage 2 claim ("boost testosterone") in a Stage 4 market reads as another commodity claim. A Stage 5 identification move on a Stage 3 audience over-identifies with exhaustion they don't yet feel.

### 6C: Score Each Angle Card

For every angle card produced in Step 5, add these fields:

```
Awareness Stage: [Unaware / Problem Aware / Solution Aware / Product Aware / Most Aware / Solution-Switching]
Sophistication Stage Score: [Stage 1-5]
Required Schwartz Move: [one sentence describing the move that fits the intersection]
```

The "Required Schwartz Move" is the strategic instruction downstream skills (funnel-builder, ad-style-generator) inherit. Examples:

- Problem Aware + Stage 3: "Name the new mechanism, then prove it with one named study and a 4th-grade-level explanation."
- Product Aware (Solution-Switching) + Stage 4: "Concentrate on the specific competing product the prospect is using; demolish its limitation with mechanism + numbers."
- Most Aware + Stage 4: "Lead with partner-noticed testimonial. Avoid mechanism heaviness."
- Problem Aware + Stage 5: "Identify with category exhaustion ('you've tried everything'). Then name a dimension the category has not reached."

### 6D: Four-Hole Pressure Test

Run this on every angle card before finalizing. It catches the most common structural failures.

1. **Desire-mechanism gap.** Does the mechanism in the card actually deliver the core desire? There must be a bridge sentence (or the option for one) connecting mechanism to desire. Example bridge: "When cortisol drops, your body produces testosterone again, and your wife notices the man she married." If no bridge exists or could exist, the angle stalls in proof.

2. **Awareness-headline mismatch.** Does the headline rule for the angle's awareness stage match the headline directions in the card? An Unaware angle with a Problem Aware headline burns half the prospects.

3. **Sophistication-claim mismatch.** Is the claim style appropriate for the sophistication score? A Stage 2 claim in a Stage 4 market is the most common failure. A Stage 5 identification move on a Stage 3 audience is the second most common.

4. **Alternative attack specificity.** Is the Alternative Attack named specifically (a specific competitor mechanism, a specific product limitation, a specific dose problem)? Or is it generic ("most supplements don't work")? At Stage 4+, generic concentration fails. The attack must name a target the prospect has actually encountered.

If any pressure test fails, revise before finalizing the angle.

**If this brand has not yet completed Schwartz onboarding:** see `_frameworks/breakthrough-advertising-brand-onboarding.md` in `contextarchitect/context-architect-brands` for the 30-60 minute scoped session that produces `schwartz-applied.md`.

## Step 7: Prioritization & Output

### Prioritization

Rank angles by testing priority using these criteria:

1. **Trigger score, gated by moat disposition** - higher-scored triggers get priority, but a high score does not override the Step 0 invariant. Priority 1 and primary cold-traffic budget go only to angles that lead on a LEAD differentiator, or on a non-differentiator emotional/identity driver when moat grounding exists and the claim has been checked against the Moat Map. An angle leading on a SUPPORT differentiator is eligible only for supporting or retargeting slots regardless of its trigger score; mark it cold_traffic: false. An angle leading on an AVOID differentiator is not in the roadmap. An ungrounded angle (no Moat Map or derivable competitive analysis, per the Step 0 fail-safe) is eligible only for supporting or retargeting slots, cold_traffic: false, until the moat input is supplied.
2. **Avatar coverage** - angles that work across multiple avatars get priority
3. **Awareness stage coverage** - ensure the top 5 angles cover at least 2 awareness stages
4. **Format diversity** - the top 5 should include at least one image ad angle, one UGC/video angle, and one advertorial angle
5. **Alternative attack diversity** - avoid putting all top angles against the same alternative
6. **Structural-move diversity (only if `schwartz-applied.md` exists at the brand repo root):** avoid putting all top angles at the same Schwartz move (e.g., five Stage 4 mechanism-naming angles)

First assign each angle a Slot Type (primary / supporting / retargeting) using the moat gate in criterion 1, then rank Testing Priority 1-N **within** each Slot Type queue. Testing Priority is a within-queue ordering; rank 1 is not by itself a primary slot or a cold-traffic grant. The primary cold-traffic budget is assigned only to angles with Slot Type primary and Cold Traffic Eligible true; downstream consumers select the primary/cold-traffic angle by reading those two fields, never the bare rank number. Under the Step 0 fail-safe, every angle is supporting or retargeting, so the primary queue is empty and no angle is primary or cold-traffic eligible regardless of its rank.

### Output: Brand Angle Roadmap Document

Deliver the complete roadmap as a single markdown file using `create_file` + `present_files`. Structure:

```
# Brand Angle Roadmap: [Brand Name]
Generated: [date]
Inputs: Phase 1 ([date]), Phase 2 ([date]), Product docs

## 0. Moat Grounding Notice
[Include this notice ONLY when the run is ungrounded (Step 0 fail-safe: no Phase 1 Moat Map and no Phase 1 competitive/differentiation analysis to derive dispositions from). Omit it entirely when grounding exists. When present, place it here, above Section 1, so the operator sees it first:

> NOTICE - NO MOAT GROUNDING. No Phase 1 Moat Map was found and there was no competitive/differentiation analysis to derive one from. Every angle's Moat Disposition is "ungrounded", the primary queue is empty, and no angle is eligible for a priority-1 slot or cold-traffic budget. These angles are usable as supporting/retargeting tests only. To prioritize for cold traffic, supply the Phase 1 Business Validation report with its Positioning Guardrails / Moat Map, or an inline Moat Map.]

## 1. Root Cause Narrative
[Full output from Step 1A]

## 2. Solution Mechanism Narrative
[Full output from Step 1B]

## 3. UGC Creator Brief
[Full output from Step 1C]

## 4. Emotional Trigger Scorecard
[Full output from Step 2]

## 5. Desire Chains
[Full output from Step 3]

## 6. Alternative Solution Positioning
[Full output from Step 4]

## 7. Angle Cards
[All angle cards from Step 5, ordered by testing priority.
Each card carries: Recommended Format (from funnel-builder format-library.md), Lead Variants (3 POV variants from Step 5.5), Multi-Bio-Marker Pivots (when applicable).
If `schwartz-applied.md` exists at the brand repo root, each card also carries the structural fields produced in Step 6.]

## 8. Testing Roadmap
[Top 5 angles to test first, with recommended:
- Lead Differentiator, Moat Disposition, Slot Type, Cold Traffic Eligible (the durable moat fields, carried verbatim from each angle card)
- Format per angle (from format-library.md)
- Lead variant priority (which of the 3 POVs to test first)
- Bio-marker priority (when angle has multi-bio-marker pivots)
- Budget allocation suggestion (% split across angles). Cold-traffic budget may be allocated only to angles with Slot Type primary and Cold Traffic Eligible true; a top Testing Priority rank does not by itself qualify an angle for cold-traffic budget. Under the Step 0 fail-safe (all angles ungrounded), no angle qualifies for cold-traffic budget.]

## 9. Creative Engine Integration
[Angle Registry - structured data for each angle, formatted
for import into Creative Engine's angle entity table. Each entry carries the
durable moat fields so the registry can re-check disposition: lead_differentiator,
moat_disposition (LEAD / SUPPORT / AVOID / non-differentiator / ungrounded), slot_type
(primary / supporting / retargeting), cold_traffic (true / false).]
```

### After Delivery

```
ANGLE ROADMAP COMPLETE: [Brand Name]

Produced:
  - Root cause narrative (with analogy)
  - Mechanism narrative (with product mapping)
  - UGC creator brief (5 components for spoken delivery)
  - [N] emotional triggers scored and ranked
  - [N] desire chains across [N] avatars
  - [N] alternative solutions analyzed
  - [N] angle cards defined, each with Recommended Format, 3 Lead Variants, and Multi-Bio-Marker Pivot consideration [if `schwartz-applied.md` exists at the brand repo root, append: plus awareness + sophistication scores from Step 6]
  - Testing roadmap with top 5 priorities

Next steps:
  -> Use angles with ad-style-generator: "Create a [STYLE] ad using angle [NAME]"
  -> Use angles with funnel-builder: "Build an advertorial using angle [NAME]"
  -> Import Angle Registry into Creative Engine (when angle entity is implemented)
  -> After ad testing: retire losing angles, double down on winners,
     build funnels for validated angles
```

## Quality Checklist

Before delivering the roadmap, verify:

**Root Cause & Mechanism:**
- [ ] Mechanism derived via the 6-step process (one throbbing pain, named villain, one-to-one product-to-villain match)
- [ ] Chosen mechanism passes the 5-criterion strength test (believable, specific, novel, singular, emotionally reframing); no candidate failing 2+ criteria was kept
- [ ] If the product has no genuinely unique mechanism, the fallback ladder was applied in preference order (problem-first before combination before process before origin before category position)
- [ ] HARD RULE honored: the mechanism is grounded in real product facts, not fabricated (gap flagged to operator if the ladder could not reach a true rung)
- [ ] Root cause analogy is visual, externalizes blame, implies a fix
- [ ] 4th-grade explanation contains zero jargon
- [ ] Mechanism analogy extends or mirrors the root cause analogy naturally
- [ ] Product-to-mechanism mapping covers all key features/ingredients
- [ ] Copywriting sections could be dropped into an advertorial without rewriting
- [ ] No em dashes in any copywriting section

**Emotional Triggers:**
- [ ] Scores are based on quote frequency and intensity, not assumption
- [ ] Cross-avatar triggers identified (these are the highest-value angles)
- [ ] At least 5 distinct triggers scored

**Desire Chains:**
- [ ] Each chain goes at least 3 levels deep (surface -> functional -> emotional -> core)
- [ ] Core desire per avatar is identified and distinct from surface desires
- [ ] Core desires across avatars share a theme but aren't identical copies

**Alternative Positioning:**
- [ ] Each alternative's "root cause gap" connects to the Step 1 root cause narrative
- [ ] Attack narratives are specific enough to become ad headlines
- [ ] Attack narratives acknowledge what the avatar liked about the alternative (not dismissive)

**Angle Cards:**
- [ ] Minimum 5 angles defined
- [ ] At least 2 awareness stages covered in top 5
- [ ] Each angle has a clear name and one-sentence summary
- [ ] No two angles are the same trigger + desire combination
- [ ] Recommended ad formats are specified per angle
- [ ] Recommended Format (from `../funnel-builder/references/format-library.md`) is specified per angle, with rationale referencing the format selection matrix
- [ ] Core feeling identified and written to the card's `Core Feeling` field (enum canonical source `copywriting-guide §8.7 The Five Core Feelings Library`)
- [ ] Headline directions pass `copywriting-guide §8.4 Hook Quality Checklist`
- [ ] Multi-Bio-Marker Pivots field populated (specific pivots OR "N/A - single-symptom angle")

**Moat Map scan (mechanical; run against the Phase 1 Moat Map before delivering):**
- [ ] For every angle card, the Lead Differentiator field names the exact Phase 1 Moat Map differentiator (or the non-differentiator sentinel), and the recorded Moat Disposition is re-derived from that differentiator's row in the Phase 1 Moat Map - not trusted from the card's self-declared tag
- [ ] For every priority-1 or primary-budget angle, the differentiator it actually rests on is identified by reading the angle's core claim, not by trusting the card's tag, then checked against the Phase 1 Moat Map. A "none / non-differentiator" classification holds only if the angle genuinely makes no differentiation claim AND moat grounding exists to confirm it. A primary angle that on reading rests on a SUPPORT or AVOID differentiator is a finding even if the card tags it LEAD or none.
- [ ] If no Moat Map or derivable competitive analysis exists (Step 0 fail-safe), no angle is ungrounded-and-primary: every angle's Moat Disposition is "ungrounded", Slot Type is supporting or retargeting, and Cold Traffic Eligible is false. "non-differentiator" is used as a primary-eligible classification only when grounding exists; an ungrounded angle mis-tagged "non-differentiator" to reach a primary slot is a finding.
- [ ] No priority-1 or primary cold-traffic-budget angle leads on a SUPPORT or AVOID differentiator (a high trigger score is never a waiver)
- [ ] No angle in the roadmap leads on an AVOID differentiator
- [ ] Every SUPPORT-led angle has Slot Type supporting or retargeting and Cold Traffic Eligible false (registry field cold_traffic: false)
- [ ] The durable fields (Lead Differentiator, Moat Disposition, Slot Type, Cold Traffic Eligible) are carried into the Section 8 testing roadmap and the Section 9 Creative Engine registry output, so downstream consumers can re-check disposition

This scan checks every angle by re-deriving its lead differentiator's disposition from the Phase 1 Moat Map, regardless of trigger score and regardless of the card's self-declared tag. Any angle whose lead framing rests on a SUPPORT or AVOID differentiator and sits in a primary slot is a finding to resolve before delivery.

**Step 1C UGC Creator Brief:**
- [ ] Hook line is 5-9 words and would survive sound-off scroll-stop
- [ ] Identity reveal establishes specific narrator (name, age, situation)
- [ ] Root cause script is conversational (not written-copy register)
- [ ] Mechanism script continues the root cause analogy
- [ ] Close prompt is hand-off, not sales pitch
- [ ] Total runtime is 60-90 seconds spoken
- [ ] Recommended creator profile matches the avatar's demographics

**Step 5.5 Lead Variants:**
- [ ] Every angle card has 3 lead variants populated
- [ ] Variant 1 (First-Person Sufferer) has specific narrator, voice register, and lead opening
- [ ] Variant 2 (First-Person Discoverer) has specific narrator, voice register, and lead opening
- [ ] Variant 3 (Third-Person Authority or Witness) has specific narrator, voice register, and lead opening
- [ ] All three variants apply `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)` - narrator specificity is sufficient for identification

**Schwartz Scoring (Step 6) (only if `schwartz-applied.md` exists at the brand repo root):**
- [ ] Every angle has an Awareness Stage assigned
- [ ] Every angle has a Sophistication Stage Score (1-5)
- [ ] Every angle has a Required Schwartz Move articulated in one sentence
- [ ] Four-hole pressure test passed on every angle (desire-mechanism gap, awareness-headline match, sophistication-claim match, alternative attack specificity)
- [ ] If any angle uses the "Solution-Switching" label, the card notes it is treated as Product Aware + dissatisfaction

## What This Skill Does NOT Do

- Does not run Deep Research (generates a focused mini-prompt only if root cause is unknown)
- Does not create ads or funnels (produces the strategic input for skills that do)
- Does not replace Phase 2 avatar research (reads and restructures its output)
- Does not generate images, copy, or video (produces narrative frameworks and the UGC creator brief that downstream skills build on)
- Does not record or produce video itself (the UGC creator brief is the source script; actual video production happens via UGC creators or video-script-generator skill)
- Does not select the Recommended Format autonomously when the format library decision is genuinely ambiguous - flags ambiguity and asks the user
- Does not commit files to GitHub
