# Video Script Generator Skill

## Metadata
- **Skill Name:** video-script-generator
- **Version:** 1.0.0
- **Category:** Creative / Copywriting
- **Dependencies:** None (standalone) | Enhanced with: avatar-research, brand-analyzer, copywriting-guide, angle-roadmap
- **Triggers:** "video script", "ad script", "write a script", "yap script", "podcast script", "AI slop", "video ad", "talking head script", "UGC script"

---

## Purpose

Generate high-converting direct-response video ad scripts using the Video Script Framework methodology. This skill produces scripts across seven formats (Yap, Podcast, Animation, Static, UGC, AI Slop) with proper beat structure, villain framing, and humanization rules.

---

## When to Use This Skill

**Trigger on:**
- "Write a video script for [product/brand]"
- "Create a yap script about [topic]"
- "Generate an AI slop script"
- "Write a podcast-style ad"
- "Create a UGC testimonial script"
- "Video ad for [avatar/audience]"
- "Talking head script"
- "Animation script for [product]"

**Also trigger when:**
- User has completed avatar research and wants to create video content
- User has an angle roadmap and wants scripts for specific angles
- User asks for "ad creative" and video is the implied format

---

## Required Inputs (Elicit if Missing)

Before generating any script, ensure you have:

### Minimum Viable Inputs
1. **Product name + mechanism** - What it does AND how it does it
   - Bad: "Regrowth+ helps with hair loss"
   - Good: "Regrowth+ uses chelating agents to strip mineral buildup from the scalp, then rosemary and caffeine to stimulate regrowth"

2. **Target avatar** - Who this is for, their emotional state, what they've tried
   - Bad: "Women with hair loss"
   - Good: "Expat women 25-40 in GCC, been there 1-3 years, tried supplements and diet changes, frustrated that nothing works"

3. **The villain** - The specific enemy the product defeats
   - Bad: "damage" or "toxins"
   - Good: "Calcium and magnesium deposits from hard water that build up on the scalp and block follicles"

4. **Format** - Which script type to generate
   - Options: Yap, Podcast, Animation, Static, UGC, AI Slop

5. **Awareness stage** - Where the audience is
   - Unaware (don't know the real cause)
   - Problem-aware (know they have the problem, not the cause)
   - Solution-aware (looking for a product)
   - Product-aware (know the brand, need final push)

### Optional Inputs (Enhance Quality)
- Avatar pain map (surface -> hidden pain -> core desire -> identity threat)
- Geographic/market context (GCC, UK, US)
- Brand voice characteristics
- Specific angle or hook direction
- Video length target (15-30s, 60-90s, 2-4min)
- CTA type (shop direct, quiz-first, lead capture)
- Hero ingredients list (for AI Slop format)
- Existing scripts (for voice consistency)

---

## Format Selection Guide

Present this decision tree when user hasn't specified format:

```
What's the audience's awareness stage?

UNAWARE of real cause:
├── Video 60-90s -> YAP MONOLOGUE (contrarian claim hook)
├── Video 2-4min -> PODCAST TWO-HOST (guessing game)
├── Animation budget -> PIXAR NARRATIVE (character arc)
├── AI voiceover -> AI SLOP (personified chain)
└── Static image -> REVERSE PSYCHOLOGY (satirical instruction)

PROBLEM-AWARE:
├── Emotional priority -> UGC TESTIMONIAL (personal confession)
├── Education priority -> DOCTOR ANIMATION (conspiracy reveal)
├── Both -> YAP MONOLOGUE (false solution exhaustion)
└── Virality priority -> AI SLOP CHAIN OF BLAME

SOLUTION-AWARE:
├── YAP -> Lead with "most products don't address the real problem"
└── ANIMATION -> Product as hero in mechanism story

PRODUCT-AWARE:
├── UGC TESTIMONIAL -> Social proof, result timeframe
└── REVERSE PSYCHOLOGY STATIC -> Humor + familiarity
```

---

## Script Generation Process

### Step 1: Assemble Context
Gather all inputs. If using other CA skills, pull from:
- Avatar Research -> pain map, false solutions, emotional state
- Brand Guidelines -> voice, tone, market
- Angle Roadmap -> villain framing, hook recommendations
- Copywriting Guide -> humanization rules, forbidden vocabulary

### Step 2: Select Hook Type
Match hook to format and awareness stage:

| Hook Type | Best Format | Best Awareness |
|-----------|-------------|----------------|
| Contrarian industry claim | Yap | Unaware |
| Reverse psychology | Static | Problem-aware |
| Suppressed-answer question | Podcast | Unaware |
| Personal confession | UGC | Problem-aware |
| Specific sensory before-state | Yap | Problem-aware |
| First-person body complaint | AI Slop | Unaware |
| Chain of blame opening | AI Slop | Unaware |

### Step 3: Follow Beat Structure
Every script follows this spine:

```
[HOOK] -> [FALSE BELIEF / THEY'VE TRIED] -> [VILLAIN REVEAL] -> 
[MECHANISM] -> [PRODUCT ENTRY] -> [RESULT / TRANSFORMATION] -> [CTA]
```

**Critical rule:** Product enters at 60-70% of script. NEVER earlier.

### Step 4: Apply Format Rules

**YAP / Monologue:**
- No timestamps, no columns
- Line breaks = breath beats
- Director notes at END in separate block
- Narrator IS the avatar speaking from the other side

**Podcast Two-Host:**
- HOST: knowledgeable insider
- GUEST: avatar proxy (confused, asks audience questions)
- Tension is the guessing game
- Product can enter at 75% through guest's question

**Animation / Character:**
- CHARACTER NAME: dialogue format
- Villain gets moment to gloat before hero arrives
- Stage directions in *[italics and brackets]*

**Static / Reverse Psychology:**
- HEADLINE: satirical instruction
- Step-by-step wrong behavior with checkmark
- THE FLIP: reframe + product + CTA

**UGC Emotional:**
- 80% before-state suffering and identity
- 20% product (almost incidental)
- Product is vessel for transformation already undergone

**AI Slop / Personified Chain:**
- Each element speaks in first-person
- Body parts complain, pass blame
- Villains CONFESS and gloat
- Heroes arrive and announce function
- Separated blocks (--- between elements)

AI Slop sub-types:
- Blame-Something-Else: complaints -> villain gloats -> heroes save
- Chain of Blame: each element passes blame to next until villain cornered
- Investigation: mystery framing, "I'm trying to figure out why"

### Step 5: Apply Humanization Rules

**FORBIDDEN VOCABULARY - Never use:**
delve, unlock, revolutionize, transformative, embark, journey, wellness, synergy, harness, leverage, elevate, game-changing, groundbreaking, holistic, comprehensive solution

**REQUIRED:**
- Contractions always (didn't, it's, I've)
- Vary sentence length (short. Short. Then one that earns its length.)
- Sensory specifics (what they see, feel, find on their pillow)
- Em dashes for pauses ("My hair was still falling out - every single morning")
- One idea per sentence maximum

**TEST:** Could a real person say this to a friend at dinner?

### Step 6: Build CTA

| Format | CTA Structure |
|--------|--------------|
| Yap | Benefit timeframe -> product -> action |
| Podcast | Embedded in final exchange |
| Animation | End card + tagline + simple action |
| Static | One-line flip + product |
| UGC | Identity statement -> soft product mention |
| AI Slop (Shop) | Final hero or body part delivers |
| AI Slop (Quiz) | Appeal for help -> quiz as diagnostic |

**Rule:** CTA must include benefit timeframe. "Less shedding in 2 weeks" converts better than "Try today."

---

## Output Format

Deliver scripts in this structure:

```markdown
## SCRIPT: [BRAND]_[FORMAT]_[ANGLE]_V[N]

**Format:** [Format name]
**Length:** [Target duration]
**Awareness stage:** [Stage]
**Avatar:** [One-line description]
**Villain:** [Named villain]
**Hook type:** [From taxonomy]
**CTA type:** [Shop/Quiz/Lead capture]

---

[SCRIPT CONTENT HERE]
[Use format-appropriate structure]
[Line breaks as breath beats for yap]
[CHARACTER: dialogue for animation/podcast]
[Separated blocks for AI Slop]

---

[DIRECTOR / PRODUCTION NOTES]
[Pacing guidance]
[Key moments to emphasize]
[Visual direction if relevant]
```

---

## Quality Checklist (Run Before Delivery)

Every script must pass ALL of these:

**Structure:**
- [ ] Product appears at 60%+ mark
- [ ] Hook creates loop in first 3 seconds
- [ ] Villain named and given presence before product
- [ ] CTA contains benefit timeframe
- [ ] Director notes at END, not mid-script

**Copy:**
- [ ] Zero forbidden vocabulary
- [ ] All contractions present
- [ ] Sentence lengths vary
- [ ] Every factual claim is specific (numbers, mechanisms)
- [ ] Passes "say it to a friend" test

**Format:**
- [ ] Correct structure for selected format
- [ ] No timestamps (unless animation studio delivery)
- [ ] Consistent formatting throughout

---

## Example Prompts and Outputs

### Example 1: Basic Yap Request

**User:** "Write a video script for Regrowth+ targeting expats in Dubai"

**Assistant response flow:**
1. Confirm I have minimum inputs (or elicit missing ones)
2. Recommend Yap format for unaware audience
3. Generate script following beat structure
4. Include director notes
5. Run quality checklist

### Example 2: AI Slop with Quiz CTA

**User:** "Create an AI slop script for Regrowth+ with a quiz CTA"

**Assistant response flow:**
1. Confirm sub-type (offer: Blame-Something-Else, Chain of Blame, Investigation)
2. Confirm villain elements (Hard Water, Calcium, Magnesium)
3. Confirm hero ingredients (Chelating Agent, Rosemary, Caffeine, etc.)
4. Generate script with separated blocks
5. End with quiz-framed CTA

### Example 3: Format Recommendation

**User:** "I need a video ad for problem-aware customers who've tried supplements"

**Assistant response flow:**
1. Recognize problem-aware + tried false solutions = YAP with false solution exhaustion
2. Confirm product and villain details
3. Generate script emphasizing the "tried everything, nothing worked" beat
4. Position villain reveal as the "aha" moment

---

## Integration with Other CA Skills

**After Avatar Research (Phase 2):**
- Pain map provides: surface -> hidden -> core desire -> identity threat
- False solutions list populates the "tried everything" beat
- Emotional state informs hook selection

**After Brand Guidelines (Phase 3):**
- Voice characteristics inform tone
- Market context determines geographic anchors
- Villain definition provides enemy framing

**After Copywriting Guide (Phase 4):**
- Humanization rules already defined
- Forbidden vocabulary list ready
- Tone by context mapped

**After Angle Roadmap (Phase 4.5):**
- Angle cards provide hook directions
- Villain framing already articulated
- Emotional triggers mapped to angles

---

## Iteration Patterns

When user provides feedback, apply these standard fixes:

| Feedback | Fix |
|----------|-----|
| "Make it more human" | Shorten sentences, add contractions, break monotone patterns |
| "Emphasize the villain" | Give enemy name, screen time, near-victory before product |
| "Product appears too early" | Move product entry to 60-70% mark |
| "Doesn't sound like our brand" | Request brand voice sample, adjust tone |
| "Need quiz CTA" | Replace shop CTA with diagnostic framing |
| "Too long" | Cut false solution exhaustion, tighten beats |
| "More emotional" | Expand before-state sensory detail, slow the pain |

---

## Version History

- **1.0.0** (Current): Initial release with 7 formats, AI Slop sub-types, quality checklist
