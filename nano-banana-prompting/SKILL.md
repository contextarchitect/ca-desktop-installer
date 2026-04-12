---
name: nano-banana-prompting
description: "Craft prompts for Nano Banana Pro (Gemini image generation) using the Three-Layer constraint framework. Use when users want help writing image generation prompts, need guidance on prompt structure, want to optimize prompts for better results, or when any other skill (funnel-builder, ad-style-generator) needs Nano Banana prompts generated. Handles product shots, lifestyle scenes, infographics, ad creatives, educational diagrams, and all other image types."
---

# Nano Banana Pro Prompting Skill

## Purpose

Generate production-ready Nano Banana Pro prompts using the Three-Layer constraint framework (Visible, Constraint, Exclusion). Every prompt enforces brand accuracy, prevents common failure modes, and produces images that require minimal regeneration.

## The Overriding Rule

**If the viewer should not see it, it must be in the Constraint Layer and explicitly forbidden in the Exclusion Layer.** This single principle prevents 90% of prompt failures.

## Mandatory: Three-Layer Prompt Model

EVERY prompt must contain all three layers. A prompt missing any layer is incomplete and will produce failures.

### Layer 1: Visible Layer
What MAY appear in the final image:
- Objects, people, products, environments
- Text content that should render (exact strings only)
- Colors as visual descriptions (not hex codes)
- Lighting effects, shadows, reflections

### Layer 2: Constraint Layer (Non-Visible)
Rules that GUIDE rendering but must NEVER appear visually:
- Typography rules (font names, weights, sizes)
- Brand color specifications (hex codes)
- Visual hierarchy logic
- Alignment and spacing systems
- Relative scale rules
- Composition guidance
- Product dimensions and real-world proportions

**Required label:** "Typography constraints (non-visible, render-only)" or "Design constraints (non-visible, render-only)"

### Layer 3: Exclusion Layer
Explicit prohibitions that PREVENT leakage:
- No font names, font sizes, point values rendered
- No hex codes, color labels, annotations visible
- No layout guides, design specs, grid lines
- No additional text beyond what's declared in Layer 1
- No watermarks, logos (unless specified), filters
- Brand-specific exclusions (from funnel config / image rules)

**A prompt without all three layers is a prompt that will fail.**

## Reference Image Protocol (Critical)

### Base Image Rule
- Exactly ONE base reference image per prompt
- All realism, proportions, identity, and brand accuracy derive from it
- Required opening: "Using Image 1 as the sole base reference..."

### Preservation Contract (Mandatory when reference attached)
Include this exact language or equivalent:
"Preserve exact proportions, scale, layout, identity, colors, and composition from the reference. Do not resize, stretch, distort, relabel, or reinterpret."

### Product Reference Rule (CRITICAL -- prevents the #1 failure mode)
**When a product reference image is attached, DO NOT describe the product verbally in the prompt.**

A verbal description gives Nano Banana a choice between the reference and the description. It will often choose the description, generating an invented product instead of using the reference.

WRONG:
```
"A woman holding a 250ml teal and white shampoo bottle with flip-top cap
and wave design, showing the Regrowth+ logo..."
```

RIGHT:
```
"A woman holding the product shown in the attached reference image.
Preserve exact product appearance, label, proportions, and branding
from the reference. Do not alter, reinterpret, or reimagine the product."
```

**The rule:** Reference attached = no product description. Reference absent = describe product in detail.

### Universal Product Appearance Rule (CRITICAL -- prevents invented products)

**ANY image where the product appears in ANY form MUST include a reference image.** This applies universally regardless of art style, rendering technique, or level of abstraction. Specifically:

- **Photorealistic scenes** (product on counter, in hand, on shelf): reference REQUIRED
- **Cartoon/illustrated versions** (animated bottle character, mascot, stylized drawing): reference REQUIRED
- **Background/environmental placement** (product visible on a ledge, in soft focus): reference REQUIRED
- **Silhouette or outline** (product shape recognizable): reference REQUIRED
- **Partial views** (cap, label, or bottom of bottle visible): reference REQUIRED

**Without a reference, the AI model will invent its own version of the product.** This results in wrong colors, wrong label design, wrong proportions, wrong cap shape, and wrong branding. This is true even for cartoon styles. An illustrated version of a product must still be based on the real product's appearance.

**The only exception:** The product does not appear in the image at all (pure infographic, text-only graphic, scene without product, problem-visualization with no solution shown).

**Pre-prompt checklist:** Before writing any prompt, ask: "Does the product appear in this image in any form?" If yes, a reference image is mandatory. No exceptions.

### Reference Image Scale Context Rule (CRITICAL -- prevents wrong product size)

**The reference image must match the scene context.** An isolated packshot (product on transparent/white background with no surrounding objects) provides NO scale information. The AI model has no way to determine how large the product should be relative to a person, a shelf, a counter, or any other object in the scene. It will default to whatever size fills the composition, which is almost always wrong.

**Reference selection by scene type:**

| Scene Type | Correct Reference | Wrong Reference |
|-----------|------------------|----------------|
| Person holding/using product | Hand holding bottle (shows true size in human grip) | Isolated packshot (no scale) |
| Product on bathroom counter/shelf | Product on vanity with faucet, other items (shows real-world placement) | Isolated packshot (no scale) |
| Product in shower/bath scene | Hand holding bottle near water, or product on ledge with visible surroundings | Isolated packshot (no scale) |
| Product next to other items (flat-lay) | Product styled with other objects (shows relative size) | Isolated packshot (no scale) |
| Product on pedestal/hero shot | Editorial-styled product on surface (shows base/shadow/depth) | Isolated packshot (limited scale) |
| Cartoon/illustrated version | Any reference showing the product clearly (cartoon style will adapt the appearance) | No reference at all |
| Product alone on clean background | Isolated packshot is CORRECT here | N/A |
| Graphic layout with product overlay | Isolated packshot is CORRECT here (being composited, not placed in a scene) | N/A |

**When to use isolated packshots:** ONLY when the product is being placed on a clean/graphic background, overlaid onto a design layout, or shown in isolation. The moment the product shares a scene with people, objects, or environments, the reference must include scale context.

**Prompt reinforcement:** Even with the correct reference, the prompt should reinforce scale in the Constraint Layer. Never state specific dimensions unless you have verified them. Instead, reference the scale context provided by the reference image:
```
Design constraints (non-visible, render-only):
The product should appear at natural, realistic scale relative to the
person and environment. The reference image shows the bottle held in
a human hand (or next to known objects). Use that ratio to determine
correct product size in this scene. Do not enlarge or shrink the product
beyond its real-world proportions. These rules guide rendering only.
```

**Dynamic Scale Context (when metadata is available):**

When generating prompts programmatically (e.g., from Creative Engine or another tool that passes product metadata):
- **hand_model reference:** "Preserve the exact product-to-hand scale ratio shown in Image 1. The product must remain graspable in one hand. Do not enlarge beyond what is shown in the reference."
- **Known dimensions from product catalog:** "Product details: [dimensions]. When placing in a scene with people, it must appear at this natural real-world scale — small enough to hold comfortably in one hand. Do not enlarge the product to fill the frame."
- **No data available (fallback):** "The product is a standard personal care bottle. In scenes with people, it should be graspable in one hand — roughly 1/4 to 1/3 the length of a human forearm. Do not enlarge beyond real-world proportions."
- **CRITICAL:** When the reference image shows the product held by a person (hand_model type), the scale relationship in the reference IS the ground truth.
- **Never include fabricated dimensions** (like "250ml" or "18cm") unless they come from verified product data.

**Pre-reference checklist:** Before selecting a reference image, ask:
1. "Does this scene include people, objects, or environments alongside the product?" If yes, the reference MUST show the product with scale context (hand, counter, other objects).
2. "Does the isolated packshot provide enough information for the AI to render the product at correct size in this scene?" If no, choose a different reference.

### Multiple Reference Images
When using more than one reference, assign explicit roles:
```
"Image 1: Product reference (preserve exactly)
 Image 2: Pose and composition reference
 Image 3: Environment/background reference"
```

Never leave reference roles ambiguous. Nano Banana will merge them unpredictably.

## Environmental Coherence Rule (CRITICAL -- prevents unrealistic scenes)

**Every object, prop, and element in the scene MUST belong naturally in the described environment.** The AI model does not judge whether objects make sense together -- it renders whatever you describe. You must enforce realism.

**Environment-specific rules:**
- **Bathroom scenes:** ONLY items found in a real bathroom (toiletries, towels, soap, toothbrush, cotton pads, candles, mirrors, hair tools). NEVER laptops, coffee cups, business cards, food, office supplies, or electronics other than an electric toothbrush or hair tool.
- **Kitchen scenes:** ONLY items found in a real kitchen. NEVER shampoo bottles, toiletries, or bathroom items.
- **Office/desk scenes:** ONLY items found on a real desk. NEVER shampoo bottles or toiletries unless the concept explicitly calls for showing the product in an unexpected context.
- **Gym/fitness scenes:** ONLY items found in a gym setting.
- **Bedroom/vanity scenes:** ONLY items found on a dressing table or bedside. Skincare and hair products are appropriate here; office supplies are not.

**Pre-prompt checklist:** Before finalizing any prompt, ask: "Would every single object I described actually be found in this environment in real life?" If any object would look out of place in the setting, remove it or replace it with something that belongs.

**This rule applies to ALL scene types.** The goal is photographic realism -- the image should look like it could be a real photograph taken in that environment.

## Anatomical Integrity Protocol (CRITICAL -- prevents body horror)

**Human subjects must have natural, correct anatomy.** The AI model does not self-check anatomical accuracy. You must constrain it explicitly.

**Mandatory inclusion when people are present:**
```
"The person has exactly two hands, each with exactly five fingers.
Natural body proportions throughout. No extra limbs, no merged fingers,
no distorted joints, no unnatural bending."
```

**Risk levels by scene type:**

| Risk Level | Scene Type | Required Action |
|------------|-----------|----------------|
| LOW | Subject from behind, distant shots, face only | Basic anatomy note sufficient |
| MEDIUM | Full body standing/sitting, arms visible | Include hand and limb constraints |
| HIGH | Hands holding product, close-up hands, two people interacting | Full anatomical constraints + explicit exclusion |

**For HIGH-risk scenes, add to Exclusion Layer:**
```
"No extra fingers, no extra hands, no third arm, no merged or fused limbs,
no distorted facial features, no unnatural joint angles."
```

**Tip:** Medium shots (waist up) with hands below frame or naturally positioned are the safest framing for scenes with people.

## Rendered Text Protocol (Critical -- prevents gibberish text)

**Every prompt that includes text on the image MUST follow this pattern:**

### Step 1: Declare exact text in Visible Layer
```
Rendered text content:
Include ONLY the following text, exactly as written:
- Primary: "MADE IN UAE"
- Secondary: "For Hard Water"
```

### Step 2: Constrain typography in Constraint Layer
```
Typography constraints (non-visible, render-only):
Primary text should appear visually dominant, bold, in the brand's
primary color. Secondary text should appear smaller and lighter.
These rules guide rendering only -- do not display as visible specs.
```

### Step 3: Forbid extra text in Exclusion Layer
```
Do not display font names, font sizes, hex codes, typography labels,
annotations, or any text not explicitly listed above. No lorem ipsum,
placeholder text, or decorative text. ONLY the declared text may appear.
```

**If ANY of these three steps is missing, Nano Banana will add gibberish, lorem ipsum, or render the constraint specs as visible text.**

## Standalone Context Rule (CRITICAL -- prevents meaningless images)

**Every image with text or data must be self-explanatory without any external caption, ad copy, or surrounding context.** A viewer scrolling past the image in a feed must understand the core message from the image alone.

This means:

- **Headlines must provide context, not just a statistic.** "50% SAY NOTHING HAS WORKED" is incomplete. The viewer asks: "50% of what? Nothing worked for what?" The headline must answer who, what, or why. Better: "50% OF WOMEN IN THE GULF SAY NOTHING HAS FIXED THEIR HAIR" or include a subheadline that provides the missing context.
- **Data visualizations must label what they're measuring.** A bar chart showing percentages is meaningless without a title explaining the question asked or the topic being measured.
- **Infographics must have a clear takeaway.** The viewer should understand the point being made without reading any ad copy below the image.
- **Split-screen comparisons must label both sides clearly.** "Before" and "After" are not enough if the viewer doesn't know before/after what.

**Pre-text checklist:** Before finalizing any prompt with text, ask: "If someone saw ONLY this image with no caption, no ad copy, no surrounding context, would they understand the message?" If not, the headline or labels need more context.

**This rule applies to ALL image types with rendered text:** infographics, data graphics, comparison layouts, editorial layouts, stat callouts, listicle images, and any image where text is part of the visual.

## Headline and Copy Default Rule (CRITICAL -- prevents contextless ad images)

**By default, every ad image MUST include rendered text (headline, subheadline, or key message) that makes the image self-explanatory.** This is an extension of the Standalone Context Rule, applied specifically to ad creatives.

A viewer scrolling past an ad in a feed must understand the core message from the image alone, without reading any external ad copy or caption below the image.

**Default behavior (applies unless an exception is met):**
- Include a headline in the Rendered Text section of every prompt
- The headline must answer: what is this about, who is it for, or what should the viewer do
- If the concept includes a `headline_suggestion`, use it (or a refined version)
- If no headline is provided in the concept, derive one from the concept description
- Data/stat images must label what they measure
- Comparison images must label both sides
- Before/after images must clarify before/after WHAT

**The ONLY exceptions where no headline/copy is needed:**
- **Lifestyle images:** Pure aspirational/aesthetic scenes where the mood and product speak for themselves (e.g. a woman with beautiful hair in golden light, product naturally integrated). The visual storytelling IS the message.
- **User explicitly requests no copy:** When the concept description says "no text", "no headline", "image only", or similar.

**Pre-headline checklist:** Before finalizing any ad prompt, ask: "Is this a Lifestyle image or did the user request no text?" If NO to both, a headline is mandatory.

## Ad Style Visual Rules (for ad creative generation)

When generating prompts for specific ad styles, detect the style and apply matching visual rules in the prompt:

- **INFOGRAPHIC**: Clean data visualization, no 3D effects, outline-style icons, clear stat callouts with large numbers, minimal text, high contrast between data points and background
- **RESEARCH / SCIENCE-FRIENDLY**: Clinical/journal aesthetic, microscopy imagery, charts with axis labels, white/blue color scheme, lab environment elements, molecular diagrams, cross-section illustrations, educational annotation style, clean clinical backgrounds
- **TUTORIAL**: Step-by-step numbered sequence, clear visual progression, arrows or flow indicators between steps, consistent framing per step
- **COMPARISON**: Split-screen or side-by-side, clear visual distinction between sides (lighting, color temperature), labels on each side
- **BA-EMOTION**: Before/after emotional transformation, warm vs cool lighting contrast, focus on facial expression and body language
- **LIFESTYLE**: Aspirational, warm natural lighting, authentic setting, product integrated naturally. This is the ONE style where no headline is required.
- **TESTIMONIAL**: Customer quote centered, authentic photography style, quote marks prominent, name and context below
- **UNBOXING**: Product reveal aesthetic, premium packaging, first-impression lighting, hands-on interaction
- **QUIZ / INTERACTIVE**: Question-driven layout, curiosity hook, clear call-to-action visual
- **UGC-STYLE**: User-generated content aesthetic, casual phone-shot framing, raw/authentic tone, slightly imperfect composition
- **PROBLEM-AGITATE**: Problem visualization, empathetic but urgent tone, focus on the pain point, warm empathetic color palette
- **NEWS**: News-style headline treatment, headline dominant layout, newsworthy tone, clean typography hierarchy

Include the matching style rules in the Constraint Layer of the prompt.

## Workflow

### Step 1: Determine Context

Check what triggered this prompt generation:
- **Standalone request:** User wants an image prompt directly
- **From funnel-builder:** Generating images for a funnel page (read funnel type framework for image specs)
- **From ad-style-generator:** Generating ad creative (read the selected style from style catalogue)
- **From Creative Engine:** Generating via the chat-first ad creative platform (avatar, angle, and style context provided)

If called from another skill or tool, that skill provides: image purpose, dimensions, brand colors, product references, and any style-specific constraints. Apply them.

### Step 2: Gather Requirements

For standalone requests, determine:

1. **Image type:** Product shot, lifestyle scene, infographic, ad creative, educational diagram, editorial, composite?
2. **Reference images:** Does the user have product photography or other references to attach? (Apply Universal Product Appearance Rule AND Reference Image Scale Context Rule)
3. **Text on image:** Is there any text that needs to render? (If yes, activate the Rendered Text Protocol AND apply the Standalone Context Rule AND apply the Headline and Copy Default Rule)
4. **Platform/dimensions:** Where will this be used? (determines aspect ratio)
5. **Brand context:** Is there a brand guidelines doc, ad style catalogue, or product photography index to reference?
6. **Avatar context:** If generating for a specific customer avatar, what are their emotional triggers, vocabulary patterns, and messaging hooks? Use these to inform headline language and visual tone.

### Step 3: Select Prompt Technique

Read `references/techniques.md` for detailed technique patterns.

| Need | Technique | Typical Length |
|------|-----------|---------------|
| Product on clean background | Structured + Reference anchoring | 120-250 words |
| Person using/holding product | Reference anchoring + Scene narrative | 150-300 words |
| Lifestyle / aspirational scene | Scene narrative + Photography terms | 120-250 words |
| Infographic / educational diagram | Educational framing + Constraint layer | 200-350 words |
| Before/after split-screen | Multi-panel + Constraint layer | 200-350 words |
| Ad creative (any style) | Style-specific + Three-layer | 150-350 words |
| Magazine cover / poster | Physical object framing + Text protocol | 200-350 words |
| Simple edit / background swap | Image transformation (minimal) | 30-120 words |

### Step 4: Construct Prompt

Build in this exact order (Canonical Skeleton):

```
1. Reference declaration ("Using Image 1 as the sole base reference...")
2. Preservation contract (lock scale, proportions, identity)
3. Scene / composition description (Visible Layer)
4. Anatomical constraints (if people present)
5. Lighting description (describe effects, not rigs)
6. Typography constraints (Constraint Layer, non-visible)
7. Rendered text declaration (exact strings only)
8. Exclusion clause (everything that must NOT appear, including extra limbs)
9. Quality gate ("Crisp and realistic at 200% zoom...")
```

**Not all prompts need all 9 elements.** Simple edits may only need 1, 3, 8, 9. But if people are present, element 4 is mandatory. If text or branding is involved, elements 6-8 are mandatory.

**Before finalizing, run six validation checks:**
- **Product check:** Does the product appear in any form? If yes, is a reference image attached? (Universal Product Appearance Rule)
- **Scale check:** If the product appears alongside people or objects, does the reference provide scale context? (Reference Image Scale Context Rule)
- **Coherence check:** Does every object in the scene belong naturally in the described environment? (Environmental Coherence Rule)
- **Anatomy check:** Are there people in the scene? If yes, have anatomical constraints been included? (Anatomical Integrity Protocol)
- **Context check:** If there's text, would a viewer understand the image without any external caption? (Standalone Context Rule)
- **Headline check:** Is this an ad image? If yes, does it include a headline? If not, is it Lifestyle or did the user request no copy? (Headline and Copy Default Rule)

### Step 5: Length Check

Nano Banana Pro does not require long prompts. Longer prompts often reduce instruction adherence.

| Complexity | Target Length |
|------------|-------------|
| Simple edits | 30-120 words |
| Standard brand-safe images | 120-350 words |
| Complex composites | Up to 600 words (use sparingly) |

**Guiding principle:** Write the shortest prompt that fully constrains the outcome and forbids everything else.

### Step 6: Deliver

Present the prompt with:
1. **Reference image instruction:** Which image(s) to attach and why
2. **The prompt:** Ready to paste into Nano Banana
3. **Dimensions:** Aspect ratio and pixel dimensions for the platform
4. **Variation note:** One alternative approach if the first doesn't produce desired results

If called from another skill, return the prompt in that skill's expected format (e.g., markdown file with filename conventions for funnel-builder).

## Common Failure Modes

| Failure | Cause | Prevention |
|---------|-------|-----------|
| Font specs visible in image | Typography in Visible Layer | Move to Constraint Layer + Exclusion |
| Product looks wrong despite reference | Verbal description overrides reference | Remove product description, reference only |
| Invented/wrong product in cartoon style | No reference for illustrated product | Attach reference even for cartoon/illustrated styles |
| Product rendered at wrong size | Isolated packshot used in scene with people/objects | Use reference with scale context (hand, counter, etc.) and add size constraint in prompt |
| Gibberish / lorem ipsum text | No rendered text declaration | Declare exact text + forbid all other text |
| Wrong proportions | No preservation contract | Explicitly lock scale from reference |
| Extra text appears | No exclusion clause for text | "ONLY the declared text may appear" |
| Brand colors wrong | Hex codes in Visible Layer | Move to Constraint Layer |
| Soft / blurry output | No quality gate | Add "200% zoom" realism clause |
| Annotations / guides visible | Design specs in Visible Layer | Move to Constraint + Exclusion |
| Image with text lacks context | Headline assumes viewer has read ad copy | Apply Standalone Context Rule; headline must be self-explanatory |
| Out-of-place objects in scene | Prompt includes items that don't belong in the environment | Apply Environmental Coherence Rule; verify every object belongs |
| Ad image with no headline | Prompt omits rendered text for non-Lifestyle ad | Apply Headline and Copy Default Rule; include headline unless Lifestyle or user opted out |
| Extra fingers / distorted hands | No anatomical constraints for people | Apply Anatomical Integrity Protocol; explicitly constrain hand/finger count |
| Body horror (merged limbs, extra arms) | High-risk scene without exclusions | Add explicit exclusion: "No extra fingers, hands, limbs, merged features" |

## Quality Gate (Include in Every Prompt)

"Ensure the image is crisp and realistic at 200% zoom with clean edges, consistent lighting, accurate shadows, and no halos, artifacts, or distortions."

## What This Skill Does NOT Do

- Does not generate images (produces prompts for the user to paste into Nano Banana Pro)
- Does not replace brand guidelines (reads them for colors, fonts, visual identity)
- Does not create ad concepts (the ad-style-generator skill does that; this skill writes the Nano Banana prompt)
- Does not handle video prompts (see video-prompting-guide skill if available)
