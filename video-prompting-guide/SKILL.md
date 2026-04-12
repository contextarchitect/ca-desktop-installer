---
name: video-prompting-guide
description: |
  Generate production-ready AI video prompts for e-commerce ad production using Image-to-Video
  first-frame anchoring. Covers Sora 2 Pro, Veo 3.1, Seedance 1.5, and Kling 3.0.
  Two visual styles: UGC (photorealistic) and Cartoon/Animation.
  Handles multi-clip consistency (product, character, background), shot list planning,
  model routing, anatomical integrity, and assembly guidance.
  Triggers: video prompt, video ad, UGC video, animated ad, video generation, AI video,
  e-commerce video, product video, video creative, talking head video, b-roll generation,
  cartoon video ad, animated explainer, video shot list, multi-clip video
---

# E-Commerce Video Prompting Skill

## Purpose

Generate production-ready video prompts for e-commerce ad creation. Videos are 30-90 seconds long, assembled from multiple 3-8 second clips generated separately. Every prompt enforces product accuracy, character consistency, and brand fidelity across clips. Outputs are optimized for Meta Feed, TikTok, and Instagram Reels.

This skill works in two contexts:
1. **Claude Desktop:** Interactive prompt crafting with the user
2. **Creative Engine:** System prompt source for automated video generation Edge Functions

## The Overriding Rule

**Image-to-Video (I2V) is the default mode. Text-to-Video (T2V) is the fallback.** Every clip that contains a product, a character, or a branded environment MUST start from a generated still image. The reference image carries all visual information. The text prompt describes ONLY motion, camera, and temporal progression.

## Adapted Three-Layer Model for Video

Video prompting adapts the image Three-Layer Model (Visible, Constraint, Exclusion) for the temporal dimension. The critical difference: in I2V mode, the reference image replaces the Visible Layer's visual content role.

### Layer 1: Motion Layer (replaces Visible Layer)
What HAPPENS in the clip — motion, camera, and change over time:
- Subject actions (walks, reaches, applies, turns, smiles)
- Camera movement (tracking, dolly, pan, static, orbit)
- Camera speed and pacing (slow, gentle, sudden)
- Environmental motion (wind, steam, light shift)

**The Motion Layer must NOT re-describe visual content already present in the reference image.** This is the video equivalent of the image rule "reference images are shown, not described." Over-describing visuals causes reduced motion or conflicting output.

### Layer 2: Temporal Constraint Layer (replaces Constraint Layer)
Rules that GOVERN timing and consistency but are not visible:
- Duration target ("approximately 5 seconds")
- What stays static ("the product remains in frame throughout, unmoved")
- Consistency anchors ("maintaining consistent form, never morphing")
- Pacing guidance ("action completes in the first 3 seconds, holds for 2")
- Shot type and framing constraints ("medium shot, waist-up, 35mm equivalent")

### Layer 3: Exclusion Layer (extends image Exclusion Layer)
Explicit prohibitions preventing temporal artifacts:
- No morphing, warping, or shape-shifting of any subject
- No color shifting or palette drift
- No new elements appearing mid-clip
- No scale changes to product or character
- No phantom limbs, extra fingers, or anatomical distortion
- No camera shake (unless UGC style explicitly requires it)
- No montage, cutaways, flashbacks, or scene changes within a single clip
- No camera angle changes, no shot transitions, no cuts within a single clip
- No overlay text generation (headlines, CTAs, captions overlaid in post-production)

**A video prompt without all three layers will produce drift, artifacts, or inconsistency.**

## I2V Bridge Protocol (Critical)

This protocol connects image generation (Nano Banana skill) to video generation. It is the foundation of the entire workflow.

### Stage 1: Generate the Anchor Still
Use the Nano Banana Pro Prompting Skill to generate a perfect reference image. This image becomes the first frame of the video clip.

**What the anchor still must contain:**
- Product at correct scale and position (if product appears in clip)
- Character with locked appearance (if character appears in clip)
- Environment with correct lighting, palette, and layout
- Correct aspect ratio for the target platform (9:16 for vertical, 16:9 for landscape)

**What the anchor still must NOT contain:**
- Motion blur (the still is a frozen starting frame)
- Text or headlines (overlay in post-production)
- Multiple scenes or panels

### Stage 2: Write Motion-Only Prompt
The video prompt describes ONLY what changes from the still image:

WRONG (re-describes visuals):
```
"A woman with shoulder-length brown hair wearing a white robe in a
modern bathroom with white subway tiles holds a teal shampoo bottle
and applies it to her hair under warm morning light"
```

RIGHT (motion only):
```
"The woman gently squeezes the bottle, dispensing product into her
palm, then reaches up to work it through her hair. Camera holds
steady. Soft natural motion, realistic pace."
```

### Stage 3: Apply Three Layers
Combine motion description with temporal constraints and exclusions.

### When to Use T2V Instead
T2V is appropriate ONLY when:
- Generating an abstract establishing shot with no product or character
- Creating atmospheric b-roll (clouds, water, light patterns)
- The concept explicitly calls for AI creative interpretation without brand constraints

## Multi-Clip Continuity Protocol

### Product Consistency Across Clips

**Rule 1: One product still, many clips.** Generate a single high-quality product image using Nano Banana. Use it (or crops/angles of it) as the reference for every clip where the product appears.

**Rule 2: Frame chain at cut points.** Export the final frame of clip N. Use it as the first-frame reference for clip N+1. This propagates product appearance, lighting, and environment across the sequence.

**Rule 3: Distinguish overlay text from product label text.** Overlay text (headlines, CTAs, captions, data labels) must NEVER be generated in video clips — all overlay text is added in post-production. However, product label text (brand name, product name, ingredient icons, bilingual labeling) is part of the product's physical appearance and must be PRESERVED from the I2V reference image. If the label degrades to noise during animation, that is a product fidelity failure. Use Pro/Quality model tiers for clips where the label is prominently visible.

**Rule 4: Lock product description across all prompts.** If using T2V fallback, the product description must be identical verbatim in every prompt. "250ml teal bottle" must never become "medium blue-green container."

**Rule 5: Budget for lighting matching.** Independent I2V generations from the same reference may produce slightly different lighting conditions. Generate 2-3 versions of each clip and select the set with the most consistent lighting. Review clips side-by-side before assembly, not just individually.

### Character Consistency Across Clips

**The Character DNA Template:**
Define the character ONCE and reference identically in every clip:

```
CHARACTER ANCHOR — [Name/Role]:
- Face: [jaw shape, nose, eye shape/color, distinguishing marks]
- Hair: [style, length, texture, exact color, hairline]
- Build: [body type, height impression, posture]
- Outfit: [specific clothing items, colors, accessories]
- Signature detail: [1-2 unique visual hooks — heart mole, teal scarf, silver ring]
```

**The Freeze/Iterate Rule:** Freeze the character description. Iterate ONLY the action and camera. Never paraphrase the character description between clips. "Shoulder-length black hair" must not become "medium-length dark hair" in any prompt.

**Model-Specific Character Tools:**
- **Sora 2 Pro Cameo:** Upload a short video+audio recording to create a persistent character ID referenced via @name. Achieves ~95% consistency. Best option when available.
- **Seedance 1.5/2.0 First-Frame:** Feed character reference as first frame. Preserves identity within clip. Chain frames across clips.
- **Veo 3.1:** Generate character against plain background first ("green screen trick"), then use Frames-to-Video with scene replacement. Veo shows unusual determinism — identical prompts produce similar results.
- **Kling 3.0:** Supports up to 7 simultaneous reference images tagged by role. Feed character reference + environment reference + product reference simultaneously.

### Background/Setting Consistency

**Rule 1: Establish then anchor.** Generate a high-quality still of each environment. Use it as the first-frame reference for all clips in that setting.

**Rule 2: Verbatim environment descriptions.** Keep the environment description identical across all prompts in the same setting. "Modern bathroom, white subway tile, brass fixtures, soft morning light from left window" — copy-paste this exactly, never paraphrase.

**Rule 3: Use Seedance fixed-camera mode** when the camera should not move within a setting. This isolates subject motion while keeping environments perfectly static.

## Anatomical Integrity Protocol

### Safe Shot Design for E-Commerce

**Tier 1 — Safest (use as primary framing):**
- Medium shots waist-up, hands not prominently featured
- Close-ups on face or product, avoiding hand detail
- Product-focused inserts with minimal human presence
- Over-the-shoulder shots with partial subject occlusion
- Specify 35-50mm lens equivalent at eye level (wide angles amplify distortion)

**Tier 2 — Moderately Safe:**
- Full-body static poses, hands at sides or simply holding product
- Slow pan/dolly movements around stationary subject
- Hands visible but not performing complex manipulation

**Tier 3 — Avoid Unless Necessary:**
- Extreme close-ups of hands during product manipulation
- Wide-angle shots (below 28mm equivalent)
- Low-angle looking up at subject
- Fast motion sequences with visible limbs
- Multiple people physically interacting

### Anatomical Prompt Patterns

**Positive anchors (include in every human-subject prompt):**
```
Temporal Constraint Layer:
Natural human anatomy throughout. Realistic finger articulation.
Consistent body proportions maintained across all frames.
```

**Negative anchors (include in Exclusion Layer):**
```
No distorted hands, no extra fingers, no broken joints, no extra
limbs, no phantom limbs, no warped proportions, no face morphing,
no body part duplication, no limb disappearance mid-motion.
```

**Budget for 3-5 generations per clip** to get anatomically clean results. For critical hand-product interactions, consider filming real hands and compositing.

**Observed pass rates (Sora 2 Standard, 5 runs per tier):**
- Tier 1: 5/5 clean (100%) — reliable for production use
- Tier 3: 3/5 clean (60%) — budget 3-5 generations per clip

### Safe Camera Direction for Product Shots
- **Safe:** Static framing, slow orbit/arc, pull-back, pan across
- **Risky:** Slow push-in toward product (magnifies label text artifacts)
- **Avoid:** Fast zoom to label, extreme close-up of label text, rack focus to label

## Text in Video: Two Categories

There are two fundamentally different types of text in e-commerce video. They follow opposite rules.

### Category 1: Overlay Text — NEVER Generate
Headlines, subheadlines, CTAs ("Shop Now"), data labels, statistics, before/after labels, captions, and any editorial or promotional copy must NEVER be generated within AI video clips. All overlay text is added in post-production using Remotion, CapCut, or FFmpeg text filters. AI video models cannot maintain legible standalone text across frames.

This means the Rendered Text Protocol, Standalone Context Rule, and Headline and Copy Default Rule from the Nano Banana skill do NOT apply to video clips. They apply only to the thumbnail/poster frame (which is a Nano Banana still image).

### Category 2: Product Label Text — MUST Be Preserved
Text that is physically part of the product (brand name, product name, ingredient icons, regulatory text, bilingual labeling) is NOT overlay text. It is a component of the product's physical appearance, just like the bottle shape, cap design, and teal wave graphic.

Product label text must be preserved from the I2V reference image. If the label degrades to noise, blurs beyond recognition, or morphs during animation, that is a **product fidelity failure** — the same category as the bottle changing shape or color.

**Label Preservation Rules:**
- The I2V anchor still must show the label clearly (the reference carries the text)
- The motion-only prompt should NOT re-describe label text (same as all other visual content)
- Include in the Temporal Constraint Layer: "Product label and branding remain legible throughout"
- Include in the Exclusion Layer: "No label distortion, no text degradation, no branding loss"
- Avoid camera movements that push in toward the product label (zoom, dolly-in, slow push-in) — these magnify small text imperfections. Instead, use static framing, slow orbit/arc, or pull-back movements for product hero shots.
- Score label legibility as part of Product Fidelity, not as a text generation issue

**Model Impact:** Higher-resolution models (Sora 2 Pro, Veo 3.1 Quality) preserve label detail significantly better than standard/fast tiers. For product hero shots where the label is prominently visible, use Pro/Quality tier. For clips where the product is in the background or partially occluded, Standard/Fast tier is acceptable.

## UGC Style Protocol

### The UGC Prompt Formula
```
[Phone camera spec] + [Subject action] + [Imperfection markers] + [Natural lighting] + [No polish keywords]
```

### Keywords That Produce UGC Authenticity
**Camera:** "handheld smartphone video," "shot on front iPhone camera," "selfie mode," "subtle camera sway," "autofocus micro-pulses," "no stabilization," "native wide lens ~26mm"

**Imperfection (the "realism governor"):** "no perfect symmetry, tiny hair flyaways, slight skin texture, natural hand motion, minor exposure variation"

**Lighting:** "pure natural light," "unbalanced exposure," "daylight through blinds," "kitchen fluorescent," "bathroom vanity light"

**Audio (if model supports):** "raw phone audio," "room echo," "ambient background noise"

### Keywords to AVOID for UGC
These push output toward cinematic and destroy the UGC feel:
- "cinematic," "film-grade," "theatrical"
- Any professional camera brand (ARRI, RED, Sony A7)
- "shallow depth of field," "bokeh," "anamorphic"
- "color graded," "LUT"
- "dolly," "gimbal," "steadicam," "crane"
- "4K," "8K," "ultra-detailed"
- "studio lighting," "dramatic lighting"
- "epic," "stunning," "breathtaking"

### UGC Aspect Ratio and Duration
- **Aspect ratio:** 9:16 vertical (TikTok, Reels, Stories)
- **Resolution:** 720p-1080p (higher actually undermines authenticity)
- **Frame rate:** 24-30fps
- **Clip duration:** 3-8 seconds per clip
- **Final ad duration:** 21-34 seconds optimal for TikTok, 30-60 seconds for Meta

### Environmental Motion Coherence Rule (UGC/Photorealistic Only)

Every environmental motion element in a UGC or photorealistic prompt must have a logical cause within the scene. The viewer should be able to answer: "Why is this happening?"

**Logical environmental motion examples:**
- Steam/mist → ONLY if shower is running, hot water is flowing, or a humidifier is visible
- Light shift → Natural cloud movement outside a window, or time-of-day progression
- Fabric movement → A towel settling after being placed, or airflow from a vent
- Hair movement → Breeze from an open window, or the person moving their head
- Water droplets → Condensation in a steamy shower, or wet hands dripping

**Illogical environmental motion to AVOID in UGC:**
- Steam on a dry bathroom counter with no heat source
- Wind blowing hair indoors with no open window or fan
- Leaves or particles floating in a sealed indoor room
- Dramatic light flares in a normally-lit bathroom
- Fog or mist in a regular indoor setting

**Pre-prompt check:** Before including any environmental motion, ask: "Is there a visible or implied source for this motion within the scene?" If not, remove it or replace it with motion that has a logical cause.

**Exception:** Cartoon and animation styles are exempt. Stylized content can use atmospheric effects for mood and visual appeal without strict realism constraints.

### Veo 3.1 UGC Limitation
Veo 3.1's safety filter blocks I2V inputs showing people in bathrobes, towels, or bathroom settings. For hair care and personal care UGC where bathroom context is essential, route character clips to Sora 2 (Cameo for consistency) or Seedance 1.5 (best first-frame fidelity). Veo 3.1 remains the best choice for product hero shots and non-bathroom character clips.

## Cartoon/Animation Style Protocol

### Model Selection for Animation
**Kling 3.0** is the primary model for cartoon and animated content. Testing confirmed significantly more dynamic, elastic, and expressive character animation compared to Sora 2. Kling maintains style consistency over longer durations (up to 15 seconds) and supports native audio with acceptable lip sync for animated characters.

**Sora 2 Pro** is the fallback for cartoon content. It offers wider creative range for diverse stylized looks but produces stiffer character motion in flat 2D animation. Use Sora 2 when Kling is unavailable or when the style requires Sora's broader genre understanding (e.g., anime, motion graphics).

**DomoAI** (dedicated tool) offers video-to-video style transfer with 30+ preset styles. Use when converting existing real footage to cartoon style.

### Animation Style Prompt Patterns

**Pixar/3D Style:**
```
"3D animation, Pixar aesthetic, soft subsurface lighting, expressive
eyes, warm rim lighting, stylized human proportions, soft fabric
textures, vibrant saturated colors, smooth character animation"
```

**Flat 2D Animation:**
```
"Flat 2D animation, cel shading, clean bold outlines, limited color
palette, smooth transitions, minimal shadows, bold geometric shapes,
elastic character movement"
```

**Anime:**
```
"Japanese anime style, cel-shaded, high-quality 2D limited animation,
expressive large eyes, dynamic poses, speed lines for emphasis,
flowing hair physics, vibrant color saturation"
```

**Motion Graphics / Explainer:**
```
"Clean vector animation, kinetic typography, smooth morphing
transitions, minimal flat design, bold brand color scheme,
infographic-style data visualization in motion"
```

### Cartoon Character Consistency
Character consistency is **easier** in cartoon than photorealistic because simpler silhouettes and solid colors give models more stable tracking patterns. Minor variations invisible in cartoon would be obvious in photorealistic output, resulting in fewer regeneration cycles.

**Workflow:**
1. Design the character as a Nano Banana still image (character sheet: front view, 3/4 view, profile, 3+ expressions)
2. Use character sheet images as references for all video clips
3. Maintain identical style keywords across every prompt
4. Kling 3.0's multi-reference system works exceptionally well here — feed character reference + style reference + environment reference simultaneously

### Product Representation in Cartoon
**Hybrid approach:** Cartoon characters and environments with a lightly stylized but recognizable product. Generate the "cartoon version" of the product as a Nano Banana still first (using real product photo as reference with style instruction: "illustrated version of the product from Image 1, matching the flat 2D animation style, maintaining exact label design and brand colors"). Use that illustrated product still as reference in all video clips.

## Model Routing Table

### Model Consistency Rule

**Use one model for all clips in a single assembled ad.** Every AI video model has a distinct visual signature — subtle differences in color grading, motion smoothness, skin tones, and lighting interpretation. Mixing models within a single ad creates visible inconsistency across cuts, even when each clip looks good individually.

**Choose the model based on the hardest requirement in the ad:**
- If ANY clip needs legible product label → Sora 2 Pro for the entire ad
- If character-focused UGC, product in background → Sora 2 Standard for the entire ad
- If product-only, no character → Veo 3.1 for the entire ad
- If cartoon/animated → Kling 3.0 for the entire ad

**Exception:** Abstract atmospheric b-roll (clouds, water, light, ingredient macros) can come from a different model. These have no character or product continuity to match, and the hard cut already signals a visual context shift.

### Model Capabilities Reference

**Note:** This table shows which models excel at which shot types. The Model Consistency Rule takes precedence — choose ONE model for all clips in an ad based on the hardest requirement, then use that model for every clip.

| Shot Type | Best Model | Why | Fallback |
|-----------|-----------|-----|----------|
| UGC talking head (English) | Veo 3.1 | Native audio + lip-sync, 10ms latency | Sora 2 (Cameo) |
| UGC talking head (multilingual) | Seedance 1.5/2.0 | Phoneme-level lip-sync in 8+ languages | Veo 3.1 |
| UGC b-roll (product in use) | Sora 2 Standard | Fast, cheap, proven character consistency | Seedance 1.5 |
| Product hero shot / rotation | Veo 3.1 | Best material rendering and physics | Sora 2 Pro |
| Product shot (label prominent) | Sora 2 Pro or Veo 3.1 Quality | Higher resolution preserves label detail | Veo 3.1 Fast (if label partially occluded) |
| Product demo with hands | Kling 3.0 | Multi-reference locks product + person | Sora 2 Pro |
| Multi-scene narrative | Sora 2 Pro | 25s duration, Cameo for character | Kling 3.0 (6 auto-cuts) |
| Cartoon / anime | Kling 3.0 | Best animation fluidity + style consistency | Sora 2 Pro |
| Motion graphics / explainer | Sora 2 Pro | Strong at abstract/stylized motion | Veo 3.1 |
| Atmospheric b-roll (no product) | Veo 3.1 | Best physical accuracy (water, light, fabric) | Sora 2 Pro |
| Budget/high-volume testing | Veo 3.1 Fast | $0.05/sec via Kie.ai | Wan 2.6 ($0.07/sec) |

**Veo 3.1 Safety Filter Note:** Google's content filter blocks I2V inputs showing people in bathrobes, towels, or bathroom/shower contexts. For personal care UGC in bathroom settings, use Sora 2 or Seedance 1.5 instead. Veo 3.1 works for product-only shots and character clips in non-bathroom, fully-clothed contexts.

**Sora 2 Audio Note:** Sora 2 generates audio inconsistently — some clips include audio with lip-sync, others are silent, even with identical setup. Always plan for post-production voiceover (ElevenLabs). When audio is generated, it can serve as a useful lip-sync timing reference.

## Shot List Architecture

### Planning a 60-Second Ad

**Step 1: Define the ad structure**
Typical e-commerce ad follows: Hook (0-5s) → Problem (5-15s) → Solution/Product (15-30s) → Proof (30-45s) → CTA (45-60s)

**Step 2: Break into clips**
Each section maps to 2-4 clips at 3-8 seconds each:

```
SHOT LIST — [Ad Title]
Style: [UGC / Cartoon / Hybrid]
Model: [Single model for all clips — chosen by hardest requirement]
Total Duration Target: [seconds]

HOOK (0-5s)
  Shot 1: [3s] [Description] — Reference: [still #]
  Shot 2: [2s] [Description] — Reference: [still #]

PROBLEM (5-15s)
  Shot 3: [4s] [Description] — Reference: [still #]
  Shot 4: [3s] [Description] — Reference: [still #]
  Shot 5: [3s] [Description] — Reference: [still #]

SOLUTION (15-30s)
  ...

PROOF (30-45s)
  ...

CTA (45-60s)
  ...

CHARACTER DNA:
  [Character anchor description — used in ALL character clips]

PRODUCT REFERENCE:
  [Which Nano Banana still — used in ALL product clips]

ENVIRONMENT REFERENCES:
  Setting A: [Description — used in shots X, Y, Z]
  Setting B: [Description — used in shots A, B]
```

**Step 3: Generate anchor stills** (Nano Banana skill)
**Step 4: Generate video clips** (this skill — motion-only prompts per shot)
**Step 5: Assemble and overlay** (see references/assembly-guide.md and references/assembly-remotion.md)

### Script-to-Duration Matching Rule (Dialogue Clips)

For any clip where a character speaks dialogue, the script word count must match the requested clip duration. If the script is too short for the duration, the model compensates by slowing the entire video, creating unnatural slow-motion. If the script is too long, the model speeds up or truncates.

**Estimation:**
- Conversational pace: ~2.5 words per second
- Enthusiastic UGC pace: ~3.0 words per second
- Target duration = word count / pace

**Pre-prompt check:** Count the dialogue words, divide by 2.5-3.0, and set the clip duration to match. Round up by 0.5-1 second to allow for natural pauses and breathing.

## Canonical Video Prompt Skeleton

Build every I2V prompt in this order:

```
1. Reference declaration ("Using Image 1 as the first frame...")
2. Motion description (what moves and how — Motion Layer)
3. Camera behavior (movement type, speed, angle changes)
4. Temporal constraints (duration, pacing, what stays static)
5. Consistency anchors ("maintaining consistent form throughout")
6. Exclusion clause (morphing, warping, drift, anatomical artifacts, single continuous shot)
```

Not all prompts need all 6 elements. Simple b-roll may need only 1, 2, 6. But any clip with a product or character needs all six. **Every clip must include "Single continuous shot. No cuts, no angle changes." in the exclusion clause.**

## Pre-Prompt Checklist

Before writing any video prompt, verify:
- [ ] **I2V or T2V?** Does this clip contain product, character, or branded environment? If yes, I2V is mandatory.
- [ ] **Anchor still ready?** Has the reference image been generated via Nano Banana? Does it contain the right content at the right aspect ratio?
- [ ] **Scale context?** If product appears alongside a person, does the reference show correct relative scale?
- [ ] **Character DNA frozen?** Is the character description identical to all other clips featuring this character?
- [ ] **Environment locked?** Is the setting description identical to all other clips in this location?
- [ ] **Motion only?** Does the text prompt avoid re-describing visual content from the reference?
- [ ] **No overlay text?** Does the prompt contain zero requests for headlines, CTAs, captions, or editorial text? (All overlay text added in post)
- [ ] **Label preservation?** If product label is prominently visible, does the prompt include label legibility constraints? Is a Pro/Quality model selected?
- [ ] **Safe shot?** Is the framing in Tier 1 or 2 for anatomical safety?
- [ ] **Framing match?** Does the prompt's framing/composition match the anchor still? (Don't request close-up from a medium shot reference)
- [ ] **Model selected?** Does the model routing match the shot type? Is the same model used for all clips in this ad?
- [ ] **Duration set?** Is the target clip duration specified (3-15 seconds)?
- [ ] **Script-duration match?** If dialogue is included, does the word count match the clip duration at ~2.5-3 words/second?
- [ ] **Environmental coherence?** Does every environmental motion element (steam, wind, light) have a logical source in the scene?
- [ ] **Single continuous shot?** Does the exclusion clause include "no cuts, no angle changes"?

## Post-Generation Checklist

After generating each clip, verify:
- [ ] Product appearance matches reference (shape, color, label, scale)
- [ ] Product label text remains legible from reference (brand name, key elements recognizable)
- [ ] Character appearance matches Character DNA (face, hair, outfit, signature detail)
- [ ] Background matches setting reference (layout, lighting, palette)
- [ ] No anatomical artifacts (extra fingers, phantom limbs, face morphing)
- [ ] No temporal drift (colors, shapes, or sizes changing mid-clip)
- [ ] No overlay text generated within the video (headlines, CTAs, captions)
- [ ] No unexpected cuts or angle changes mid-clip (single continuous shot)
- [ ] Motion feels natural and matches the prompt intent
- [ ] Clip duration is within target range
- [ ] Product does not appear in two places simultaneously

If a clip fails 2+ checks, regenerate rather than trying to fix in post.

## Failure Mode Table

| Failure | Cause | Prevention |
|---------|-------|-----------|
| Product looks different across clips | Different T2V descriptions or no reference | Use single anchor still as I2V reference for all clips |
| Product label illegible (overlay text attempted) | Attempted to render headlines/CTAs in video | Never generate overlay text; add in post-production |
| Product label degraded (on-product text) | Low-resolution model or temporal drift | Use Pro/Quality tier for label-prominent shots; add "label remains legible" to constraints; keep clips to 3-5 seconds |
| Label imperfections visible | Camera push-in toward product magnifies text artifacts | Use static framing, orbit, or pull-back for product shots; avoid pushing in toward label |
| Product morphs during clip | Temporal drift in long clips | Use 3-5 second clips; include "never morphing" in Exclusion |
| Product appears in two places simultaneously | Model renders product in both original and new position after pickup | Include "product exists as a single object only" in constraints; keep product-interaction clips to 3-4 seconds |
| Character appearance changes between clips | Paraphrased character descriptions | Freeze Character DNA; copy-paste exactly |
| Character face morphs mid-clip | Temporal coherence collapse | Use Tier 1 framing; add face stability to Exclusion |
| Unnatural facial expressions | AI generates forced/uncanny smiles | Describe action that causes the expression, not the expression itself; generate 2-3 versions and select most natural |
| Background changes between clips in same setting | Different environment descriptions | Copy-paste environment description verbatim |
| Lighting inconsistent across clips | Random generation variance | Generate 2-3 versions of each clip; select matching lighting set |
| Extra fingers / phantom limbs | Anatomical generation failure | Tier 1 framing; anatomical exclusion prompts; budget 3-5 gens |
| Model reframes shot, ignoring reference | Prompt requests framing that contradicts anchor still | Match prompt framing to reference composition; generate new still if different framing needed |
| Unexpected cut/angle change mid-clip | Model interprets camera direction as permission to cut | Add "single continuous shot, no cuts, no angle changes" to every prompt Exclusion Layer |
| Video looks cinematic instead of UGC | Polish keywords in prompt | Remove all cinematic keywords; add UGC imperfection markers |
| Illogical atmospheric effects | Environmental motion with no cause in the scene | Apply Environmental Motion Coherence Rule; every motion needs a logical source |
| Cartoon style drifts between clips | Inconsistent style keywords | Lock style description; use same style reference image |
| Cartoon animation stiff/robotic | Model lacks animation fluidity | Use Kling 3.0 for cartoon (better fluidity than Sora); budget longer clips |
| Product blends with person's body | Object-person boundary failure | Use close-up product insert instead; or composite product in post |
| Color palette shifts between clips | No temporal constraint | Add "maintaining consistent color palette" to constraints |
| Motion too minimal or frozen | Over-described visuals in I2V prompt | Describe ONLY motion; let reference handle visuals |
| Video plays in slow motion | Dialogue script too short for requested duration | Match script word count to duration (2.5-3 words/sec); reduce duration to fit script |
| Dialogue feels rushed/truncated | Script too long for requested duration | Shorten script or increase duration to match word count |
| Visual style inconsistent across clips | Different models used for clips in same ad | Use one model for all clips in a single ad (Model Consistency Rule) |
| Veo 3.1 rejects character image | Safety filter flags bathroom/robe content | Use Sora 2 or Seedance for bathroom UGC; reserve Veo for product shots and clothed characters |

## What This Skill Does NOT Do

- Does not generate video (produces prompts for AI video models)
- Does not generate anchor still images (the Nano Banana skill does that)
- Does not replace brand guidelines (reads them for voice, compliance, visual identity)
- Does not create ad concepts or scripts (the ad-style-generator skill does concepts; this skill writes the video prompts)
- Does not handle audio generation (ElevenLabs voiceover and music are post-production steps)
- Does not perform video editing/assembly (see references/assembly-guide.md for that workflow)

## References

- `references/model-profiles.md` — Platform-specific prompt formats, capabilities, and pricing
- `references/shot-templates.md` — Copy-paste prompt templates for common e-commerce shots
- `references/assembly-guide.md` — Post-generation assembly, audio, and publishing workflow (manual tools)
- `references/assembly-remotion.md` — Programmatic video assembly using Remotion (automated pipeline)
