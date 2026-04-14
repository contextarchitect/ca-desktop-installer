---
name: video-script-generator
description: "Generate high-converting direct-response video ad scripts using the Video Script Framework. Produces scripts across seven formats (Yap/Voiceover, Podcast, Animation, Static, UGC, AI Slop) with awareness-stage-specific structures, proper beat sequencing, villain framing, and humanization rules. Trigger on: video script, ad script, yap script, voiceover script, podcast script, AI slop, UGC script, talking head script, animation script."
---

# Video Script Generator Skill

## Metadata
- **Skill Name:** video-script-generator
- **Version:** 1.2.0
- **Category:** Creative / Copywriting
- **Dependencies:** None (standalone) | Enhanced with: avatar-research, brand-analyzer, copywriting-guide, angle-roadmap
- **Triggers:** "video script", "ad script", "write a script", "yap script", "voiceover script", "podcast script", "AI slop", "video ad", "talking head script", "UGC script"

---

## Purpose

Generate high-converting direct-response video ad scripts using the Video Script Framework methodology. This skill produces scripts across seven formats with **awareness-stage-specific structures**, proper beat sequencing, villain framing, and humanization rules.

**Core principle:** Awareness stage determines script structure. A problem-unaware script is structurally different from a product-aware script. Get the stage right first, then select format.

This skill is **brand-agnostic** and applies to any product category: physical products, supplements, skincare, SaaS, services, coaching, etc.

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

Before generating any script, ensure you have ALL of these. If any are missing, ask the user before proceeding.

### Minimum Viable Inputs

1. **Awareness stage** (MOST IMPORTANT - ask first)
   - Problem-unaware: Don't know they have the problem or the cause
   - Problem-aware: Know they have the problem, don't know the real cause
   - Solution-aware: Know the solution category, but their attempts haven't worked
   - Product-aware: Know your brand, visited site, haven't converted

2. **Product name + mechanism** - What it does AND how it does it
   - Bad: "Product X helps with [problem]"
   - Good: "[Product] does [specific action] via [mechanism], which results in [outcome]"

3. **Target avatar** - Who this is for, their emotional state, what they've tried
   - Bad: "People with [problem]"
   - Good: "[Demographics], [situation/context], tried [false solutions], feeling [emotional state]"

4. **The villain** - The specific enemy the product defeats
   - Bad: "damage" or "toxins" or "inefficiency"
   - Good: A specific, nameable cause that can be visualized and blamed

5. **Credibility anchor** - What gives the product authority/legitimacy
   - Examples: Geographic origin, scientific backing, founder story, manufacturing process, ingredient sourcing, clinical studies, industry experience, proprietary method
   - Source: Pull from brand guidelines or copywriting guide if available. If not, ask the user: "What's your brand's main credibility anchor - the thing that makes you legitimate/trustworthy?"

6. **CTA (Call to Action)** - What action should the viewer take?
   - Ask the user: "What's your CTA for this script?"
   - Examples: Quiz, free trial, book a call, shop now, download guide, join waitlist, get sample, learn more

7. **Format** - Which script type to generate
   - Options: Yap/Voiceover Monologue, Podcast, Animation, Static, UGC, AI Slop

### Optional Inputs (Enhance Quality)
- Avatar pain map (surface -> hidden pain -> core desire -> identity threat)
- Brand voice characteristics
- Specific angle or hook direction
- Video length target (15-30s, 45-60s, 60-90s, 2-4min)
- Hero ingredients/features list (for AI Slop format)
- False solutions they've tried (for problem-aware scripts)
- Guarantee details (for product-aware scripts)
- Payment/pricing details (for product-aware scripts)
- Benefit timeframe (e.g., "results in 2 weeks", "see difference in 30 days")

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
[Product as the solution built for this] -> [Mechanism in simple terms] -> [CTA]
```

**Example hook patterns across categories:**

| Category | Hook Example |
|----------|-------------|
| Hair care (regional) | "When you move to the Gulf, people tell you a lot of things. Nobody tells you what it does to your hair." |
| Skincare (age) | "After 35, your skin changes in a way nobody warns you about. And it has nothing to do with wrinkles." |
| SaaS (workflow) | "Your team is losing 12 hours a week to something you don't even know is happening." |
| Supplements (hidden cause) | "There's a reason you're tired even after 8 hours of sleep. And it's not what your doctor checked for." |
| Coaching (career) | "The thing holding back your promotion isn't your skills. Nobody in HR will tell you what it actually is." |

**Product entry:** 65-70% mark. More education needed before product.

---

### Stage 2: PROBLEM-AWARE

**Avatar state:** Knows they have the problem, has tried to fix it, doesn't know the real cause.

**Script job:** Eliminate false causes, reveal the true villain, provide the "aha" moment.

**Hook strategy:** False solution elimination + open loop, analogy setup

**Beat structure:**
```
[HOOK: Promise of hidden answer] -> [FALSE CAUSE ELIMINATION: list what it's NOT] ->
[ANALOGY: concrete visual for the real problem] -> [VILLAIN REVEAL with specifics] ->
[Why other solutions fail] -> [Product positioned for this specific problem] ->
[Mechanism in human language] -> [Result timeframe] -> [CTA]
```

**REQUIRED: Include an analogy.** The villain must be visualizable.

**Example analogies across categories:**

| Category | Analogy |
|----------|---------|
| Hair care | "Think about watering a plant. You pour water in every day. But under the surface, concrete is slowly covering the roots. The water never reaches them." |
| Skincare | "Imagine trying to paint a wall that's covered in dust. No matter how good the paint is, it won't stick until you clean the surface first." |
| SaaS | "It's like having a leak in your roof but only mopping the floor. You're treating the symptom while the cause keeps dripping." |
| Supplements | "Your body is like a locked door. You've been pushing vitamins at it, but nobody gave you the key that actually opens it." |
| Fitness | "You're filling the bathtub, but the drain is open. No matter how much you pour in, it keeps draining out." |

**Product entry:** 60-65% mark.

---

### Stage 3: SOLUTION-AWARE

**Avatar state:** Knows the solution category (e.g., "I need a CRM" or "I need a serum"), has tried products in that category, they haven't worked.

**Script job:** Explain why their solution category attempts failed. Position your product as the version built for their specific context.

**Hook strategy:** Contrarian industry claim, failed solution reframe

**Beat structure:**
```
[HOOK: Your solution category isn't broken, it's mismatched] ->
[Why every product in this category was built for a different context] ->
[What's different about YOUR situation] ->
[VILLAIN: The invisible thing those products can't address] ->
[Product as the one built for this specific context] -> [Mechanism] -> [Result] -> [CTA]
```

**Example hook patterns across categories:**

| Category | Hook Example |
|----------|-------------|
| Hair care | "If none of your hair growth shampoos are working, they're probably not broken. They're just not built for your water." |
| Skincare | "You've tried every retinol on the market. None of them worked. Here's why that's not your fault." |
| SaaS | "You've tried three project management tools. Your team still misses deadlines. The tools weren't the problem." |
| Supplements | "You've taken every probiotic your naturopath recommended. Your gut is still a mess. Here's what they all missed." |
| Coaching | "You've read the books. Done the courses. Still stuck at the same level. None of them addressed what's actually holding you back." |

**Product entry:** 55-60% mark. Less education needed, faster to product.

---

### Stage 4: PRODUCT-AWARE

**Avatar state:** Knows your brand, has visited your site, hasn't bought. Sitting on the fence.

**Script job:** Collapse the final objection. Remove friction. This is NOT about education.

**Hook strategy:** Direct accusation, objection acknowledgment, risk reversal

**Beat structure:**
```
[HOOK: Direct acknowledgment they know you] -> [Name the hesitation] ->
[OBJECTION COLLAPSE: address specific barriers] ->
[Risk reversal: guarantee, payment plans, trial] -> [Urgency without hype] -> [CTA]
```

**CRITICAL RULES for Product-Aware:**
- Do NOT re-educate on the problem. They know.
- Do NOT re-explain the mechanism. They've read it.
- DO address specific objections: price, "will it work for me", inaction, timing
- DO lead with risk reversal (guarantee, free trial, payment split)
- DO use direct language ("You just haven't bought it yet")

**Example hook patterns across categories:**

| Category | Hook Example |
|----------|-------------|
| Any product | "You've seen [Brand] before. You know what it does. You just haven't [bought/signed up/booked] yet." |
| With guarantee | "Most [category] make you a promise. Try it. See the difference. Trust us. And if it doesn't work, good luck getting your money back. We do it differently." |
| With trial | "You've been on our site three times this week. Here's what's stopping you - and why it shouldn't." |

**Product entry:** Can appear in first 30%. Education phase is skipped.

---

## Hook Construction Rules

**The hook must create an open loop the viewer cannot close without watching.**

### Hook Anti-Patterns (AVOID)
- Slow, reflective openings that ask for recognition before creating tension
- Starting with the problem statement directly ("Hair loss is frustrating...")
- Leading with the product name
- Generic claims ("What if there was a better way...")

### Hook Patterns by Stage

| Stage | Hook Pattern | Structure |
|-------|-------------|-----------|
| Problem-Unaware | Hidden truth + withhold | "Nobody tells you what [context] does to [problem area]. You're about to find out." |
| Problem-Aware | False cause elimination + promise | "There's a reason nothing you've tried has worked. And it's got nothing to do with [obvious causes]." |
| Solution-Aware | Contrarian + question | "You [tried solution] specifically for [problem]. And it did absolutely nothing. Why?" |
| Product-Aware | Direct accusation | "You've seen [Brand] before. You know what it does. You just haven't [action] yet." |

### Hook Quality Test
Ask: "Does this hook make a promise AND withhold the answer?"
- If yes -> good hook
- If no -> rewrite

---

## Product Introduction Sequence

When introducing the product, follow this order:

1. **Product name + unique positioning**
   - Emphasize the USP - what makes this product different from others in the category
   - Examples: "first [category] designed for [specific context]", "only [product type] that [unique capability]", "built specifically for [audience/situation]"

2. **Credibility anchor**
   - This varies by brand. Common types:
     - Geographic: "Actually made here" / "Sourced from [origin]"
     - Scientific: "Developed with [institution]" / "Backed by [studies]"
     - Founder: "Created by someone who [relevant experience]"
     - Process: "Using [proprietary method]" / "[Unique manufacturing approach]"
     - Time: "[X] years in development" / "Perfected over [timeframe]"
   - If not provided in brand materials, ask the user.

3. **Mechanism in human language** (NOT clinical/technical terms)
   - Bad: "The mechanism is called [technical term]"
   - Good: "The way it works is simple. [Plain language explanation]"

4. **What happens next** (the cascade effect)
   - After the mechanism does its job, what's the follow-on benefit?

5. **Benefit timeframe**
   - When will they see/feel results?
   - Examples: "Most people notice [result] within [timeframe]"

---

## Format Selection Guide

**After determining awareness stage**, select format based on content needs:

```
PROBLEM-UNAWARE:
- Voiceover Monologue (60-90s) -> Hidden truth reveal
- Podcast Two-Host (2-4min) -> Guessing game, extended education
- AI Slop -> Personified villain chain
- Animation -> Character discovers the truth

PROBLEM-AWARE:
- Voiceover Monologue (60-90s) -> False solution exhaustion + analogy (MOST COMMON)
- UGC Testimonial -> Personal discovery story
- AI Slop Chain of Blame -> Elements pass blame to villain
- Animation -> Villain gloats, hero arrives

SOLUTION-AWARE:
- Voiceover Monologue (45-75s) -> Contrarian industry claim
- Animation -> Product as hero in mechanism story
- Static Reverse Psychology -> Satirical "keep using what doesn't work"

PRODUCT-AWARE:
- Voiceover Monologue (45-60s) -> Objection collapse, risk reversal (MOST COMMON)
- UGC Testimonial -> Social proof, result confirmation
- Static -> Guarantee-forward, direct CTA
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
- Body parts / system components complain, pass blame
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
- Sensory specifics (what they see, feel, experience)
- One idea per sentence maximum
- Human phrasing: "The way it works is simple" not "The mechanism is called [term]"

**TEST:** Could a real person say this to a friend at dinner?

---

## CTA Integration

**CTA is user-specified.** Do not assume or prescribe CTA type - ask the user what CTA they want for this script.

When integrating the user's CTA into the script:

1. **Always include benefit timeframe before or near the CTA**
   - Good: "[Benefit timeframe]. [CTA instruction]."
   - Bad: Just the CTA with no context

2. **Match CTA language to awareness stage tone**
   - Problem-unaware: Discovery framing ("Find out if...")
   - Problem-aware: Confirmation framing ("See if this is what's been...")
   - Solution-aware: Diagnosis framing ("Find out exactly what...")
   - Product-aware: Direct action framing ("Link below", "Get started")

3. **Keep CTA delivery simple**
   - One clear action
   - No stacking multiple CTAs
   - End with "Link below" or equivalent for video format

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
**CTA:** [User-specified CTA]

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

**Structure:**
- [ ] Hook creates open loop in first 3 seconds
- [ ] Hook makes a promise AND withholds the answer
- [ ] Villain named and given presence before product
- [ ] Product introduction follows the 5-step sequence
- [ ] CTA includes benefit timeframe

**Copy:**
- [ ] Zero forbidden vocabulary
- [ ] All contractions present
- [ ] Sentence lengths vary dramatically
- [ ] Every factual claim is specific
- [ ] Mechanism explained in human language, not clinical terms
- [ ] Passes "say it to a friend" test

**For Problem-Aware scripts:**
- [ ] Includes analogy for the villain/problem
- [ ] False solutions are eliminated before villain reveal

**For Product-Aware scripts:**
- [ ] Does NOT re-educate on problem
- [ ] Addresses specific objections
- [ ] Includes risk reversal element

**Format:**
- [ ] No separate pacing notes (line breaks handle pacing)
- [ ] Visual direction notes at END only
- [ ] Consistent formatting throughout

---

## Example Scripts by Category

### Example 1: Supplement Brand (Problem-Aware)

**Context:** Magnesium supplement for sleep. Avatar has tried melatonin and sleep hygiene. CTA: Quiz.

```markdown
## SCRIPT: DEEPREST_VO_PROBLEMAWARE_V1

**Format:** Voiceover Monologue
**Length:** 60-75 seconds
**Awareness stage:** Problem-aware (knows they can't sleep, has tried melatonin, doesn't know real cause)
**Avatar:** Professional 30-45, tried melatonin and blue light glasses, still waking at 3am
**Villain:** Magnesium deficiency blocking GABA production
**Hook type:** False cause elimination + analogy
**CTA:** Sleep assessment quiz

---

There's a reason you're still waking up at 3am.

And it has nothing to do with your phone. Your stress. Or your mattress.

You've tried melatonin. It made you groggy.

You've tried the sleep hygiene routine. Blue light glasses. No screens after 9.

Still awake at 3am. Staring at the ceiling.

Here's what nobody told you.

Your brain has a brake pedal. It's called GABA. It's what slows your nervous system down enough to stay asleep.

But GABA needs magnesium to work.

Think of it like a car. You can have perfect brakes, but if there's no brake fluid, nothing happens when you press the pedal.

Magnesium is the brake fluid.

And 68% of adults don't get enough of it. Especially if you drink coffee, exercise, or deal with any level of daily stress.

The melatonin was never going to fix this. Melatonin helps you fall asleep. Magnesium helps you stay asleep.

Different problem. Different solution.

DeepRest is a magnesium glycinate formula designed specifically for sleep.

Developed with a neuroscientist who spent 11 years studying why people wake up in the middle of the night.

The glycinate form crosses the blood-brain barrier more effectively than other types. That's why it works when the cheap stuff from the pharmacy didn't.

Most people notice deeper sleep within the first week.

Take the 2-minute Sleep Assessment.

Find out if magnesium is the missing piece.

Link below.
```

---

### Example 2: SaaS Product (Solution-Aware)

**Context:** Project management tool. Avatar has tried Asana, Monday, Notion. CTA: Free trial.

```markdown
## SCRIPT: FLOWSTATE_VO_SOLUTIONAWARE_V1

**Format:** Voiceover Monologue
**Length:** 45-60 seconds
**Awareness stage:** Solution-aware (knows they need PM software, tried several, none stuck)
**Avatar:** Team lead, 8-15 person team, tried 3+ tools in last 2 years
**Villain:** Tools built for task management, not team rhythm
**Hook type:** Contrarian + failed solution reframe
**CTA:** 14-day free trial

---

You've tried Asana. Monday. Notion. Maybe all three.

Your team still misses deadlines.

Here's what nobody told you.

Those tools were built to manage tasks. Yours is a people problem dressed up as a task problem.

Your team doesn't need another place to list what needs to happen.

They need to see how their work connects to everyone else's. In real time. Without asking.

That's a completely different architecture.

FlowState was built by a team that burned out using the same tools you did.

What we built isn't a task manager. It's a rhythm system.

Every person sees how their work affects the timeline. Bottlenecks surface before they become emergencies. And nobody has to sit in a status meeting to find out what's actually happening.

Most teams cut their "where are we on this" messages by 70% in the first two weeks.

Start a 14-day free trial. No card required.

See what your team looks like when everyone's actually in sync.

Link below.
```

---

### Example 3: Skincare (Problem-Unaware)

**Context:** Vitamin C serum for post-30 skin. Avatar doesn't know about oxidative stress yet. CTA: Shop now.

```markdown
## SCRIPT: GLOWLAB_VO_UNAWARE_V1

**Format:** Voiceover Monologue
**Length:** 60-75 seconds
**Awareness stage:** Problem-unaware (doesn't know oxidative stress is happening)
**Avatar:** Women 32-40, noticed skin looking "tired" but attributes it to sleep or age
**Villain:** Daily oxidative stress from environment breaking down collagen
**Hook type:** Hidden truth reveal
**CTA:** Shop now

---

After 30, your skin starts losing a fight you didn't know it was in.

Every day. UV exposure. Pollution. Even the blue light from your screen.

They create something called free radicals. Unstable molecules that attack your collagen from the inside.

You can't see it happening. But you can see the result.

Skin that looks tired even when you're not. Fine lines that showed up faster than they should. A dullness that moisturiser doesn't fix.

This isn't aging. This is oxidative stress. And it's happening every single day you're not neutralising it.

The fix isn't complicated.

Vitamin C is the most effective antioxidant for skin. It neutralises free radicals before they do damage. And it signals your skin to produce more collagen while it's at it.

But most Vitamin C serums oxidise before you even open the bottle. That's why the cheap ones turn orange and stop working.

GlowLab uses a stabilised L-ascorbic acid formula that stays active for 12 months after opening.

Formulated by a cosmetic chemist who spent 6 years figuring out why most serums fail.

Most people see brighter, more even skin within 3 weeks.

Link below.
```

---

### Example 4: Coaching/Service (Product-Aware)

**Context:** Executive coaching. Avatar has visited sales page multiple times. CTA: Book discovery call.

```markdown
## SCRIPT: PEAKLEAD_VO_PRODUCTAWARE_V1

**Format:** Voiceover Monologue
**Length:** 45-60 seconds
**Awareness stage:** Product-aware (knows the program, hasn't signed up)
**Avatar:** Director/VP level, knows they need coaching, sitting on the fence
**Villain:** Hesitation itself
**Hook type:** Direct accusation + risk reversal
**CTA:** Book discovery call

---

You've been on our site three times this month.

You've read the case studies. Watched the testimonials. Maybe even asked around.

You know this program could change your trajectory.

You just haven't booked the call yet.

So let's address it directly.

If it's the investment, consider what staying stuck at this level costs you over the next 3 years. The raise you don't get. The role you don't land.

If it's "I'm not sure it'll work for me specifically," that's exactly what the discovery call is for. No pitch. Just a conversation about whether this is actually the right fit.

If it's timing, there's never a good time. There's only now, and later. Later usually means never.

Here's what I can promise.

If you do the work, you'll see results within 90 days. If you don't, you don't pay for the second half of the program.

That's the deal.

If you've been thinking about this for more than a week, you already know the answer.

Book the call. Let's find out if this is your moment.

Link below.
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
| "This is for product-aware" | Remove education, add objection collapse + risk reversal |
| "Wrong CTA" | Replace with user's specified CTA |

---

## Version History

- **1.2.0** (Current): Made skill brand-agnostic. Removed CTA prescriptions (now user-specified). Added multiple category examples (supplement, SaaS, skincare, coaching). Changed "Geographic authenticity" to "Credibility anchor" as variable input. Generalized all brand-specific language.
- **1.1.0**: Added Awareness Stage Architecture, Hook Construction Rules, Product Introduction Sequence, removed separate Pacing Notes requirement
- **1.0.0**: Initial release with 7 formats, AI Slop sub-types, quality checklist
