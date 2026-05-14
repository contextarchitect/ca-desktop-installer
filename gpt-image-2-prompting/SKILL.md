---
name: gpt-image-2-prompting
version: 1.0.0
description: "Craft prompts for OpenAI GPT Image 2 using the labeled-segment structure (Goal / Scene / Subject / Composition / Lighting / Style / Text / Constraints / Preserve). Use when users want GPT Image 2 prompts for new images, edits, masked edits, multi-reference composition, text-heavy layouts, style transfer, or iterative refinement. Also used when Creative Engine's 'Generate with GPT' regeneration path is triggered, or when any skill needs a GPT Image 2 prompt generated."
---

# GPT Image 2 Prompting Skill

## Purpose

Generate production-ready GPT Image 2 prompts using the labeled-segment structure. GPT Image 2 responds best to prompts that place the highest-value controls early, use short labeled segments with line breaks, and treat text accuracy as a hard constraint with exact quoting. Every prompt enforces brand accuracy, prevents common failure modes, and produces images that require minimal regeneration.

## The Overriding Rule

**Explicit instructions and layout constraints beat decorative prose.** Put the highest-value controls early (goal, scene, subject, constraints). Use concrete, visual, testable wording. Specify negatives by omission and constraint language rather than long negative-prompt lists.

## Model-Aware Rules (Non-Negotiable)

These are GPT Image 2 specific. Do not port assumptions from other image models:

1. **No `input_fidelity` parameter.** GPT Image 2 already processes image inputs at high fidelity. Do not suggest or output this parameter.
2. **No transparent backgrounds.** Transparency is unsupported. If the user asks for a transparent PNG, state that it is unsupported and provide an opaque fallback (e.g. off-white or brand-matching solid background).
3. **Aspect-appropriate sizes, not square-by-default.** GPT Image 2 supports flexible sizes. Pick the aspect ratio based on output need first (portrait for posters, landscape for heroes, square for feed).
4. **Size limits:** maximum edge 3840 px; both edges multiples of 16 px; long-edge to short-edge ratio no greater than 3:1; total pixels between 655,360 and 8,294,400.
5. **Do not default above 2K resolution** unless the user clearly needs it.
6. **Aspect ratios NOT supported (use nano-banana-prompting instead):** `1:4`, `1:8`, `4:1`, `8:1`. GPT Image 2 supports: `auto`, `1:1`, `5:4`, `9:16`, `21:9`, `16:9`, `4:3`, `3:2`, `4:5`, `3:4`, `2:3`.
7. **Prompt length limit:** 20,000 characters (vs Nano Banana Pro's 5,000). This is a real structural advantage for dense text-in-image briefs. Use the headroom when required strings are many, but do not bloat for its own sake.
8. **Text-heavy, layout-sensitive, or brand-consistency-sensitive work may still need iterative passes.** Exact text placement and repeated cross-image consistency are the weakest areas — plan for one or two refinement rounds rather than expecting perfect first-shot output.

## Mandatory: Request Classification

EVERY GPT Image 2 request must be classified as exactly one of the following before writing the prompt. The classification determines which pattern to use from `references/patterns.md`:

1. **New image generation** — no input image must be preserved
2. **Edit of existing image** — modify one aspect, preserve everything else
3. **Masked edit** — replace content in a specific region, blend with surroundings
4. **Multi-image reference composition** — combine elements from 2+ sources with explicit contribution per source
5. **Text-heavy design or layout** — posters, ads, packaging, infographics where text accuracy is a hard constraint
6. **Style transfer** — apply a specific visual style to a subject
7. **Iterative refinement** — change one thing from a previous generation, restate invariants

**Failing to classify first leads to the most common failure mode: mixing change instructions with invariants in edits, which produces drift.**

## Default Prompt Structure (Canonical Order)

For most tasks, write the prompt in this internal order. Use short labeled segments with line breaks, not a single dense paragraph:

```
Create [goal / intended use].

Scene/background: [setting].

Subject: [main subject].

Secondary elements: [only what matters].

Materials/textures: [surfaces, finish, realism cues].

Composition: [framing, angle, crop, lens feel, orientation].

Lighting/color: [light quality, mood, palette].

Style/medium: [photo, illustration, render, poster, etc.].

Text in image: "[exact text]" [placement and hierarchy — omit this line if no text].

Constraints: [hard requirements].

Preserve: [only for edits or iterative refinement].
```

**Not every line is required for every prompt.** Simple new generations may skip `Preserve:`. Lifestyle scenes may skip `Text in image:`. But the order of included lines must follow the canonical skeleton — the model reads earliest lines as highest-priority controls.

**Starter verb matters:**
- New generations: start with `Create` or `Draw`
- Edits: start with `Edit Image 1` or `Edit the provided image` or `Edit the masked area in the provided image`
- Iterative deltas: start with `Change ONLY [X]. Keep EVERYTHING ELSE the same:`

## Reference Image Protocol (Critical)

GPT Image 2 supports up to 16 reference images. Label each one.

### Base Image Rule (when references are used)
- Label sources explicitly: `Image 1`, `Image 2`, `Image 3`, etc.
- State exactly what transfers from each reference
- Separate content transfer from style transfer

Example:
```
Image 1 contribution: use the face, hairstyle, and skin tone of the person.
Image 2 contribution: use the outfit design and color palette.
Image 3 contribution: use the environment and camera framing.
```

### Universal Product Appearance Rule (CRITICAL — prevents invented products)

**ANY image where the product appears in ANY form MUST include a reference image.** This applies universally regardless of art style, rendering technique, or level of abstraction. Specifically:

- **Photorealistic scenes** (product on counter, in hand, on shelf): reference REQUIRED
- **Cartoon/illustrated versions** (animated bottle character, mascot, stylized drawing): reference REQUIRED
- **Background/environmental placement** (product visible on a ledge, in soft focus): reference REQUIRED
- **Silhouette or outline** (product shape recognizable): reference REQUIRED
- **Partial views** (cap, label, or bottom of bottle visible): reference REQUIRED

**Without a reference, the AI model will invent its own version of the product.** This results in wrong colors, wrong label design, wrong proportions, wrong cap shape, and wrong branding. This is true even for cartoon styles — an illustrated version of a product must still be based on the real product's appearance.

**The only exception:** The product does not appear in the image at all (pure infographic with no product, text-only graphic, scene without product, problem-visualization with no solution shown).

**Auto-attach behavior (when called from Creative Engine or similar):** When no reference is provided and the product should appear, auto-attach a sensible packshot from the brand's `product-images/` folder and add it to the prompt as `Image 1`. This matches the Nano skill's behavior.

**Pre-prompt checklist:** Before writing any prompt, ask: "Does the product appear in this image in any form?" If yes, a reference image is mandatory. No exceptions.

### Product Reference Rule (do not describe what the reference already shows)

**When a product reference image is attached, DO NOT describe the product verbally in the prompt.** A verbal description gives GPT Image 2 a choice between the reference and the description, and can produce drift.

WRONG:
```
"Subject: a 250ml teal and white shampoo bottle with flip-top cap and wave
design, showing the Regrowth+ logo..."
```

RIGHT:
```
Subject: the product shown in Image 1.
Preserve: exact product appearance, label, proportions, and branding from
Image 1. Do not alter, reinterpret, or reimagine the product.
```

**The rule:** Reference attached = no product description. Reference absent = describe product in detail.

### Reference Image Scale Context Rule (CRITICAL — prevents wrong product size)

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

**Prompt reinforcement:** Even with the correct reference, the prompt should reinforce scale in the `Constraints:` line. Never state specific dimensions unless you have verified them. Reference the scale context provided by the reference image:
```
Constraints: the product should appear at natural, realistic scale relative
to the person and environment. Image 1 shows the bottle held in a human
hand. Use that ratio to determine correct product size in this scene. Do
not enlarge or shrink the product beyond its real-world proportions.
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

## Text in Image Rules (CRITICAL — GPT Image 2's core strength and weak point)

GPT Image 2 is generally strong at text rendering, but text accuracy is a hard constraint and deserves explicit handling.

### The Pattern

1. **Always quote required visible text exactly.** Do not paraphrase user-provided text.
2. **Preserve capitalization, punctuation, spacing, and line breaks exactly.**
3. **When spelling is critical, repeat the text letter-by-letter after the quote.** Example: `"CITY ROAST FEST"` — spell exactly as written. For the headline, C-I-T-Y space R-O-A-S-T space F-E-S-T.
4. **Specify placement, hierarchy, size, weight, contrast, and background treatment for legibility.**
5. **Declare text as a hard constraint when the image type demands it.** Posters, ads, packaging, signs, charts, diagrams, infographics, menus, UI screens, and logos should state this explicitly:
   ```
   Text in image is a hard constraint:
   Top line: "[exact text]"
   Second line: "[exact text]"
   ```

### When to Use Letter-by-Letter Spelling

- Brand names and proper nouns the model is unlikely to have memorized
- Words with unusual spelling or capitalization
- Short critical words (3-8 characters) where a single-letter drop changes meaning
- Any word where drift would break the design (product names, event names, CTAs)

Skip letter-by-letter for common English words ('AFTER', 'BEFORE', 'CLICK HERE') — it adds noise without meaningfully reducing risk.

### Forbidden by omission

GPT Image 2 rarely adds gibberish the way some models do, but it can add interpretive decorative text. Close out the `Constraints:` line with: `no extra text, no misspellings, no placeholder, no overlapping elements.`

## Standalone Context Rule (CRITICAL — prevents meaningless images)

**Every image with text or data must be self-explanatory without any external caption, ad copy, or surrounding context.** A viewer scrolling past the image in a feed must understand the core message from the image alone.

This means:

- **Headlines must provide context, not just a statistic.** "50% SAY NOTHING HAS WORKED" is incomplete. The viewer asks: "50% of what? Nothing worked for what?" The headline must answer who, what, or why. Better: "50% OF WOMEN IN THE GULF SAY NOTHING HAS FIXED THEIR HAIR" or include a subheadline that provides the missing context.
- **Data visualizations must label what they're measuring.** A bar chart showing percentages is meaningless without a title explaining the question asked or the topic being measured.
- **Infographics must have a clear takeaway.** The viewer should understand the point being made without reading any ad copy below the image.
- **Split-screen comparisons must label both sides clearly.** "Before" and "After" are not enough if the viewer doesn't know before/after what.

**Pre-text checklist:** Before finalizing any prompt with text, ask: "If someone saw ONLY this image with no caption, no ad copy, no surrounding context, would they understand the message?" If not, the headline or labels need more context.

**This rule applies to ALL image types with rendered text:** infographics, data graphics, comparison layouts, editorial layouts, stat callouts, listicle images, and any image where text is part of the visual.

## Headline and Copy Default Rule (CRITICAL — prevents contextless ad images)

**By default, every ad image MUST include rendered text (headline, subheadline, or key message) that makes the image self-explanatory.** This is an extension of the Standalone Context Rule, applied specifically to ad creatives.

A viewer scrolling past an ad in a feed must understand the core message from the image alone, without reading any external ad copy or caption below the image.

**Default behavior (applies unless an exception is met):**
- Include a headline in the `Text in image:` line of every prompt
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

## Environmental Coherence Rule (CRITICAL — prevents unrealistic scenes)

**Every object, prop, and element in the scene MUST belong naturally in the described environment.** The AI model does not judge whether objects make sense together — it renders whatever you describe. You must enforce realism.

**Environment-specific rules:**
- **Bathroom scenes:** ONLY items found in a real bathroom (toiletries, towels, soap, toothbrush, cotton pads, candles, mirrors, hair tools). NEVER laptops, coffee cups, business cards, food, office supplies, or electronics other than an electric toothbrush or hair tool.
- **Kitchen scenes:** ONLY items found in a real kitchen. NEVER shampoo bottles, toiletries, or bathroom items.
- **Office/desk scenes:** ONLY items found on a real desk. NEVER shampoo bottles or toiletries unless the concept explicitly calls for showing the product in an unexpected context.
- **Gym/fitness scenes:** ONLY items found in a gym setting.
- **Bedroom/vanity scenes:** ONLY items found on a dressing table or bedside. Skincare and hair products are appropriate here; office supplies are not.

**Pre-prompt checklist:** Before finalizing any prompt, ask: "Would every single object I described actually be found in this environment in real life?" If any object would look out of place in the setting, remove it or replace it with something that belongs.

**This rule applies to ALL scene types.** The goal is photographic realism — the image should look like it could be a real photograph taken in that environment.

## Anatomical Integrity Protocol (CRITICAL — prevents body horror)

**Human subjects must have natural, correct anatomy.** GPT Image 2 is generally stronger than Nano Banana Pro at hand and limb rendering, but constraints are still required for high-risk scenes.

**Mandatory inclusion when people are present** (add to the `Constraints:` line or `Subject:` segment):
```
exactly two hands, each with exactly five fingers. Natural body proportions
throughout. No extra limbs, no merged fingers, no distorted joints,
no unnatural bending.
```

**Risk levels by scene type:**

| Risk Level | Scene Type | Required Action |
|------------|-----------|----------------|
| LOW | Subject from behind, distant shots, face only | Basic anatomy note sufficient |
| MEDIUM | Full body standing/sitting, arms visible | Include hand and limb constraints |
| HIGH | Hands holding product, close-up hands, two people interacting | Full anatomical constraints + explicit exclusion in Constraints: |

**For HIGH-risk scenes, add to Constraints:**
```
No extra fingers, no extra hands, no third arm, no merged or fused limbs,
no distorted facial features, no unnatural joint angles.
```

**Tip:** Medium shots (waist up) with hands below frame or naturally positioned are the safest framing for scenes with people. GPT Image 2's multi-person hand rendering is materially better than Nano's — if the scene involves two people interacting, GPT is often the correct default.

## When to Use Photorealistic Language

GPT Image 2 takes "photorealistic" as a real instruction, not a fluffy quality booster. Use it when the target image is any of the following:

- Product photography, food photography, interiors, architecture, fashion/editorial portraits, lifestyle scenes, mockups intended to resemble a real photo, or sketch-to-photo transformations.
- Composited scenes where a person or object must sit convincingly inside a believable environment.
- Cases where the user explicitly asks for the image to look like a real photo rather than an illustration, render, or graphic design piece.

**Reinforce photorealism with grounded photographic cues** — camera angle, lens feel, natural lighting, believable materials, realistic textures, true-to-life proportions, subtle imperfections, and explicit anti-stylization constraints when needed:

```
Style/medium: photoreal product photography, grounded and believable,
not illustrated, not overly cinematic, not heavily stylized.
```

**Do not add photorealistic language by default** for illustrations, flat posters, logos, icons, diagrams, infographics, cartoons, stylized 3D, or painterly work. For non-photo outputs, describe the medium directly: `Style/medium: flat-vector illustration, solid color shapes, no gradients.`

## Editing Invariants Checklist

For edits of existing images, lock identity and layout explicitly with the `Preserve:` line. Use hard locking language: `Change ONLY [X]. Keep EVERYTHING ELSE the same.`

**For edits involving people**, lock as needed:
- face and facial features
- skin tone
- body shape and proportions
- pose
- hair and hairstyle
- expression
- framing and camera angle
- background
- lighting and color balance

**For edits involving products or designs**, lock as needed:
- geometry and silhouette
- layout and margins
- alignment
- branding and logos
- existing text
- packaging structure
- materials and finish

**Example edit prompt:**
```
Edit the provided image.

Change ONLY the jacket color from navy to deep forest green.

Keep EVERYTHING ELSE the same: same person, same face, same hair, same
pose, same expression, same camera angle, same framing, same background,
same lighting, same fabric texture, same logos and seams, same image style.

Do not introduce any new accessories or background changes.
```

## Workflow

### Step 1: Classify the Request

Determine exactly one of the seven request types (see Mandatory: Request Classification above). This controls which pattern to use from `references/patterns.md`.

### Step 2: Determine Context

Check what triggered this prompt generation:
- **Standalone request:** User wants a GPT Image 2 prompt directly.
- **From Creative Engine 'Generate with GPT' regeneration:** CE passes the original Nano prompt + concept context. Re-frame into GPT Image 2's labeled-segment structure; do not pass the Three-Layer prompt through verbatim.
- **From funnel-builder / ad-style-generator / other skills:** That skill provides image purpose, dimensions, brand colors, product references, and any style-specific constraints. Apply them.

If called from another skill or tool, that skill provides: image purpose, dimensions, brand colors, product references, and any style-specific constraints.

### Step 3: Gather Requirements

Extract from the user request:

1. **Goal or intended use:** ad, product page, poster, packaging, social graphic, concept art, UI mockup, portrait, editorial image, etc.
2. **Reference images:** Does the caller have product photography or other references to attach? (Apply Universal Product Appearance Rule AND Reference Image Scale Context Rule. Auto-attach a packshot if the product appears and no reference was provided.)
3. **Scene or background**
4. **Main subject**
5. **Important secondary elements**
6. **Materials, textures, and surfaces**
7. **Composition, framing, camera angle, focal length or lens feel, crop, orientation**
8. **Lighting, mood, and palette**
9. **Style or medium:** photo, illustration, 3D render, watercolor, collage, flat vector-like poster, etc.
10. **Required visible text and exact spelling.** (If yes, activate Standalone Context Rule AND Headline and Copy Default Rule.)
11. **Hard constraints**
12. **What must remain unchanged** (for edits and iterative refinement)
13. **Output shape, aspect ratio, or size preference**
14. **Per-reference contribution** (for multi-image composition)
15. **Avatar context:** If generating for a specific customer avatar, what are their emotional triggers, vocabulary patterns, and messaging hooks? Use these to inform headline language and visual tone.

### Step 4: Select Pattern

Read `references/patterns.md` for the pattern matching the classification. The seven patterns are:

| Classification | Pattern Section |
|---------------|-----------------|
| New image generation | §1 |
| Edit of existing image | §2 |
| Masked edit | §3 |
| Multi-image reference composition | §4 |
| Text-heavy design or layout | §5 |
| Style transfer | §6 |
| Iterative refinement | §7 |

### Step 5: Construct Prompt

Build in the Canonical Order (above). Apply the pattern's specific guidance on top of the default structure. Not every prompt needs every line — simple edits may only use `Edit / Change ONLY / Keep EVERYTHING ELSE`. Text-heavy designs need the full text protocol.

**Before finalizing, run seven validation checks:**
- **Classification check:** Was the request classified as exactly one type? (Mandatory: Request Classification)
- **Product check:** Does the product appear in any form? If yes, is a reference image attached (or auto-attached)? (Universal Product Appearance Rule)
- **Scale check:** If the product appears alongside people or objects, does the reference provide scale context? (Reference Image Scale Context Rule)
- **Coherence check:** Does every object in the scene belong naturally in the described environment? (Environmental Coherence Rule)
- **Anatomy check:** Are there people in the scene? If yes, have anatomical constraints been included? (Anatomical Integrity Protocol)
- **Context check:** If there's text, would a viewer understand the image without any external caption? (Standalone Context Rule)
- **Headline check:** Is this an ad image? If yes, does it include a headline? If not, is it Lifestyle or did the user request no copy? (Headline and Copy Default Rule)

### Step 6: Length Check

GPT Image 2 supports up to 20,000 character prompts. This headroom is genuinely useful for text-heavy briefs with many required strings. But longer is not better by default:

| Complexity | Target Length |
|------------|-------------|
| Simple edits | 50-200 characters (one or two lines) |
| Simple generations | 300-1000 characters |
| Standard brand-safe images | 800-2500 characters |
| Text-heavy / multi-panel / detailed infographic | 2000-5000 characters |
| Complex composites with many invariants | Up to 10,000 characters (use sparingly) |

**Guiding principle:** Write the shortest prompt that fully constrains the outcome. Use the headroom only for required text strings and per-reference contributions that genuinely need the detail.

### Step 7: Aspect Ratio and Size

Pick based on output need first:

| Output Use | Aspect Ratio | Notes |
|-----------|-------------|-------|
| Instagram Feed | 1:1 | Square or near-square |
| Instagram Stories / Reels cover | 9:16 | Vertical |
| TikTok cover | 9:16 | Vertical |
| Facebook Feed | 1.91:1 → closest is 2:3 or 16:9 | Use 16:9 for safety |
| Landing Page Hero | 16:9 or 21:9 | Wide |
| Landing Page Inline | 3:2 or 4:3 | Landscape |
| Poster / book cover | 4:5 or 2:3 | Portrait |
| Editorial portrait | 4:5 | Portrait |
| UI mockup | 4:3 or 16:9 | Depends on device |

**If the concept requires an extreme ratio** (`1:4`, `1:8`, `4:1`, `8:1`), route to nano-banana-prompting instead — GPT Image 2 does not support these.

### Step 8: Deliver

Present the prompt with:
1. **Reference image instructions:** Which images to attach as Image 1, Image 2, etc., and what each contributes
2. **The prompt:** Ready to paste into GPT Image 2 / Kie.ai `gpt_image_2_image` tool
3. **Aspect ratio:** Matched to the platform (from the table above)
4. **Invariants (for edits):** Separate fenced block listing what must be preserved
5. **Iteration deltas (for iterative refinement):** One or two delta prompts if the user is likely to refine, each starting with `Change ONLY [X]. Keep EVERYTHING ELSE the same.`

If called from another skill, return the prompt in that skill's expected format.

## Soft Routing Guidance (Nano vs GPT)

The nano-vs-gpt A/B test v1 (April 2026, n=6 voters × 14 concepts) produced directional signals — not hard defaults. Use these as hints when the caller is choosing between models:

**Lean toward GPT Image 2 when:**
- The concept involves two or more people interacting with each other or with a product (Models Interacting category won 10-2 for GPT in v1)
- The brief includes heavy text rendering with many required strings (Simple Infographic leaned 5-7 GPT)
- The aspect ratio is in GPT's supported set and extreme ratios aren't needed

**Lean toward Nano Banana Pro when:**
- The concept is a product-on-surface or flat-lay shot with no people (Product Placement won 10-2 for Nano in v1)
- The concept is UGC-style casual phone photography (UGC leaned 8-4 Nano)
- The aspect ratio requires Nano-only extreme ratios (1:4, 1:8, 4:1, 8:1)
- 4K output is required (Nano Banana Pro supports 4K; GPT Image 2 does not)
- Google Search grounding would add factual accuracy (Nano-only feature)

**Treat as a coin flip** (v1 did not separate them meaningfully):
- Product Scale / single person holding product
- Detailed Infographic (though Nano's 5000-char prompt cap is a real constraint here; if the brief has many required strings, GPT's 20000-char headroom wins on structural grounds)
- Animation / Illustration (style-dependent; flat-vector leaned GPT, isometric-3D-cartoon leaned Nano)

**Do not treat the v1 signals as hard routing rules.** n=6 is small and the categorical splits were narrow outside the two blowouts (Product Placement and Models Interacting). CE's UI lets the user select per-generation; this skill does not override that choice. The soft guidance exists for cases where a caller is asking "which should I use?" rather than "write me a prompt for X model."

## Common Failure Modes

| Failure | Cause | Prevention |
|---------|-------|-----------|
| Product looks wrong despite reference | Verbal description overrides reference | Remove product description, reference only (Product Reference Rule) |
| Invented/wrong product in cartoon style | No reference for illustrated product | Attach reference even for cartoon/illustrated styles (Universal Product Appearance Rule) |
| Product rendered at wrong size | Isolated packshot used in scene with people/objects | Use reference with scale context and add size constraint (Reference Image Scale Context Rule) |
| Text drifts or is misspelled | No exact quoting, no letter-by-letter spelling | Quote exactly, add letter-by-letter for critical words, declare as hard constraint |
| Extra decorative text appears | No exclusion in Constraints line | Add "no extra text, no misspellings, no overlapping elements" |
| Edit drifts from original (wrong identity, wrong background) | Mixed change instructions with invariants | Use "Change ONLY X. Keep EVERYTHING ELSE the same:" pattern, list invariants explicitly |
| Transparent background fails | Transparency is unsupported on GPT Image 2 | Use opaque fallback (off-white or brand color); inform user if they explicitly requested transparency |
| Unsupported aspect ratio rejected | 1:4, 1:8, 4:1, 8:1 not supported | Route to nano-banana-prompting for extreme ratios |
| Dense prompt, weak adherence | Prompt is one long paragraph instead of labeled segments | Rewrite as labeled segments with line breaks |
| Scope creep (unrequested flourishes) | Prompt added style words the user didn't ask for | Preserve user's requested scope; no new elements, text, logos, props, or style flourishes unless requested |
| Masked edit has visible seams | Mask treated as hard edge | Describe perspective, lighting, edges, shadows, material continuity; "blend naturally into the surrounding scene" |
| Image with text lacks context | Headline assumes viewer has read ad copy | Apply Standalone Context Rule; headline must be self-explanatory |
| Out-of-place objects in scene | Prompt includes items that don't belong in the environment | Apply Environmental Coherence Rule; verify every object belongs |
| Ad image with no headline | Prompt omits rendered text for non-Lifestyle ad | Apply Headline and Copy Default Rule |
| Extra fingers / distorted hands | No anatomical constraints for people | Apply Anatomical Integrity Protocol |
| Multi-reference merging | Reference roles left ambiguous | Label each image and state exactly what transfers from each |
| Iteration drift | Multiple changes in one refinement round | One variable at a time, restate invariants each round |
| `input_fidelity` suggested | Treated as a Sora/Dall-E-style param | Do not suggest this param — GPT Image 2 processes at high fidelity by default |

## Failure Modes to Actively Avoid

(From the GPT Image 2 prompting guide — these are the canonical anti-patterns the model's authors call out)

- Overwriting scope with unrequested stylistic additions
- Dense prompts that bury the actual constraint
- Forgetting preserve instructions in edits
- Mixing multiple changes into one refinement round
- Weak text-placement guidance for posters or packaging
- Using unsupported assumptions such as transparent backgrounds for GPT Image 2
- Vague descriptors that do not translate into visible control

## Assumptions Policy

- If the request is clear enough to produce a useful prompt, proceed without blocking on questions.
- Ask clarifying questions only when missing information would materially change the result.
- When proceeding without clarification, make reversible assumptions and label them briefly outside the main prompt when that helps future refinement.

## What This Skill Does NOT Do

- Does not generate images (produces prompts for the caller to pass to GPT Image 2 via the `kie-ai:gpt_image_2_image` tool or equivalent)
- Does not replace brand guidelines (reads them for colors, fonts, visual identity)
- Does not create ad concepts (the ad-style-generator skill does that; this skill writes the GPT Image 2 prompt)
- Does not handle video prompts (see video-prompting-guide)
- Does not override user choice between Nano and GPT Image 2 — CE's UI lets the user pick, and this skill is invoked after that choice is made. Soft routing guidance is for callers asking "which should I use?" without having picked yet.
