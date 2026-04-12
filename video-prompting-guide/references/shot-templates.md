# Shot Templates — E-Commerce Video Prompts

Copy-paste prompt templates for common e-commerce shots. Each template is provided in the recommended model format. Adapt the bracketed sections for your brand, product, and character.

All templates assume I2V mode (reference image provided as first frame) unless marked T2V.

---

## UGC Templates

### UGC-01: Selfie Talking Head (Hook/CTA)

**Use for:** Opening hook, testimonial delivery, CTA
**Model:** Veo 3.1 (English) or Seedance 1.5 (multilingual)
**Duration:** 3-5 seconds
**Aspect:** 9:16

**Anchor still:** Character at selfie distance, front-facing camera, natural environment behind.

**Veo 3.1 prompt:**
```
Starting from the reference image. The woman speaks directly to
camera with natural enthusiasm: "[Exact dialogue line]." Subtle
handheld sway as if holding phone in one hand. Natural eye contact
with slight glances away. Ambient room sound. Duration: 5 seconds.
Maintaining consistent facial features and appearance throughout.
No morphing, no warping, no new elements appearing.
```

**Seedance 1.5 prompt:**
```
The woman speaks to camera: "[Dialogue in target language]."
Subtle phone sway. Natural blinks and micro-expressions. Static
background. 5 seconds.
```

---

### UGC-02: Product Unboxing / First Impression

**Use for:** Problem-to-solution transition, product reveal
**Model:** Sora 2 Pro (long clip) or Kling 3.0 (multi-reference)
**Duration:** 5-8 seconds
**Aspect:** 9:16

**Anchor still:** Hands visible at edge of frame, package/product on surface, top-down or slight angle view.

**Sora 2 Pro prompt:**
```
Using the provided image as the starting frame. Hands reach into
frame and open the package, lifting the product out with a gentle
reveal motion. Camera holds steady from above with subtle handheld
sway. Natural, unhurried pace. Shot on smartphone, casual and
authentic. Maintaining product appearance exactly as shown.
No morphing, no scale changes, no color shifting.
```

---

### UGC-03: Morning/Evening Routine (Product in Use)

**Use for:** Solution demonstration, lifestyle context
**Model:** Seedance 1.5 (best first-frame fidelity for product) or Sora 2 Pro
**Duration:** 4-6 seconds
**Aspect:** 9:16

**Anchor still:** Character at bathroom vanity or mirror, product visible on counter at correct scale (use hand-holding or counter-placement reference for scale context).

**Seedance 1.5 prompt:**
```
The woman picks up the product from the counter and applies it
to her [hair/skin/face]. Gentle, natural motion. Camera static.
Soft ambient bathroom sound. 5 seconds.
```

---

### UGC-04: Before/After Reaction

**Use for:** Proof/results section
**Model:** Sora 2 Pro (Cameo for character match) or Veo 3.1
**Duration:** 3-5 seconds per clip (generate "before" and "after" as separate clips)
**Aspect:** 9:16

**Anchor still (before):** Character looking dissatisfied, flat lighting, muted environment.
**Anchor still (after):** Same character looking confident, warmer lighting, brighter environment.

**Sora 2 Pro prompt (before clip):**
```
Using the provided image as the starting frame. The woman examines
her [hair/skin] in the mirror with visible frustration, gently
touching the problem area. Slight head shake. Handheld phone camera
feel, selfie perspective. Natural bathroom lighting. 4 seconds.
Maintaining consistent appearance. No morphing, no warping.
```

**Sora 2 Pro prompt (after clip):**
```
Using the provided image as the starting frame. The woman runs her
fingers through her [hair/touches her skin] with visible satisfaction,
a genuine smile spreading across her face. She turns slightly to
check from another angle. Handheld phone feel. Warmer, brighter
lighting. 4 seconds. Same character maintained from before clip.
No morphing, no warping.
```

---

### UGC-05: Friend Recommendation / Social Proof

**Use for:** Social proof section, peer endorsement
**Model:** Veo 3.1 (dialogue) or Sora 2 Pro
**Duration:** 4-6 seconds
**Aspect:** 9:16

**Anchor still:** Character in casual setting (couch, cafe, outdoor), relaxed posture, speaking to camera.

**Veo 3.1 prompt:**
```
Starting from the reference image. The woman leans slightly toward
camera with genuine excitement and says: "[Recommendation dialogue]."
Natural hand gestures while speaking. Casual, intimate tone as if
talking to a friend on FaceTime. Phone microphone audio quality
with slight room ambience. 5 seconds. No cinematic elements,
no stabilization, no color grading.
```

---

## Cartoon / Animation Templates

### CARTOON-01: Animated Explainer (How Product Works)

**Use for:** Mechanism of action, ingredient breakdown, educational
**Model:** Sora 2 Pro (best for stylized) or Kling 3.0
**Duration:** 5-8 seconds per scene
**Aspect:** 9:16 or 16:9

**Anchor still:** First frame of the explanation sequence (e.g., cross-section diagram, ingredient molecule, product layer illustration) generated in the chosen animation style via Nano Banana.

**Sora 2 Pro prompt:**
```
In flat 2D animation style with clean bold outlines and [brand color
palette]. Starting from the reference frame, the [diagram/molecules/
layers] animate to show [the process — ingredient penetrating skin
layers / molecule binding to receptor / product flowing through hair
strand]. Smooth, educational pacing. Elements appear sequentially
with subtle bounce. Clean white background. 6 seconds.
No style drift, no 3D effects, no photorealistic elements.
Maintaining consistent line weight and color palette throughout.
```

---

### CARTOON-02: Animated Character Testimonial

**Use for:** Relatable character telling product story in cartoon form
**Model:** Sora 2 Pro or Kling 3.0
**Duration:** 4-6 seconds
**Aspect:** 9:16

**Anchor still:** Cartoon character (generated from character sheet) in relevant setting, facing camera or 3/4 view.

**Sora 2 Pro prompt:**
```
In [chosen animation style — e.g., Pixar 3D / flat 2D / anime].
Starting from the reference frame, the character [specific action —
gestures while speaking / picks up the product / points to their
hair with surprise]. Expressive facial animation with natural blink
cycle. Subtle body movement. Background static. 5 seconds.
Maintaining exact character design from reference throughout.
No style mixing, no morphing, no design drift.
```

---

### CARTOON-03: Motion Graphics Product Feature

**Use for:** Feature callouts, stat highlights, benefit lists
**Model:** Sora 2 Pro
**Duration:** 3-5 seconds
**Aspect:** 9:16 or 1:1

**Anchor still:** Product illustration with feature callout arrows or benefit icons positioned around it, in brand colors.

**Sora 2 Pro prompt:**
```
Clean vector animation style. Starting from the reference frame,
the feature callouts animate in sequentially — each icon slides in
from the edge and connects to the product with a smooth line.
Subtle product rotation or gentle float. Kinetic, professional
pacing. [Brand primary color] accents. 4 seconds.
No photorealistic elements, no text rendering, no 3D depth.
```

**NOTE:** All text/labels in motion graphics are overlaid in post-production. The AI generates only the animated icons, lines, and product motion.

---

### CARTOON-04: Animated Before/After Transformation

**Use for:** Problem visualization → solution demonstration
**Model:** Sora 2 Pro or Kling 3.0
**Duration:** 5-8 seconds
**Aspect:** 9:16

**Anchor still:** Split or sequential frame showing the "before" state in the chosen cartoon style.

**Sora 2 Pro prompt:**
```
In [animation style]. Starting from the reference frame showing
the problem state, the scene smoothly transforms: [describe the
visual transformation — dull hair becomes vibrant, dry skin becomes
smooth, tired expression becomes energized]. Satisfying, smooth
transition over 3 seconds, then holds the result state for 2
seconds. Consistent art style maintained throughout the transformation.
No style drift, no photorealistic blending.
```

---

## Product B-Roll Templates

### PRODUCT-01: Hero Product Shot (Slow Rotation)

**Use for:** Product reveal, beauty shot
**Model:** Veo 3.1 (best material rendering) or Kling 3.0
**Duration:** 4-6 seconds
**Aspect:** 1:1 or 9:16

**Anchor still:** Product on clean surface with studio-style lighting. Nano Banana still using editorial/hero technique.

**Veo 3.1 prompt:**
```
Starting from the reference image. The product slowly rotates on
its axis, approximately 45 degrees clockwise. Soft studio lighting
highlights the surface texture and label. Subtle reflection on the
surface below. Smooth, elegant motion. 5 seconds. Single continuous
shot. Product shape, color, label, and proportions maintained
exactly. Product label and branding remain legible throughout.
No label distortion, no color shifting, no morphing, no cuts,
no angle changes.
```

---

### PRODUCT-02: Product in Use (Close-Up Hands)

**Use for:** Application demonstration, texture reveal
**Model:** Kling 3.0 (multi-reference for product + hands) or Sora 2 Pro
**Duration:** 3-5 seconds
**Aspect:** 9:16

**Anchor still:** Close-up of hands holding/using the product, showing texture and application. Use Tier 2 framing (hands visible but not primary focus).

**Kling 3.0 prompt:**
```
References:
- Image 1: Product appearance (preserve exactly)
- Image 2: Hand position and scene composition

The hands gently squeeze the product, dispensing a small amount.
Natural, unhurried motion. Camera holds steady on the action.
Soft, even lighting. 4 seconds.

Negative: morphing, extra fingers, product color change, scale
change, label distortion, phantom limbs.
```

---

### PRODUCT-03: Product Placement in Environment

**Use for:** Lifestyle context, aspirational setting
**Model:** Sora 2 Pro or Veo 3.1
**Duration:** 3-5 seconds
**Aspect:** 9:16 or 16:9

**Anchor still:** Product naturally placed in lifestyle environment (bathroom counter, vanity, shelf) with appropriate surrounding objects. Use Nano Banana Environmental Coherence Rule.

**Sora 2 Pro prompt:**
```
Using the provided image as the starting frame. The light shifts
very slightly as if a cloud passed outside the window. Soft fabric
of a nearby towel settles gently. Product remains completely still
and unchanged. Camera performs a very slow arc, maintaining
consistent distance from the product. Peaceful, premium atmosphere.
5 seconds. Single continuous shot. Product label and branding
remain legible throughout. No product movement, no morphing,
no new objects appearing, no cuts, no angle changes.
```

---

### PRODUCT-04: Product Reveal from Packaging

**Use for:** Unboxing feel, premium presentation
**Model:** Sora 2 Pro
**Duration:** 5-8 seconds
**Aspect:** 9:16

**Anchor still:** Closed packaging centered in frame, clean background.

**Sora 2 Pro prompt (T2V acceptable here if packaging design is simple):**
```
Using the provided image as the starting frame. The packaging
opens smoothly, revealing the product inside. A hand enters
from below frame and lifts the product out with a gentle,
appreciative motion. Soft studio-style lighting. Premium,
deliberate pacing. 7 seconds. Product appearance maintained
exactly from reference. No label changes, no color drift.
```

---

## Atmospheric / Establishing Templates

### ATMO-01: Location Establishing Shot (T2V)

**Use for:** Setting the scene before character/product clips
**Model:** Veo 3.1 (physics accuracy) or Sora 2 Pro (long clips)
**Duration:** 3-5 seconds
**Aspect:** 9:16 or 16:9

**No anchor still needed — T2V mode.**

**Veo 3.1 prompt:**
```
[Detailed environment description — "A modern bathroom at golden
hour, white subway tile walls, brass fixtures, a marble counter
with folded towels and candles, soft warm light streaming through
a frosted window"]. Camera slowly pans from left to right across
the space. Gentle, serene atmosphere. 4 seconds. Photorealistic,
natural lighting.
```

**IMPORTANT:** Save the best frame from this generation as the anchor still for all subsequent clips in this environment.

---

### ATMO-02: Close-Up Texture / Ingredient (T2V)

**Use for:** Ingredient beauty shot, sensory appeal
**Model:** Veo 3.1
**Duration:** 3-4 seconds
**Aspect:** 1:1 or 9:16

**Veo 3.1 prompt:**
```
Extreme close-up macro shot of [ingredient/texture — "golden oil
droplets falling into clear liquid" / "botanical leaves with morning
dew" / "cream being stirred with visible texture"]. Slow motion.
Soft studio lighting with subtle golden warmth. Shallow depth of
field. Satisfying, sensory visual. 4 seconds. Photorealistic
detail.
```

---

## Multi-Clip Sequence Example

### Full 30-Second UGC Ad: Hair Care Product

```
SHOT LIST — "Hard Water Hair Rescue"
Style: UGC
Duration: 30 seconds
Platform: TikTok (9:16)

CHARACTER DNA:
Woman, early 30s, Middle Eastern features, warm olive skin,
shoulder-length dark brown wavy hair, wearing white cotton
robe. No makeup. Natural, relatable appearance. Signature
detail: small gold hoop earrings.

PRODUCT REFERENCE: [Nano Banana still — product held in hand]
ENVIRONMENT: [Nano Banana still — modern bathroom, white tile, brass]

HOOK (0-5s)
  Shot 1: [3s] UGC-01 talking head — "If your hair feels like
    straw after every shower..." — Veo 3.1
  Shot 2: [2s] UGC-04 before reaction — frustrated hair touch
    in mirror — Sora 2 Pro

PROBLEM (5-12s)
  Shot 3: [3s] ATMO-02 close-up of hard water mineral buildup
    texture — Veo 3.1 (T2V)
  Shot 4: [4s] UGC-01 talking head — "It's not your hair, it's
    your water" — Veo 3.1

SOLUTION (12-22s)
  Shot 5: [3s] PRODUCT-03 product on bathroom counter, steam
    rising — Sora 2 Pro
  Shot 6: [4s] UGC-03 morning routine, applying product —
    Seedance 1.5
  Shot 7: [3s] PRODUCT-02 close-up dispensing product —
    Kling 3.0

CTA (22-30s)
  Shot 8: [4s] UGC-04 after reaction — confident hair flip,
    genuine smile — Sora 2 Pro (same character via Cameo)
  Shot 9: [4s] UGC-01 talking head — "Link in bio, seriously"
    — Veo 3.1

POST-PRODUCTION:
  - Voiceover: ElevenLabs (or native audio from Veo shots)
  - Captions: CapCut auto-captions
  - Text overlays: Product name, CTA, pricing
  - Background music: Subtle, trending audio
  - Transitions: Hard cuts between all clips
```
