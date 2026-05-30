---
name: video-script-generator
version: "1.6.0"
description: "Generate high-converting direct-response video ad scripts using the Video Script Framework. Produces scripts across seven formats (Yap/Voiceover, Podcast, Animation, Static, UGC, AI Slop) with awareness-stage-specific structures, three-variable hook framework, three-stage mechanism pattern, discovery vs desperation frames, villain framing, and humanization rules. Consumes copywriting-guide §8.4 Hook Quality Checklist, §8.5 Identification-Before-Mechanism Rule, §8.6 The Discovery Story Format, §8.7 The Five Core Feelings Library, and §8.8 Authority Hook Patterns as universal cross-references; consumes angle-roadmap Step 1C UGC Creator Brief and Step 5.5 Lead Variants, and the awareness-vocabulary framework doc, as cross-skill contracts. Schwartz Structural Layer added (gated). Trigger on: video script, ad script, yap script, voiceover script, podcast script, AI slop, UGC script, talking head script, animation script."
---

# Video Script Generator Skill

## Metadata
- **Skill Name:** video-script-generator
- **Version:** 1.6.0
- **Category:** Creative / Copywriting
- **Dependencies:** None (standalone) | Enhanced with: avatar-research, brand-analyzer, copywriting-guide, angle-roadmap
- **Triggers:** "video script", "ad script", "write a script", "yap script", "voiceover script", "podcast script", "AI slop", "video ad", "talking head script", "UGC script"

---

## Purpose

Generate high-converting direct-response video ad scripts using the Video Script Framework methodology. This skill produces scripts across seven formats with **awareness-stage-specific structures**, proper beat sequencing, villain framing, and humanization rules.

**Core principle:** Awareness stage determines script structure. A problem-unaware script is structurally different from a product-aware script. Get the stage right first, then select format.

This skill is **brand-agnostic** and applies to any product category: physical products, supplements, skincare, SaaS, services, coaching, etc. The skill provides structural frameworks; the user provides brand-specific content.

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

## Upstream Format Sources

Some script requests originate as repurposing tasks from `long-form-static-builder`. When a user has a winning long-form-static ad and wants a video adaptation, the upstream skill produces repurposing instructions covering two formats:

- **Movie-credits scroll video ad** - the long-form static body becomes scrolling text over a static or slow-motion background, voiceover optional. Format selection in this skill: "Static" with explicit "movie-credits scroll" sub-type if needed.
- **UGC long-form yap-session script** - the long-form static body becomes a first-person creator monologue script (3-7 minutes). Format selection in this skill: "UGC".

When the user references a long-form-static ad and asks for a video version, the body copy is already written. The job here is reformatting for delivery (timing, scene cuts, voiceover pacing), not generating fresh narrative. Do not re-write identification, mechanism, or close sections from scratch - preserve the body and add video-specific direction (scene cuts, voiceover pacing, on-screen text breaks).

If the user does not have a long-form-static ad already and asks for "video version of an advertorial," route them to `long-form-static-builder` first. The body copy must exist before video reformatting can produce a coherent script.

---

## Required Inputs (Elicit if Missing)

Before generating any script, ensure you have ALL of these. If any are missing, ask the user before proceeding.

### Minimum Viable Inputs

1. **Awareness stage** (MOST IMPORTANT - ask first)
   - This skill uses the universal 3-value awareness field (Problem-aware / Solution-aware / Product-aware) extended with a 4th video-specific value, "Problem-unaware", that maps to the universal field's "Problem-aware" with an upstream education layer (the script first introduces the problem before treating the avatar as Problem-aware). See `_frameworks/awareness-vocabulary.md` for the universal-vs-gated awareness distinction; the gated Schwartz 6-value enum is used in the Schwartz Structural Layer section below when `phase-4.5-angle-roadmap/schwartz-applied.md` exists for the brand. This first-use qualifier covers all subsequent awareness-vocabulary references in this skill.
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

4.5. **Identification-Before-Mechanism context** - Per `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`: before any mechanism explanation in the script, the narrator's identity must be established (specific name/age/situation). Ask the user: "Who is the narrator delivering this script: what's their specific identity?" The identity grounds the mechanism explanation in someone the viewer can see themselves in. Without identification before mechanism, even technically correct scripts fail to convert.

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
- Key differentiators to emphasize (user may have 2-3 to choose from per script)

---

## Concept Structure (Pre-Script)

Script generation runs in two stages. Stage one commits a concept. Stage two writes the script from it. Committing the concept first means the structural decisions (format, awareness stage, the angle the hook takes, the beat order) are agreed before a single line of script is written. A concept that is wrong in shape is cheap to fix here and expensive to fix once a full script exists. The ConceptCard holds the skeleton; the ScriptCard fills it in.

Do not jump to a finished script when the user has not settled the concept. If the required inputs (see `## Required Inputs (Elicit if Missing)`) are present but the structural approach is still open, present a ConceptCard and get approval before writing.

**ConceptCard required fields**

- `format` -> one of the six canonical formats (see `## Format Selection Guide` and `## Format-Specific Rules`). Fixed for the script that derives from this concept.
- `awareness_stage` -> one of Problem-Unaware, Problem-Aware, Solution-Aware, Product-Aware (see `## Awareness Stage Architecture (PRIMARY FRAMEWORK)`). This is the primary axis; it sets beat order and product-entry timing.
- `hook_angle` -> the specific entry point the hook takes, expressed through the `### Three-Variable Hook Framework` (which of curiosity, specificity, or identity leads).
- `structural_approach` -> the named pattern the body follows: the `## Three-Stage Mechanism Pattern`, the Frustration-to-Eureka Arc (the Problem-Aware sub-pattern under `## Awareness Stage Architecture`), or a Discovery or Desperation frame (see `## Discovery Frame vs Desperation Frame`).
- `key_beats` -> 3 to 8 ordered beat headlines, in delivery order. These are headlines, not written lines. They are the spine the ScriptCard expands.

**ConceptCard optional fields**

- `cta_hook` -> the user-specified call to action, if known. The skill never invents a CTA (see `## CTA Integration`).
- `target_duration_seconds` -> drives length variation (see `## Angle Variation Framework`, Script Length Variations).
- `concept_id` -> stable identifier so derived scripts can point back to their concept.
- `title` -> a short human-readable label.

**Concept shape mirrors the awareness stage**

`key_beats` is not free-form. It is populated from the `**Beat structure:**` block of the chosen stage in `## Awareness Stage Architecture`. A Problem-Aware concept draws its beats from the Problem-Aware beat structure, or from the Frustration-to-Eureka Arc when the script needs emotional validation before the reveal. A Solution-Aware concept draws from the Solution-Aware beats and usually carries the `## Three-Stage Mechanism Pattern`. A Product-Aware concept compresses or drops the early problem-framing beats because the viewer already knows the problem. The concept and the stage stay consistent; a Product-Aware concept does not carry a Problem-Unaware beat order.

**One concept, many scripts**

A single approved concept can produce more than one script. Hold the concept fixed and vary the hook, the target duration, or the lead variant to generate a set. Each derived script shares the concept's `format`, `awareness_stage`, and `structural_approach`; what changes is the surface.

**One conversation, many concepts**

A single conversation can carry more than one concept, including concepts in different formats. Concept selection happens before each script. When the user asks for a new format mid-conversation, present a fresh ConceptCard for that format rather than reshaping the previous concept. Format is fixed per concept.

---

## Awareness Stage Architecture (PRIMARY FRAMEWORK)

**This is the most important section.** Script structure varies dramatically by awareness stage. Determine stage FIRST, then apply the appropriate template.

(Awareness-vocabulary first-use qualifier is at Required Inputs item #1 above; see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction.)

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

#### Problem-Aware Sub-Pattern: Frustration-to-Eureka Arc

A powerful structure for problem-aware scripts that emphasizes emotional validation before the reveal:

```
[QUALIFYING CONTEXT: Who this is for] ->
[FRUSTRATION ACKNOWLEDGMENT: "You have every right to be frustrated"] ->
[EFFORT VALIDATION: List specific things they've tried - be detailed] ->
[SENSORY MOMENTS: Relatable snapshots of their experience] ->
[PIVOT: "Here's what I need you to understand"] ->
[REFRAME: "You didn't fail. You were solving the wrong problem."] ->
[EUREKA: "This is the part that's going to make everything click."] ->
[VILLAIN REVEAL with mechanism] -> [Product] -> [CTA]
```

The key is converting frustration into a eureka moment - the instant when the real cause clicks.

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

## Angle Variation Framework

**One villain can generate many scripts.** The entry point changes based on what false solution the avatar tried.

This is critical for producing multiple scripts from the same core insight without repeating yourself.

### How It Works

Take ONE villain/mechanism and create MANY angle variations by changing:
- What false solution they tried first
- Which aspect of their experience you enter through
- Which emotional state you lead with

### Example: Same Villain, Different Entry Points

**Villain:** Blocked follicles preventing absorption

| Entry Point | Angle | Hook Direction |
|------------|-------|----------------|
| Tried topical treatment | "Why your [treatment] isn't reaching the follicle" | Treatment lands on surface, can't penetrate |
| Tried supplements | "Why your vitamins aren't working" | Nutrients circulating with nowhere to go |
| Tried competitor product | "Why their serum just sits on top" | Product designed for different conditions |
| Tried environmental fix | "Why your [fix] didn't solve it" | Addresses symptom, not accumulated damage |
| Tried lifestyle change | "Why clean living isn't enough" | Internal optimization blocked by external problem |
| Emotional state | "Breaking the frustration cycle" | Convert frustration to eureka moment |
| Nostalgia | "Looking at old photos" | What changed between then and now |

### Pattern for Creating Variations

1. **Identify the core villain** - The one true cause your product addresses
2. **List all false solutions** avatar might have tried
3. **For each false solution**, write a script explaining why it failed
4. **The mechanism explanation stays the same** - only the entry point changes

### Script Length Variations

Same angle can have short and long versions:

- **Short (30-45s):** Hook → Villain reveal → Product → CTA
- **Medium (60-75s):** Hook → False solution elimination → Analogy → Villain → Mechanism → CTA
- **Long (90-120s):** Full emotional journey with sensory details, technical education, extended mechanism

When user asks for "shorter version, same angle" - cut the fat, keep the core.

---

## Hook Construction Rules

Apply `copywriting-guide §8.4 Hook Quality Checklist` (5-point check: opens a loop, one specific claim, first-person voice, specificity, identity marker). Apply `copywriting-guide §8.8 Authority Hook Patterns` when the hook invokes authority (Classic / Doctor's Surprise / Doctor's Skepticism / Study/Research). The patterns below are video-format-specific extensions of those universal rules.

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

### Three-Variable Hook Framework

Strong video hooks deliberately combine three variables. Tune each variable based on the awareness stage and avatar:

**Variable 1: Curiosity Trigger**
- Hidden truth ("Nobody tells you...")
- Pattern interrupt ("Stop doing X")
- Counter-intuitive claim ("X is making it worse")
- Insider knowledge ("Most people don't know...")
- Time-anchored revelation ("After 35, this happens")

**Variable 2: Specificity Marker**
- Number ("12 hours a week", "3am again", "68%")
- Name (specific brand, place, condition)
- Time anchor ("After 35", "In your first month")
- Concrete situation (specific scenario the viewer recognizes)

**Variable 3: Identity Marker**
- Demographic ("If you're over 35")
- Behavioral ("If you've tried minoxidil")
- Situational ("If you live in [region]")
- Professional ("If you manage a team of 8+")
- Aspirational ("If you want to feel like yourself again")

A hook that hits all three variables with strong levels typically passes the §8.4 Hook Quality Checklist. A hook that hits only one is usually weak. The variables are not stage-locked; all four awareness stages benefit from all three. The MIX changes by stage: Problem-unaware leads with Curiosity Trigger; Problem-aware balances all three; Solution-aware leads with Identity Marker; Product-aware leads with Specificity Marker (specific numbers, specific guarantees).

The Three-Variable Hook Framework is a deeper structural layer underneath the Hook Patterns by Stage table above. The patterns table gives you stage-specific hook shapes. The three-variable framework gives you the components those shapes are built from. Use them together: pick the stage-appropriate pattern, then tune each of the three variables to make the pattern land harder.

When iterating hooks (see "Hook Iteration Pattern" below), generate 3 variants by holding the dominant variable constant and changing the secondary mix. Example: same Identity Marker ("If you're over 35"), but Variant A leads with Curiosity Trigger, Variant B leads with Specificity Marker, Variant C leads with a hybrid.

### Hook Quality Test
Ask: "Does this hook make a promise AND withhold the answer?"
- If yes -> good hook
- If no -> rewrite

### Hook Iteration Pattern

When refining hooks, offer 2-3 options with different approaches:

```
Option 1: [Hook version A - e.g., curiosity-driven]
Option 2: [Hook version B - e.g., validation-driven]
Option 3: [Hook version C - e.g., direct accusation]

Which direction feels right?
```

Let the user choose, then build the full script from their selection.

### Discovery Story Format Hook (when applicable)

Per `copywriting-guide §8.6 The Discovery Story Format`, when the script uses the Discovery Story Format, the hook should setup the 7-stage sequence (Distress -> Unusual decision -> Discovery -> Mechanism reveal -> Application -> Validation -> Crossroads). The hook itself opens with Distress framing; the rest of the script walks the 7 stages. This format works strongest in UGC and Voiceover Monologue formats; less effective in Static and AI Slop where the format depends on rhythm rather than narrative arc.

---

## Early Context Establishment

**Establish qualifying context early** - but what that context is depends entirely on the brand and angle.

### The Principle

Viewers need to know "Is this for me?" within the first few lines. The qualifying context answers this question.

### What Qualifies as Qualifying Context

This varies by brand. Common types:

| Type | Example | Best For |
|------|---------|----------|
| Geographic | "If you live in [region]..." | Products designed for specific conditions |
| Demographic | "If you're over [age]..." | Age-specific products/services |
| Situational | "If you [specific situation]..." | Context-dependent problems |
| Behavioral | "If you've tried [category]..." | Solution-aware audiences |
| Professional | "If you manage a team of [size]..." | B2B/professional services |
| Identity | "If you're the kind of person who..." | Lifestyle/values-based products |

### Rule

Ask the user: "What's the qualifying context for this script - who exactly is this for?"

Do NOT assume geographic context is always the answer. Let the user specify based on their brand's positioning and the specific angle being explored.

---

## Sensory Snapshot Moments

**Every script needs 2-3 relatable sensory moments that make the avatar feel seen.**

These are specific visual/experiential details that create emotional resonance.

### What Makes a Good Sensory Moment

- **Specific:** Not "you feel frustrated" but "that moment when [specific experience]"
- **Visual:** Something they can see in their mind
- **Private:** Often something they haven't told anyone
- **Universal to avatar:** Most people in this situation experience this

### How to Generate Sensory Moments

Pull from:
- Avatar research (if available)
- Customer reviews and testimonials
- Reddit posts and forum discussions
- User's description of their customer

Ask the user: "What are the small, specific moments your customers experience with this problem? The things they notice but don't talk about?"

### Examples by Category

| Category | Sensory Moment |
|----------|----------------|
| Hair care | "That moment when the light hits at that angle and you just stop. And stare." |
| Sleep | "3am again. Same ceiling. Same thoughts." |
| Productivity | "That sinking feeling when you open your inbox and it's worse than yesterday." |
| Fitness | "Catching your reflection and not recognizing who's looking back." |
| Finance | "The mental math you do before every purchase." |
| Parenting | "The guilt when you snap at them for something small." |

### Placement

Sensory moments work best:
- Early, after establishing who this is for (creates connection)
- During frustration acknowledgment (validates their experience)
- Before the pivot to solution (emotional peak before relief)

### Core Feeling Alignment

Sensory snapshot moments serve `copywriting-guide §8.7 The Five Core Feelings Library`. Each moment activates ONE of the five core feelings (Vindication, Loss aversion, Betrayal, Desperation, Identity). Pick the dominant core feeling for the script and let sensory moments reinforce that ONE feeling. Multiple core feelings dilute the script per §8.7.

---

## Logic Flow Rule

**Every line must connect logically to the next. No jumping steps.**

### The Problem

Scripts fail when they skip logical steps - the viewer gets confused or loses trust.

### Bad Example (Skips Logic)
```
Minoxidil works by increasing blood flow.
But if your follicles are blocked, it can't reach them.
That's why we created [Product].
```

**What's missing:** WHY would follicles be blocked? For whom? How does that happen?

### Good Example (Connected Logic)
```
Minoxidil works by increasing blood flow to your scalp.
More blood flow means more oxygen and nutrients reaching your follicles.
And when your follicles get what they need, they grow hair.

But here's what changes everything if you live in [context].

Your follicles might be blocked.
And if they're blocked, minoxidil can't reach them.

Here's why.

[Explanation of how blocking happens in their specific context]
```

### Connection Phrases

Use transitional phrases that connect ideas:
- "Here's why."
- "But here's what changes everything..."
- "And that means..."
- "Which brings us to the real problem."
- "So what does that mean for you?"

### Test

Read the script line by line. After each line, ask: "Does the next line logically follow from this one?"

If you need to add explanation for the jump to make sense, add it.

---

## Three-Stage Mechanism Pattern

Mechanism explanations in video scripts work best in three stages, each serving a distinct cognitive job. The Three-Stage Mechanism Pattern is a specific structural pattern that operates within the universal Logic Flow Rule above; the Logic Flow Rule applies to every line of every script, while this pattern applies specifically to mechanism explanations.

**Stage 1: Problem framing in everyday language**
- The villain's effect, not the villain itself
- What the viewer experiences (the symptom, the frustration, the gap)
- Stays in the viewer's experiential vocabulary, not the brand's technical vocabulary
- Example: "You're tired even after 8 hours of sleep" (NOT "GABA receptor downregulation")

**Stage 2: Mechanism reveal with analogy**
- The villain's identity (named, specific)
- An analogy that makes the mechanism visualizable
- The "aha" moment, the cognitive click
- Example: "Magnesium is the brake fluid your nervous system needs to slow down at night. Without it, you have brakes but no fluid."

**Stage 3: Cascade effect, what happens once mechanism is fixed**
- The follow-on consequences once the villain is removed
- Includes timeframe ("within 2 weeks", "by week 4")
- Connects back to Stage 1's experiential framing (closes the loop)
- Example: "When magnesium is restored, GABA works again. You stay asleep. By week 2, most people sleep through the night."

The three stages are sequential. Skipping Stage 1 loses the viewer (they can't see why this matters). Skipping Stage 2 loses credibility (no aha moment). Skipping Stage 3 loses the close (no clear "what's in it for me").

Apply the Three-Stage Mechanism Pattern in problem-aware and solution-aware scripts. Product-aware scripts often skip Stage 1 (viewer already knows the problem) and abbreviate Stage 2 (viewer has read the mechanism on the website); they go heavier on Stage 3 with risk reversal and timeline.

The Three-Stage Mechanism Pattern combines with the Frustration-to-Eureka Arc (existing Problem-Aware sub-pattern) when the script needs both emotional validation AND mechanism education.

---

## Discovery Frame vs Desperation Frame

Every script operates in one of two dominant emotional frames. Pick ONE per script; mixing dilutes both.

### Discovery Frame
- Narrator found something. Wants to share it.
- Tone: insider knowledge, "I figured this out and you should know"
- Energy: calm, confident, almost gentle
- Best for: Problem-unaware, Solution-aware (intellectual reframe), most UGC scripts
- Hook patterns: hidden truth, pattern interrupt, insider knowledge
- Pacing: deliberate; long pauses; thoughtful

### Desperation Frame
- Narrator is in the situation now. Looking for help.
- Tone: vulnerable, raw, "I'm sharing this because I don't know what else to do"
- Energy: intense, urgent, sometimes shaky
- Best for: Problem-aware (validation through shared suffering), some UGC scripts where the creator hasn't fully resolved
- Hook patterns: false cause elimination, frustration acknowledgment, sensory snapshot
- Pacing: faster; shorter sentences; emotional peaks

The Frustration-to-Eureka Arc (existing Problem-Aware sub-pattern) is a Desperation Frame opening that pivots to Discovery Frame at the eureka moment. This is one of the strongest Problem-Aware structures because it converts the desperation into a discovery WITHIN the script.

UGC scripts especially benefit from explicit frame selection. Variant 1: First-Person Sufferer typically operates in Desperation Frame. Variant 2: First-Person Discoverer typically operates in Discovery Frame. Variant 3: Third-Person Authority or Witness usually operates in Discovery Frame with a more measured tone. See `_skills/angle-roadmap/SKILL.md` Step 5.5 for variant definitions; this skill's UGC format consumes those variant names as canonical references.

---

## No Meta-Commentary Rule

**Delete lines that describe what you're explaining instead of explaining it.**

### Forbidden Patterns

| Pattern | Why It's Bad | Fix |
|---------|--------------|-----|
| "That's the mechanism." | Tells instead of shows | Delete - let explanation speak for itself |
| "Here's how it works." | Unnecessary setup | Delete or replace with direct explanation |
| "Let me explain." | Creates distance | Delete - just explain |
| "The science is simple." | Evaluative, not informative | Delete |
| "This is the important part." | If it's important, it should be obvious | Delete |

### The Principle

If you've explained something clearly, you don't need to tell the viewer you've explained it. The explanation IS the point.

### Exception

Pivot phrases are okay when they signal emotional shift:
- "Here's what I need you to understand." (signals reframe)
- "This is the part that's going to make everything click." (signals eureka)

These serve emotional function, not explanatory function.

---

## Partial Solution Framing

**When the avatar has tried something that partially works, acknowledge it as smart before showing its limits.**

### The Pattern

```
1. Acknowledge the partial solution as "smart" or "good instinct"
2. Explain why it works (validates their reasoning)
3. Introduce the limitation: "But here's where it falls short"
4. Quantify if possible: "It only solves [X]% of the problem"
5. List what it doesn't address
6. Position your product as "the complete answer"
```

### Example Structure

```
Some people have started [partial solution].

And honestly, it works.

[Evidence it works - what improves]

And when you understand why it works, everything clicks.

[Explanation of mechanism]

Smart.

But here's where it falls short.

It only solves [portion] of the problem.

Because [what it doesn't address].

[List remaining problems]

[Partial solution] stops the problem getting worse.

It doesn't fix the damage that's already done.

[Product] does both.
```

### Why This Works

- Respects the viewer's intelligence (they were onto something)
- Builds trust (you're not dismissing their efforts)
- Creates clear gap for your product to fill

---

## Technical Education Option

**Some scripts benefit from technical depth. Use when the audience values understanding the "why."**

### When to Add Technical Depth

- Audience is educated/research-oriented
- Product has genuine scientific differentiation
- Competing products make vague claims
- "Skeptical" avatar who needs proof

### How to Add Technical Depth Without Losing Humanity

1. **Explain in accessible language first**
2. **Add technical detail as reinforcement**
3. **Connect back to their experience**

### Example

```
[Accessible version first]
Shower filters catch the big stuff - chlorine and sediment.

[Technical detail]
But calcium and magnesium minerals are ionic.
Dissolved directly into the water at a molecular level.
No standard carbon or KDF filter on the market can remove them.

[Back to experience]
So while your filter is doing its job perfectly,
the minerals destroying your hair are flowing through completely untouched.
```

### Technical Education Triggers

- User says "make it more technical" or "add more science"
- Avatar profile indicates research-oriented buyer
- Product differentiation is technical in nature

---

## Product Introduction Sequence

When introducing the product, follow this order:

1. **Product name + unique positioning**
   - Emphasize the USP - what makes this product different from others in the category
   - The user may have 2-3 USPs to choose from - ask which to emphasize for this script
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

## External Content → Angle Conversion

**Real customer language (Reddit posts, reviews, support tickets) can inspire authentic angles.**

### How to Convert External Content to Angles

1. **Extract the insight, not the person**
   - Don't make the script about the Reddit user
   - Extract what they discovered or experienced

2. **Identify the entry point**
   - What did they try?
   - What did they discover?
   - What's their unique framing?

3. **Generalize to the avatar**
   - "Some people have discovered..." or "Here's something nobody talks about..."

### Example

**Source:** Reddit post about using bottled water for hair

**Wrong:** Script about the Reddit user and their discovery

**Right:** Script about bottled water as partial solution, using their insight as the entry point

```
Some people have started rinsing their hair with bottled water.
And honestly, it works.
...
But it only solves part of the problem.
```

### Where to Find Angle Inspiration

- Reddit threads about the problem
- Amazon reviews of competitor products
- Support tickets and customer emails
- Facebook group discussions
- YouTube comments on related content

---

## Output Format

### Default: Script Only

Unless the user asks for visual direction, deliver ONLY the narrator script:

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
```

### With Visual Direction (On Request)

If user asks for visual notes, add at the end:

```markdown
---

#### Visual Direction Notes

[Beat-by-beat visual guidance]
[What's on screen for each major section]
[Keep brief and practical]
```

**Note:** Do NOT include separate "Pacing Notes" sections. Line breaks handle pacing.

---

## Cross-Reference Disciplines

This skill consumes contracts from prior corpus-enhancement work. The following disciplines apply rigorously:

### §8.5 Disambiguation Discipline (Session 9)

Every reference to `copywriting-guide §8.5` carries the full title `(Identification-Before-Mechanism Rule)` to disambiguate from the gated Schwartz technique #2 Identification. This discipline is now load-bearing across 6 skills (copywriting-guide as source, plus funnel-builder + angle-roadmap + ad-style-generator + ad-analysis-tagger + this skill).

### Awareness-Vocabulary Disambiguation (Session 14)

The first-use qualifier referencing `_frameworks/awareness-vocabulary.md` appears at the FIRST strategic-decision use of awareness vocabulary in any universal section. In this skill, that's Required Inputs item #1 (Awareness stage). The Awareness Stage Architecture section carries only a pointer back to that first-use location. Subsequent awareness-vocabulary references throughout the skill don't repeat the qualifier.

### Variant Name Canonical Match

Variant names match `_skills/angle-roadmap/SKILL.md` Step 5.5 exactly:
- "Variant 1: First-Person Sufferer"
- "Variant 2: First-Person Discoverer"
- "Variant 3: Third-Person Authority or Witness"

This skill is the third downstream consumer of the Lead Variants section (after ad-style-generator US-VS-OTHERS in Session 11 and ad-analysis-tagger Cross-Variant Tagging in Session 12).

### Step 1C UGC Creator Brief Canonical Match

The Step 1C UGC Creator Brief at `_skills/angle-roadmap/SKILL.md` Step 1C is the canonical source narrative for UGC video scripts when available. Reference it by full path; do not paraphrase the 5-component structure.

### Format Names as Cross-Skill Contracts

The 6 video formats are now stable cross-skill contracts:
- Voiceover Monologue (also referred to colloquially as "Yap" in triggers)
- Podcast Two-Host
- Animation / Character
- Static / Reverse Psychology
- UGC Emotional Testimonial
- AI Slop / Personified Chain

Future sessions consuming this skill (e.g., ad-analysis-tagger when extended to video tagging, future format library cross-references) should use these exact names. Format renames require coordinated edits. (Note: the historical version-history language and frontmatter wording use "seven formats" with "Yap/Voiceover" listed as a slash-separated pair; these are the same format. The canonical count is 6 distinct formats.)

---

## Schwartz Structural Layer (Gated)

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages (in the gated 6-value sense), the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

When the brand has Schwartz onboarding, video scripts apply additional structural rules on top of the universal awareness-stage architecture.

### Technique Density Per Script

Apply the technique density rule from `_skills/ad-style-generator/SKILL.md` Schwartz Structural Layer. Video scripts execute the same density rules as ad creatives:

- Unaware: 1 technique per script
- Problem Aware: 2 techniques (Mechanization + Intensification)
- Solution Aware: 2 techniques (Concentration + Mechanization)
- Product Aware (incl. Solution-Switching): 3 techniques (Concentration + Redefinition + light Identification)
- Most Aware: 1 technique (Identification or social proof)

The Three-Stage Mechanism Pattern (above, universal) maps to the gated techniques:
- Stage 1 (Problem framing) executes Intensification
- Stage 2 (Mechanism reveal with analogy) executes Mechanization
- Stage 3 (Cascade effect) executes Identification

For Solution Aware scripts that lead with Concentration (zooming in on ONE specific alternative attack), the alternative attack becomes the script's villain. For Product Aware (incl. Solution-Switching), the polemical-comparison register from ad-style-generator Style #14 US-VS-OTHERS may apply at script level.

### Sophistication Stage Adjustment

When the brand's Sophistication Stage Score (per `_skills/angle-roadmap/SKILL.md` Step 6) is 4-5 (mature category, audience has heard many competing claims), apply Camouflage as a tertiary technique. Hooks that look like organic content (UGC scripts using "Variant 1: First-Person Sufferer" in Desperation Frame; AI Slop with personified avatar) outperform brand-forward formats in mature categories.

When the Sophistication Stage Score is 1-3, brand-forward formats (Voiceover Monologue with named brand authority, Podcast Two-Host with named experts) outperform Camouflage formats.

### 38-Method Headline Tagging for Hooks

Video script hooks can also be tagged against the 12 most-used Schwartz headline methods from `_skills/ad-style-generator/SKILL.md`:
- #1 Promise a Benefit
- #2 Reveal a New Mechanism
- #4 Question Headline
- #6 Specific Number Headline
- #11 Promise of Inside Information
- #14 Statement of Astonishment
- #19 Reframed Alternative
- #20 Promise of Simplicity
- #21 Numbered List
- #25 Customer Quote
- #28 Headline as Demonstration
- #34 Single-Word Punch

When iterating hooks per the Hook Iteration Pattern, optionally tag each variant with its Schwartz method. Variants spanning multiple methods (e.g., Variant A is #2 Reveal a New Mechanism, Variant B is #11 Promise of Inside Information, Variant C is #19 Reframed Alternative) typically test better than variants all using the same method.

### Pressure Test for Video Scripts

Run the four-check pressure test from `_skills/ad-style-generator/SKILL.md` adapted to video:

1. Angle inheritance: does the script match its angle card?
2. Technique density correct for awareness stage
3. Hook uses a Schwartz method (or is method-less by deliberate choice)
4. Concentration target named (Stage 4-5 only): for video this means the polemical comparison or alternative attack is named, not generic

If any check fails, surface the finding and propose a concrete revision.

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
- Visual Direction Notes optional, at END only if requested
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

When the brand has completed angle-roadmap Phase 4.5 with Step 1C UGC Creator Brief, that Brief is the primary source narrative. Rather than generating fresh UGC narrative, this skill REFORMATS Step 1C content into the UGC video format.

**Reading Step 1C as input:**

The UGC Creator Brief at `_skills/angle-roadmap/SKILL.md` Step 1C produces 5 components for spoken delivery (60-90s):
1. Hook line (5-9 words spoken): camera-on opener; passes the spirit of `copywriting-guide §8.4 Hook Quality Checklist` translated for spoken delivery
2. Identity reveal (1-2 sentences): narrator establishment grounding `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)`
3. Root cause script (~60-80 words, ~30 seconds spoken): the 4th-grade root-cause explanation, conversational, with the analogy
4. Mechanism script (~40-60 words, ~20 seconds spoken): the 4th-grade mechanism explanation, continuing the analogy
5. Close prompt (1 sentence): hand-off line, not a sales pitch

The CTA itself does NOT come from Step 1C. Per the angle-roadmap contract, the CTA "comes from the funnel/ad context, not from the UGC clip." When generating the video script, source CTA, product introduction, and any guarantee/risk-reversal content from separate inputs (the user's CTA spec at Required Input #6, brand guidelines, funnel context). Do not invent product/CTA content from a Brief that does not contain it.

**Reformatting Step 1C for video:**
- Add line breaks as breath beats per existing format-specific rules
- Add scene cuts where the narrative beats shift (after hook line, after identity reveal, after mechanism script, before close)
- Add stage directions for emotional shifts ([narrator's voice softens], [shows product], [holds for camera])
- Map the Brief's beats into video beats: Hook line opens the script; Identity reveal anchors before any mechanism; Root cause + Mechanism scripts deliver the Three-Stage Mechanism Pattern's Stage 1 + Stage 2; Close prompt sets up the externally-sourced CTA in the script's final beat
- Apply Lead Variant selection per `_skills/angle-roadmap/SKILL.md` Step 5.5. The Brief's narrator type determines which variant carries the script: Variant 1: First-Person Sufferer, Variant 2: First-Person Discoverer, or Variant 3: Third-Person Authority or Witness.

**Variant-to-frame mapping:**
- Variant 1: First-Person Sufferer typically uses Desperation Frame opening, may pivot to Discovery Frame at eureka moment
- Variant 2: First-Person Discoverer typically uses Discovery Frame throughout
- Variant 3: Third-Person Authority or Witness typically uses Discovery Frame with measured tone

**When Step 1C is unavailable:**

If the brand hasn't completed Phase 4.5 with Step 1C, generate UGC narrative from scratch using the existing UGC structure (80% before-state, 20% product, transformation-as-vessel). This is the legacy path; the Step 1C path is preferred when available.

**Structure (universal, applied either path):**

The 80/20 ratio is content allocation; the Lead Variant choice (per `_skills/angle-roadmap/SKILL.md` Step 5.5) determines the emotional register of the 80% before-state portion; the frame (Discovery vs. Desperation) determines the energy level of the variant.

- 80% before-state suffering and identity (or Discovery Frame insider knowledge for "Variant 2: First-Person Discoverer" or "Variant 3: Third-Person Authority or Witness")
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
- [ ] No meta-commentary ("That's the mechanism", "Here's how it works")
- [ ] Passes "say it to a friend" test

**Logic Flow:**
- [ ] Every line connects logically to the next
- [ ] No skipped steps in reasoning
- [ ] Transitions are smooth and clear

**Sensory Details:**
- [ ] 2-3 relatable sensory moments included
- [ ] Moments are specific to this avatar's experience

**For Problem-Aware scripts:**
- [ ] Includes analogy for the villain/problem
- [ ] False solutions are eliminated before villain reveal

**For Product-Aware scripts:**
- [ ] Does NOT re-educate on problem
- [ ] Addresses specific objections
- [ ] Includes risk reversal element

**Format:**
- [ ] Script-only by default (no visual notes unless requested)
- [ ] No separate pacing notes (line breaks handle pacing)
- [ ] Visual direction notes at END only (if requested)
- [ ] Consistent formatting throughout

**Cross-Skill Contract Compliance (universal, always):**
- [ ] §8.5 references carry full title "Identification-Before-Mechanism Rule"
- [ ] §8.4, §8.6, §8.7, §8.8 references carry section number with full title at first use
- [ ] Awareness-vocabulary first-use qualifier present at first strategic-decision use of awareness vocabulary
- [ ] Lead Variant names from angle-roadmap Step 5.5 used by exact canonical name when applicable
- [ ] Step 1C UGC Creator Brief consumed by full path when generating UGC scripts (when Brief is available)

**Schwartz Structural Layer (only if `phase-4.5-angle-roadmap/schwartz-applied.md` exists for the brand):**
- [ ] Technique density correct for awareness stage
- [ ] Three-Stage Mechanism Pattern mapped to gated techniques (Intensification -> Mechanization -> Identification)
- [ ] Sophistication Stage Score considered for format selection (4-5 favors Camouflage formats; 1-3 favors brand-forward)
- [ ] Hooks tagged against 38-method framework when iterating
- [ ] Pressure test (4 checks) passed

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
| "Make it more technical" | Add technical education section (see Technical Education Option) |
| "Same angle, shorter" | Cut fat, keep core villain + mechanism + CTA |
| "Same angle, different execution" | Change entry point (see Angle Variation Framework) |
| "Logic doesn't flow" | Add transitional phrases, ensure each line connects to next |
| "Too much meta-commentary" | Delete "That's the mechanism" type lines |
| "Add visual notes" | Append Visual Direction Notes section at end |

---

## Version History

- **1.6.0** (Current): Added Concept Structure (Pre-Script) section: the two-stage concept-then-script flow with the ConceptCard schema (format, awareness_stage, hook_angle, structural_approach, key_beats; optional cta_hook, target_duration_seconds, concept_id, title). Documents one-concept-to-many-scripts, one-conversation-to-many-concepts, and concept-shape-mirrors-awareness-stage. Session 109.
- **1.5.0**: Added cross-skill contract consumption from Sessions 8-12 corpus-enhancement series. Wired §8.4/§8.5/§8.6/§8.7/§8.8 universal cross-references throughout (with §8.5 carrying full title per Session 9 disambiguation discipline). Added awareness-vocabulary disambiguation first-use qualifier per Session 14. Added Step 1C UGC Creator Brief consumption from angle-roadmap Phase 4.5 (first downstream consumer of that contract). Added Lead Variants integration in UGC Emotional Testimonial format (third downstream consumer of angle-roadmap Step 5.5 after ad-style-generator US-VS-OTHERS and ad-analysis-tagger Cross-Variant Tagging). Added Three-Variable Hook Framework (curiosity / specificity / identity), Three-Stage Mechanism Pattern (problem framing / mechanism reveal / cascade), Discovery Frame vs Desperation Frame, Discovery Story Format Hook cross-reference. Added Cross-Reference Disciplines section. Added gated Schwartz Structural Layer with technique density rules, sophistication stage adjustment, 38-method headline tagging, pressure test for video scripts. Updated Quality Checklist with cross-skill contract compliance items + gated Schwartz items.
- **1.4.0**: Added Upstream Format Sources section. When the user has a winning long-form-static ad and wants a video adaptation, the body copy is already written; this skill handles reformatting for delivery (timing, scene cuts, voiceover pacing) rather than generating fresh narrative. Cross-references the new long-form-static-builder skill.
- **1.3.0**: Added Angle Variation Framework, Frustration-to-Eureka Arc, Sensory Snapshot Moments, Logic Flow Rule, No Meta-Commentary Rule, Partial Solution Framing, Technical Education Option, External Content → Angle pattern, Hook Options pattern, Early Context Establishment (brand-agnostic), Script Length Variations. Made Visual Direction Notes optional (script-only default). Ensured all principles are brand-agnostic throughout.
- **1.2.0**: Made skill brand-agnostic. Removed CTA prescriptions (now user-specified). Added multiple category examples (supplement, SaaS, skincare, coaching). Changed "Geographic authenticity" to "Credibility anchor" as variable input. Generalized all brand-specific language.
- **1.1.0**: Added Awareness Stage Architecture, Hook Construction Rules, Product Introduction Sequence, removed separate Pacing Notes requirement
- **1.0.0**: Initial release with 7 formats, AI Slop sub-types, quality checklist
