# GPT Image 2 — Prompt Patterns Reference

Seven patterns covering the seven request classifications. Each applies within the Canonical Order (Goal / Scene / Subject / Secondary / Materials / Composition / Lighting / Style / Text / Constraints / Preserve).

Select based on request classification (see Mandatory: Request Classification in SKILL.md).

---

## §1. New Image Generation

**Use when:** No input image must be preserved.

**Rules:**
- Emphasize the desired end state, composition, and finish
- Include intended use when it affects polish or composition
- Be specific about visual anchors, not speculative process
- Start with `Create [goal]`

**Template:**
```
Create [goal / intended use].

Scene/background: [setting].

Subject: [main subject].

Secondary elements: [only what matters].

Materials/textures: [surfaces, finish, realism cues].

Composition: [framing, angle, crop, lens feel, orientation].

Lighting/color: [light quality, mood, palette].

Style/medium: [photo, illustration, render, poster, etc.].

Constraints: [hard requirements].
```

**Example:**
```
Create a premium e-commerce hero image.

Scene/background: seamless warm-gray studio backdrop.

Subject: a matte black ceramic coffee mug with a subtle curved handle.

Secondary elements: faint natural steam rising from the mug.

Materials/textures: smooth ceramic finish, soft rim highlights, realistic steam, no visible branding.

Composition: centered three-quarter view, medium close-up, slight top-down angle, generous negative space on the right for copy.

Lighting/color: soft diffused studio light, gentle shadow below the mug, restrained neutral palette.

Style/medium: photoreal product photography.

Constraints: no extra props, no text, no hands, no clutter.
```

---

## §2. Edit of Existing Image

**Use when:** Modifying one aspect of an existing image while preserving everything else.

**Rules:**
- Separate what changes from what must remain unchanged
- Use hard locking language: `Change ONLY X. Keep EVERYTHING ELSE the same.`
- Repeat identity and layout anchors to reduce drift
- Start with `Edit the provided image` or `Edit Image 1`

**Template:**
```
Edit the provided image.

Change ONLY [specific requested change].

Keep EVERYTHING ELSE the same: [identity/layout/style/background/invariants].

Do not add any new objects, text, logos, accessories, or scene changes unless explicitly requested.
```

**Example:**
```
Edit the provided image.

Change ONLY the jacket color from navy to deep forest green.

Keep EVERYTHING ELSE the same: same person, same face, same hair, same pose, same expression, same camera angle, same framing, same background, same lighting, same fabric texture, same logos and seams, same image style.

Do not introduce any new accessories or background changes.
```

**Invariants checklist — people:** face and facial features, skin tone, body shape and proportions, pose, hair and hairstyle, expression, framing and camera angle, background, lighting and color balance.

**Invariants checklist — products/designs:** geometry and silhouette, layout and margins, alignment, branding and logos, existing text, packaging structure, materials and finish.

---

## §3. Masked Edit

**Use when:** Replacing content in a specific masked region and blending with surroundings.

**Rules:**
- Describe the replacement content and how it should blend with surroundings
- Assume the mask is guidance, not a mathematically hard edge
- Mention perspective, lighting, edges, shadows, and material continuity
- Start with `Edit the masked area in the provided image`

**Template:**
```
Edit the masked area in the provided image.

Replace the masked [region description] with [replacement content].

Match the existing [camera perspective, surface reflections, ambient lighting, shadow direction, edge sharpness, color temperature].

Blend naturally into the surrounding scene with realistic contact shadows.

Keep EVERYTHING ELSE unchanged.
```

**Example:**
```
Edit the masked area in the provided image.

Replace the masked empty tabletop area with a small clear glass vase holding three white tulips.

Match the existing camera perspective, tabletop reflections, ambient daylight, shadow direction, edge sharpness, and overall color temperature.

Blend naturally into the surrounding scene with realistic contact shadows.

Keep EVERYTHING ELSE unchanged.
```

---

## §4. Multi-Image Reference Composition

**Use when:** Combining elements from two or more source images into a new composition.

**Rules:**
- Label sources as `Image 1`, `Image 2`, `Image 3`, etc.
- State exactly what transfers from each reference
- Separate content transfer from style transfer
- Never leave reference roles ambiguous

**Template:**
```
Create a new image using multiple references.

Image 1 contribution: [what transfers from Image 1].

Image 2 contribution: [what transfers from Image 2].

Image 3 contribution: [what transfers from Image 3].

Output: [describe the composed scene].

Preserve: realistic proportions and coherent lighting across all elements.

Constraints: do not copy any extra objects, logos, or text that are not explicitly requested.
```

**Example:**
```
Create a new image using multiple references.

Image 1 contribution: use the face, hairstyle, and skin tone of the person.

Image 2 contribution: use the outfit design and color palette.

Image 3 contribution: use the kitchen environment and camera framing.

Output: a natural lifestyle photo of the person from Image 1 wearing the outfit from Image 2 inside the environment from Image 3.

Preserve: realistic proportions and coherent lighting across all elements.

Constraints: do not copy any extra objects, logos, or text that are not explicitly requested.
```

**Common roles:** Product reference, pose reference, style reference, color palette reference, background reference, branding reference, face/identity reference, outfit reference, environment reference.

**Critical:** GPT Image 2 supports up to 16 reference images. Use the headroom when composition needs it — but each added reference should have a clearly distinct contribution. Redundant references (two pose references, three background references) create drift.

---

## §5. Text-Heavy Design or Layout

**Use when:** Posters, ads, packaging, infographics, UI mockups, menus, signs — anywhere text accuracy is critical.

**Rules:**
- Treat text accuracy and placement as hard constraints
- Put required text in exact quotes
- Preserve capitalization, punctuation, spacing, and line breaks exactly
- When spelling is critical, repeat the text letter-by-letter after the quote
- Specify size hierarchy, placement, contrast, and background treatment for legibility
- Declare `Text in image is a hard constraint:` explicitly

**Template:**
```
Create [poster/ad/package/UI screen/etc.].

Background and graphics: [visual description].

Text in image is a hard constraint:
Line 1: "[exact text]"
Line 2: "[exact text]"
Line 3: "[exact text]"

Spell exactly as written: [repeat critical words letter-by-letter if needed].

Layout: [placement, hierarchy, margins, alignment].

Legibility: [contrast, size, background treatment].

Style/medium: [design style].

Constraints: no extra text, no misspellings, no overlapping elements.
```

**Example:**
```
Create a clean promotional poster for a coffee festival.

Background: warm cream paper texture with subtle grain.

Main graphic: simple illustrated coffee cup and rising steam centered in the upper half.

Text in image is a hard constraint:
Top line: "CITY ROAST FEST"
Second line: "SATURDAY, OCTOBER 18"
Third line: "DOWNTOWN MARKET HALL"
Bottom tag: "TASTINGS • MUSIC • WORKSHOPS"

Spell exactly as written. For the headline, C-I-T-Y space R-O-A-S-T space F-E-S-T.

Layout: centered, strong hierarchy, large bold headline, medium event details, smaller bottom tag.

Legibility: high contrast dark brown text on light background, generous margins, no overlapping text or decoration behind text.

Style/medium: polished editorial poster illustration.

Constraints: no extra text, no misspellings, no overlapping elements.
```

**When to use letter-by-letter spelling:**
- Brand names and proper nouns the model is unlikely to have memorized
- Words with unusual spelling or capitalization
- Short critical words (3-8 characters) where a single-letter drop changes meaning
- Any word where drift would break the design

**Skip letter-by-letter** for common English words (`AFTER`, `BEFORE`, `CLICK HERE`) — it adds noise without meaningfully reducing risk.

---

## §6. Style Transfer

**Use when:** Applying a specific visual style to a subject while preserving composition.

**Rules:**
- State what should transfer: palette, brushwork, era, material feel, graphic language, or rendering technique
- State what should NOT transfer when needed
- Keep composition grounded and readable — don't let the style swallow the subject

**Template:**
```
Create [subject / composition].

Style transfer target: [specific style description — palette, brushwork, era, medium].

Keep the composition grounded and readable. [Any specific anti-transfer instructions.]
```

**Example:**
```
Create a portrait of a young violinist on a city rooftop at dusk.

Style transfer target: soft gouache illustration with visible dry-brush texture, muted teal-and-amber palette, simplified facial detail, layered atmospheric background shapes.

Keep the composition grounded and readable. Do not turn it into an abstract painting or add fantasy elements.
```

**Transfer-vocabulary anchors:**
- Palette: muted / saturated / monochrome / teal-and-amber / earth tones / neon
- Brushwork: dry-brush / wet-on-wet / cross-hatched / flat-vector / impasto
- Era: 1950s advertising / 1970s psychedelic / 1990s grunge / Y2K web / Soviet constructivist
- Material feel: gouache / watercolor / oil / charcoal / ink wash / risograph / screenprint
- Graphic language: flat vector / isometric / chunky 3D / woodcut / collage / mid-century modern
- Rendering technique: photoreal / painterly / stylized 3D / cel-shaded / pixel art

---

## §7. Iterative Refinement

**Use when:** Changing one thing from a previous generation while restating invariants.

**Rules:**
- Use minimal delta prompts to change one thing at a time
- Every delta should restate the important invariants
- Never bundle multiple changes into one refinement round (this is a canonical anti-pattern)
- Start with `Change ONLY [X]. Keep EVERYTHING ELSE the same:`

**Template:**
```
Change ONLY [specific change]. Keep EVERYTHING ELSE the same: [restate invariants].
```

**Example:**
```
Change ONLY the background from light gray to pale sand. Keep EVERYTHING ELSE the same: same product size, same centered composition, same mug shape, same steam, same studio lighting, same shadow softness, same crop, same photoreal finish.
```

**Common iteration scenarios:**

| Change | Invariants to Restate |
|--------|----------------------|
| Background swap | product size, composition, subject, lighting, shadows, crop |
| Color adjustment | subject identity, pose, framing, background, materials, lighting quality |
| Text correction | composition, colors, layout, hierarchy, all other text |
| Adding/removing one prop | subject, environment, lighting, composition of existing elements |
| Lighting mood change | subject identity, composition, materials, colors, text if present |
| Crop/framing adjustment | subject identity, style, lighting, colors |

**Two-delta max per prompt.** If the user wants three or more changes, split into multiple rounds. One change per round is the safest discipline.

---

## Composition Guidelines (Universal)

**Describe outcomes, not tools:**
- CORRECT: "centered composition with balanced negative space"
- WRONG: "rule of thirds grid" / "camera transform"

**Backgrounds — keep visual and minimal:**
- CORRECT: "clean white background with subtle white-to-light-grey gradient"
- WRONG: lengthy environmental descriptions for what should be a simple backdrop

**Lighting — describe effects, not rigs:**
- CORRECT: "soft studio lighting with gentle shadow falloff and subtle edge separation"
- WRONG: "3-point lighting, 45° key, 5600K"

**Composition specifics that transfer well to GPT Image 2:**
- Framing: centered / off-center / rule-of-thirds composition (describe as outcome, not grid)
- Angle: three-quarter view / slight top-down / low angle / eye-level / overhead flat-lay
- Crop: medium close-up / full-body / waist-up / close crop / wide establishing
- Lens feel: 50mm / 85mm / 35mm wide / macro / telephoto compression
- Orientation: portrait / landscape / square

---

## Aspect Ratio Decision Table

| Use Case | Aspect Ratio | Nano-only Alternative |
|----------|-------------|----------------------|
| Instagram Feed | 1:1 | — |
| Instagram Stories / Reels cover | 9:16 | — |
| TikTok cover | 9:16 | — |
| Facebook Feed | 16:9 (safe) or 2:3 | — |
| Landing Page Hero | 16:9 or 21:9 | — |
| Landing Page Inline | 3:2 or 4:3 | — |
| Poster / book cover | 4:5 or 2:3 | — |
| Editorial portrait | 4:5 | — |
| UI mockup | 4:3 or 16:9 | — |
| Extreme vertical banner | — | Route to Nano (1:4, 1:8) |
| Extreme horizontal header | — | Route to Nano (4:1, 8:1) |

---

## Length Discipline

| Complexity | Characters | Notes |
|------------|-----------|-------|
| Simple edit | 50-200 | Background swap, color change, minor change |
| Simple generation | 300-1000 | Single-subject product shot, clean scene |
| Standard production | 800-2500 | Lifestyle, ad creative, multi-element composition |
| Text-heavy / detailed infographic | 2000-5000 | Posters with 5+ required strings, multi-panel layouts |
| Complex composite | Up to 10,000 | Many invariants, multiple references, heavy text |

**Over 10,000 characters rarely improves results and often reduces adherence even within GPT Image 2's 20,000-character limit.**

Write the shortest prompt that fully constrains the outcome. Use the headroom only for required text strings and per-reference contributions that genuinely need the detail.
