---
name: funnel-builder
description: "Create high-converting funnel pages (advertorials and listicles) for e-commerce brands. Handles the complete workflow: funnel type selection based on avatar awareness stage, image generation prompts via Nano Banana, copy creation following brand voice guidelines, and deployment via the Funnel Factory pipeline (default) or Lovable implementation prompts (on request). Use when user says 'build a funnel', 'create an advertorial', 'create a listicle', 'funnel page for [avatar/topic]', 'run Phase 5', or references funnel/landing page creation for any brand. Reads avatar research, brand guidelines, and copywriting guide as inputs."
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

- `funnel-builder` -> Landing page with hero image, sections, CTAs, deployed via Funnel Factory pipeline or Lovable
- `long-form-static-builder` -> Ad primary text (2,500-3,500 words full / 1,000-1,400 medium / 200-300 fake-complaint) plus a Reddit-native image spec, paste-ready for Meta Ads Manager

If the user says "build me an advertorial" without context, ask which they mean. The two formats serve different funnel positions: long-form-static is the ad itself; funnel-builder produces the page that ad clicks through to. A typical campaign uses both - a long-form-static ad drives clicks to a funnel-built landing page, which then drives conversion.

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
| All images (via Nano Banana Pro) | Pre-generated images (upload first) |
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
  → Map content structure and image requirements

STAGE 1: COPY CREATION
  → Write body copy following section architecture
  → Write close section
  → Write lead (tease of full content)
  → Write headline (checked against five-element framework)
  → Run deletion pass, simplicity check, humanity check

STAGE 2: IMAGE PROMPT PREPARATION
  → Generate Nano Banana Pro prompts
  → Include prompts in pipeline spec (Stage 3A) OR user generates externally (Stage 3B)

STAGE 3A: PIPELINE DEPLOY (DEFAULT)
  → Generate structured JSON spec
  → Deploy via deploy_funnel MCP tool (images generated automatically by pipeline)
  → QA review

STAGE 3B: LOVABLE IMPLEMENTATION (ON REQUEST)
  → User generates images from Stage 2 prompts
  → Generate complete Lovable prompt
  → User uploads images + pastes prompt
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

**Gating check (run before this step).** Look for `phase-4.5-angle-roadmap/schwartz-applied.md` in the brand's GitHub repo. If the file does not exist, skip this entire step silently and proceed to Step 0.5 as if this step were not present. Do not mention Schwartz, sophistication scoring, awareness stages, the seven techniques, technique density, the 38 headline methods, or any related vocabulary in your output. If the file exists, run this step normally.

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

### Stage 2: Image & Video Asset Preparation

**All images are generated in Nano Banana Pro. Never in Lovable.**
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

**Deliverable:** Complete set of Nano Banana prompts with filenames, purposes, and reference image instructions. Plus video placement map if videos are included. Output as a markdown file if over 500 words.

**For Stage 3A (Pipeline Deploy):** Proceed directly. No need to wait for image generation. The pipeline generates images from the prompts automatically.

**For Stage 3B (Lovable Implementation):** Wait for user confirmation ("Images ready" / "Images generated") before proceeding.

### Stage 3: Output

**Stage 3 has two output modes. Stage 3A (Pipeline Deploy) is the default. Stage 3B (Lovable Prompt) is available on explicit request.**

#### Stage 3A: Pipeline Deploy (Default)

Generate a structured JSON spec that the Funnel Factory pipeline accepts. This spec can be deployed via:
- **Creative Engine** (primary): The CE Funnel Builder generates the spec, handles image generation with reference images, and deploys via the FF REST API. The full workflow (copy → images → deploy) runs within a single CE conversation.
- **MCP tool** (Claude Desktop): The `deploy_funnel` MCP tool deploys via the Funnel Factory connector at `mcp.econstructor.ai`.
- **Manual**: Output the spec as JSON for manual deployment.

The pipeline handles everything automatically: image generation (concurrent via Kie.ai from the prompts in the spec), HTML rendering with brand design tokens (auto-extracted from brand-guidelines.md), tracking pixel injection, and deployment to Cloudflare Pages. Total time: ~90 seconds.

Read `references/visual-design.md` for section-level layout patterns when determining image placement and section structure.

**The JSON spec must follow this exact schema:**

```json
{
  "brand_id": "<brand key, e.g., 'regrowth' not 'regrowthplus'>",
  "funnel_type": "advertorial" | "listicle",
  "slug": "<lowercase-hyphenated-max-80-chars>",
  "update": false,
  "metadata": {
    "avatar_name": "<target avatar name>",
    "awareness_stage": "problem_aware" | "solution_aware" | "product_aware",
    "price_point": "low_ticket" | "mid_ticket" | "high_ticket",
    "traffic_source": "<ad format driving traffic>",
    "created_by": "claude_desktop"
  },
  "copy": {
    "headline": "<main headline text>",
    "subheadline": "<subheadline text>",
    "authority_line": "<byline, e.g., 'By Dr. Sarah Mitchell, Trichologist | March 2026'>",
    "urgency_banner": "<urgency banner text, or null if none>",
    "sections": [
      {
        "id": "<unique_section_id>",
        "type": "<section_type>",
        "heading": "<section heading, or null>",
        "body": "<full section body copy>",
        "image_ref": "<matching ref from images array, or null>"
      }
    ],
    "faq": [
      {
        "question": "<FAQ question>",
        "answer": "<FAQ answer>"
      }
    ],
    "guarantee": {
      "text": "<guarantee headline>",
      "details": "<guarantee details>"
    },
    "social_proof": [
      {
        "name": "<reviewer name>",
        "rating": 5,
        "text": "<review text>",
        "verified": true
      }
    ]
  },
  "images": [
    {
      "ref": "<unique ref matching image_ref in sections>",
      "purpose": "<what this image shows>",
      "prompt": "<complete Nano Banana Three-Layer Model prompt>",
      "dimensions": "1200x800" | "800x600",
      "position": "above_fold" | "inline"
    }
  ],
  "profile": "problem-aware" | "solution-aware" | "product-aware" | "standard",
  "variations": {},
  "config": {
    "cta_text": "<CTA button text>",
    "cta_url": "<CTA destination URL>"
  }
}
```

**Schema Rules:**

1. **brand_id** should use the pipeline's preferred brand key (e.g., `regrowth`). The pipeline resolves aliases automatically - `regrowth-plus`, `regrowthplus`, or the GitHub repo name will also work. When deploying via Creative Engine, the brand slug from the CE database is used directly (CE sends `brand.slug`, FF resolves it).
2. **slug** must be lowercase, hyphenated, no special characters, max 80 chars
3. **copy.sections** is an ordered array. The pipeline renders sections in the order they appear. Section selection is YOUR responsibility based on awareness stage and funnel type.
4. **Section types for advertorials:** `lead`, `background_story`, `root_cause`, `consequences`, `mechanism`, `product_buildup`, `product_reveal`, `close`, `social_proof`, `urgency`
5. **Section types for listicles:** `opening`, `item`, `cta_mid`, `cta_final`, `guarantee`
6. **images[].ref** must match a `copy.sections[].image_ref` value. The hero image uses `position: "above_fold"`.
7. **images[].prompt** must be a complete Nano Banana Three-Layer Model prompt (Visible Layer + Constraint Layer + Exclusion Layer). Do not use shorthand.
8. **profile** maps to page layout config on the pipeline: `problem-aware`, `solution-aware`, `product-aware` for both advertorials and listicles. The pipeline has awareness-stage-specific profiles for each funnel type (different CTA positions, list lengths, and layout parameters by awareness stage). Falls back to `standard` if a specific profile doesn't exist.
9. **config.cta_text** and **config.cta_url** override brand defaults for this specific funnel. Always include them explicitly.
10. **copy.urgency_banner** can be null if no urgency banner is needed.
11. **metadata** is stored in the deployment log but does not affect rendering.
12. **variations** is empty `{}` for now. Used for A/B testing in Phase 2.

**Section Mapping from Advertorial Architecture:**

| Advertorial Section | Spec Location |
|---|---|
| Section 1: Above the Fold | `headline`, `subheadline`, `authority_line` in top-level `copy.*`. Urgency banner in `copy.urgency_banner`. Hero image in `images[]` with `position: "above_fold"` |
| Section 2: The Lead | `{ "id": "lead", "type": "lead", "heading": null, "body": "..." }` |
| Section 3: Background Story | `{ "id": "background_story", "type": "background_story", "heading": "...", "body": "..." }` |
| Section 4: Root Cause | `{ "id": "root_cause", "type": "root_cause", "heading": "...", "body": "...", "image_ref": "root-cause-infographic" }` |
| Section 5: Consequences | `{ "id": "consequences", "type": "consequences", "heading": null, "body": "..." }` |
| Section 6: Unique Mechanism | `{ "id": "mechanism", "type": "mechanism", "heading": "...", "body": "...", "image_ref": "mechanism-diagram" }` |
| Section 7: Product Buildup | `{ "id": "product_buildup", "type": "product_buildup", "heading": null, "body": "..." }` |
| Section 8: Product Reveal | `{ "id": "product_reveal", "type": "product_reveal", "heading": "...", "body": "...", "image_ref": "product-hero" }` |
| Section 9: The Close | `social_proof` entries in `copy.social_proof[]`, guarantee in `copy.guarantee`, urgency as `{ "type": "urgency" }` section |

**What the spec does NOT contain (pipeline resolves from brand config):**
- Colors, fonts, logo URL (auto-extracted from brand-guidelines.md)
- Tracking pixels and pixel code (from funnel-config.md / brands.json)
- UTM passthrough script (embedded in templates)
- Payment plan details, free shipping info (from funnel-config.md)
- GCC compliance rules, image ethnicity rules (from funnel-config.md)

**After generating the spec, offer to deploy immediately:**

> "The funnel spec is ready. Would you like me to deploy it now using the Funnel Factory pipeline? It will generate images, render the page, and publish to [brand domain]. Takes about 90 seconds."

If the user confirms, call the `deploy_funnel` MCP tool with the spec as a JSON string.

If the MCP connector is not available in this conversation, output the spec as a downloadable JSON file using `create_file` + `present_files` so the user can deploy from a conversation where the connector is enabled.

**Output format:** Always save the spec as `{slug}-spec.json` using `create_file` + `present_files`. If also deploying via MCP, provide both the file and the deployment.

#### Stage 3B: Lovable Implementation (On Request)

**Use only when the user explicitly requests Lovable output.**

Trigger phrases: "output as Lovable prompt", "Lovable format", "Stage 3B", "I want to use Lovable"

Read `references/visual-design.md` for section-level layout patterns, component specifications, and design rules. Apply brand-specific colors/typography from brand guidelines (Phase 3) on top of these structural defaults.

Generate a single, complete Lovable prompt containing:
- All copy (pre-written, not generated by Lovable)
- Image placement instructions (referencing uploaded filenames)
- Video embed instructions if applicable (see `references/video-guidance.md`)
- Section-level layout specifications (from `references/visual-design.md`)
- Brand design system (colors, typography from brand guidelines)
- Component specifications (CTA buttons, urgency banner, trust icons, review cards, guarantee section per visual-design.md)
- Tracking pixel code in `<head>` section (all configured pixels)
- UTM passthrough script in `<head>` section (MANDATORY, see reference framework)
- Technical requirements (responsive, accessible, performant)

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
- [ ] **Stage 3A:** Spec validates against pipeline JSON schema (all required fields present, brand_id correct, slug valid)
- [ ] **Stage 3A:** All `images[].ref` values match an `image_ref` in `copy.sections[]`
- [ ] **Stage 3A:** Image prompts follow Three-Layer Model (not shorthand)
- [ ] **Stage 3B:** Tracking pixels included in `<head>` (all configured platforms)
- [ ] **Stage 3B:** UTM passthrough script included in `<head>` (MANDATORY)
- [ ] **Stage 3B:** All images referenced by correct filename
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

- Does not generate images (Stage 3A: pipeline generates from prompts automatically; Stage 3B: user generates from Nano Banana prompts externally)
- Does not generate videos (accepts user-provided video assets for placement)
- Does not handle brand visual identity for pipeline deployment (pipeline extracts colors/fonts from brand-guidelines.md automatically)
- Does not create brand strategy (reads previous phase outputs)
- Does not handle quiz funnels (future addition)
