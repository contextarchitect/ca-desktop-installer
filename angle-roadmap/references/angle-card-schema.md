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
  (Universal 3-value field. See `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction. When the brand has completed Schwartz onboarding, the gated 6-value Schwartz enum from angle-roadmap Step 6 adds operational mechanics on top.)
Market Sophistication Match: [How this angle accounts for market sophistication level]

--- EMOTIONAL CORE ---

Lead Emotion: [The primary emotional trigger this angle opens with]
Trigger Score: [From the scorecard - X/10]
Lead Differentiator: [The exact Phase 1 Moat Map differentiator label/id this angle's lead framing rests on, OR the sentinel "none (pure emotional/identity hook, no differentiation claim)", OR the sentinel "ungrounded (no Phase 1 Moat Map or derivable competitive analysis)"]
  Required, non-empty. The "none" sentinel is a deliberate classification meaning the angle makes no differentiation claim and hands differentiation downstream; it is distinct from an unfilled field (an unfilled field is a defect). The "ungrounded" sentinel means the moat input itself is missing (Step 0 fail-safe): it is NOT a "no claim" judgment, it is a "cannot judge" state, and it is distinct from "none". This is the durable source field. The Moat Disposition below is re-derived from this differentiator's row in the Phase 1 Moat Map (or is "non-differentiator" when this field is the "none" sentinel, or "ungrounded" when this field is the "ungrounded" sentinel), not self-declared. QA (the Quality Checklist scan) and the Creative Engine registry compare this field against the Moat Map so a mis-tag is caught mechanically.
Moat Disposition: [LEAD / SUPPORT / AVOID / non-differentiator / ungrounded]
  The Moat Map disposition (angle-roadmap Step 0) of the Lead Differentiator above, or "non-differentiator" if the angle leads on a pure emotional or identity driver with moat grounding present, or "ungrounded" if no Moat Map or derivable competitive analysis exists to judge against. This is the second axis to Trigger Score: intensity vs defensibility. It gates prioritization (Step 7) - a SUPPORT-led angle is not eligible for priority 1 or primary cold-traffic budget (cold_traffic: false) regardless of Trigger Score; an AVOID-led angle is not produced; an ungrounded angle is not eligible for priority 1 or primary cold-traffic budget (Slot Type supporting or retargeting, cold_traffic: false) until the moat input is supplied. "non-differentiator" is primary-eligible only when grounding exists and the angle's core claim has been checked against the Moat Map.
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

--- LEAD FRAMING ROUTE ---

Lead Framing Route: [UMP / UMS / aspiration / curiosity / N/A]
  Set by the Pain Matrix in angle-roadmap Step 5 sub-step 8.
  Values:
    - UMP (Unique Mechanism of Problem): lead downstream copy with the problem mechanism. Use when avatar has High Pain (trigger score >= 8 + visceral language) and Low Awareness (Problem-aware).
    - UMS (Unique Mechanism of Solution): lead downstream copy with the solution mechanism. Use when avatar has High Pain and High Awareness (Solution-aware or Product-aware).
    - aspiration: lead downstream copy with post-product identity / transformation framing. Use when avatar has Low Pain and High Awareness.
    - curiosity: cold-traffic discovery framing; Pain Matrix routing does not apply to this angle. Use when avatar has Low Pain and Low Awareness, OR when the angle is explicitly testing a non-pain-led approach.
    - N/A: operator deliberately skipped the Pain Matrix for this angle. Downstream consumers treat N/A the same as absent field (graceful fallback to non-routed defaults).

Reference: angle-roadmap SKILL.md Step 5 sub-step 8 for the Pain Matrix routing table, input definitions, and visceral-language criteria. Downstream consumers: funnel-builder Stage 0.5 (Lead Framing Route consumer) and ad-style-generator Step 2 (Style Selection adjustment).

--- CREATIVE DIRECTION ---

Recommended Ad Formats:
  - [Format 1] - [why this format fits this angle]
  - [Format 2] - [why]

Recommended Format: [name from funnel-builder format-library.md - one of: Advertorial / Listicle-Logic / Listicle-Emotion / Listicle-Product / PAS / AIDA / SPS / 4P / Long-Form / BAB / Problem Stack / Fake-Complaint]
  Rationale: [Why this format matches this angle's awareness stage, resistance level, and emotional intensity. Reference funnel-builder/references/format-library.md format selection matrix.]
  Reference: [Path to the format's reference - e.g., `funnel-builder/references/advertorial-framework.md` for Advertorial, `funnel-builder/references/listicle-framework.md` for Listicle variants, or `funnel-builder/references/format-library.md` entry for the other 7 formats]
  Note: this is the strategic default for this angle. The funnel-builder Stage 0.2 traffic-source matrix (see `funnel-builder/SKILL.md`) overrides operationally if the actual traffic source contradicts the recommendation.

Headline Direction: [2-3 example headlines that capture this angle's core tension.
  These are NOT final copy - they're directional examples for the ad-style-generator
  and funnel-builder to riff on. Each headline should pass the
  `copywriting-guide §8.4 Hook Quality Checklist` (open loop, one specific claim,
  identity marker, specificity, first-person where brand voice allows).]

Visual Direction: [What kind of imagery this angle calls for - problem-state visuals,
  hope/transformation visuals, infographic/educational, UGC/authentic, etc.]

--- LEAD VARIANTS ---

The same angle is delivered through 3 different POV variants. Each variant is a different narrator/lens on the same root cause + mechanism + alternative attack. Variants test which voice resonates strongest with this angle's lead emotion.

Variant 1 - First-Person Sufferer:
  Narrator: [Specific avatar-matched persona: name, age, situation, occupation]
  Voice register: [How this narrator speaks - frustrated, exhausted, hopeful, vindicated]
  Lead opening: [First-line hook from this narrator's POV]

Variant 2 - First-Person Discoverer:
  Narrator: [Different specific persona - typically someone who solved the problem and wants to share]
  Voice register: [How this narrator speaks - relieved, evangelical, matter-of-fact]
  Lead opening: [First-line hook from this narrator's POV]

Variant 3 - Third-Person Authority or Witness:
  Narrator: [Authority figure (specialist, doctor, researcher) or witness (partner, friend, family member)]
  Voice register: [How this narrator speaks - clinical, observational, surprised by data]
  Lead opening: [First-line hook from this narrator's POV]

These three variants are the testing surface. Production runs all three; the winner becomes the canonical version of the angle.

(Reference: copywriting-guide §8.5 (Identification-Before-Mechanism Rule) - every variant must establish narrator identity before any mechanism explanation.)

--- MULTI-BIO-MARKER PIVOT ---

Some angles can be reframed across multiple bio-markers or symptoms while preserving the same root cause + mechanism. When the same root cause manifests across multiple felt symptoms (e.g., low testosterone -> energy / libido / recovery / focus / mood), each symptom can serve as the angle's emotional entry point.

Pivot variants for this angle:
  Primary bio-marker: [The lead symptom this angle opens with]
  Secondary pivots: [Other symptoms the same root cause produces, ranked by avatar resonance]
    e.g., for a low-T angle: primary = energy, secondaries = libido / recovery / focus

If this angle has only one bio-marker (single-symptom product, or root cause produces only one felt experience), mark "N/A - single-symptom angle."

(Reference: Rosabella variant analysis, where the same root cause pivots across multiple bio-markers in different ad variants for the same brand.)

--- TESTING METADATA ---

Testing Priority: [1-N ranking within the angle's Slot Type queue]
  Testing Priority is an ordering WITHIN a queue, not a grant of primary status. It does not by itself confer a primary slot or cold-traffic budget. The primary cold-traffic queue is ranked 1-N over primary-eligible angles only (Slot Type primary); supporting and retargeting angles are ranked in their own queues. A SUPPORT-led or ungrounded angle never holds a rank in the primary queue, so a fail-safe (all-ungrounded) roadmap has no primary rank-1 card at all. Downstream consumers selecting an angle for a primary or cold-traffic slot read Slot Type and Cold Traffic Eligible, never the bare rank number.
Slot Type: [primary / supporting / retargeting]
  Set by Step 7 prioritization, gated by Moat Disposition. Primary requires a LEAD lead, or a non-differentiator lead with moat grounding present. SUPPORT-led angles are supporting or retargeting only; an ungrounded angle is supporting or retargeting only until moat input is supplied; an AVOID-led angle is not in the roadmap.
Cold Traffic Eligible: [true / false]
  The durable cold-traffic flag (registry field: cold_traffic) consumed by the Step 8 testing roadmap and the Section 9 Creative Engine registry. Per Step 0 / Step 7: false for a SUPPORT-led or ungrounded angle regardless of Trigger Score; true requires a LEAD lead or a grounded non-differentiator lead.
Priority Rationale: [Why this angle should be tested at this priority]
Success Signal: [What would indicate this angle is working - CTR threshold, engagement type, etc.]
Kill Signal: [What would indicate this angle should be retired]
```

## Angle Types

Angles naturally fall into a few categories based on their lead emotion. A good roadmap has a mix:

### Pain-Led Angles
Open with the emotional trigger directly. The reader sees their pain reflected and is drawn in by identification (`copywriting-guide §8.5 Identification-Before-Mechanism Rule`). Works best for problem-aware audiences and high-intensity triggers (score 7+). Lead emotion typically maps to one of the five core feelings (vindication / loss aversion / betrayal / desperation / identity per `copywriting-guide §8.7`).

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
- Lead emotion + visual direction -> selects appropriate ad style from the 13-style catalogue (12 base + REDDIT-NATIVE)
- Headline direction (passes `copywriting-guide §8.4 Hook Quality Checklist`) -> starting point for ad headline development
- Lead Variants -> determines which POV the ad voice represents (first-person sufferer / first-person discoverer / third-person authority)
- Multi-bio-marker pivots -> determines whether to test the same angle across multiple symptoms
- Alternative attack -> "us vs them" ad concepts
- Avatar(s) -> demographic and psychographic targeting for image generation

### Funnel-Builder
Receives the angle card and uses:
- Root cause frame -> advertorial sections 4-5 (root cause + consequences)
- Mechanism frame -> advertorial section 6 (unique mechanism)
- Alternative attack -> integrated into background story (section 3) or root cause (section 4)
- Key objection -> addressed in close section (section 9)
- Core desire -> the emotional destination the funnel builds toward
- Recommended Format (one of 9 named formats from `../../funnel-builder/references/format-library.md` plus Fake-Complaint sub-format) -> determines the funnel structure
- Lead Variants -> determines the narrator/POV for the funnel's body copy
- UGC Creator Brief (from angle-roadmap Step 1C) -> source material when the funnel includes embedded video assets

### Creative Engine (Future)
Angles stored as Supabase entity:
- Linked to brand_id and avatar_id(s)
- Selected during ad and funnel creation conversations
- System prompt receives the full angle card as context
- Performance data (from Meta Ads) tracked per angle for optimization
