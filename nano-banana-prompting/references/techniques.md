# Nano Banana Pro — Prompt Techniques Reference

16 techniques for different image generation needs. Each technique applies within the Three-Layer framework (Visible, Constraint, Exclusion). Select based on the image type needed.

---

## 1. Scene Narrative

Simple descriptive approach. Best for lifestyle scenes, atmospheric shots, candid moments.

Describe a moment happening in the scene, then anchor with a style summary:

```
"A young woman stands at her bathroom vanity during her morning routine,
reaching for the product on the counter. Natural morning light through
frosted glass. Warm, editorial photography style."
```

**Tips:**
- Direct attention: "The main emphasis is on [element]"
- Add mood: "dreamy, storytelling vibe" / "warm, nostalgic" / "cinematic"
- Candid actions add authenticity: "looking slightly away, relaxed expression"

---

## 2. Structured Prompt (YAML-Style)

Detailed control over multiple elements. Best for complex compositions with specific requirements.

```yaml
subject:
  description: "Woman at vanity"
  expression: "confident, natural"
  hair: "long dark waves"

product:
  reference: "Image 1 (preserve exactly)"
  placement: "on counter, right of center"

environment:
  setting: "modern bathroom"
  lighting: "soft natural, window light"
  background: "clean marble, neutral tones"

photography:
  angle: "slight 3/4 view"
  focus: "sharp on product and hands"
  style: "editorial beauty photography"
```

**When to use:** Multiple subjects, precise positioning, complex scenes.

---

## 3. Photography Terms

Technical camera/lighting language for photorealistic results.

**Camera specs:** "Shot on Sony A7III with 85mm f/1.4 lens" (suggests quality and compression)

**Lighting setups:** "Soft key light with gentle shadow falloff and subtle edge separation"

**Focus:** "Exquisite focus on the eyes" / "Sharp focus on product label"

**Color grading:** "Clean, bright cinematic grading with subtle warmth"

**Era-specific:** "Early-2000s digital camera aesthetic" / "1990s film grain"

**Framing:** "Framed from chest up with ample headroom, shot from slightly above"

**Important:** Describe effects, not rigs. "Soft studio lighting" not "3-point, 45° key, 5600K"

---

## 4. Vibe Library

Era or style defined by signature details:

| Era/Style | Signature Details |
|-----------|-------------------|
| 2000s bedroom | CD player, beaded curtain, lip glosses, pop icon posters |
| 1990s film | Direct flash, messy hair, dim lighting, magazine posters |
| Film noir | Venetian blind shadows, cigarette smoke, fedora, rain on window |
| Wes Anderson | Symmetry, pastels, vintage props, centered framing |
| Clinical luxury | Marble surfaces, gold accents, minimalist, dramatic lighting |
| Editorial beauty | Soft focus, warm tones, natural light, high-fashion composition |

---

## 5. Physical Object Framing

Generate an image OF a physical object (magazine, poster, product box) rather than just the content.

```
"A photo of a glossy magazine cover lying on a white shelf.
The cover shows [subject]. The magazine has realistic
page edges, subtle shadow, and a barcode in the corner."
```

**Critical:** When text is on the physical object, use the full Rendered Text Protocol from SKILL.md.

---

## 6. Perspective Framing

Ask for interpretation from a specific viewpoint:

- "How a dermatologist sees a scalp under magnification"
- "How a child sees a doctor's office"
- "How an architect sees a city skyline"

The model infers what that perspective would emphasize.

---

## 7. Educational / Infographic

For diagrams, process flows, data visualization.

**Structure:**
1. State purpose: "Create an educational diagram explaining [concept]"
2. List visual components: "Illustrate: [element A], [element B], [element C]"
3. Set audience level: "Suitable for a general consumer audience"
4. Specify flow: "Use arrows to show the process direction. Label each element clearly."
5. Apply Constraint Layer for any typography or brand specs
6. Apply Exclusion Layer for font specs, hex codes, annotations

**If brand has an infographic design principles document:** Reference it for spacing, color hierarchy, and typography scale ratios.

---

## 8. Image Transformation

Transform an existing reference image. Use task-based verbs:

- "Extract the product cleanly from the background"
- "Replace the background with [new environment]"
- "Remove hands and place product on surface"
- "Change lighting from harsh flash to soft studio"

**Key:** Be specific about what changes and what stays. "Keep everything about the product identical. Change ONLY the background."

---

## 9. Multi-Panel / Split-Screen

Multiple views or panels in one image.

```
"A two-panel split-screen image. Left panel (50%): [problem state].
Right panel (50%): [solution state]. Central VS badge separating panels."
```

**Specify per panel:** What appears, color treatment, mood.
**Ensure consistency:** "Apply consistent lighting and style across ALL panels."

---

## 10. Negative Prompts / Exclusions

Tell the model what NOT to include. Place in the Exclusion Layer.

```
"No date stamp, no watermark, no additional text, no people,
no competing products, no busy background elements."
```

**Most effective for:** Stopping repeated unwanted elements across regeneration attempts.

---

## 11. Aspect Ratio & Dimensions

Always specify for the target platform:

| Platform | Dimensions | Prompt Language |
|----------|-----------|----------------|
| Instagram Feed | 1080x1080 | "Square 1:1 format" |
| Instagram Stories | 1080x1920 | "Vertical 9:16 format" |
| Facebook Feed | 1200x628 | "Horizontal 1.91:1 format" |
| Landing Page Hero | 1920x1080 | "Wide 16:9 format" |
| Landing Page Inline | 1200x800 | "3:2 landscape format" |

---

## 12. Reference Role Assignment

When using multiple reference images, assign explicit roles:

```
"Image 1: Product appearance (preserve exactly, do not reinterpret)
 Image 2: Person's pose and body position
 Image 3: Background environment and lighting mood"
```

**Common roles:** Product reference, pose reference, style reference, color palette reference, background reference, branding reference.

**Critical:** Never leave roles ambiguous. Unassigned references get merged unpredictably.

---

## 13. Character Consistency

Maintain same character across multiple outputs.

**Single reference:** Generate variations to build a library.
"A 360 turnaround view in 4 different angles, full body pose"

**Multiple references (up to 5):** Use diverse angles for better consistency.
Include: close-up, full body, different clothes/poses, different expressions.

---

## 14. Image Blending

Combine multiple input images into one:

```
"Combine these images into one cinematic image in 16:9 format.
Take the subject from Image 1 and place them in the environment
from Image 2. Use the lighting mood from Image 3."
```

---

## 15. Upscaling & Restoration

**Upscale:** "Upscale to 4K" (works with images as small as 150x150)
**Restore:** "Faithfully restore this old photo"

Minimal prompts work best here. Don't over-describe.

---

## 16. Text Translation & Localization

Translate or adapt text within images:

```
"Translate all English text on the packaging into Arabic,
keeping everything else exactly the same. Maintain the same
font style, size, and positioning for the translated text."
```

---

## Composition Guidelines

**Describe outcomes, not tools:**
- CORRECT: "Centered product with balanced negative space"
- WRONG: "Rule of thirds grid" / "Camera transform"

**Backgrounds — keep visual and minimal:**
- "Clean white background with subtle white-to-light-grey gradient"

**Lighting — describe effects, not rigs:**
- CORRECT: "Soft studio lighting with gentle shadow falloff"
- WRONG: "3-point lighting, 45° key, 5600K"

---

## Prompt Length Discipline

| Complexity | Words | Notes |
|------------|-------|-------|
| Simple edit | 30-120 | Background swap, upscale, minor change |
| Standard production | 120-350 | Product shot, lifestyle, ad creative |
| Complex composite | 350-600 | Multi-panel, multiple references, heavy text |

**Over 600 words rarely improves results and often reduces adherence.**

Write the shortest prompt that fully constrains the outcome and forbids everything else.
