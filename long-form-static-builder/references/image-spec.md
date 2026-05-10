# Long-Form Static: Image Specification (Reddit-Native Style)

The single image that runs alongside long-form-static ad copy. The whole job of the image is to look like a screenshot a real person would have on their phone, not an ad. This file is the canonical spec for the Reddit-native style. The ad-style-generator catalogue includes a summary entry as style #13 (`../../ad-style-generator/references/style-catalogue.md`) and defers to this file for full detail. The prompts here are paste-ready for direct Nano Banana use.

## Style Definition

**Style name:** Reddit-native (also called: Native candid, Phone-roll style)

**Core principle:** The image should pass a 2-second sniff test as something a real person took on their phone or screenshotted from a forum, not something a brand commissioned.

**Aspect ratio:** 4:5 (vertical). In-feed optimized. Portrait orientation produces the largest in-feed footprint on mobile, where the format converts best.

## Aesthetic Markers

The image must have at least three of these markers; without them, the image reads as a brand asset and the ad converts at half the rate of one with native styling.

- Low light or harsh fluorescent light (kitchen overhead, bathroom, hospital corridor)
- Candid framing (slightly off-center subject, imperfect cropping, foreground clutter)
- No professional staging (no clean white background, no symmetrical product placement)
- No obvious AI tells (no glossy skin, no perfect symmetry, no over-saturated colors, no impossible body proportions)
- Visible imperfection (a wrinkle, a thumbprint on the lens, a dust speck, a misaligned shelf)
- Flash glare or screen reflection where appropriate (hospital lights, fluorescent strip in a kitchen, phone screen reflected in a mirror)
- Natural color cast (yellow from incandescent bulbs, green from fluorescents, blue from screens)

## Subjects That Work

The Reddit-native style supports specific subject types that look authentic in this aesthetic. Subject choice should match the angle's emotional tone:

- Blood pressure cuff readings on a wrist or upper arm, often with the cuff still attached
- Crumpled prescription bottles on a kitchen counter, cluttered around a bottle of water
- Grocery-store-style supplement comparisons (one held up next to another in the aisle)
- Hand-held selfie style of a tired-looking person, often partial face only
- X-rays, MRI scans, or medical paperwork on a desk or held up to light
- Before/after photos with poor lighting consistency (intentional - matched lighting reads as staged)
- Swollen ankles, hands, or feet shot from above on a couch or bed
- A pill organizer mid-fill, with several open bottles around it
- Hospital corridor or waiting room from a patient's seat, shot at hip height
- A bathroom scale showing a number, framed at floor level
- Doctor's office paperwork on a clipboard, partially in shadow
- A lab report or blood work results on a counter, half-folded

Match the subject to the angle's emotional trigger:

| Emotional trigger | Recommended subject |
|------------------|--------------------|
| Vindication | Lab report or doctor's paperwork |
| Loss aversion | Pill organizer, prescription bottles, scale |
| Betrayal | Comparison shot (two products held up) |
| Desperation | Hospital corridor, waiting room |
| Identity | Mirror selfie, partial face, before/after |

## Subjects That Do NOT Work

- Brand-styled product shots on white seamless backgrounds
- Polished lifestyle scenes (yoga studio, pristine kitchen, sunlit bedroom)
- Fashion model body types or beauty model faces
- Anything that could be a stock photo
- Perfectly composed flatlays
- Studio lighting setups (softbox shadows, ring light eyes)
- Brand logos or branded packaging in focus
- Aspirational product-as-hero shots

If a subject from the works list starts looking like a subject from the does-not-work list, the markers above are missing. Add at least three.

## Source Guidance

For inspiration, pull from:

- Reddit search by problem keyword, filtered by media (e.g., r/PCOS top posts with images)
- Forum threads in the avatar's community
- Old YouTube thumbnails from informal medical content
- Patient-side photographs on health blogs

Recreate via Higgsfield with style preservation, or generate fresh in Nano Banana with the constraints below.

**Important:** Do not screenshot or directly use Reddit images. Pull the structural inspiration (subject, framing, lighting), then generate fresh.

## Nano Banana Prompt Skeleton

```
Subject: [specific subject from the works list]
Style: Reddit-native phone photograph
Aspect ratio: 4:5

Visible Layer:
- [Specific subject description with named details]
- [Foreground clutter or context items]
- [Lighting source: kitchen overhead / hospital fluorescent / phone flash / window light]

Constraint Layer:
- Phone-camera quality (not professional)
- Slightly off-center framing
- Visible imperfection: [wrinkle / thumbprint / dust speck / misalignment]
- Color cast: [yellow incandescent / green fluorescent / cool screen blue]
- Shallow depth of field where appropriate (phone-portrait mode look)

Exclusion Layer:
- No glossy skin retouching
- No perfect symmetry
- No over-saturated colors
- No professional studio lighting
- No clean white seamless background
- No model-grade body proportions
- No brand logos in focus
- No polished aspirational aesthetic
- No AI-glossy finish
```

## Sample Prompt: Swollen Ankles + Blood Pressure Cuff Scenario

For an angle anchored on cardiovascular health, loss-aversion trigger, problem-aware audience:

```
Subject: A person's wrist with a digital blood pressure cuff still attached, reading a high number on the screen. The cuff is partially loosened. The wrist is on a kitchen table next to a half-empty cup of coffee and an open prescription bottle.

Style: Reddit-native phone photograph
Aspect ratio: 4:5

Visible Layer:
- Wrist with black digital BP cuff, screen showing 158/94
- Cuff partially loosened, velcro slightly askew
- Background: kitchen table, half-empty coffee mug, open Rx bottle with white pills visible
- Lighting source: kitchen overhead pendant light, slight yellow incandescent cast

Constraint Layer:
- Phone-camera quality, hand-held angle from the person's own perspective
- Slightly off-center framing - cuff weighted to left side of frame
- Visible imperfection: a coffee ring on the table near the cuff, blurred slightly
- Color cast: warm yellow from overhead light
- Shallow depth of field at the prescription bottle in background

Exclusion Layer:
- No glossy skin retouching
- No perfect symmetry
- No over-saturated colors
- No professional studio lighting
- No clean white seamless background
- No model-grade hand or wrist proportions
- No brand logos in focus on the BP cuff or bottle
- No polished aspirational aesthetic
- No AI-glossy finish
```

## Sample Prompt: Before/After Selfie Comparison Scenario

For an angle anchored on hair regrowth, identity trigger, solution-aware audience:

```
Subject: A person's mirror selfie holding their phone in front of a bathroom mirror, with a second smaller image visible in the corner showing an older selfie for comparison. The lighting is uneven between the two images.

Style: Reddit-native phone photograph
Aspect ratio: 4:5

Visible Layer:
- Person mid-thirties, partial face visible (no full face required), holding phone in front of bathroom mirror
- Hair visible at the crown, fuller than the inset comparison image
- Inset image (corner of frame): older selfie with thinner hair at the crown, lit differently
- Background: typical bathroom (towel rail visible, fluorescent strip light overhead)

Constraint Layer:
- Phone-camera quality, mirror selfie angle
- Slightly off-center framing - subject weighted slightly right
- Visible imperfection: smudge on the mirror, faint thumbprint on the camera lens
- Color cast: cool fluorescent green-white in main shot, warmer yellow in inset
- Inconsistent lighting between main image and inset (intentional)

Exclusion Layer:
- No glossy skin retouching
- No perfect symmetry between the two images
- No professional studio lighting
- No matching color grades between the comparison images
- No model-grade face or body proportions
- No brand logos
- No polished aspirational aesthetic
```

## Handoff to ad-style-generator

The ad-style-generator catalogue documents Reddit-native as style #13 (`../../ad-style-generator/references/style-catalogue.md`). When long-form-static-builder hands off to ad-style-generator, the payload uses this format:

```yaml
style: reddit-native
ratio: 4:5
subject: [from the angle's emotional trigger mapping]
emotional_trigger: [vindication | loss-aversion | betrayal | desperation | identity]
markers_required:
  - low-light-or-fluorescent
  - candid-framing
  - phone-camera-quality
  - visible-imperfection
exclusions:
  - studio-lighting
  - white-seamless-background
  - model-grade-proportions
  - brand-logos-in-focus
  - ai-glossy-finish
nano_banana_prompt: |
  [Full prompt as paste-ready text]
```

In addition to the structured handoff, always output the full Nano Banana prompt directly so the user can paste it into Nano Banana without round-tripping through ad-style-generator if they prefer.

## Policy-Filter Safety

Some Reddit-native subjects (especially medical paperwork or distress imagery) can trigger Nano Banana or Higgsfield policy filters. Safe-prompt patterns:

- Reference paperwork generically ("a lab report on a counter") without specifying conditions or named diseases in the visible layer
- Reference body parts without distress framing ("swollen ankles on a couch") rather than ("inflamed, painful ankles")
- Avoid hospital settings if the policy filter is sensitive; use home settings with hospital-style lighting instead
- For prescription bottles, avoid named-medication labels in focus; the bottle should be visible but the label generic or out of focus
- For BP cuff readings, the number on the screen is fine; the medical context can stay implicit

If a prompt is rejected, soften the medical framing first before changing the subject. The Reddit-native aesthetic comes from the lighting and framing, not from the medical specificity.

## Final Image-Spec Test

Before output, the image spec should pass these checks:

- [ ] Aspect ratio is 4:5
- [ ] At least three aesthetic markers are present in the prompt
- [ ] Subject is from the works list, not the does-not-work list
- [ ] Subject matches the angle's emotional trigger per the mapping table
- [ ] No brand logo is in focus
- [ ] No model-grade proportions are required
- [ ] The exclusion layer explicitly bans studio lighting and AI-glossy finish
- [ ] The prompt is paste-ready for Nano Banana (no placeholder syntax)

If any check fails, fix before output.
