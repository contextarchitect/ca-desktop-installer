# Angle Card Schema

Each angle card is a complete, self-contained marketing strategy unit. It contains everything needed to brief an ad creative or funnel - the operator selects an angle card and the downstream skill (ad-style-generator or funnel-builder) uses it as the primary input.

## Card Structure

```
ANGLE: [Evocative name - 2-4 words]
Angle ID: [BRAND]-ANG-[SEQUENTIAL_NUMBER]
  e.g., REGROWTH-ANG-001

Summary: [One sentence that captures the complete narrative arc of this angle]

--- TARGETING ---

Avatar(s): [Which avatars this angle targets - can be 1 or multiple]
Awareness Stage: [Problem-aware / Solution-aware / Product-aware]
Market Sophistication Match: [How this angle accounts for market sophistication level]

--- EMOTIONAL CORE ---

Lead Emotion: [The primary emotional trigger this angle opens with]
Trigger Score: [From the scorecard - X/10]
Core Desire: [The deepest-core desire this angle promises to fulfill]
Desire Chain: [The full chain - surface -> functional -> emotional -> core]

--- NARRATIVE STRUCTURE ---

Root Cause Frame: [How this angle presents the root cause - which aspect to emphasize,
  which analogy to use. The same brand root cause can be framed differently per angle.
  e.g., one angle emphasizes the "internal sabotage" framing, another emphasizes
  the "your body working against you" framing - same science, different emotional entry point]

Mechanism Frame: [How this angle presents the solution mechanism - again, same mechanism
  but the emphasis shifts based on the emotional trigger.
  e.g., for a fear-led angle, mechanism emphasis is on "protection/stopping damage."
  For a hope-led angle, mechanism emphasis is on "restoration/renewal."]

Alternative Attack: [Which alternative solution(s) this angle positions against,
  and the specific "us vs them" framing]

Key Objection to Preempt: [The #1 objection this angle must handle,
  from Phase 2 objection mapping]

--- CREATIVE DIRECTION ---

Recommended Ad Formats:
  - [Format 1] - [why this format fits this angle]
  - [Format 2] - [why]

Recommended Funnel Type: [Advertorial / Listicle-Logic / Listicle-Emotion / Listicle-Product]
  Rationale: [Why this funnel type matches this angle's awareness stage and emotional intensity]

Headline Direction: [2-3 example headlines that capture this angle's core tension.
  These are NOT final copy - they're directional examples for the ad-style-generator
  and funnel-builder to riff on.]

Visual Direction: [What kind of imagery this angle calls for - problem-state visuals,
  hope/transformation visuals, infographic/educational, UGC/authentic, etc.]

--- TESTING METADATA ---

Testing Priority: [1-N ranking]
Priority Rationale: [Why this angle should be tested at this priority]
Success Signal: [What would indicate this angle is working - CTR threshold, engagement type, etc.]
Kill Signal: [What would indicate this angle should be retired]
```

## Angle Types

Angles naturally fall into a few categories based on their lead emotion. A good roadmap has a mix:

### Pain-Led Angles
Open with the emotional trigger directly. The reader sees their pain reflected and is drawn in by identification. Works best for problem-aware audiences and high-intensity triggers (score 7+).

Example: "The Stolen Identity" - leads with identity loss, the feeling of not recognizing yourself anymore. Root cause framed as something that stole a part of who you are.

### Fear-Led Angles
Open with consequences of inaction. The reader feels urgency because the problem is getting worse. Works best for problem-aware and solution-aware audiences.

Example: "The Silent Progression" - leads with the fear that the problem is worsening while they do nothing. Root cause framed as an escalating process.

### Logic-Led Angles
Open with the root cause explanation directly. "Here's what's ACTUALLY causing your problem." Works best for solution-aware audiences who have tried things and want to understand WHY nothing worked.

Example: "The Root Cause Revelation" - leads with the scientific insight. Appeals to the avatar's rational side. Root cause is the star, mechanism feels like the inevitable conclusion.

### Hope-Led Angles
Open with transformation - what life looks like after. Works best for product-aware audiences and retargeting. Requires existing trust or strong social proof.

Example: "The Comeback Story" - leads with someone who was in the same situation and found their way out. Mechanism framed as the turning point.

### Attack Angles
Open by naming the alternative the avatar has tried and explaining why it failed. "Why [alternative] didn't work for you - and what actually will." Works best for solution-aware audiences.

Example: "The Dependency Trap" - leads by attacking a specific alternative's dependency model. Root cause framed as what the alternative ignores.

## Naming Guidelines

Angle names should be:
- **Evocative** - conveys the emotional territory without being generic ("The Stolen Identity" not "Identity Loss Angle")
- **Short** - 2-4 words maximum
- **Memorable** - the team should be able to reference it in conversation ("Let's test The Silent Storm against The Dependency Trap")
- **Non-overlapping** - no two angle names should be confusable

Avoid generic names like "Pain Angle #1" or "Awareness Ad." The name IS the angle's identity.

## How Downstream Skills Use Angle Cards

### Ad-Style-Generator
Receives the angle card and uses:
- Lead emotion + visual direction -> selects appropriate ad style from the 12-style catalogue
- Headline direction -> starting point for ad headline development
- Alternative attack -> "us vs them" ad concepts
- Avatar(s) -> demographic and psychographic targeting for image generation

### Funnel-Builder
Receives the angle card and uses:
- Root cause frame -> advertorial sections 4-5 (root cause + consequences)
- Mechanism frame -> advertorial section 6 (unique mechanism)
- Alternative attack -> integrated into background story (section 3) or root cause (section 4)
- Key objection -> addressed in close section (section 9)
- Core desire -> the emotional destination the funnel builds toward
- Recommended funnel type -> determines whether to build advertorial or listicle variant

### Creative Engine (Future)
Angles stored as Supabase entity:
- Linked to brand_id and avatar_id(s)
- Selected during ad and funnel creation conversations
- System prompt receives the full angle card as context
- Performance data (from Meta Ads) tracked per angle for optimization
