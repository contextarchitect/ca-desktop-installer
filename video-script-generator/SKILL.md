---
name: video-script-generator
description: "Generate high-converting direct-response video ad scripts using the Video Script Framework. Produces scripts across seven formats (Yap/Voiceover, Podcast, Animation, Static, UGC, AI Slop) with awareness-stage-specific structures, proper beat sequencing, villain framing, and humanization rules. Trigger on: video script, ad script, yap script, voiceover script, podcast script, AI slop, UGC script, talking head script, animation script."
---

# Video Script Generator Skill

## Metadata
- **Skill Name:** video-script-generator
- **Version:** 1.1.0
- **Category:** Creative / Copywriting
- **Dependencies:** None (standalone) | Enhanced with: avatar-research, brand-analyzer, copywriting-guide, angle-roadmap
- **Triggers:** "video script", "ad script", "write a script", "yap script", "voiceover script", "podcast script", "AI slop", "video ad", "talking head script", "UGC script"

---

## Purpose

Generate high-converting direct-response video ad scripts using the Video Script Framework methodology. This skill produces scripts across seven formats with **awareness-stage-specific structures**, proper beat sequencing, villain framing, and humanization rules.

**Core principle:** Awareness stage determines script structure. A problem-unaware script is structurally different from a product-aware script. Get the stage right first, then select format.

---

## When to Use This Skill

**Trigger on:**
- "Write a video script for [product/brand]"
- "Create a yap/voiceover script about [topic]"
- "Generate an AI slop script"
- "Write a podcast-style ad"
- "Create a UGC testimonial script"
- "Video ad for [avatar/audience]"
- "Talking head script"
- "Animation script for [product]"
- "Script for [awareness stage] audience"

**Also trigger when:**
- User has completed avatar research and wants to create video content
- User has an angle roadmap and wants scripts for specific angles
- User asks for "ad creative" and video is the implied format

---

## Required Inputs (Elicit if Missing)

Before generating any script, ensure you have:

### Minimum Viable Inputs

1. **Awareness stage** (MOST IMPORTANT - ask first)
   - Problem-unaware: Don't know they have the problem or the cause
   - Problem-aware: Know they have the problem, don't know the real cause
   - Solution-aware: Know the solution category (e.g., "shampoo"), but their attempts haven't worked
   - Product-aware: Know your brand, visited site, haven't converted

2. **Product name + mechanism** - What it does AND how it does it
   - Bad: "Regrowth+ helps with hair loss"
   - Good: "Regrowth+ uses chelating agents to strip mineral buildup from the scalp, then rosemary and caffeine to stimulate regrowth"

3. **Target avatar** - Who this is for, their emotional state, what they've tried
   - Bad: "Women with hair loss"
   - Good: "Expat women 25-40 in GCC, been there 1-3 years, tried supplements and diet changes, frustrated that nothing works"

4. **The villain** - The specific enemy the product defeats
   - Bad: "damage" or "toxins"
   - Good: "Calcium and magnesium deposits from hard water that build up on the scalp and block follicles"

5. **Format** - Which script type to generate
   - Options: Yap/Voiceover Monologue, Podcast, Animation, Static, UGC, AI Slop

### Optional Inputs (Enhance Quality)
- Avatar pain map (surface -> hidden pain -> core desire -> identity threat)
- Geographic/market context (GCC, UK, US)
- Brand voice characteristics
- Specific angle or hook direction
- Video length target (15-30s, 45-60s, 60-90s, 2-4min)
- CTA type (shop direct, quiz-first, lead capture)
- Hero ingredients list (for AI Slop format)
- False solutions they've tried (for problem-aware scripts)
- Guarantee details (for product-aware scripts)
- Payment plan details (for product-aware scripts)

---

## Awareness Stage Architecture (PRIMARY FRAMEWORK)

**This is the most important section.** Script structure varies dramatically by awareness stage. Determine stage FIRST, then apply the appropriate template.

### Stage 1: PROBLEM-UNAWARE

**Avatar state:** Doesn't know they have the problem, or doesn't know the real cause exists.

**Script job:** Introduce a hidden truth they've never heard. Create recognition.

**Hook strategy:** Hidden truth reveal, "Nobody tells you" framing

**Beat structure:**
```
[HOOK: Hidden truth promise] -> [Context they recognize] -> [The thing nobody mentions] ->
[Problem introduction] -> [Why it happens] -> [VILLAIN REVEAL] ->
[Product as the solution built for this] -> [Mechanism in simple terms] -> [CTA: Quiz]
```

**Example hook patterns:**
- "When you move to the Gulf, people tell you a lot of things. Nobody tells you what it does to your hair."
- "There's something in your shower that nobody warned you about."
- "If you've been here more than six months and your hair feels different, you're not imagining it."

**Product entry:** 65-70% mark. More education needed before product.

**CTA type:** Quiz (diagnostic) - they need to discover if this applies to them.

---

### Stage 2: PROBLEM-AWARE

**Avatar state:** Knows they have the problem, has tried to fix it, doesn't know the real cause.

**Script job:** Eliminate false causes, reveal the true villain, provide the "aha" moment.

**Hook strategy:** False solution elimination + open loop, analogy setup

**Beat structure:**
```
[HOOK: Promise of hidden answer] -> [FALSE CAUSE ELIMINATION: diet, stress, hormones, supplements] ->
[ANALOGY: concrete visual for the real problem] -> [VILLAIN REVEAL with specifics] ->
[Why other solutions fail] -> [Product positioned for this specific problem] ->
[Mechanism in human language] -> [Result timeframe] -> [CTA: Quiz]
```

**Example hook patterns:**
- "There's a reason nothing you've tried has worked. And most people never figure out what it is."
- "It might not be your diet. It might not be your stress. It might not be your hormones. And here's the one that surprises people most - it might not even be a deficiency."

**REQUIRED: Include an analogy.** The villain must be visualizable.
- Good: "Think about watering a plant. You pour water in every day. But under the surface, concrete is slowly covering the roots. The water never reaches them."
- Bad: Just explaining the science without a mental picture.

**Product entry:** 60-65% mark.

**CTA type:** Quiz (diagnostic) - they want to confirm this is their situation.

---

### Stage 3: SOLUTION-AWARE

**Avatar state:** Knows the solution category (e.g., hair growth shampoo), has tried products in that category, they haven't worked.

**Script job:** Explain why their solution category attempts failed. Position your product as the version built for their specific context.

**Hook strategy:** Contrarian industry claim, failed solution reframe

**Beat structure:**
```
[HOOK: Your solution category isn't broken, it's mismatched] ->
[Why every product in this category was built for somewhere else] ->
[What's different about your context (water, climate, etc.)] ->
[VILLAIN: The invisible thing those products can't address] ->
[Product as "first one built for this"] -> [Mechanism] -> [Result] -> [CTA: Quiz]
```

**Example hook patterns:**
- "If you live in the Gulf and none of your hair growth shampoos are working, they're probably not broken. They're just not built for your water."
- "You bought a shower filter specifically for your hair. And it did absolutely nothing. Why?"
- "Every hair growth shampoo you've tried was formulated in Europe or the US. For soft water. They weren't designed for what comes out of your tap here."

**Product entry:** 55-60% mark. Less education needed, faster to product.

**CTA type:** Quiz or direct shop (depends on price point).

---

### Stage 4: PRODUCT-AWARE

**Avatar state:** Knows your brand, has visited your site, hasn't bought. Sitting on the fence.

**Script job:** Collapse the final objection. Remove friction. This is NOT about education.

**Hook strategy:** Direct accusation, objection acknowledgment, risk reversal

**Beat structure:**
```
[HOOK: Direct acknowledgment they know you] -> [Name the hesitation] ->
[OBJECTION COLLAPSE: price, "will it work for me", inaction] ->
[Risk reversal: guarantee, payment plans] -> [Urgency without hype] -> [CTA: Direct purchase]
```

**Example hook patterns:**
- "You've seen Regrowth+ before. You know what it does. You just haven't bought it yet."
- "Most hair products make you a promise. Try it for 30 days. See the difference. Trust us. And if it doesn't work, good luck getting your money back. We do it differently."

**CRITICAL RULES for Product-Aware:**
- Do NOT re-educate on the problem. They know.
- Do NOT re-explain the mechanism. They've read it.
- DO address specific objections: price, "will it work for me", inaction
- DO lead with risk reversal (guarantee, payment split)
- DO use direct language ("You just haven't bought it yet")

**Product entry:** Can appear in first 30%. Education phase is skipped.

**CTA type:** Direct purchase with guarantee emphasis.

---

## Hook Construction Rules

**The hook must create an open loop the viewer cannot close without watching.**

### Hook Anti-Patterns (AVOID)
❌ Slow, reflective openings: "You've been eating better. Taking the supplements..."
❌ Starting with the problem statement: "Hair loss is frustrating..."
❌ Leading with the product: "Regrowth+ is a new shampoo..."
❌ Generic claims: "What if there was a better way..."

### Hook Patterns by Stage

| Stage | Hook Pattern | Example |
|-------|-------------|---------|
| Problem-Unaware | Hidden truth + withhold | "Nobody tells you what [context] does to your [problem area]. You're about to find out." |
| Problem-Aware | False cause elimination + promise | "There's a reason nothing you've tried has worked. And it's got nothing to do with your diet, stress, or genetics." |
| Solution-Aware | Contrarian + question | "You bought [solution] specifically for [problem]. And it did absolutely nothing. Why?" |
| Product-Aware | Direct accusation | "You've seen [Brand] before. You know what it does. You just haven't bought it yet." |

### Hook Quality Test
Ask: "Does this hook make a promise AND withhold the answer?"
- If yes -> good hook
- If no -> rewrite

---

## Product Introduction Sequence

When introducing the product, follow this exact order:

1. **Product name + positioning**
   - "Regrowth+ is the first shampoo in the Gulf specifically engineered for hard water conditions in this region."

2. **Geographic authenticity**
   - "And it's actually made here."

3. **Mechanism in human language** (NOT clinical terms)
   - ❌ "The mechanism is called chelation."
   - ✅ "The way it works is simple. It contains agents that bind directly to the mineral deposits sitting on your follicle and pull them away completely. Every single wash."

4. **What happens next**
   - "Once the follicle is clear, rosemary and caffeine restore blood circulation and wake up the growth cycle."

5. **Benefit timeframe**
   - "Most people notice less shedding within two weeks."

---

## Format Selection Guide

**After determining awareness stage**, select format:

```
PROBLEM-UNAWARE:
├── Voiceover Monologue (60-90s) -> Hidden truth reveal
├── Podcast Two-Host (2-4min) -> Guessing game, education
├── AI Slop -> Personified villain chain
└── Animation -> Character discovers the truth

PROBLEM-AWARE:
├── Voiceover Monologue (60-90s) -> False solution exhaustion + analogy (MOST COMMON)
├── UGC Testimonial -> Personal discovery story
├── AI Slop Chain of Blame -> Body parts pass blame to villain
└── Animation -> Villain gloats, hero arrives

SOLUTION-AWARE:
├── Voiceover Monologue (45-75s) -> Contrarian industry claim
├── Animation -> Product as hero in mechanism story
└── Static Reverse Psychology -> Satirical "keep using what doesn't work"

PRODUCT-AWARE:
├── Voiceover Monologue (45-60s) -> Objection collapse, risk reversal (MOST COMMON)
├── UGC Testimonial -> Social proof, result confirmation
└── Static -> Guarantee-forward, direct CTA
```

---

## Format-Specific Rules

### Voiceover Monologue (Primary Format)

The most common and versatile format. No on-camera talent required.

**Structure:**
- No timestamps, no columns
- Line breaks = breath beats (no separate pacing notes needed)
- Visual Direction Notes at END in separate block
- Narrator speaks as knowledgeable insider, not as avatar

**Line break rule:** If the script is written correctly, line breaks ARE the pacing. Short lines = slow down. Flowing sentences = speed up. Do NOT include separate "Pacing Notes" sections.

**Visual Direction Notes:** Include after the script as a separate section. Brief, practical guidance for each major beat.

### Podcast Two-Host

- HOST: Knowledgeable insider
- GUEST: Avatar proxy (confused, asks audience questions)
- Tension is the guessing game
- Product can enter at 75% through guest's question

### Animation / Character

- CHARACTER NAME: dialogue format
- Villain gets moment to gloat before hero arrives
- Stage directions in *[italics and brackets]*

### Static / Reverse Psychology

- HEADLINE: Satirical instruction
- Step-by-step wrong behavior with checkmark
- THE FLIP: Reframe + product + CTA

### UGC Emotional Testimonial

- 80% before-state suffering and identity
- 20% product (almost incidental)
- Product is vessel for transformation already undergone

### AI Slop / Personified Chain

- Each element speaks in first-person
- Body parts complain, pass blame
- Villains CONFESS and gloat
- Heroes arrive and announce function
- Separated blocks (--- between elements)

Sub-types:
- Blame-Something-Else: complaints -> villain gloats -> heroes save
- Chain of Blame: each element passes blame to next until villain cornered
- Investigation: mystery framing, "I'm trying to figure out why"

---

## Humanization Rules

**FORBIDDEN VOCABULARY - Never use:**
delve, unlock, revolutionize, transformative, embark, journey, wellness, synergy, harness, leverage, elevate, game-changing, groundbreaking, holistic, comprehensive solution, "the mechanism is called"

**REQUIRED:**
- Contractions always (didn't, it's, I've, you're)
- Vary sentence length dramatically (short. Short. Then one that earns its length because it carries weight.)
- Sensory specifics (what they see, feel, find on their pillow)
- One idea per sentence maximum
- Human phrasing: "The way it works is simple" not "The mechanism is called chelation"

**TEST:** Could a real person say this to a friend at dinner?

---

## CTA Rules by Awareness Stage

| Stage | CTA Type | Structure | Example |
|-------|----------|-----------|---------|
| Problem-Unaware | Quiz | Discovery framing | "Take the 60-second Hard Water Hair Quiz. Find out if this is what's been happening to you." |
| Problem-Aware | Quiz | Confirmation framing | "Take the quiz. Find out if your water is behind what you've been experiencing." |
| Solution-Aware | Quiz or Shop | Diagnosis framing | "Find out exactly what's happening on your scalp." |
| Product-Aware | Direct Shop | Risk reversal + urgency | "It works or you don't pay. Link below." |

**ALWAYS include benefit timeframe in or near CTA:**
- ✅ "Most people notice less shedding within two weeks."
- ❌ "Try it today."

---

## Output Format

Deliver scripts in this structure:

```markdown
## SCRIPT: [BRAND]_[FORMAT]_[AWARENESS]_V[N]

**Format:** [Format name]
**Length:** [Target duration]
**Awareness stage:** [Stage + one-line description of avatar state]
**Avatar:** [One-line description]
**Villain:** [Named villain]
**Hook type:** [From taxonomy]
**CTA type:** [Quiz/Shop + framing]

---

[SCRIPT CONTENT HERE]
[Line breaks as breath beats]
[No timestamps unless animation studio delivery]
[CHARACTER: dialogue for animation/podcast]
[Separated blocks for AI Slop]

---

#### Visual Direction Notes

[Beat-by-beat visual guidance]
[What's on screen for each major section]
[Keep brief and practical]
```

**Note:** Do NOT include separate "Pacing Notes" sections. Line breaks handle pacing.

---

## Quality Checklist (Run Before Delivery)

Every script must pass ALL of these:

**Awareness Stage Alignment:**
- [ ] Script structure matches the awareness stage template
- [ ] Hook pattern is appropriate for the stage
- [ ] Product entry timing is correct for the stage
- [ ] CTA type matches the stage

**Structure:**
- [ ] Hook creates open loop in first 3 seconds
- [ ] Hook makes a promise AND withholds the answer
- [ ] Villain named and given presence before product
- [ ] Product introduction follows the 5-step sequence
- [ ] CTA contains benefit timeframe

**Copy:**
- [ ] Zero forbidden vocabulary
- [ ] All contractions present
- [ ] Sentence lengths vary dramatically
- [ ] Every factual claim is specific (numbers, mechanisms)
- [ ] Mechanism explained in human language, not clinical terms
- [ ] Passes "say it to a friend" test

**For Problem-Aware scripts:**
- [ ] Includes analogy for the villain/problem
- [ ] False solutions are eliminated before villain reveal

**For Product-Aware scripts:**
- [ ] Does NOT re-educate on problem
- [ ] Addresses specific objections (price, doubt, inaction)
- [ ] Leads with risk reversal

**Format:**
- [ ] No separate pacing notes (line breaks handle pacing)
- [ ] Visual direction notes at END only
- [ ] Consistent formatting throughout

---

## Example: Problem-Aware Voiceover Script

**User:** "Write a voiceover script for Regrowth+ targeting expats who've tried supplements and diet changes"

```markdown
## SCRIPT: REGROWTH_VO_PROBLEMAWARE_V1

**Format:** Voiceover Monologue
**Length:** 60-75 seconds
**Awareness stage:** Problem-aware (knows hair is falling out, has tried supplements, doesn't know real cause)
**Avatar:** Sarah, expat professional, 1-3 years in GCC, tried everything
**Villain:** Mineral buildup blocking the follicle
**Hook type:** False cause elimination + analogy reveal
**CTA type:** Quiz (diagnostic)

---

There's a reason nothing you've tried has worked.

And most people never figure out what it is.

It might not be your diet.

It might not be your stress levels.

It might not be your hormones.

And here's the one that surprises people most.

It might not even be a deficiency.

You can take every supplement on the shelf. Biotin. Iron. Collagen. All of it.

And your hair will keep falling out.

Because supplements feed the follicle from the inside.

But if the follicle is blocked from the outside, none of that nutrition gets through.

Think about watering a plant.

You pour water into the soil every single day.

But under the surface, concrete is slowly covering the roots.

The water never reaches them. The plant keeps dying. And you keep watering, wondering what you're doing wrong.

That's what's happening to your scalp.

The water in the Gulf leaves mineral deposits behind every time you shower. Calcium. Magnesium. They build up layer by layer directly on the follicle.

Your shampoo doesn't remove them. It was never made for this water.

So the follicle stays blocked. Starved. And your hair keeps falling out.

Not because something is wrong with you.

Because nobody told you about the concrete.

Regrowth+ is the first shampoo in the Gulf engineered specifically for this water.

And it's actually made here.

The way it works is simple. It contains agents that bind directly to the mineral buildup and strip it away. Every wash.

Then rosemary and caffeine restore circulation and restart the growth cycle.

Most people notice less shedding within two weeks.

Take the 60-second Hard Water Hair Quiz.

Find out if this is what's been behind it.

Link below.

---

#### Visual Direction Notes

**"There's a reason nothing you've tried has worked"** Open on: supplement bottles lined up. Expensive shampoo in a shower. Hair on a pillow.

**"It might not be your diet... stress... hormones"** Quick cuts between each. Building unease.

**"Think about watering a plant"** Cut to: water being poured into soil. Then reveal cracked concrete beneath. Hold on it.

**"That's what's happening to your scalp"** Slow-motion shower water. Microscope graphic of mineral layer on follicle.

**"Nobody told you about the concrete"** Silence beat. Let it land.

**"Regrowth+"** First product shot. Clean, confident.

**"Less shedding within two weeks"** Woman running fingers through full hair. Warm, calm.

**"Take the quiz"** End card. Single URL. Nothing else.
```

---

## Iteration Patterns

When user provides feedback, apply these standard fixes:

| Feedback | Fix |
|----------|-----|
| "Hook is too slow" | Rewrite with open loop + tension in first line |
| "Reveals the problem too quickly" | Add more false cause elimination, hold the reveal |
| "Needs an analogy" | Add concrete visual metaphor before villain reveal |
| "Product intro feels sudden" | Follow 5-step product introduction sequence |
| "Sounds too clinical" | Replace technical terms with human language |
| "Make it more human" | Shorten sentences, add contractions, vary rhythm |
| "Emphasize the villain" | Give enemy name, screen time, near-victory |
| "Product appears too early" | Move to correct % for awareness stage |
| "Need quiz CTA" | Replace with diagnostic framing |
| "This is for product-aware" | Remove education, add objection collapse + risk reversal |

---

## Version History

- **1.1.0** (Current): Added Awareness Stage Architecture as primary framework, Hook Construction Rules, Product Introduction Sequence, removed separate Pacing Notes requirement, added Voiceover Monologue as primary format, added stage-specific quality checklist items, added full example script
- **1.0.0**: Initial release with 7 formats, AI Slop sub-types, quality checklist
