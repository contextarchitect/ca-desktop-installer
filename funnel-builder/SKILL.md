---
name: funnel-builder
version: "3.4.1"
description: "Create high-converting funnel pages for e-commerce brands using a 9-format library (Advertorial, Listicle 3-variant, PAS, AIDA, SPS, 4P, Long-Form, BAB, Problem Stack, plus the Fake-Complaint sub-format). Handles the complete workflow: format selection based on awareness x resistance, objection-handling architecture, image generation via the KIE MCP (Nano Banana Pro) by default, copy creation following brand voice and the universal structural copywriting rules, and deployment via a Lovable implementation prompt. Use when user says 'build a funnel', 'create an advertorial', 'create a listicle', 'funnel page for [avatar/topic]', 'run Phase 5', or references funnel/landing page creation for any brand. Reads avatar research, brand guidelines, copywriting guide, and angle roadmap as inputs."
---

# Funnel Builder Skill

## Purpose

Create production-ready funnel pages (advertorials and listicles) by combining avatar research, brand voice, and conversion psychology into a structured workflow. The copy methodology follows a 9-section advertorial architecture and a 3-variant listicle system, both built on the awareness ladder principle: every decision flows from where the audience sits on the awareness ladder and what ad format drove them there.

This is Phase 5 in the brand development workflow: Business Validation → Avatar Research → Brand Guidelines → Copywriting Guide → **Funnel Pages** → Launch.

## When to Use

- User wants to create an advertorial or listicle funnel page
- User says "build a funnel for [topic/avatar]"
- User needs a landing page that warms cold traffic before purchase
- User has completed avatar research and brand guidelines and needs conversion pages

## When NOT to Use

This skill builds landing pages with their own URLs (advertorials and listicles served to traffic that has clicked an ad).

For Facebook in-feed ad copy where the entire advertorial body lives as the ad's primary text - the reader scrolls inside the ad, not on a separate page - use `long-form-static-builder` instead. The two skills produce structurally different outputs:

- `funnel-builder` -> Landing page with hero image, sections, CTAs, deployed via a Lovable implementation prompt
- `long-form-static-builder` -> Ad primary text (2,500-3,500 words full / 1,000-1,400 medium / 200-300 fake-complaint) plus a Reddit-native image spec, paste-ready for Meta Ads Manager

If the user says "build me an advertorial" without context, ask which they mean. The two formats serve different funnel positions: long-form-static is the ad itself; funnel-builder produces the page that ad clicks through to. A typical campaign uses both - a long-form-static ad drives clicks to a funnel-built landing page, which then drives conversion.

Do not use this skill for a **Most Aware** audience. A most-aware reader is already sold on the category and the product and should enter directly at the offer, not through an interstitial funnel page (the RMBC entry-point rule: most aware enters at the offer). Route the ad straight to the product page or offer instead. The Step 0.1 awareness early-exit gate enforces this.

**Ecosystem note (build vs diagnose).** funnel-builder is build-mode: it constructs a page forward from research. After a page ships and underperforms, the diagnostic path is the `funnel-audit` skill (`../funnel-audit/SKILL.md`) - a reverse-RMBC teardown that runs Layer 0 foundation gates, interrogates Research/Mechanism/Brief/Copy backward, runs the 15-point frame-rules pass, and returns the top 3-5 leaks ranked by Leverage x Position Weight. funnel-audit diagnoses and hands its top findings back here for the rebuild.

## Core Principles

### The Full-Picture Doctrine

Nothing works in isolation. The ad, the headline, the landing page, the close form one continuous experience. Before building any funnel page, you must understand what ad is driving traffic, what state the reader arrives in, and what the page needs to do to continue their journey.

**Causal chain:** see `references/advertorial-framework.md` section "The Yes-Yes-Yes Causal Chain" for the canonical block. Every advertorial must verify the chain before delivery.

### System 1 Principle

Root cause and mechanism explanations must activate System 1 (fast, intuitive processing). No jargon. Analogies mandatory. Visuals mandatory. A tired person scrolling at midnight must understand it. The dumbest person gets it; the most skeptical trusts it.

### Copy Length Principle

Length is determined by the job each section needs to do, not by a target word count. Every sentence must create curiosity, build belief, deepen emotional connection, or move the reader toward the next section. If a sentence could be removed without the reader missing anything, remove it. Even if the full page is long, it should never FEEL long - short paragraphs, short sentences, visual breaks every 3-4 paragraphs.

### The Persuasive Spine and Entry Point

Every persuasive page runs the same spine, in the same order:

**attention -> emotion/pain -> Root Cause Narrative -> Solution Mechanism Narrative -> proof -> offer.**

Everything after the offer is governed only by the Close ordering invariant in `references/advertorial-framework.md`; this Core Principles section does not restate any close components or order.

The spine order is fixed **through the argument body (attention through offer)**. What changes is WHERE you enter it and how fast you move through it:

- **Market awareness determines the entry point.** Cold, problem-aware traffic enters at full emotion/pain and gets the whole Root Cause Narrative reveal. Solution-aware traffic enters closer to the Solution Mechanism Narrative. Product-aware traffic can enter near the offer with a shortened pain section. Most-aware traffic does not get an interstitial funnel page at all: route it straight to the offer, per the Step 0.1 awareness early-exit gate. (Do not redefine the awareness levels here; the universal selection layer is the 3-value set Problem-aware / Solution-aware / Product-aware and Most-Aware is handled by the Step 0.1 early-exit; see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction, and the angle card's awareness stage.)
- **Format determines the pace.** An advertorial eases into the pain before the pitch; a VSL front-loads a stronger, faster emotional hook; an email takes one slice of the spine; a short-form ad is hook + one mechanism beat + CTA. The more aware the market and the shorter the format, the later you enter and the faster you reach the offer.

The spine is the macro-order of the argument, and its fixed order covers the argument body only (attention through offer). The close is governed by the **Section 9 close architecture as defined in `references/advertorial-framework.md`** (its Close ordering invariant), which is the single authority for the fine-grained close sequence; this Core Principles statement cites that authority and does not enumerate the close order itself.

This is a **complement to the Schwartz Structural Layer, not a replacement.** The spine and entry point decide the ORDER and entry beat of the argument; the Sophistication-Driven Section Weighting (in the Schwartz Structural Layer below, when `schwartz-applied.md` exists) decides which sections carry the most WORDS. They operate on different axes and compose without conflict. This skill uses the ContextArchitect names Root Cause Narrative and Solution Mechanism Narrative; the RMBC framework calls these the Unique Mechanism of the Problem (UMP) and Unique Mechanism of the Solution (UMS), per the canonical precedence in the angle-card schema's "Canonical sources and terminology" section. (See `references/copy-brief-template.md` for the brief's field mapping.)

## Critical Architecture Rule: Lovable is Execution Only

**Lovable is a frontend execution tool. It receives completed assets. It does not create them.**

| Created OUTSIDE Lovable | Provided TO Lovable |
|------------------------|-------------------|
| All copy (headlines, body, CTAs, FAQ) | Complete copy (paste in) |
| All images (via Nano Banana Pro) | Pre-generated images (upload first) |
| Page architecture and layout specs | Layout instructions |
| Tracking pixels (user provides) | Pixel code in `<head>` |



## Required Inputs

### From Previous Phases (Read First)

The 6-document input rule (Zakaria Video28): when all six upstream documents below exist, this skill REQUIRES them all before generating any copy. When some are missing, the skill proceeds but flags which inputs are degraded. Operators should always check the 6-document set before starting; missing inputs degrade output quality predictably.

1. **Avatar Research (Phase 2)** - target segments, awareness stages, language preferences, emotional triggers, platform behavior, raw quotes, day-to-day struggles. Also check for an Emotion-First Communications Framework if the brand has one. **Used for:** narrator identity, identification scenes, language calibration, objection sourcing.

2. **Root Cause Narrative** (full narrative from the Brand Angle Roadmap section `## 1. Root Cause Narrative`; per-angle framing from the selected card's `Root Cause Frame` field, per the angle-card schema's Canonical sources and terminology section) - the specific root cause this funnel argues for, with analogy and System 1 framing. **Used for:** Section 4 (Root Cause) construction.

3. **Solution Mechanism Narrative** (full narrative from the Brand Angle Roadmap section `## 2. Solution Mechanism Narrative`; per-angle framing from the selected card's `Mechanism Frame` field, per the angle-card schema's Canonical sources and terminology section) - the specific mechanism this funnel reveals, with named technique and proof points. **Used for:** Section 6 (Unique Mechanism) construction.

4. **Product Specifics** (from brand product documents / config) - actual SKU details, pricing, ingredients/components, certifications, sourcing. **Used for:** Section 8 (Product Reveal) accuracy and Section 9 (Close) value stack.

5. **Objection Inventory** (from Phase 2 Avatar Research "Objection Mapping Per Avatar" (top 3 per archetype) plus each archetype's Section L "Key Objection to Overcome"; the L/G/F derivation fallback applies for degraded inputs; the angle card's `Key Objection to Preempt` is unioned in at Step 0.5.1) - 3-5 named objections to address explicitly. **Used for:** section-by-section objection mapping (see advertorial framework Objection-Handling section).

6. **Competitor Inventory** (from Phase 1 Business Validation + brand competitor docs) - named alternatives the avatar has tried or is comparing. **Used for:** Section 7 (Product Buildup) concentration on specific alternatives.

**Plus the foundational documents (always required):**

7. **Brand Guidelines (Phase 3)** - brand colors, typography, positioning, voice pillars, visual identity.
8. **Copywriting Guide (Phase 4)** - voice rules, forbidden vocabulary, humanization principles, archetype-specific tone guidance, AND the universal structural copywriting rules in §8 (Bridge Principle, Open-Loop Principle, Time-Delay Introduction Rule, Hook Quality Checklist, Identification-Before-Mechanism Rule, Discovery Story Format, Five Core Feelings Library, Authority Hook Patterns, Claim-Proof Adjacency, First-Draft-to-Final Process).
9. **Angle Roadmap (Phase 4.5)** - the angle card driving this funnel. If the brand has completed Schwartz onboarding (i.e., `schwartz-applied.md` exists at the brand repo root, alongside `angle-roadmap.md`), the angle card will also carry Awareness Stage and Sophistication Stage Score; these determine which advertorial sections carry the most weight (see Schwartz Structural Layer section below). If the file does not exist, treat the angle card as the standard Phase 4.5 output.

### Degraded Input Handling

If any required input is missing (the 6 upstream documents #1-6, the foundational documents #7-9, or the Stage 0 brand configuration), proceed only after explicitly flagging the gap to the operator before generating copy:

- **Missing #1 (Avatar Research):** Cannot derive narrator identity or objections. Stop and request.
- **Missing #2 or #3 (Root Cause / Mechanism):** Cannot write Sections 4 or 6. Stop and request angle card or its source narratives.
- **Missing #4 (Product Specifics):** Generate Sections 1-7 with placeholders for product-specific content. Flag for user fill-in.
- **Missing #5 (Objection Inventory):** Generate but flag: objection-handling will be implicit rather than explicit. Proceed only if user accepts the degradation.
- **Missing #6 (Competitor Inventory):** Section 7 (Product Buildup) becomes generic concentration. Flag and request before proceeding when possible.

Foundational documents and brand config (feed brief fields outside the #1-6 set):

- **Missing #7 (Brand Guidelines):** Generate with placeholder visual and positioning references; flag explicitly that brand identity is unverified. Operator must accept the degradation before copy generation proceeds.
- **Missing #8 (Copywriting Guide)** (feeds brief field 15, Tone & Voice): Generate in a neutral, hype-free voice; flag the Tone & Voice field as UNVERIFIED against brand voice; note that the humanization checklist cannot be run without the brand voice guide. Operator must explicitly accept this degradation before copy generation proceeds.
- **Missing brand configuration** (Stage 0 Question Sets; feeds brief field 13 Offer and field 16 Mandatories & Compliance): Field 13 (Offer) gets placeholders flagged for user fill-in (same pattern as missing #4). Field 16 (Mandatories & Compliance) is different and asymmetric: **compliance mandatories must NEVER be guessed or generated.** If config is missing, field 16 gets an explicit BLOCKING placeholder stating that the compliance rules are unknown and the page must not ship until the operator supplies them. A fabricated compliance line is worse than a missing one, so the failure mode is blocked, not filled.

### Brand-Specific Documents (Check If Available)

Before generating image prompts, check whether the brand has any of these specialized documents. Ask the user if unsure.

10. **Ad Style Catalogue** (optional) - If the brand has a catalogue of approved ad visual styles, funnel images should align with established brand visual language.
11. **Visual Design Guidelines** (optional) - If the brand has infographic specifications (typography sizes, icon styles, color usage for data visualization), apply these before writing infographic-style image prompts.
12. **Product Photography Reference Index** (optional) - If the brand maintains a reference index mapping REF numbers to filenames, verify all product image references against this index.

### Brand-Specific Configuration (Ask User)

Before building the first funnel for any brand, collect these configuration inputs. Use the host's interactive input capability to gather them efficiently.

**Question Set 1: Traffic & Funnel Rules**

```
1. What ad format will drive traffic to this page?
   [Ugly/clickbait image / UGC-day-in-the-life / Long VSL / Targeted image+copy / 
    Advertorial ad copy (long Facebook text) / Retargeting / Other]

2. Pricing display policy: Should funnel pages show specific pricing?
   [No pricing (recommended) / Show pricing / Show savings only]

3. CTA language: What should CTA buttons say?
   [User provides, e.g., "Check Availability →", "Shop Now", "Get My Bundle"]

4. Guarantee: Do you offer a guarantee? If yes, specifics?
   [User provides, e.g., "90-day money-back, no questions asked"]

5. Product link: Where should CTAs point?
   [User provides URL]

6. Payment plans: Do you offer BNPL? Which providers?
   [User provides, e.g., "Tabby/Tamara, 4 interest-free payments"]
```

**Question Set 2: Tracking & Technical**

```
7. Tracking pixels: Which platforms need pixel tracking?
   - Meta/Facebook Pixel (ID or full code)
   - Google Analytics / Google Ads tag
   - TikTok Pixel
   - Other

8. Free shipping threshold: Is there one? What amount?
   [User provides]

9. Regional/regulatory compliance or required disclaimers: Any compliance
   language, claim restrictions, or disclaimers this brand's pages must carry?
   (e.g. health-claim rules, financial disclaimers, regional advertising rules,
    or none.) [User provides, default: none]
```

**Question Set 3: Image & Video Rules**

```
10. Brand-specific image rules: Any restrictions on imagery?

11. Product reference images: Do you have product photography that
    Nano Banana should use as reference? Provide REF numbers or filenames.

12. Brand-specific documents: Do you have any of the following?
    - Ad Style Catalogue
    - Visual Design Guidelines
    - Product Photography Reference Index

13. Video assets: Do you have existing videos to include on funnel pages?
    See references/video-guidance.md for format and placement specifications.
```

**Store these answers as `funnel-config.md` at the brand repo root (the storage artifact for the Question Set answers).** This matches the de facto artifact brand repos already carry: brands such as `regrowth/funnel-config.md` already persist exactly these settings (pricing policy, CTA language, guarantee, product links, payment plans, shipping, tracking pixels, image rules). Every subsequent funnel for the brand loads `funnel-config.md` before Stage 0 and treats it as the source of truth for the Question Set answers; only ask the Question Sets again when the file is absent or a specific answer is missing. Reuse it for all subsequent funnels.

## Workflow

**Canonical execution order. Do not reorder. Each step's inputs come from the step before it.** When in doubt about what to do next, return to this spine.

```
STAGE 0: PLANNING & ALIGNMENT
  0.1  Identify traffic source and reader state; if Most Aware, exit (route to offer, no funnel page); if cold/primary traffic, gate on the card's Slot Type + Cold Traffic Eligible before any copy
  0.2  Select format (FINAL, full 9-format decision)  <- all downstream structure depends on this
  0.3  Avatar-image alignment check
  0.4  Pull angle card's Schwartz scores (gated: only if schwartz-applied.md exists at the brand repo root)
  0.5  Pull angle card's Lead Framing Route
  0.5.1 Inherit the angle card (narrator from the selected Lead Variant, Core Desire, Alternative Attack, Key Objection to Preempt) into the planning notes
  0.6  Map content structure (uses the format finalized in 0.2)
  0.7  Map objections to sections (uses the format finalized in 0.2; unions the card's Key Objection to Preempt)
  --- Stage 0 exit gate: format final, content structure mapped, objections mapped, routing + card inheritance metadata pulled ---

STAGE 1: COPY CREATION
  → Consolidate the Copy Brief (17 fields, references/copy-brief-template.md) from the full input set (upstream #1-6, foundational #7-9, Stage 0 brand config) BEFORE any copy generation
  → Apply the Universal Structural Copywriting Rules (copywriting-guide §8) throughout
  → Write body copy following the selected format's section architecture
  → Write close section
  → Write lead (tease of full content)
  → Write headline (checked against five-element framework AND Hook Quality Checklist §8.4)
  → Run deletion pass, simplicity check, humanity check
  → Run Yes-Yes-Yes causal chain self-test
  --- Stage 1 exit gate: all copy complete and self-tested ---

STAGE 2: IMAGE GENERATION
  → Generate Nano Banana Pro prompts for each image slot from the 0.6 content map
  → Generate the images via the KIE MCP (Nano Banana Pro) by default, applying the brand's image rules from config
  → Persist each generated image to the brand's durable asset store; carry the durable URLs forward, never the Kie TTL URLs
  → Prompts-only (no generation) ONLY when the user explicitly asks for prompts
  --- Stage 2 exit gate: funnel images generated AND persisted to durable URLs (or prompts delivered on explicit request) ---

STAGE 3: LOVABLE IMPLEMENTATION (sole deployment path)
  → Verify Stage 2 funnel images exist for THIS funnel (pre-flight gate)
  → Generate a single complete Lovable prompt (copy + image URLs + brand system + compliance + tracking)
  → User pastes prompt into Lovable
  → QA review
```

### Stage 0: Planning & Alignment

Read `references/funnel-selection.md` for the complete selection matrix, ad-to-page alignment rules, and awareness stage mapping.

**Step 0.1: Identify Traffic Source (MANDATORY)**

Before anything else, determine what ad format will drive traffic. This determines the reader's mental state on arrival and what the funnel page must do. Ask the user via the host's interactive input capability if not already known from brand configuration.

| Ad Type | Reader Arrives... | Page Must... |
|---------|------------------|--------------|
| Ugly/clickbait image | Curious, unfiltered | Filter + full emotional journey |
| UGC / day-in-the-life | Curious about product | Skip broad filtering, build emotional connection |
| Long-form VSL | Emotionally invested | Focus on logic, don't repeat emotional arc |
| Targeted image + copy | Filtered, problem-aware | Go deeper into root cause + mechanism |
| Advertorial ad copy | Emotionally warmed | Logical validation → Listicle (Logic) |

**Awareness early-exit gate (run before Step 0.2).** Read the audience's awareness stage as emitted by avatar research, using the raw producer value BEFORE any collapse to the 3-value enum (the 5-to-3 mapping folds Most Aware into Product-aware, so this check must run on the raw stage or it can never fire). If that raw stage is **Most Aware**, STOP: funnel-builder is not the right asset class. A most-aware reader is already sold on the category and the product and enters at the offer, so an interstitial funnel page is not warranted (the RMBC entry-point rule: most aware enters at the offer). Exit with an explicit disposition to the operator: route the ad directly to the product page or offer, and do not build a funnel page. See the "When NOT to Use" section. Only after this exit check, map the remaining stages to the universal 3-value field via the normative 5-to-3 mapping in `_frameworks/awareness-vocabulary.md` (Unaware folds into Problem-aware with mandatory filtering; the middle three map directly) and proceed to Step 0.2.

**Cold-traffic eligibility gate (run once traffic temperature is known, before any copy).** Traffic temperature is known at this step from the traffic source above: cold/primary traffic is a first-touch cold audience (ugly/clickbait, curiosity, or targeted-image ads, and the advertorial-ad-copy combo when it drives a cold primary audience); warm traffic (VSL, retargeting, product-aware) is not gated here. When the traffic is cold/primary, read the angle card's `Slot Type` and `Cold Traffic Eligible` fields and require the card to be **(Slot Type `primary`, Cold Traffic Eligible `true`)**. If the card is not (primary, true), STOP and surface to the operator before writing any copy: "Angle card [name] is Slot Type [value] / Cold Traffic Eligible [value]; it is not primary-eligible for cold traffic. Confirm the traffic source, or select a primary cold-eligible angle, before I build this funnel." Read `Slot Type` and `Cold Traffic Eligible`, never the bare `Testing Priority` rank number (per the angle-card schema, rank is an intra-queue ordering, not a grant of primary or cold-traffic status).

This read uses the angle-card field-presence precedence keyed on `Schema Version`, but because this is a STOP gate (a gate that proceeds on a defect is not a gate), the current-schema defect branch fails closed rather than proceeding. Evaluate in order:

1. **Both `Slot Type` and `Cold Traffic Eligible` present:** apply the (primary, true) gate above, regardless of `Schema Version`.
2. **Both absent AND `Schema Version` absent (true legacy card):** degrade silently to the pre-existing behavior (there was no cold-traffic gate, so proceed without one; do NOT halt, do NOT prompt to re-run angle-roadmap). Record "legacy card, cold-traffic gate not applicable" in the planning notes.
3. **`Schema Version` present AND either `Slot Type` or `Cold Traffic Eligible` absent (current-schema defect, including the partial-missing case where only one of the two is present):** treat as a BLOCKING defect for cold/primary traffic. STOP and surface to the operator ("Angle card [name] declares Schema Version [X] but is missing Slot Type / Cold Traffic Eligible; it cannot be confirmed cold-eligible. Re-run angle-roadmap Step 7 for this angle before I build this funnel."). Do NOT proceed. Only the true legacy case in clause 2 uses the no-gate fallback.

**Step 0.2: Select Format (FINAL)**

This is the single, authoritative format decision. The format chosen here is final and drives every downstream step (content structure in 0.6, objection mapping in 0.7, section architecture in Stage 1). Do not defer or re-open it later in Stage 0. Step 0.2 executes only for awareness levels that warrant a funnel page (Problem-aware, Solution-aware, Product-aware); a Most Aware audience has already exited at the Step 0.1 awareness early-exit gate. This step ALWAYS returns exactly one canonical format name from `references/format-library.md`. There is no direct-to-product or no-format escape hatch here.

Read `references/format-library.md` for the 9 named formats and the format selection matrix. Select the format based on: traffic source (from Step 0.1), awareness stage (the universal 3-value field: Problem-aware / Solution-aware / Product-aware, which is canonical for format selection; see `_frameworks/awareness-vocabulary.md` for the universal-vs-gated distinction and the normative 5-to-3 mapping, and when Phase 2 avatar research emits a 5-value stage, map it to the 3-value enum via that mapping before selecting a format), resistance level (category maturity + price-tier + alternative-stack), and ad-format-to-page alignment (the COMBO PATTERN where advertorial ad copy leads to a Listicle (Logic) page is one example).

The default is **Advertorial** unless one of the 8 alternative formats fits the audience better. Most ContextArchitect funnels use Advertorial or Listicle; the other 7 formats are for specific audience/resistance fits.

Note: the angle card carries a `Recommended Format` strategic default (see `../angle-roadmap/references/angle-card-schema.md`). The matrix below is the operational override and applies when the actual traffic source contradicts the angle card's recommendation.

Quick-reference signal map (use alongside the full matrix in format-library.md):

| Signal | Recommended |
|--------|-------------|
| Traffic from emotional ad, needs logical validation | Listicle (Logic) |
| Traffic from curiosity ad, needs emotional + product connection | Listicle (Emotion) |
| Solution-aware audience comparing options | Listicle (Product) |
| Skeptical audience, tried alternatives, needs full journey | Advertorial (full 9-section) |
| Emotional connection needed beyond features | Advertorial |
| Advertorial ad copy → landing page | Listicle (Logic), COMBO PATTERN |

**Output of this step:** Final format name + the format's reference file (advertorial-framework.md, listicle-framework.md, or the format-library.md entry for the chosen format). Steps 0.6 and 0.7 consume this directly.

**Step 0.3: Avatar-Image Alignment Check**

Before any content or image planning:

1. Identify the target avatar from Phase 2 research
2. If the content involves a protagonist/narrator, confirm avatar matches story context
3. Confirm visual representation will match avatar demographics
4. Check for contradictions (e.g., expat story + local avatar)
5. Apply brand-specific image rules from configuration

**If misalignment detected: resolve before proceeding.**

**Step 0.4: Pull the Angle Card's Schwartz Scores**

**Gating check (run before this step).** Look for `schwartz-applied.md` at the brand repo root (alongside `angle-roadmap.md`). If the file does not exist, skip this entire step silently and proceed to Step 0.5 as if this step were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. If the file exists, run this step normally.

Open the angle card driving this funnel. Capture three values that drive Stage 1 writing:

- **Awareness Stage** (Unaware / Problem Aware / Solution Aware / Product Aware / Most Aware / Solution-Switching)
- **Sophistication Stage Score** (1-5, with most mature D2C categories at Stage 4)
- **Required Schwartz Move** (the one-sentence strategic instruction the angle card carries)

These determine which advertorial sections carry the most weight (see Schwartz Structural Layer section below).

If the angle card lacks these fields, the angle predates the angle-roadmap skill's Schwartz scoring update. Either run the angle-roadmap skill's Step 6 on the card to add them, or score them inline before proceeding.

**Step 0.5: Pull the Angle Card's Lead Framing Route**

The angle card carries a Lead Framing Route field (see `../angle-roadmap/references/angle-card-schema.md`) set by the Pain Matrix in angle-roadmap Step 5. This field determines which mechanism layer leads in this funnel's copy.

**Read the angle card's Lead Framing Route field.** The value is one of:
- **UMP** (Unique Mechanism of Problem): the funnel leads with problem mechanism in early sections. Apply heavier weight to Section 4 (Root Cause). The reader must feel the pain before the solution lands.
- **UMS** (Unique Mechanism of Solution): the funnel leads with solution mechanism. Apply heavier weight to Section 6 (Unique Mechanism Solution). The reader knows the pain; the funnel earns trust by explaining THIS solution's specific mechanism.
- **aspiration**: the funnel leads with post-product identity / transformation. Apply heavier weight to Sections 8 (Product Reveal) and 9 (Close), specifically the positive future pacing and fulfillment scene work. Pain framing is downplayed.
- **curiosity**: cold-traffic discovery framing. Pain Matrix routing does not apply. Treat the same as N/A operationally (no section weighting adjustment).
- **N/A (explicit field value):** operator considered the Pain Matrix and deliberately skipped routing for this angle. The 5-value enum's presence signals the Pain Matrix step ran. Use standard funnel weighting; no Lead Framing Route adjustment.

**Field-presence handling (evaluate in this precedence order, first match wins):**

The card's `Schema Version` field is the legacy discriminator (see `../angle-roadmap/references/angle-card-schema.md`), but a populated `Lead Framing Route` is applied regardless of version. Do not infer legacy status from any missing field other than `Schema Version`. Evaluate in order:

1. **Lead Framing Route present (any of UMP / UMS / aspiration / curiosity / N/A):** apply the routing rule above per the field value. This holds regardless of `Schema Version` (a card can carry a valid route from before the `Schema Version` field existed).
2. **Lead Framing Route absent AND `Schema Version` absent (legacy card):** the card predates the versioned schema. Apply standard funnel weighting silently. Do NOT halt the workflow; do NOT prompt the operator to re-run angle-roadmap.
3. **Lead Framing Route absent AND `Schema Version` present (current-schema defect):** a current-schema card is missing a required sibling field. Surface this to the operator as a QA flag: "Angle card [name] declares Schema Version [X] but is missing Lead Framing Route. Re-run angle-roadmap Step 5 sub-step 8 for this angle."

**Output of this step:** Record the Lead Framing Route value (or "N/A" / "absent") in the funnel's planning notes. This routes into Stage 1 (Copy Creation) where section weighting decisions are applied.

**Stacking with Schwartz Structural Layer:** if `schwartz-applied.md` exists at the brand repo root and Step 0.4 produced a Sophistication Stage Score, both the Schwartz section-weighting (Sophistication-Driven Section Weighting table in the Schwartz Structural Layer below) and the Lead Framing Route apply simultaneously. The two operate on different axes (Schwartz weights sections by sophistication; Lead Framing Route emphasizes mechanism layer entry) and compose without conflict. Apply both in Stage 1 writing.

**Step 0.5.1: Inherit the Angle Card's Narrator, Core Desire, Alternative Attack, and Key Objection**

The angle card carries the strategy this funnel executes. Before mapping content structure (0.6) or objections (0.7), read the four fields below from the same angle card opened in Step 0.5 and record them in the funnel's planning notes. These reads feed Stage 1 (narrator, desire, close) and Steps 0.6-0.7 (Section 7 concentration target, required-handle objection list).

**Field-presence handling (evaluate in this precedence order, first match wins).** This is the same rule Step 0.5 applies to Lead Framing Route, applied here to each inherited field. The card's `Schema Version` field is the legacy discriminator (see `../angle-roadmap/references/angle-card-schema.md`), but a populated inherited field is applied regardless of version. Do not infer legacy status from any missing field other than `Schema Version`. Evaluate in order:

1. **Inherited field present:** use it as described per field below. This holds regardless of `Schema Version` (a card can carry a valid value from before the `Schema Version` field existed).
2. **Inherited field absent AND `Schema Version` absent (legacy card):** the card predates the versioned schema. Fall back to that field's pre-existing derivation (named per field below) silently. Do NOT halt the workflow; do NOT prompt the operator to re-run angle-roadmap.
3. **Inherited field absent AND `Schema Version` present (current-schema defect):** a current-schema card is missing a required sibling field. Surface this to the operator as a QA flag ("Angle card [name] declares Schema Version [X] but is missing [field]. Re-run angle-roadmap to regenerate this card's [field]."), fall back to the pre-existing derivation, and proceed.

Apply that precedence to each of the following:

- **F-4 narrator (from `Lead Variants`).** Select the variant by first match, so the funnel narrator cannot silently diverge from the ad the reader clicked: (1) if the ad-style-generator creative brief for the driving ad emits a `Selected Lead Variant` (its ad-to-funnel narrator handoff), or the funnel config / campaign brief otherwise records the driving ad's variant, use that variant, since it is the exact POV the reader clicked; (2) else if a canonical winner is recorded on the card, use the winning variant; (3) else select the variant whose POV matches the traffic source from Step 0.1. Carry the selected variant's narrator name, age, situation, voice register, and lead opening into Stage 1 as the Section 3 narrator, and record them (and which selection rule fired) in the planning notes. Motivation: the funnel narrator must match the ad narrator the reader just clicked; re-inventing the POV on the page throws away the tested 2-5x spread the variant testing bought. The three variants share the same root cause, mechanism, and alternative attack, so this selection changes only the narrator POV, never the argument. Pre-existing derivation (legacy card): derive the narrator from avatar research per the Section 3 narrator options, as before.

- **F-5 Core Desire (from `Core Desire`).** Record the card's Core Desire in the planning notes. Stage 1's close step (step 5) and the Section 9 fulfillment intensification must land on that recorded desire, phrased in the avatar's own language for it. Pre-existing derivation (legacy card): derive the desire the close builds toward from avatar research (Section H Primary Wants), as before.

- **F-6 Alternative Attack (from `Alternative Attack`).** The card's Alternative Attack is the REQUIRED primary concentration target for Section 7 (Product Buildup): Section 7 must demolish it by name. The Phase 1 Competitor Inventory (input #6, Required Inputs) is the supplement pool for additional per-paragraph concentration, not the source of the primary target. Record the primary target in the planning notes for Section 7. The gated repair-diagnostic read of alternative attack in "Strengthening a Weak Advertorial" is unchanged. Pre-existing derivation (legacy card): draw Section 7 concentration from the Competitor Inventory alone, as before.

- **F-7 Key Objection to Preempt (from `Key Objection to Preempt`).** Union the card's Key Objection to Preempt into the funnel's required-handle objection list (Step 0.7), assign it a section, and give it the same QA coverage as the Phase 2 objections: the objection-completeness check in Stage 1 step 14 and the Quality Assurance checklist treat it identically. Pre-existing derivation (legacy card): the required-handle list is the Phase 2 objections only, as before.

**Output of this step:** the planning notes record the selected narrator (name, age, situation, voice register, lead opening), the Core Desire phrase, the Section 7 primary concentration target, and the card's Key Objection unioned into the required-handle list. Any defect QA flags raised above travel with the deliverable.

**Step 0.6: Map Content Structure**

Read the reference file for the format finalized in Step 0.2. Because the format is already final, this mapping is done once, with no revisiting:

- Advertorial → `references/advertorial-framework.md`
- Listicle → `references/listicle-framework.md`
- Other 7 formats → `references/format-library.md` (the entry for the selected format)
- Visual layout → `references/visual-design.md` (section-level design specs, component patterns)

Determine: section sequence, tone balance for awareness stage, CTA placement, image requirements, listicle variant (if applicable).

**Emit the image-slot table (this removes the last aspect-ratio judgment call from the image gate).** For every image slot in the content map, emit two fields alongside its filename and purpose: a `slot_type` from the fixed set {`hero`, `infographic`, `inline`, `listicle-item`} and the exact expected dimensions. The slot-type-to-dimensions mapping is fixed and covers every format, so no slot is left undefined:

- `hero` (the above-the-fold visual hook): 16:9, 1920x1080.
- `infographic` (root cause infographic, mechanism diagram, or any diagram slot): landscape 1200x800 OR portrait; pick the orientation this slot uses and record it.
- `inline` (product hero, testimonial/review, comparison, social-proof, or section-support image): landscape, 1200x800.
- `listicle-item` (a listicle item-grid image only): 1:1, 1080x1080, per the listicle item-image spec in `references/listicle-framework.md`.

A brand image rule in configuration may override a specific slot's expected dimensions; when it does, record the configured value as that slot's expected dimensions here. Stage 2 generates each image to its slot's recorded dimensions, and the Stage 3 pre-flight check 3 and the Mechanical Output Scan item 8 both read the emitted `slot_type` (never an inferred role) to decide the aspect gate.

**Visual break rule:** No more than 3-4 short paragraphs between visual elements. If you count four consecutive paragraphs without a visual break, plan an image for that gap.

**Step 0.7: Map Objections to Sections**

Pull the brand's named objections from input #5 (Objection Inventory). The primary source is Phase 2 Avatar Research "Objection Mapping Per Avatar" (the top 3 objections per archetype) plus each archetype's Section L "Key Objection to Overcome"; combined across archetypes these become the required-handle list. Then union the angle card's `Key Objection to Preempt` inherited in Step 0.5.1 into that same list (F-7), assigning it a section like any other. Target 3-5 distinct named objections. If avatar research lacks explicit objection language, keep the degraded-input fallback that derives objections from Section L ("Language to Avoid"), Section G ("Buying Behavior") decision blockers, and Section F ("Emotional Landscape") trust requirements (see `references/advertorial-framework.md` "Sourcing Objections").

Map each objection to the section(s) where it gets addressed. The mapping table is in `references/advertorial-framework.md` under "Objection-Handling Architecture." For listicle and other format choices, the mapping shifts:

- **Advertorial:** Objections handled in Sections 3 (narrator), 6 (mechanism), 7 (alternatives), 9 (close). See advertorial-framework.md Objection-Handling section.
- **Listicle:** Objections handled in item bodies: assign at least one item to each named objection.
- **PAS / AIDA / SPS / 4P:** Objections handled in the Solution / Desire / Solution / Push sections respectively.
- **Long-Form:** Same as Advertorial but with longer per-section objection coverage.
- **BAB:** Objections handled in the Bridge section (between Before and After).
- **Problem Stack:** Objections embedded in the stacked failure scenes.
- **Fake-Complaint:** Objections handled implicitly through the customer-voice complaint frame.

**Output of this step:** A list mapping each named objection to the section(s) that will address it. This list becomes a Stage 1 writing constraint.

### Stage 1: Copy Creation

**This stage produces all copy before any images are generated.**

**Step 1.0: Consolidate the Copy Brief (do this before writing a single line).**

After input gathering (the full input set: upstream documents #1-6, foundational documents #7-9, and the Stage 0 brand configuration) and Stage 0 planning are complete, and before any copy generation, consolidate the 17-field Copy Brief in `references/copy-brief-template.md`. Populate every field from the full input set (several fields draw from outside the six upstream documents: field 15 from #8 Copywriting Guide, field 13 from product specifics and brand config, field 16 from brand config). This is the RMBC Brief stage: with Research and Mechanism already settled upstream, the brief is where you assemble the argument so that writing becomes filling in each bullet in order.

- **Every field is filled from the inputs, not invented.** A field you cannot fill from the full input set is an **input gap**, not a blank to guess at. It triggers the existing Degraded Input Handling above (flag the gap to the operator; stop-and-request for the load-bearing gaps, placeholder-and-flag for the rest, and BLOCK on missing compliance config per field 16).
- **Field 17 (Section-by-Section Outline) is where the format library's section architecture gets instantiated.** Pull the section sequence for the format finalized in Step 0.2 from its reference file (advertorial-framework.md / listicle-framework.md / format-library.md), order it along the persuasive spine (Core Principles), and apply the Step 0.7 objection map so each objection lands in its assigned beat. The writing-order steps below then execute this outline.
- Terminology: fields 6 and 7 of the Copy Brief are the Root Cause Narrative and Solution Mechanism Narrative from the angle card (see `references/copy-brief-template.md` for the brief's RMBC field mapping).

This writing order is funnel-builder's instantiation of the universal body-first-lead-last drafting process (`../copywriting-guide/SKILL.md` §8.10 The First-Draft-to-Final Process). The canonical process lives there; the format-specific order below applies it to the 9-section advertorial.

**For Advertorials - Writing Order:**

1. **Immerse in avatar research** - re-read raw quotes, struggles, emotional triggers.
2. **(Only if `schwartz-applied.md` exists at the brand repo root) Apply the Schwartz Structural Layer (below) to plan section weighting** based on the angle's sophistication score. If the file does not exist, skip this step.
3. **Read the Core Feeling from the angle card** (enum canonical source: `copywriting-guide §8.7 The Five Core Feelings Library`). The whole advertorial serves that ONE core feeling; do not blend. If Core Feeling is absent, apply the schema's missing-field precedence: a legacy card (Schema Version absent) means pick one yourself; a current-schema card (Schema Version present) means flag the missing-Core-Feeling defect and pick one to proceed. Settle it before writing.
4. **Write sections 3-8 in one sitting** (Background Story → Root Cause → Consequences → Unique Mechanism → Product Buildup → Product Reveal). Continuous flow, not section-by-section.
   - Section 3 must apply `copywriting-guide §8.5 (Identification-Before-Mechanism Rule)` - the narrator must be specific (name, age, situation) and the reader must feel seen before any mechanism explanation.
   - Section 4 root cause uses one analogy (System 1 principle).
   - Sections 6 and 8 explain mechanism in plain English (System 1 principle).
   - Each section addresses its assigned objections from Step 0.7.
5. **Write section 9 (Close)** - testimonials, price anchoring, value stack, guarantee, urgency. Apply `copywriting-guide §8.8 Authority Hook Patterns` if invoking named authority in the close.
6. **Write section 2 (Lead)** - tease/summarize what the reader will discover. Written AFTER body is complete. The lead must apply `copywriting-guide §8.2 The Open-Loop Principle` - open a loop the body closes.
7. **Write section 1 (Headline)** - check against the five-element framework AND `copywriting-guide §8.4 Hook Quality Checklist`. If any quality check answer is "no," rework.
8. **Add bridges between sections** (`copywriting-guide §8.1 The Bridge Principle`) - every transition (Section 1 → 3, Section 3 → 4, Section 4 → 5, Section 5 → 6, Section 6 → 7, Section 7 → 8, Section 8 → 9, Section 9 → CTA) gets an explicit transition sentence.
9. **Apply Time-Delay Introduction** to results sections (`copywriting-guide §8.3 The Time-Delay Introduction Rule`) - every result anchored to a specific time delay before the outcome.
10. **Deletion pass** - remove any sentence that doesn't create curiosity, build belief, deepen identification, handle an objection, or move the reader forward.
11. **Simplicity check** - root cause and mechanism sections: would a tired, distracted person understand them?
12. **Humanity check** - no em dashes, no forbidden vocabulary, contractions natural, high burstiness.
13. **Yes-Yes-Yes causal chain self-test (NEW build step).** Verify the four-link chain explicitly:
    - **Root Cause click:** Does the reader believe THIS is what's causing their problem? Look for: clear cause-and-effect framing; analogy that lands; specific avatar-language acknowledgment of the symptoms.
    - **Mechanism click:** Does the reader believe THIS approach fixes that cause? Look for: System 1 explanation; named mechanism; one analogy; at least one specific number or proof point.
    - **Product click:** Does the reader believe THIS product delivers that mechanism? Look for: specific ingredient/component → specific mechanism step traceability; differentiation against named alternatives in Section 7.
    - **Close click:** Is this the obvious next step? Look for: stacked value (testimonials, anchoring, guarantee, urgency); risk reversal; payment plan if configured.

    If any link is weak, identify which section is structurally underwriting it (most commonly: Root Cause → Section 4 thin; Mechanism → Section 6 jargon-heavy; Product → Section 7 generic alternative-demolition; Close → Section 9 missing post-product fulfillment scenes). Fix before delivering.
14. **Verify objection-handling completeness.** Every objection from Step 0.7 has an explicit handle in its assigned section. If any unaddressed, the relevant section is structurally weak. Fix.

**For Listicles - Writing Order:**

1. **Determine variant** (Logic, Emotion, or Product-focused) based on traffic source.
2. **Read the Core Feeling from the angle card** (enum canonical source: `copywriting-guide §8.7 The Five Core Feelings Library`); one core feeling drives the whole list. If Core Feeling is absent, apply the schema's missing-field precedence: a legacy card (Schema Version absent) means pick one yourself; a current-schema card (Schema Version present) means flag the defect and pick one to proceed.
3. **Write item headlines first** - all items, sequenced per the variant's psychological arc. Each headline passes `copywriting-guide §8.4 Hook Quality Checklist`.
4. **Write item body copy** - maximum 2 paragraphs per item, text must not visually overwhelm the image. Each item addresses at least one objection from Step 0.7 if applicable.
5. **Write opening paragraph** - variant-specific opening. Apply `copywriting-guide §8.2 The Open-Loop Principle`.
6. **Write CTA card copy** - mid-page and final.
7. **Write guarantee section copy.**
8. **Write headline** - variant-specific, odd number mandatory; passes `copywriting-guide §8.4 Hook Quality Checklist`.
9. **Add bridges** between items where transitions don't feel earned (`copywriting-guide §8.1 The Bridge Principle`).
10. **Deletion pass** - cut any word that doesn't earn its place.
11. **Yes-Yes-Yes causal chain self-test:** for listicles, the chain compresses to: Belief in problem framing (item 1-2) → Belief in mechanism (mid-list items) → Belief in product (item containing product reveal) → Close click. Verify each link.

**Deliverable:** Complete copy document (all sections, all CTAs, FAQ, guarantee). Output as markdown file if over 500 words. Run the copy-document items of the Mechanical Output Scan (Pre-Delivery Gate) before presenting this deliverable.

### Stage 2: Image & Video Asset Preparation

**CRITICAL: Funnel images are NOT interchangeable with ad images.**

If the conversation already contains images generated by ad-style-generator for ad campaigns, those images do NOT count as funnel images. The two serve different purposes:

| | Funnel images | Ad images |
|---|---|---|
| **Purpose** | Educational, mechanism-forward, inline support for body copy | Scroll-stopping, identity-forward, feed-positioned |
| **Default aspect ratio** | Landscape (1200x800) or hero (1920x1080); infographics may be portrait; listicle item images are the exception at 1:1 (1080x1080) per the listicle item-image spec | 1:1 (1080x1080) per ad-style-generator default |
| **Visual language** | Editorial, didactic, mechanism diagrams, root cause analogies | One of 14 catalogued ad styles (BA-EMOTION, SCIENCE-FRIENDLY, REDDIT-NATIVE, etc.) |
| **Reading context** | Reader is mid-page, scrolling slowly, reading body copy | Reader is scrolling fast, must stop in 2 seconds |
| **Required slot list** | Defined in Stage 0.6 content map (hero, root cause, mechanism, product, etc.) | Defined by ad campaign brief, not funnel structure |

**Stage 2 generates the funnel's image set from scratch, every time.** Even if related ad images exist in context, they are not substitutes. Skipping Stage 2 because "we have images already" is the production failure mode this callout is designed to prevent.

**Default behavior: generate the images, do not just hand over prompts.** For every image slot in the 0.6 content map, write the Nano Banana Pro prompt AND generate the image via the KIE MCP (Nano Banana Pro). The generated image URLs are what feed the Stage 3 Lovable prompt. Generating is the default and does not require asking the user first.

**Prompts-only is the explicit opt-out.** Deliver prompts without generating ONLY when the user explicitly asks for prompts (e.g. "just give me the prompts", "I'll generate the images myself"). When in doubt, generate.

**All images are generated in Nano Banana Pro (via the KIE MCP). Never in Lovable.**
**All videos are provided by the user (pre-existing assets). Video generation is not part of this workflow.**

**Before writing any image prompts, check for brand-specific documents:**
1. Search for Ad Style Catalogue → if found, align image styles to catalogue
2. Search for Visual Design Guidelines → if found, apply infographic specs
3. Search for Product Photography Reference Index → if found, verify all REF numbers

Read the brand's image rules from configuration (Question Set 3) before writing any prompts, and apply them to every generated image. These rules are whatever the brand defined (for example demographic or representation constraints, setting restrictions, or style limits) and vary by brand. A brand may have several, one, or none; apply exactly what is configured and add nothing.

**Universal image generation rules:**

1. **Visual Reference Priority:** When a reference image exists for the product, reference it rather than describing the product verbally.

2. **Product Placement Rule:** NEVER show the brand's product in negative contexts (problem states, failure narratives, frustration scenes). Product appears only as the solution/hope/resolution.

3. **Reference Verification:** If using reference images (REF numbers), verify against the brand's product photography index before writing prompts.

4. **Nano Banana Three-Layer Model:** All prompts must follow Visible Layer + Constraint Layer + Exclusion Layer structure.

5. **Authenticity Rule:** People images should feel authentic (iPhone-quality, real body types, relatable demographics). Product images can be polished. Social proof images should look like real user-generated content.

6. **Root Cause Infographic (MANDATORY for advertorials):** Every advertorial must include at least one infographic/diagram visualizing the root cause analogy. This is a System 1 support visual, not decoration.

7. **Brand Logo Loading (MANDATORY):** Before completing Stage 2, locate the brand's logo file. Search the brand's `brand-assets/<brand>/` folder for any file with "logo" in the filename (e.g., `logo.png`, `logo-primary.svg`, `brand-logo-white.png`). Record the public URL of the logo file for inclusion in the Stage 3 Lovable prompt.

   If no file matching "logo" is found, surface the gap to the user: "No logo file found in `brand-assets/<brand>/`. Either upload a logo to that folder first, OR confirm you want to proceed without a logo (the funnel will render with text-only branding)." Do not silently proceed; the logo is part of the funnel's visual identity and missing it is a degradation worth surfacing.

**Durable Asset Persistence (MANDATORY):** The KIE MCP returns temporary URLs (Kie TTL, typically 24-48 hours). After generating every funnel image, upload each one to the brand's durable asset store at `brand-assets/<brand>/funnels/<funnel-slug>/`, and carry THOSE durable URLs forward into the Stage 2 deliverable, the image list, and the Stage 3 Lovable prompt. No Kie URL may reach the Lovable prompt. Motivation: the Lovable prompt is a document an operator may run tomorrow or re-run next month, so every URL in it must outlive the Kie TTL; durable hosting is that guarantee. The Stage 3 download-locally instruction stays in place as defense in depth (durable hosting is the primary guarantee, the local copy is the backstop). Derive `<funnel-slug>` from the funnel's working name, lowercase and hyphenated. The brand logo loaded above already lives durably under `brand-assets/<brand>/`; funnel images join it under the `funnels/<funnel-slug>/` subpath.

**Video assets:** If the user has videos to include, read `references/video-guidance.md` for placement, dimension, and naming specifications.

**Deliverable:** The generated funnel image set carried as durable-store URLs (from `brand-assets/<brand>/funnels/<funnel-slug>/`, persisted per the Durable Asset Persistence rule above, not the raw Kie TTL URLs), each tagged with its filename, purpose, the section/slot it fills, the emitted `slot_type` and expected dimensions carried over from the Stage 0.6 image-slot table, and the ACTUAL generated dimensions/aspect, plus the prompts used. Pre-flight check 3 and Mechanical Output Scan item 8 read these recorded fields (slot_type, expected dimensions, actual dimensions) directly, so they must be present for every image; a missing slot_type or a missing dimension is itself a check-3 / item-8 finding, and Stage 3 does not proceed until they are recorded. Plus a video placement map if videos are included. Output the prompt set as a markdown file if over 500 words. If the user opted for prompts-only, deliver the prompts and stop here; the user will generate the images before Stage 3.

Once the funnel images exist, proceed to Stage 3. If the user opted for prompts-only, Stage 2 ends here: resume at Stage 3 only after the user returns with the generated funnel images. Stage 3 builds a Lovable prompt around real image URLs, so it cannot run on prompts alone.

### Stage 3: Lovable Implementation

Lovable is the sole deployment path for this skill. The output of Stage 3 is a single, complete Lovable prompt that the user pastes into Lovable to render and publish the funnel page. Every asset (copy, generated images, brand design system, regional/regulatory compliance, payment and shipping details, tracking) is produced outside Lovable and handed to it fully formed. Lovable executes; it does not create assets.

### MANDATORY Pre-Flight Gate: Verify Stage 2 Completed for This Funnel

**Before writing any Lovable prompt, you MUST verify that Stage 2 (Image Generation) was completed FOR THIS SPECIFIC FUNNEL.** Skipping this gate is the most common Stage 3 failure mode in production. The failure shape: the conversation already contains images from an earlier ad-generation task (via ad-style-generator), and the funnel images appear "already done" when they are not.

**Run these five checks in order. If ANY check fails, STOP and resolve before continuing:**

1. **Funnel images exist as a distinct artifact.** A set of generated funnel image URLs (from the KIE MCP by default, or user-supplied after a prompts-only handoff), explicitly tagged as funnel images (not ad images), should exist in conversation. A prompts-only markdown with no generated images does NOT satisfy this gate, because Stage 3 embeds real image URLs. If you only see ad images, or only prompts, Stage 2 image generation was NOT completed for this funnel.

2. **Image count matches the funnel's section structure.** The Stage 0.6 content map identified specific image slots (hero, root cause infographic, mechanism diagram, product hero, testimonial visuals, etc.). The Stage 2 deliverable should have one image per planned slot. If the count does not match, Stage 2 was incomplete.

3. **Image dimensions match the emitted slot_type's spec, not ad format.** For each image, read the `slot_type` and expected dimensions the Stage 0.6 image-slot table emitted for its slot. This is a lookup, not a role inference: the judgment about which role a slot plays was already made and recorded at Stage 0.6, so this gate only compares the image's recorded aspect against its slot_type's fixed expected-aspect set. Each slot_type resolves to a FIXED set:
   - `hero`: {16:9} (1920x1080).
   - `infographic`: {landscape, portrait} (1200x800 or portrait; a diagram may legitimately be either orientation, but never square).
   - `inline`: {landscape} (1200x800).
   - `listicle-item`: {1:1} (1080x1080) per the listicle item-image spec in `references/listicle-framework.md`. Here 1:1 is CORRECT, not an ad-image tell; do not reject a listicle item image for being square.
   A brand image rule in configuration may override a specific slot's expected dimensions; when Stage 0.6 recorded a configured override for a slot, gate against that recorded value. `1:1` is in only the `listicle-item` set, so any image recorded at 1:1 in a `hero`, `infographic`, or `inline` slot is an ad image recycled by mistake (ad-style-generator defaults to 1:1, 1080x1080) - reject it. An image passes iff its recorded aspect is in its slot_type's set, so two reviewers reach the same accept/reject verdict on the same slot. The gate's intent is unchanged: stop ad images being recycled as funnel images.

4. **Image purposes match funnel needs.** Funnel images are educational and mechanism-forward (root cause analogies, mechanism diagrams, product hero shots in editorial framing). Ad images are scroll-stopping and identity-forward (BA-EMOTION, SCIENCE-FRIENDLY, LIFESTYLE, etc. per ad-style-generator's 14-style catalogue). If the images in context were generated for ad styles, they do not substitute for funnel images.

5. **Image URLs are durable, not Kie TTL URLs.** Every funnel image URL carried into the Lovable prompt must resolve to the brand's durable asset store (`brand-assets/<brand>/funnels/<funnel-slug>/`), the persistence output of Stage 2. If any image URL points at a `kie.ai` host, Stage 2 persistence was skipped: the URL will 404 once the Kie TTL expires (24-48h) and the operator cannot re-run the Lovable prompt later. Halt and run Stage 2 persistence before continuing.

**If any check fails, halt and push back:**

> "Before I build the Lovable prompt, I need to confirm Stage 2 (funnel image generation) was completed for this funnel. The images currently in context appear to be [ad images / from a different task / missing]. Funnel images are distinct in purpose, format, and dimensions from ad images. Let me generate the funnel images first."

Then run Stage 2 properly: write the Nano Banana prompt for each funnel image slot identified in Stage 0.6 and generate each image via the KIE MCP (Nano Banana Pro), then return to Stage 3 with the generated funnel images.

**Do NOT proceed with the Lovable prompt until all funnel images exist and are approved.** Even if the user asked you to "just generate the Lovable prompt," push back. The skill workflow requires the gate.

Read `references/visual-design.md` for section-level layout patterns, component specifications, and design rules. Apply brand-specific colors/typography from brand guidelines (Phase 3) on top of these structural defaults.

Generate a single, complete Lovable prompt containing:
- All copy (pre-written, not generated by Lovable)
- **Image URLs and download instructions (MANDATORY):**
  - Include the durable-store URL of each funnel image from Stage 2 (from `brand-assets/<brand>/funnels/<funnel-slug>/`, persisted per the Stage 2 Durable Asset Persistence rule). Never a Kie TTL URL: a `kie.ai` host in the Lovable prompt is a defect the Stage 3 pre-flight gate (check 5) rejects.
  - **CRITICAL: Instruct Lovable to download each image locally to the project assets (defense in depth).** Even though the source URLs are durable, a local copy in the project assets keeps the page self-contained and removes any runtime dependence on the asset store. If Lovable references URLs directly via `<img src="[URL]">` without downloading, the page stays dependent on the host remaining reachable.
  - Sample wording to include in the Lovable prompt: "Download each of the following images and save them to the project's image assets folder. Reference them locally in the rendered page. Do NOT hotlink the URLs; keep the page self-contained."
  - List each image with: filename to save as, source URL, and the section/position where it should render
- **Brand logo (MANDATORY when available):**
  - Search the brand's `brand-assets/<brand>/` folder for any file with "logo" in the filename
  - Include the logo URL in the Lovable prompt with the same download-locally instruction as above
  - Specify the logo placement: header (always) and footer (when applicable)
  - If no logo file exists in `brand-assets/<brand>/`, surface this gap to the user before generating the prompt: "No logo file found in `brand-assets/<brand>/`. Either upload a logo to that folder first, OR confirm you want to ship the funnel without a logo (Lovable will render with text-only branding)."
- Video embed instructions if applicable (see `references/video-guidance.md`)
- Section-level layout specifications (from `references/visual-design.md`)
- **Awareness-stage CTA placement:** key the first CTA's position to traffic warmth. Per the above-the-fold First CTA rule in `references/visual-design.md`, warm / product-aware traffic can carry the first CTA above the fold, while cold / earlier-awareness traffic gets the first CTA later, after the full run-up. State the stage-appropriate first-CTA position explicitly in the prompt. (`references/visual-design.md` documents the first-CTA warmth rule; it does not define a full stage-by-stage layout or section-depth system, so do not invent one beyond first-CTA positioning.)
- Brand design system (colors, typography from brand guidelines)
- Component specifications (CTA buttons, urgency banner, trust icons, review cards, guarantee section per visual-design.md)
- **Payment plans and free shipping (from brand config):** if the brand configured BNPL providers or a free-shipping threshold (Question Set 1 and Question Set 2), state them where they belong on the page (near price/CTA and in the close). Omit if not configured.
- **Regional/regulatory compliance and disclaimers (from brand config Question Set 2, if any):** if the brand configured compliance language, claim restrictions, or required disclaimers, include them verbatim in the page (typically footer and near any claim). If the brand has none, omit entirely. This is brand-specific: include exactly what is configured and add nothing.
- Tracking pixel code in `<head>` section (all configured pixels)
- UTM passthrough script in `<head>` section (MANDATORY, see reference framework)
- Technical requirements (responsive, accessible, performant)

**Output format:** Any Lovable prompt over 500 words must be delivered as a single downloadable markdown file (create the file and present it for download using the host's file-creation and file-presentation capability). Never break long prompts into multiple copyable sections in chat.

Run the Lovable-prompt items of the Mechanical Output Scan (Pre-Delivery Gate) before presenting the Stage 3 deliverable.

## Schwartz Structural Layer (Advertorial Section Mapping)

**Gating check (run before this section).** Look for `schwartz-applied.md` at the brand repo root (alongside `angle-roadmap.md`). If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

The 9-section advertorial format is structurally aligned with the seven techniques from Eugene Schwartz's Breakthrough Advertising. The angle card's Sophistication Stage Score (from the angle-roadmap skill, Step 6) determines which sections carry the most weight.

This section provides the section-by-section technique map and the sophistication-driven weighting rules. Use these when writing or auditing an advertorial.

### Section-by-Section Technique Map

| Phase 5 Section | Primary Technique | Secondary | Why |
|----------------|-------------------|-----------|-----|
| 1. Above the Fold | Headline method | Identification | Stops the scroll, signals who the piece is for |
| 2. Lead | Identification | Camouflage | Establish narrator and authentic content surface |
| 3. Background Story | Identification | Intensification | Build narrator identity through specific scenes the reader recognizes |
| 4. Root Cause | Mechanization | Gradualization | Name the mechanism in plain English; build the small-claim → bigger-claim chain |
| 5. Consequences | Intensification | Concentration | Make the do-nothing path vivid; concentrate on specific deteriorations |
| 6. Unique Mechanism | Mechanization | Redefinition | Name the solution mechanism; redefine the desire it satisfies |
| 7. Product Buildup | Concentration | Gradualization | Demolish the alternatives the reader has tried; sequence belief toward the product |
| 8. Product Reveal | Mechanization | Redefinition | Tie product specifics back to the mechanism; reframe objections |
| 9. Close | Identification | Intensification | Final identity reinforcement; final fulfillment scenes |

**The seven techniques (definitions):**

1. **Intensification** - build desire by making the fulfilled state vivid through multiple specific scenes
2. **Identification** - give the reader a felt identity to step into
3. **Gradualization** - sequence claims so each one earns belief from the one before
4. **Redefinition** - reframe a desire, problem, or alternative so a different solution becomes obviously correct
5. **Mechanization** - give proof a physical, mechanical, named explanation
6. **Concentration** - zoom in on ONE specific competitor or alternative and demolish it
7. **Camouflage** - hide the sales pitch inside a different surface (story, editorial, expose, FAQ)

### Sophistication-Driven Section Weighting

The angle's Sophistication Stage Score determines where the writing weight goes. Most mature D2C categories sit at Stage 4 by default.

| Sophistication Stage | Sections that carry the load | Why |
|----------------------|------------------------------|-----|
| Stage 2-3 | Sections 4 (Root Cause) and 6 (Mechanism) | The mechanism is news. Spend words there. |
| Stage 4 | Sections 7 (Product Buildup) and 8 (Product Reveal) | The reader has heard mechanism claims before. Proof and demolition of alternatives carry the trust. |
| Stage 5 | Sections 2-3 (Lead + Background Story) | The reader is exhausted by the category. Identification with their exhaustion is the entry point. |

The most common structural error: a Stage 4 angle with a thin Section 7. Underwriting Section 7 in a Stage 4 market is the leading cause of weak conversion.

### Intensification Rhythm in the Body Story

In Section 3 (Background Story), rotate through 3-5 specific moments, each from a different angle. Different times of day, different locations, different witnesses, different textures. Variety, not amplification of one description.

In Section 9 (Close), rotate through 3-5 specific moments of the FULFILLED state. The same intensification pattern, applied to the post-product identity.

This bookend (intensification of the struggle in Section 3, intensification of the fulfillment in Section 9) is the most powerful structural move in long-form copy.

### Concentration in Section 7

Section 7 is where existing alternatives get demolished. The rule: concentrate on ONE alternative per paragraph. Demolish it specifically with mechanism + numbers. Then move to the next. Do not aggregate ("most alternatives are bad") - generic concentration loses force.

The primary concentration target is the angle card's `Alternative Attack` inherited at Step 0.5.1 (F-6): Section 7 must demolish it by name. The Competitor Inventory (input #6) is the supplement pool for the remaining per-paragraph targets, not the source of the primary one. On a legacy card with no Alternative Attack, the concentration targets come from the Competitor Inventory alone, as before.

Common concentration targets across categories:

- Underdosed competitors (specific dose vs. clinical-study dose)
- Proprietary blends (hidden doses)
- Pharmaceutical alternatives (mechanism gap, dependency)
- Lifestyle alternatives (caffeine, diet alone, exercise alone)
- Doing nothing (the problem doesn't plateau; it tightens)

### Camouflage at the Format Level

The whole advertorial is camouflage. The reader thinks they are reading a first-person story, an editorial, or an expose. Structurally it is a sales argument.

For the camouflage to work:

- The narrator must be specific (name, age, location, occupation, family situation)
- The narrator's experience must be authentic enough to read as content
- The product reveal must arrive late, after the reader has already accepted the mechanism story
- The CTA must be embedded in the close and the FAQ, not pasted at the bottom

### Strengthening a Weak Advertorial

When a published advertorial is underperforming (read-through under 40%, CTA click-through under 2.5%), use this diagnostic procedure:

1. **Confirm angle inheritance.** Read the advertorial against the angle card. Does the mechanism, root cause frame, and alternative attack match? Drift in long-form is the highest-priority finding if present.

2. **Section-by-section technique read.** For each of the 9 sections, identify which primary technique the section carries (table above). Does the section actually carry it? What is weak: technique missing, under-loaded, executed in wrong voice, or running the wrong technique entirely?

3. **Sophistication-based section weighting check.** Apply the weighting rule above. If the heaviest sections in the copy are mismatched to the angle's sophistication score, that is the structural cause. The most common case: a Stage 4 angle with a thin Section 7.

4. **Identify the limiting section.** One section is usually disproportionately weak. Conversion is gated by it. Common diagnoses:
   - Section 3 thin → add specific failed-attempt scenes for Intensification
   - Section 4 jargon-heavy → add the analogy + plain-English mechanization
   - Section 5 abstract → make the do-nothing path vivid with specific deteriorations
   - Section 7 generic → concentrate per-paragraph on specific alternatives
   - Section 9 only does CTA + guarantee → add fulfillment-scene Intensification

5. **Rewrite the limiting section in brand voice.** Use the primary technique from the table. Pass the brand's full Phase 4 humanization checklist. Match surrounding sections' length proportionally. Do not balloon a section out of structural balance.

6. **Present the rewrite to the user.** Per the workflow efficiency protocol, present before committing.

**If this brand has not yet completed Schwartz onboarding:** see `_frameworks/breakthrough-advertising-brand-onboarding.md` in `contextarchitect/context-architect-brands` for the 30-60 minute scoped session that produces `schwartz-applied.md`.

## Mechanical Output Scan (Pre-Delivery Gate)

**Run this scan mechanically over the two finished artifacts, the copy document (Stage 1) and the Lovable prompt (Stage 3), before presenting either deliverable. It is one pass, not a re-read of the prose rules: each item is a literal check against the finished text, and each is the authoritative enforcement of a rule that earlier sections state as prose guidance. Where a per-slot prose rule and a scan item overlap, the prose stays as guidance and the scan item is what gates delivery (enforcement-over-prose). A failing item is a finding to resolve before the artifact is presented, not a soft preference.**

Scan the copy document before presenting the Stage 1 deliverable; scan the Lovable prompt before presenting the Stage 3 deliverable. Each item names the artifact it runs against. Several items additionally check an artifact against a delivery-side reference the artifact must agree with: item 8 reads image dimensions from the Stage 2 image-list deliverable; items 9 and 10 read the angle card's `Core Feeling` field and the funnel planning notes' recorded awareness value; and items 11-15 read the angle card's inherited fields (narrator from `Lead Variants`, `Alternative Attack`, `Key Objection to Preempt`, `Core Desire`) and the planning notes' recorded cold-traffic eligibility, all captured at Stage 0.5.1 (and, for cold-traffic eligibility, the Step 0.1 gate); item 11 additionally reads the ad-style-generator brief's `Selected Lead Variant` handoff. Those references are named inline; they are grounding inputs for the check, not extra free-text artifacts to eyeball.

- [ ] **(1) Zero em dashes** in both artifacts. Literal character scan for the em dash; require zero hits. (Copy document + Lovable prompt.)
- [ ] **(2) Zero forbidden-vocabulary hits** per the copywriting guide's humanization rules (`../copywriting-guide/references/humanization-rules.md`). Scan both artifacts against the forbidden-vocabulary list; require zero hits. (Copy document + Lovable prompt.)
- [ ] **(3) Zero Schwartz-layer vocabulary when the gate is closed.** Active ONLY when `schwartz-applied.md` is absent from the brand repo root (the gate is closed). The enforceable check is a literal case-insensitive search of both artifacts for each term in the fixed gag-rule list ("Schwartz", "sophistication", "awareness stage", "the seven techniques", "technique density", "38 headline methods") plus the singular and plural inflection of each; require zero hits. Beyond that fixed floor, also reject any other Breakthrough-Advertising vocabulary you recognize, but the fixed list is what mechanically gates delivery. When `schwartz-applied.md` exists, this item is not applicable: the gate is open and the vocabulary is permitted in internal planning. (Copy document + Lovable prompt.)
- [ ] **(4) CTA text and href match configuration.** Every CTA button label equals the configured CTA text, and every CTA href equals the configured product URL, from the brand funnel configuration (Question Set 1). No CTA carries placeholder text or an unconfigured link. (Lovable prompt; copy document where CTA copy appears.)
- [ ] **(5) Numeric pricing presence matches the configured pricing policy.** Presence check only, one of three policy branches (from `funnel-config.md`, Question Set 1):
  - **No pricing:** zero numeric price strings appear anywhere in the close, neither the brand's price nor any alternative's dollar figure. A savings percentage (for example "40% off") is not a price string and is permitted.
  - **Show savings only:** the configured savings figure or percentage is present, and the brand's own base/regular price does NOT appear (alternative anchor prices may appear).
  - **Show pricing:** the configured brand price is present.
  This checks presence against policy; the policy-branch prose lives in `references/advertorial-framework.md` (9c/9d) and this item is its enforcement. (Lovable prompt; copy document close section.)
- [ ] **(6) UTM passthrough script and configured pixels present verbatim** in the Lovable prompt head. The UTM passthrough script (see `references/advertorial-framework.md`) and every configured tracking pixel (Question Set 2) appear verbatim in the `<head>`, not paraphrased or summarized. (Lovable prompt.)
- [ ] **(7) One image URL per Stage 0.6 slot, every URL durable.** Each image slot from the Stage 0.6 content map maps to exactly one image URL in the Lovable prompt (the count of image URLs equals the count of planned slots), and every image URL resolves to the durable asset-store path `brand-assets/<brand>/funnels/<funnel-slug>/`. The mechanical check: zero image URLs carry `kie.ai` as their host. This is the delivery-time restatement of the Stage 3 pre-flight URL check (check 5). (Lovable prompt.)
- [ ] **(8) Per-image aspect matches the emitted slot_type's spec.** For each image, read its recorded dimensions from the Stage 2 image-list deliverable (which tags every image with filename, slot, and dimensions) and confirm the recorded aspect is in the expected-aspect set for that image's emitted `slot_type` from the Stage 0.6 image-slot table, the same set pre-flight check 3 uses (`hero` {16:9}; `infographic` {landscape, portrait}; `inline` {landscape}; `listicle-item` {1:1}). `1:1` is in only the `listicle-item` set, so any funnel image recorded at 1:1 in a `hero`, `infographic`, or `inline` slot fails. If the Stage 2 image list records no `slot_type` or no dimensions for an image, that missing metadata is itself a finding. (Stage 2 image-list deliverable; the Lovable prompt inherits these images.)
- [ ] **(9) Declared Core Feeling equals the angle card's Core Feeling field** when the field is present. The mechanical check: the single Core Feeling the copy document declares it serves (recorded in the copy-document header or planning notes, from the five-value enum in `copywriting-guide §8.7`) is string-equal to the `Core Feeling` field read from the angle card. Whether the prose actually holds to that one feeling throughout is a qualitative concern handled by the Quality Assurance checklist, not by this mechanical item. When the card field is absent, this item defers to the Stage 1 missing-field precedence (legacy card picks one; current-schema card flags the defect and picks one) and is not a scan failure on its own. (Copy-document header / planning notes, checked against the angle card.)
- [ ] **(10) Planning-note awareness value is inside the universal 3-value enum,** with the 5-to-3 mapping recorded when applied. The mechanical check: the awareness value recorded in the funnel planning notes is exactly one of the three enum strings (Problem-aware / Solution-aware / Product-aware); any value outside that set, including a raw 5-value stage such as Most Aware or Unaware, is a finding. When avatar research emitted a 5-value stage, the planning notes must also carry the applied 5-to-3 mapping line (per `_frameworks/awareness-vocabulary.md`); its absence is a finding. The Most Aware early-exit (Step 0.1) runs on the raw stage before this collapse, so a planning-note value of Most Aware means the early-exit was missed. (Funnel planning notes.)

**Slice-2 inheritance items (the reserved slots, now checkable).** These extend the scan; they enforce the Stage 0.5.1 angle-card inheritance. Each follows the same present/absent discipline as item 9: when the card field is present the item is a hard check; when the card field is absent it defers to the Stage 0.5.1 missing-field precedence (legacy card uses the pre-existing derivation; current-schema card flags the defect) and is not a scan failure on its own.

- [ ] **(11) Narrator identity served equals the selected Lead Variant's narrator, and matches the ad handoff when present.** The mechanical check has two parts:
  - (a) When the card's `Lead Variants` are present: the narrator identity the copy document establishes in Section 3 (name, age, situation, recorded in the copy-document header or planning notes) is string-equal to the narrator name/age/situation of the Lead Variant selected at Step 0.5.1.
  - (b) When the driving ad's ad-style-generator brief carried a `Selected Lead Variant` handoff naming a variant: the Section 3 narrator name/age/situation is string-equal to that handoff's narrator, so the funnel narrator matches the ad the reader clicked. If the driving ad was produced by ad-style-generator (v1.7.0+) but no `Selected Lead Variant` handoff is present in the planning notes, OR the handoff is the current-schema defect marker (`DEFECT (Schema Version present, Lead Variants missing)`), that missing or unverifiable handoff is a finding (the ad-to-funnel narrator match cannot be verified). When the handoff is the legacy `none` sentinel there is no card-anchored POV to match and sub-check (b) does not apply. Ads produced outside ad-style-generator carry no handoff and do not trigger this sub-finding.
  When the card carries no `Lead Variants` AND there is no ad handoff, this item defers to the Stage 0.5.1 precedence and is not a scan failure on its own. (Copy document Section 3 / planning notes, checked against the angle card and the ad-style-generator brief's `Selected Lead Variant`.)
- [ ] **(12) Section 7 names the card's Alternative Attack as a concentration target** when `Alternative Attack` is present. The mechanical check is a string-presence test: the angle card's `Alternative Attack` label (recorded as the Section 7 primary concentration target at Step 0.5.1) appears verbatim (or as its recorded label) in Section 7's list of named alternatives in the copy document. Whether the demolition is persuasive is a Quality Assurance concern, not this item. When the card carries no `Alternative Attack`, this item defers to the Stage 0.5.1 precedence (concentration targets come from the Competitor Inventory) and is not a scan failure on its own. (Copy document Section 7, checked against the angle card.)
- [ ] **(13) The card's Key Objection has an objection-map row and appears in its assigned section** when `Key Objection to Preempt` is present. The mechanical check is two string-presence tests: (a) the Step 0.7 objection map contains a row for the card's `Key Objection to Preempt` with an assigned section id; and (b) that assigned section of the copy document contains the objection's text (or its recorded objection label). Whether the handle actually resolves the objection is a Quality Assurance concern, not this item. When the card carries no `Key Objection to Preempt`, this item defers to the Stage 0.5.1 precedence and is not a scan failure on its own. (Step 0.7 objection map + copy document, checked against the angle card.)
- [ ] **(14) Cold-traffic eligibility is recorded for cold/primary builds.** Active ONLY when the traffic source is cold/primary (Step 0.1). The mechanical check: the funnel planning notes carry the Step 0.1 cold-traffic gate's recorded read (either the eligibility result Slot Type `primary` / Cold Traffic Eligible `true`, or, on a legacy card, the recorded "legacy card, cold-traffic gate not applicable" disposition). Its absence on a cold/primary build is a finding (the gate was skipped). For warm traffic this item is not applicable. (Funnel planning notes.)
- [ ] **(15) The recorded Core Desire phrase appears in the close** when `Core Desire` is present. The mechanical check: the Core Desire phrase recorded in the planning notes at Step 0.5.1 (from the angle card's `Core Desire`) appears in the copy document's close (Section 9). When the card carries no `Core Desire`, this item defers to the Stage 0.5.1 precedence (the close desire is derived from avatar research) and is not a scan failure on its own. (Copy document close section / planning notes, checked against the angle card.)

## Quality Assurance

After Stage 3, verify against this checklist:

**Conversion Architecture (Advertorial Only):**
- [ ] **Causal chain verified:** Root Cause → Mechanism → Product flows logically
- [ ] **System 1 compliance:** Root cause and mechanism would be understood by a tired, distracted reader
- [ ] **Analogy present:** Root cause has at least one real-world analogy
- [ ] **Root cause infographic planned:** Visual explanation of root cause included in image list
- [ ] **Villain externalized:** Root cause shifts blame from reader to external factor
- [ ] **Consequences section present:** Urgency created between root cause and mechanism
- [ ] **Product buildup present:** Perceived value built before product reveal
- [ ] **Close architecture complete:** Testimonials → Anchoring → price elements per configured pricing policy → Value stack → Guarantee → CTA. This is the canonical order: proof first, then the offer and value case, then risk reversal (the guarantee), then the ask (the CTA). Risk reversal precedes the ask, and positive future-pacing sits inside the close.
- [ ] **Lead written last and teases full content**
- [ ] **Headline passes quality check:** All five elements evaluated, all gut-check questions answered "yes"
- [ ] **Yes-Yes-Yes causal chain explicitly verified:** all four links (Root Cause click → Mechanism click → Product click → Close click) tested per Stage 1 step 13 self-test; no weak links remaining
- [ ] **All objections from Step 0.7 explicitly addressed** in their assigned sections per `references/advertorial-framework.md` Objection-Handling Architecture

**Universal Structural Copywriting Rules (All Formats) - from `copywriting-guide §8`:**
- [ ] **Bridges present at every section transition** (`§8.1 The Bridge Principle`): explicit transition sentence between each major section
- [ ] **Open-loop discipline** (`§8.2 The Open-Loop Principle`): every paragraph opens / deepens / closes a loop; "best-copy-can-start-at-any-line" test passes
- [ ] **Time-delay anchors on all results** (`§8.3 The Time-Delay Introduction Rule`): every result statement anchored to a specific time delay
- [ ] **Hook Quality Checklist passed** (`§8.4`): all 5 points (open loop, one claim, first-person where brand voice allows, specificity, identity marker)
- [ ] **Identification before mechanism** (`§8.5 Identification-Before-Mechanism Rule`): narrator/reader feels seen before any mechanism explanation lands
- [ ] **One core feeling, not multiple** (enum canonical source `copywriting-guide §8.7 The Five Core Feelings Library`): the Core Feeling read from the angle card drives the whole piece
- [ ] **Authority hook from the named four patterns** (`§8.8 Authority Hook Patterns`): when invoking authority, one of Classic/Doctor's Surprise/Doctor's Skepticism/Study-Research is used (not a hybrid)
- [ ] **Claim-proof adjacency:** every claim has its proof beside it, not stranded paragraphs away from the claim it supports
- [ ] **No dead-end sections:** every section hands off with an open loop; the reader never hits a comfortable stopping point before the offer (builds on `§8.1 Bridge` + `§8.2 Open-Loop`; this check is specifically that no section is a premature exit)

**Schwartz Structural Layer (Advertorial Only) (only if `schwartz-applied.md` exists at the brand repo root):**
- [ ] **Section technique map applied:** every section carries its primary technique
- [ ] **Sophistication weighting matches the angle's score:** heaviest sections align with the rule
- [ ] **Section 3 intensification present:** at least 3 different specific scenes of the struggle
- [ ] **Section 7 concentration specific:** at least 2 alternatives demolished per-paragraph (not aggregated)
- [ ] **Section 9 fulfillment intensification present:** at least 3 different specific scenes of the post-product state
- [ ] **Camouflage surface authentic:** narrator is specific (name, age, situation); product reveal arrives in Section 8, not earlier

**Listicle Architecture:**
- [ ] **Correct variant selected** for traffic source (Logic / Emotion / Product)
- [ ] **Item sequencing follows variant arc** (not random order)
- [ ] **Odd number of items** (5, 7, 9, 11)

**Content Quality (All Types):**
- [ ] Run the copywriting-guide humanization checklist (see `../copywriting-guide/references/humanization-rules.md`). All universal rules + all brand-specific additions must pass.
- [ ] Avatar-appropriate tone and language
- [ ] Brand-specific compliance rules followed
- [ ] **Deletion pass completed:** Every sentence creates curiosity, builds belief, or moves reader forward
- [ ] **Visual break rule:** No more than 3-4 consecutive paragraphs without a visual element

**CTA Compliance:**
- [ ] **One-ask rule:** each CTA makes exactly one request; no dual CTAs ("Shop Now / See the Science") and no paragraph-long asks
- [ ] Pricing policy followed (per configuration: show-pricing / show-savings-only / no-pricing)
- [ ] All CTAs use configured language
- [ ] All CTAs link to configured product URL
- [ ] Guarantee referenced per configuration
- [ ] Payment plans mentioned if configured

**Technical:**
- [ ] **Funnel images exist** for every slot in the 0.6 content map (generated via the KIE MCP by default, or user-supplied after a prompts-only handoff), persisted to the durable asset store and carried into the Lovable prompt as durable-store URLs (`brand-assets/<brand>/funnels/<funnel-slug>/`), never raw Kie TTL URLs
- [ ] Image prompts follow the Three-Layer Model (not shorthand)
- [ ] All images referenced in the Lovable prompt by correct filename, with the download-locally instruction retained as defense in depth; zero `kie.ai` URLs appear in the Lovable prompt (durable-store URLs only, per the Stage 2 Durable Asset Persistence rule and pre-flight check 5)
- [ ] Tracking pixels included in `<head>` (all configured platforms)
- [ ] UTM passthrough script included in `<head>` (MANDATORY)
- [ ] Payment plans and free shipping included in the Lovable prompt if configured
- [ ] Regional/regulatory compliance and disclaimers included if configured (omitted cleanly if the brand has none)
- [ ] Awareness-stage first-CTA placement specified in the Lovable prompt (per the visual-design.md first-CTA warmth rule)
- [ ] Video embeds responsive and properly placed (if applicable)
- [ ] Mobile responsive design specified
- [ ] Sticky mobile CTA specified
- [ ] Brand-specific doc compliance (Ad Style Catalogue, Visual Design Guidelines if applicable)

**Ad-to-Page Alignment:**
- [ ] **Traffic source identified** and funnel type matches reader state
- [ ] **Filtering handled** - if ad doesn't filter, headline/subheadline/image does
- [ ] **Emotional state continuity** - page picks up where the ad left off (no repetition, no gap)

**Visual Design Compliance (per references/visual-design.md):**
- [ ] **Above-the-fold components present:** urgency banner, headline, subheadline, authority line, visual hook
- [ ] **Root cause has infographic/diagram** - System 1 visual, not text-only
- [ ] **Analogy has supporting image** - real-world photo visualizing the analogy
- [ ] **Social proof uses review card format** - avatar, stars, verified badge, user photos
- [ ] **CTA buttons consistent** - same color, same style, same size throughout
- [ ] **Trust icon row present** in close section - guarantee/trust badges
- [ ] **Before/After image** included if applicable - labeled overlays
- [ ] **No design anti-patterns** - no full-width dividers, no text walls, no centered body text, no tiny fonts

## What This Skill Does NOT Do

- Does not generate videos (accepts user-provided video assets for placement)
- Does not create brand strategy (reads previous phase outputs)
- Does not deploy or host the page (produces a Lovable prompt; the user runs it in Lovable to render and publish)
- Does not handle quiz funnels (future addition)
