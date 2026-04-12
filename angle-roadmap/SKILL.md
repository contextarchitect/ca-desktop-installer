---
name: angle-roadmap
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

The ad-style-generator and funnel-builder skills both require knowing WHAT to say (the angle), not just WHO to say it to (the avatar) and HOW to say it (the copywriting guide). Without defined angles, the quality of ads and funnels depends entirely on the operator's marketing instinct. This skill captures that instinct as a structured, reusable asset.

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
STEP 1: ROOT CAUSE & MECHANISM NARRATIVES
  -> Develop the scientific explanation, simplification, analogy, and copywriting section
  -> For root cause AND solution mechanism

STEP 2: EMOTIONAL TRIGGER SCORING
  -> Extract from Phase 2, consolidate, score, rank across avatars

STEP 3: DESIRE CHAIN LAYERING
  -> Restructure Phase 2 desires into "I want -> so I can -> deepest core" chains

STEP 4: ALTERNATIVE SOLUTION POSITIONING
  -> Structure from Phase 2 competitive context into attack angles

STEP 5: ANGLE CARD GENERATION
  -> Combine Steps 1-4 into structured angle cards (5-15 per brand)

STEP 6: PRIORITIZATION & OUTPUT
  -> Rank angles by testing priority, deliver as Brand Angle Roadmap document
```

## Step 1: Root Cause & Mechanism Narratives

This is the most important step. Every advertorial depends on sections 4-6 (root cause -> consequences -> mechanism), and every ad depends on being able to communicate WHY the problem exists and WHY this solution works - in a way that a tired person scrolling at midnight understands instantly.

### 1A: Root Cause Narrative

Ask the user (or extract from documents): **What is actually causing the problem your product solves?**

If the user knows the root cause, develop the narrative. If they don't, generate a focused research prompt (see `references/root-cause-research-prompt.md`).

**Four layers of the root cause narrative:**

1. **Scientific explanation** - the factual, evidence-based explanation of why the problem exists. Include the key contributing factors. This doesn't appear in marketing copy directly, but it's the foundation everything else is built on. Cite credible sources where possible.

2. **4th-grade explanation** - rewrite the scientific explanation so a child could understand it. Strip all jargon. Use only common words. If you have to use a technical term, define it immediately in plain language. This is the version that gets adapted into marketing copy.

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

2. **4th-grade explanation** - plain language version. "It does X, which stops Y, which lets Z happen again."

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

**Output format:**

```
EMOTIONAL TRIGGER SCORECARD: [Brand Name]

Cross-Avatar Triggers (appear across multiple avatars):
1. [Trigger Name] - [Score]/10
   Avatars affected: [list]
   Key quotes: ["...", "...", "..."]

2. [Trigger Name] - [Score]/10
   ...

Avatar-Specific Triggers:
[Avatar Name]:
1. [Trigger] - [Score]/10 - ["quote"]
2. [Trigger] - [Score]/10 - ["quote"]
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
3. Select the root cause framing that connects to this trigger (Step 1) - the same root cause can be framed differently depending on which emotion you're leading with
4. Select the mechanism framing that resolves this specific trigger
5. Select the alternative attack that's most relevant to this trigger/desire combination (Step 4)
6. Determine the awareness stage this angle is best suited for
7. Recommend ad formats and funnel types based on awareness stage + emotional intensity

**Angle naming convention:** Each angle gets a short, evocative name that captures the core narrative. Think of it as the "campaign theme" name. Examples: "The Internal Sabotage," "The Dependency Trap," "The Stolen Identity," "The Silent Storm."

**How many angles to generate:**
- Minimum 5, maximum 15
- At least 2 angles per primary avatar
- At least 1 angle per awareness stage the brand targets
- Mix of emotional-led angles (lead with trigger) and logic-led angles (lead with root cause)

## Step 6: Prioritization & Output

### Prioritization

Rank angles by testing priority using these criteria:

1. **Trigger score** - higher-scored triggers get priority
2. **Avatar coverage** - angles that work across multiple avatars get priority
3. **Awareness stage coverage** - ensure the top 5 angles cover at least 2 awareness stages
4. **Format diversity** - the top 5 should include at least one image ad angle, one UGC/video angle, and one advertorial angle
5. **Alternative attack diversity** - avoid putting all top angles against the same alternative

### Output: Brand Angle Roadmap Document

Deliver the complete roadmap as a single markdown file using `create_file` + `present_files`. Structure:

```
# Brand Angle Roadmap: [Brand Name]
Generated: [date]
Inputs: Phase 1 ([date]), Phase 2 ([date]), Product docs

## 1. Root Cause Narrative
[Full output from Step 1A]

## 2. Solution Mechanism Narrative
[Full output from Step 1B]

## 3. Emotional Trigger Scorecard
[Full output from Step 2]

## 4. Desire Chains
[Full output from Step 3]

## 5. Alternative Solution Positioning
[Full output from Step 4]

## 6. Angle Cards
[All angle cards from Step 5, ordered by testing priority]

## 7. Testing Roadmap
[Top 5 angles to test first, with recommended:
- Ad format per angle
- Funnel type per angle (if angle is validated by ad performance)
- Budget allocation suggestion (% split across angles)]

## 8. Creative Engine Integration
[Angle Registry - structured data for each angle, formatted
for import into Creative Engine's angle entity table]
```

### After Delivery

```
ANGLE ROADMAP COMPLETE: [Brand Name]

Produced:
  - Root cause narrative (with analogy)
  - Mechanism narrative (with product mapping)
  - [N] emotional triggers scored and ranked
  - [N] desire chains across [N] avatars
  - [N] alternative solutions analyzed
  - [N] angle cards defined
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
- [ ] Recommended ad formats and funnel types are specified per angle

## What This Skill Does NOT Do

- Does not run Deep Research (generates a focused mini-prompt only if root cause is unknown)
- Does not create ads or funnels (produces the strategic input for skills that do)
- Does not replace Phase 2 avatar research (reads and restructures its output)
- Does not generate images or copy (produces narrative frameworks that copy is built from)
- Does not commit files to GitHub
