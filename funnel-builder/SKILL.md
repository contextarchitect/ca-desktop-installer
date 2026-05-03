---
name: funnel-builder
version: 2.3.1
description: "Create high-converting funnel pages (advertorials and listicles) for e-commerce brands. Handles the complete workflow: funnel type selection based on avatar awareness stage, image generation via Kie MCP, copy creation following brand voice guidelines, and deployment via Lovable. Use when user says 'build a funnel', 'create an advertorial', 'create a listicle', 'funnel page for [avatar/topic]', 'run Phase 5', or references funnel/landing page creation for any brand. Reads avatar research, brand guidelines, and copywriting guide as inputs."
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

## Core Principles

### The Full-Picture Doctrine

Nothing works in isolation. The ad, the headline, the landing page, the close form one continuous experience. Before building any funnel page, you must understand what ad is driving traffic, what state the reader arrives in, and what the page needs to do to continue their journey.

### The Yes-Yes-Yes Causal Chain

Every advertorial must build this chain:
- Root cause clicks → "I believe THIS is causing my problem"
- Unique mechanism clicks → "I believe THIS approach fixes that cause"
- Product clicks → "I believe THIS product delivers that mechanism"
- Close clicks → "This is the obvious choice"

If any link is weak, the conversion architecture fails.

### System 1 Principle

Root cause and mechanism explanations must activate System 1 (fast, intuitive processing). No jargon. Analogies mandatory. Visuals mandatory. A tired person scrolling at midnight must understand it. The dumbest person gets it; the most skeptical trusts it.

### Copy Length Principle

Length is determined by the job each section needs to do, not by a target word count. Every sentence must create curiosity, build belief, deepen emotional connection, or move the reader toward the next section. If a sentence could be removed without the reader missing anything, remove it. Even if the full page is long, it should never FEEL long - short paragraphs, short sentences, visual breaks every 3-4 paragraphs.

## Critical Architecture Rule: Lovable is Execution Only

**Lovable is a frontend execution tool. It receives completed assets. It does not create them.**

| Created OUTSIDE Lovable | Provided TO Lovable |
|------------------------|-------------------|
| All copy (headlines, body, CTAs, FAQ) | Complete copy (paste in) |
| All images (via Nano Banana Pro / Kie MCP) | Pre-generated images (uploaded or via temp URL instructions) |
| Page architecture and layout specs | Layout instructions |
| Tracking pixels (user provides) | Pixel code in `<head>` |



## Required Inputs

### From Previous Phases (Read First)

1. **Avatar Research (Phase 2)** - target segments, awareness stages, language preferences, emotional triggers, platform behavior, raw quotes, day-to-day struggles. Also check for an Emotion-First Communications Framework if the brand has one.
2. **Brand Guidelines (Phase 3)** - brand colors, typography, positioning, voice pillars, visual identity
3. **Copywriting Guide (Phase 4)** - voice rules, forbidden vocabulary, humanization principles, archetype-specific tone guidance
4. **Angle Roadmap (Phase 4.5)** - the angle card driving this funnel. If the brand has completed Schwartz onboarding (i.e., `phase-4.5-angle-roadmap/schwartz-applied.md` exists in the brand repo), the angle card will also carry Awareness Stage and Sophistication Stage Score; these determine which advertorial sections carry the most weight (see Schwartz Structural Layer section below). If the file does not exist, treat the angle card as the standard Phase 4.5 output.

### Brand-Specific Documents (Check If Available)

Before generating image prompts, check whether the brand has any of these specialized documents. Ask the user if unsure.

5. **Ad Style Catalogue** (optional) - If the brand has a catalogue of approved ad visual styles, funnel images should align with established brand visual language.
6. **Visual Design Guidelines** (optional) - If the brand has infographic specifications (typography sizes, icon styles, color usage for data visualization), apply these before writing infographic-style image prompts.
7. **Product Photography Reference Index** (optional) - If the brand maintains a reference index mapping REF numbers to filenames, verify all product image references against this index.

### Brand-Specific Configuration (Ask User)

Before building the first funnel for any brand, collect these configuration inputs. Use `ask_user_input_v0` to gather efficiently.

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
```

**Question Set 3: Image & Video Rules**

```
9. Brand-specific image rules: Any restrictions on imagery?

10. Product reference images: Do you have product photography that
    Nano Banana should use as reference? Provide REF numbers or filenames.

11. Brand-specific documents: Do you have any of the following?
    - Ad Style Catalogue
    - Visual Design Guidelines
    - Product Photography Reference Index

12. Video assets: Do you have existing videos to include on funnel pages?
    See references/video-guidance.md for format and placement specifications.
```

**Store these as the brand's funnel configuration. Reuse for all subsequent funnels.**

## Workflow

```
STAGE 0: PLANNING & ALIGNMENT
  → Identify traffic source and reader state
  → Select funnel type + variant
  → Choose target avatar + awareness stage
  → Pull the angle card's Sophistication Stage Score (drives section weighting)
  → Map content structure and image requirements

STAGE 1: COPY CREATION
  → Write body copy following section architecture (apply Schwartz section mapping)
  → Write close section
  → Write lead (tease of full content)
  → Write headline (checked against five-element framework)
  → Run deletion pass, simplicity check, humanity check
  *** STOP. Present copy to user. Wait for approval or revision requests.
  *** Do NOT proceed to Stage 2 until copy is approved.

STAGE 2: IMAGE GENERATION (via Kie MCP)
  → Build Three-Layer prompts for each image slot
  → Submit each via kie-ai:nano_banana_image, poll for completion
  → Present generated image links in chat for each image
  *** STOP. Wait for user to approve or request regeneration per image.
  *** Do NOT proceed to Stage 3 until all images are approved.

STAGE 3: LOVABLE IMPLEMENTATION
  → Read references/visual-design.md
  → Generate single complete Lovable prompt with approved copy + approved images
  → Output as downloadable markdown file
  → QA review
```

### Stage 0: Planning & Alignment

Read `references/funnel-selection.md` for the complete selection matrix, ad-to-page alignment rules, and awareness stage mapping.

**Step 0.1: Identify Traffic Source (MANDATORY)**

Before anything else, determine what ad format will drive traffic. This determines the reader's mental state on arrival and what the funnel page must do. Use `ask_user_input_v0` if not already known from brand configuration.

| Ad Type | Reader Arrives... | Page Must... |
|---------|------------------|--------------|
| Ugly/clickbait image | Curious, unfiltered | Filter + full emotional journey |
| UGC / day-in-the-life | Curious about product | Skip broad filtering, build emotional connection |
| Long-form VSL | Emotionally invested | Focus on logic, don't repeat emotional arc |
| Targeted image + copy | Filtered, problem-aware | Go deeper into root cause + mechanism |
| Advertorial ad copy | Emotionally warmed | Logical validation → Listicle (logic variant) |

**Step 0.2: Select Funnel Type + Variant**

Based on traffic source and awareness stage:

| Signal | Recommended |
|--------|-------------|
| Traffic from emotional ad, needs logical validation | Listicle - Logic variant |
| Traffic from curiosity ad, needs emotional + product connection | Listicle - Emotion variant |
| Solution-aware audience comparing options | Listicle - Product variant |
| Skeptical audience, tried alternatives, needs full journey | Advertorial (full 9-section) |
| Emotional connection needed beyond features | Advertorial |
| Advertorial ad copy → landing page | Listicle - Logic variant (COMBO PATTERN) |

**Step 0.3: Avatar-Image Alignment Check**

Before any content or image planning:

1. Identify the target avatar from Phase 2 research
2. If the content involves a protagonist/narrator, confirm avatar matches story context
3. Confirm visual representation will match avatar demographics
4. Check for contradictions (e.g., expat story + local avatar)
5. Apply brand-specific image rules from configuration

**If misalignment detected: resolve before proceeding.**

**Step 0.4: Pull the Angle Card's Schwartz Scores**

**Gating check (run before this step).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire step silently and proceed to Step 0.5 as if this step were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, or any related vocabulary in your output. If the file exists, run this step normally.

Open the angle card driving this funnel. Capture three values that drive Stage 1 writing:

- **Awareness Stage** (Unaware / Problem Aware / Solution Aware / Product Aware / Most Aware / Solution-Switching)
- **Sophistication Stage Score** (1-5, with most mature D2C categories at Stage 4)
- **Required Schwartz Move** (the one-sentence strategic instruction the angle card carries)

These determine which advertorial sections carry the most weight (see Schwartz Structural Layer section below).

If the angle card lacks these fields, the angle predates the angle-roadmap skill's Schwartz scoring update. Either run the angle-roadmap skill's Step 6 on the card to add them, or score them inline before proceeding.

**Step 0.5: Map Content Structure**

Read the appropriate reference file:
- Advertorial → `references/advertorial-framework.md`
- Listicle → `references/listicle-framework.md`
- Visual layout → `references/visual-design.md` (section-level design specs, component patterns)

Determine: section sequence, tone balance for awareness stage, CTA placement, image requirements, listicle variant (if applicable).

**Visual break rule:** No more than 3-4 short paragraphs between visual elements. If you count four consecutive paragraphs without a visual break, plan an image for that gap.

### Stage 1: Copy Creation

**This stage produces all copy before any images are generated.**

**For Advertorials - Writing Order:**

1. **Immerse in avatar research** - re-read raw quotes, struggles, emotional triggers
2. **(Only if `schwartz-applied.md` exists for this brand) Apply the Schwartz Structural Layer (below) to plan section weighting** based on the angle's sophistication score. If the file does not exist, skip this step.
3. **Write sections 3-8 in one sitting** (Background Story → Root Cause → Consequences → Unique Mechanism → Product Buildup → Product Reveal). Continuous flow, not section-by-section.
4. **Write section 9 (Close)** - testimonials, price anchoring, value stack, guarantee, urgency
5. **Write section 2 (Lead)** - tease/summarize what the reader will discover. Written AFTER body is complete.
6. **Write section 1 (Headline)** - checked against the five-element framework (Relatability, Tension, Curiosity, Humanity, Contextual Fit) and the headline quality check questions. If any quality check answer is "no," rework.
7. **Deletion pass** - remove any sentence that doesn't create curiosity, build belief, deepen identification, handle an objection, or move the reader forward
8. **Simplicity check** - root cause and mechanism sections: would a tired, distracted person understand them?
9. **Humanity check** - no em dashes, no forbidden vocabulary, contractions natural, high burstiness
10. **Verify causal chain** - Root Cause → Mechanism → Product must flow logically

**For Listicles - Writing Order:**

1. **Determine variant** (Logic, Emotion, or Product-focused) based on traffic source
2. **Write item headlines first** - all items, sequenced per the variant's psychological arc
3. **Write item body copy** - maximum 2 paragraphs per item, text must not visually overwhelm the image
4. **Write opening paragraph** - variant-specific opening
5. **Write CTA card copy** - mid-page and final
6. **Write guarantee section copy**
7. **Write headline** - variant-specific, odd number mandatory
8. **Deletion pass** - cut any word that doesn't earn its place

**Deliverable:** Complete copy document (all sections, all CTAs, FAQ, guarantee). Output as markdown file if over 500 words.

**STOP HERE. Present copy to user. Do not proceed to Stage 2 until the user explicitly approves the copy or requests revisions.**

### Stage 2: Image Generation via Kie MCP

**All images are generated via Kie MCP (`kie-ai:nano_banana_image`). Never in Lovable.**
**All videos are provided by the user (pre-existing assets). Video generation is not part of this workflow.**

**Before writing any image prompts, check for brand-specific documents:**
1. Search for Ad Style Catalogue → if found, align image styles to catalogue
2. Search for Visual Design Guidelines → if found, apply infographic specs
3. Search for Product Photography Reference Index → if found, verify all REF numbers

Read brand-specific image rules from configuration before writing any prompts.

**Universal image generation rules:**

1. **Visual Reference Priority:** When a reference image exists for the product, reference it rather than describing the product verbally.

2. **Product Placement Rule:** NEVER show the brand's product in negative contexts (problem states, failure narratives, frustration scenes). Product appears only as the solution/hope/resolution.

3. **Reference Verification:** If using reference images (REF numbers), verify against the brand's product photography index before writing prompts.

4. **Nano Banana Three-Layer Model:** All prompts must follow Visible Layer + Constraint Layer + Exclusion Layer structure.

5. **Authenticity Rule:** People images should feel authentic (iPhone-quality, real body types, relatable demographics). Product images can be polished. Social proof images should look like real user-generated content.

6. **Root Cause Infographic (MANDATORY for advertorials):** Every advertorial must include at least one infographic/diagram visualizing the root cause analogy. This is a System 1 support visual, not decoration.

**Video assets:** If the user has videos to include, read `references/video-guidance.md` for placement, dimension, and naming specifications.

**Kie MCP Generation Steps (per image):**

1. **Build Three-Layer prompt** per nano-banana-prompting skill (Visible Layer + Constraint Layer + Exclusion Layer)
2. **Submit via `kie-ai:nano_banana_image`:**
   - Include reference image URL in `image_input` array (use public GitHub URLs for product reference images)
   - Set `output_format: "jpg"` for funnel pages
   - Set `aspect_ratio` as needed (typically `16:9` for hero and inline images)
3. **Capture `taskId`** from response
4. **Poll `kie-ai:get_task_status`** every ~15 seconds until status = "success"
5. **Extract download URL** from `result_urls` array
6. **Present to user** with descriptive filename and purpose

Generate and present images one at a time (or in logical batches). After presenting each image or batch, wait for the user to approve or request a regeneration before continuing.

**Generation Time Expectations:**

| Mode | Typical Duration |
|------|------------------|
| Generate (no reference) | 30-90 seconds |
| Edit (with 1 reference) | 90-200 seconds |
| Edit (with multiple references) | 200-500 seconds |

**STOP HERE. Do not proceed to Stage 3 until all images are approved by the user.**

---

### Stage 3: Lovable Implementation

Read `references/visual-design.md` for section-level layout patterns, component specifications, and design rules. Apply brand-specific colors/typography from brand guidelines (Phase 3) on top of these structural defaults.

Generate a single, complete Lovable prompt containing:
- All copy (pre-written and approved - paste verbatim, Lovable must not alter it)
- Image placement instructions (referencing approved image filenames or temp URLs with download instructions)
- Video embed instructions if applicable (see `references/video-guidance.md`)
- Section-level layout specifications (from `references/visual-design.md`)
- Brand design system (colors, typography from brand guidelines)
- Component specifications (CTA buttons, urgency banner, trust icons, review cards, guarantee section per visual-design.md)
- Tracking pixel code in `<head>` section (all configured pixels)
- UTM passthrough script in `<head>` section (MANDATORY, see reference framework)
- Technical requirements (responsive, accessible, performant)

**Temporary URL Handling (CRITICAL):**

Kie MCP returns temporary URLs from `tempfile.aiquickdraw.com` that **expire within approximately 3 days**. These URLs MUST NOT be used directly in production code. The Lovable prompt MUST include explicit download instructions at the top:

```
CRITICAL - IMAGE HANDLING:
These image URLs are TEMPORARY and will expire within days.
For each image:
1. Download from its temp URL during build
2. Save to /public/images/[descriptive-filename].jpg
3. Reference via local path only (/images/[filename].jpg)

NEVER use tempfile.aiquickdraw.com URLs in production code.

Image Assets:
- hero-image.jpg: [temp URL]
- root-cause-diagram.jpg: [temp URL]
- product-shot.jpg: [temp URL]
[etc.]
```

**Reference Image URL Format:**

When passing product reference images to Kie MCP, use publicly accessible URLs:

```
https://raw.githubusercontent.com/[org]/[repo]/main/[path]/[filename]
```

**Output format:** Any Lovable prompt over 500 words must be delivered as a single downloadable markdown file using `create_file` + `present_files`. Never break long prompts into multiple copyable sections in chat.

## Schwartz Structural Layer (Advertorial Section Mapping)

**Gating check (run before this section).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire section silently and proceed to the next step in the workflow as if this section were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. Do not surface that a section was skipped. If the file exists, run this section normally.

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
- [ ] **Close architecture complete:** Testimonials → Anchoring → Price → Value stack → Guarantee → CTA
- [ ] **Lead written last and teases full content**
- [ ] **Headline passes quality check:** All five elements evaluated, all gut-check questions answered "yes"

**Schwartz Structural Layer (Advertorial Only) (only if `schwartz-applied.md` exists for this brand):**
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
- [ ] No em dashes anywhere
- [ ] No forbidden AI vocabulary
- [ ] Contractions used naturally
- [ ] High burstiness (sentence length varies dramatically)
- [ ] Avatar-appropriate tone and language
- [ ] Brand-specific compliance rules followed
- [ ] **Deletion pass completed:** Every sentence creates curiosity, builds belief, or moves reader forward
- [ ] **Visual break rule:** No more than 3-4 consecutive paragraphs without a visual element

**CTA Compliance:**
- [ ] Pricing policy followed (show/hide per configuration)
- [ ] All CTAs use configured language
- [ ] All CTAs link to configured product URL
- [ ] Guarantee referenced per configuration
- [ ] Payment plans mentioned if configured

**Technical:**
- [ ] Tracking pixels included in `<head>` (all configured platforms)
- [ ] UTM passthrough script included in `<head>` (MANDATORY)
- [ ] All images referenced by correct filename
- [ ] Temp URL download instructions included at top of Lovable prompt
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

- Does not generate images in Lovable (all images generated via Kie MCP before Lovable prompt is created)
- Does not generate videos (accepts user-provided video assets for placement)
- Does not create brand strategy (reads previous phase outputs)
- Does not handle quiz funnels (future addition)
