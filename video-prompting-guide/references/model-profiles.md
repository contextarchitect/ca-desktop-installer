# Model Profiles — Video Generation for E-Commerce

Prompt formats, capabilities, and pricing for each supported model. Updated March 2026.

---

## Sora 2 Pro (OpenAI)

**Best for:** Long narrative clips, character consistency (Cameo), cartoon/anime, multi-scene UGC

**Access:** Direct via OpenAI API, or via Kie.ai at ~70% discount

### Capabilities
- **Max duration:** 25 seconds (single generation)
- **Resolution:** Up to 1080p
- **I2V:** Yes (image as first frame)
- **Audio:** Yes (co-generated)
- **Cameo:** Yes — persistent character ID from video+audio recording, referenced via @name
- **Negative prompts:** Yes (use "Avoid:" prefix or embed in natural language)
- **Aspect ratios:** 16:9, 9:16, 1:1

### Prompt Format
Sora 2 responds best to **natural language paragraph format**. Write the prompt as if describing a scene to a cinematographer. Mention camera movements by name. Include atmospheric details.

**I2V prompt structure:**
```
Using the provided image as the starting frame. [Motion description
in natural paragraph form]. [Camera movement]. [Pacing/timing].
Maintaining consistent form and appearance throughout. No morphing,
no warping, no new elements appearing.
```

**Character consistency with Cameo:**
```
@character_name [action description]. [Camera]. [Setting context
only if not in reference image].
```

**End-frame chaining:** Export final frame of clip N, use as I2V reference for clip N+1. This is the standard technique for multi-clip consistency without Cameo.

### Prompt Tips
- Front-load the subject and action in the first sentence
- Keep prompts 40-80 words for I2V, 60-120 words for T2V
- For UGC: include "shot on iPhone, handheld, no stabilization" early in prompt
- For cartoon: specify the style in the first clause ("In flat 2D animation style,...")
- Defensive constraints: "maintaining consistent form, never morphing, maintaining correct proportions"
- **Always include "Single continuous shot. No cuts, no angle changes."** — Sora 2 sometimes cuts to a different camera angle mid-clip without this explicit constraint
- **Audio:** Generated inconsistently — some clips include audio with lip-sync, others are silent, even with identical setup. Do not rely on Sora 2 audio for production. Always plan for post-production voiceover (ElevenLabs). When audio is generated, it can serve as a useful lip-sync timing reference.
- **Cartoon motion:** Sora 2 maintains cartoon style consistency well but produces relatively stiff character motion in flat 2D animation. For cartoon/anime content, Kling 3.0 produces significantly more dynamic and elastic animation.
- **Label fidelity:** Sora 2 Standard (720p) degrades product label text. Sora 2 Pro (1080p) preserves labels much better. Use Pro for any clip where the product label is prominently visible.

### Pricing (March 2026)
| Quality | Official | Kie.ai |
|---------|---------|--------|
| 720p | $0.30/sec | ~$0.045/sec |
| 1080p | $0.50/sec | ~$0.10-0.13/sec |

**60-second ad (12 clips x 5s) via Kie.ai:** ~$2.70-7.80 depending on resolution

---

## Google Veo 3.1

**Best for:** Hero product shots, English talking heads with dialogue, atmospheric b-roll, material/physics accuracy

**Access:** Google AI Studio, Vertex AI, or via Kie.ai

### Capabilities
- **Max duration:** 8 seconds per generation (chain via Extend to 60s+, up to 148s total)
- **Resolution:** Up to 1080p (4K via Ultra tier)
- **I2V:** Yes (up to 3 reference images with tagged roles)
- **Audio:** Yes — best-in-class native audio co-generation with ~10ms A/V latency
- **Lip-sync:** Yes — dialogue-driven lip-sync from text scripts
- **Negative prompts:** Yes
- **Aspect ratios:** 16:9, 9:16, 1:1
- **Frame interpolation:** Yes (Veo 3.1 feature for smoother motion)

### Prompt Format
Veo 3 uses **structured narrative with explicit camera direction**. More detailed than Sora, with technical camera and lighting terminology welcomed.

**I2V prompt structure:**
```
Starting from the provided reference image. [Detailed camera
movement with speed]. [Subject action with timing]. [Environmental
effects]. [Lighting behavior]. Duration: [X] seconds. Maintaining
visual continuity with the reference frame throughout.
```

**Canvas prompting (advanced product consistency):**
Place the product image and subject image on a canvas with annotation arrows indicating placement. Feed this annotated canvas as the reference. This provides spatial anchoring beyond what text alone achieves.

**Dialogue/talking head format:**
```
[Character description]. [Setting]. The character speaks directly
to camera: "[Exact dialogue text]". [Camera behavior]. [Emotional
tone]. Natural ambient sound: [environment sounds].
```

**Extend chaining:** Use the Extend feature to chain 8-second clips. Maintains character consistency within the extension chain. Generate the first 8 seconds with maximum quality, then extend.

### Prompt Tips
- Veo shows unusual determinism — identical prompts produce notably similar results, which helps consistency
- For product shots: specify material properties ("glass with caustic light refraction," "matte plastic with soft highlight")
- "Green screen trick": generate character against plain background, then use Frames-to-Video with scene replacement
- For UGC: explicitly include "no montage, no cutaways, no flashbacks, no cinematic transitions" in negatives
- Veo 3.1 has the best physics simulation — use it for water, fabric, hair, and liquid products
- **Safety filter limitation:** Veo 3.1 blocks I2V inputs showing people in bathrobes, towels, or bathroom contexts (flagged as "sexual or explicit"). This affects personal care brands where bathroom UGC is standard. Workarounds: (1) Use Sora 2 or Seedance for bathroom character clips, (2) Use Veo for product-only hero shots and clothed character clips, (3) Use T2V mode for Veo character clips (no image input to filter)
- **Veo is literal and faithful** — it renders exactly what you describe, even if illogical (e.g., steam in a dry setting). Ensure all environmental motion has a logical cause before prompting. Sora is more "creative" and may ignore some prompt elements.
- **Maintains single continuous shot** — unlike Sora 2, Veo does not cut to different angles mid-clip. Strong adherence to continuous shot constraint.

### Pricing (March 2026)
| Tier | Official | Kie.ai |
|------|---------|--------|
| Standard (with audio) | $0.40/sec | ~$0.31/sec |
| Fast (with audio) | $0.15/sec | ~$0.05/sec |
| Ultra (4K) | Higher tier | — |

**60-second ad (12 clips x 5s) via Kie.ai Fast:** ~$3.00
**60-second ad (12 clips x 5s) via Kie.ai Standard:** ~$18.60

---

## Seedance 1.5 Pro (ByteDance)

**Best for:** Multilingual UGC, first-frame fidelity, lip-sync in 8+ languages, human motion

**Access:** Via fal.ai, WaveSpeed, Atlas Cloud, or Kie.ai

### Capabilities
- **Max duration:** 4-12 seconds (varies by provider)
- **Resolution:** Up to 1080p / 2K
- **I2V:** Yes (up to 2 reference images) — strongest first-frame preservation via Dual-Branch Diffusion Transformer
- **Audio:** Yes — phoneme-level lip-sync in English, Mandarin, Japanese, Korean, Spanish, Portuguese, Indonesian, and more
- **First-frame control:** Industry-leading fidelity — "The start frame already defines the scene"
- **Fixed-camera mode:** Isolates subject motion while keeping environment perfectly static
- **Negative prompts:** Limited (depends on provider)
- **Aspect ratios:** 16:9, 9:16, 1:1

### Prompt Format
Seedance responds best to **concise motion-focused prompts**. Minimal visual description (the first frame handles it). Focus entirely on what changes.

**I2V prompt structure:**
```
[Subject action]. [Camera behavior]. [Pacing]. [Audio description
if generating with sound].
```

**Example (from official guidance):**
```
"The woman slowly lifts the bottle to pour product into her hand,
then gently massages it through her hair. Camera remains static.
Soft ambient bathroom sounds."
```

**Seedance 2.0 (when API available):**
Supports up to 9 reference images + 3 video clips simultaneously via "Universal Reference technology." Character consistency reported at ~5% variance across 8 clips. Currently web-UI only — monitor for API release.

### Prompt Tips
- Keep I2V prompts under 40 words — Seedance's first-frame preservation is so strong that less text = better results
- Use fixed-camera mode for any clip where the environment should not change
- For multilingual UGC: write the dialogue in the target language within the prompt
- Seedance excels at dance and complex human motion (its original training focus)
- For product shots: let the first frame do all the work, prompt only the hand/arm motion

### Pricing (March 2026)
| Provider | Price |
|----------|-------|
| Official | ~$0.247/sec |
| fal.ai | ~$0.20-0.25/sec |
| WaveSpeed | ~$0.15-0.20/sec |
| Kie.ai | Available (check current rates) |

**60-second ad (12 clips x 5s):** ~$12-15 at mid-tier pricing

---

## Kling 3.0 (Kuaishou)

**Best for:** Multi-reference product demos, 4K output, cartoon consistency, complex multi-scene generation

**Access:** Via Higgsfield platform, fal.ai, or Kie.ai

### Capabilities
- **Max duration:** 15 seconds (single generation); multi-scene: 6 automatic camera cuts with maintained consistency
- **Resolution:** Up to 4K at 60fps (highest in class)
- **I2V:** Yes — up to 7 simultaneous reference images with tagged roles
- **Audio:** Yes
- **Multi-scene:** Automatic 6-cut generation maintaining visual consistency across cuts
- **Motion Control:** Fine-grained control over camera paths and subject movement
- **Negative prompts:** Yes
- **Aspect ratios:** 16:9, 9:16, 1:1, 4:5

### Prompt Format
Kling supports **tagged multi-reference input** which is unique in the field. The prompt focuses on action while references handle all visual identity.

**Multi-reference I2V structure:**
```
References:
- Image 1: Product appearance (preserve exactly)
- Image 2: Character face and build
- Image 3: Environment and lighting
- Image 4: Brand style/color palette

Prompt: [Action sequence]. [Camera movement]. [Timing for each
action beat]. Duration: [X] seconds.

Negative: morphing, warping, color shifting, extra limbs,
scale changes, new elements appearing.
```

**Multi-scene format:**
```
Scene 1 (0-3s): [Action + camera]
Scene 2 (3-6s): [Action + camera]
Scene 3 (6-10s): [Action + camera]
```
Kling auto-generates transitions between scenes while maintaining character/product consistency.

### Prompt Tips
- Use ALL 7 reference slots when possible — product, character, environment, style, plus additional angles
- For cartoon: Kling's multi-reference system maintains animated style consistency better than single-reference models
- The multi-scene feature is excellent for quick product demo sequences (unbox → apply → results)
- 4K output means less upscaling needed in post
- For budget production: Kling 2.1 Standard via Kie.ai costs ~$0.125/5s
- **Confirmed primary for cartoon/animation:** Testing showed significantly more dynamic, elastic, and expressive character animation compared to Sora 2. Characters bounce and move naturally rather than stiffly.
- **Duration stability:** Kling maintains cartoon style consistency across 5s, 10s, and 15s durations. Longer clips (10-15s) are viable for animation, reducing the need for multi-clip stitching.
- **Lip sync:** Acceptable for cartoon characters (mouth moves roughly in sync with speech) but not phoneme-precise. Fine for animated content where the viewer isn't focused on mouth detail. Not recommended for photorealistic talking heads.
- **Script-to-duration matching is critical:** If dialogue is too short for the clip duration, Kling slows the entire video to compensate. Always match word count to duration (~2.5-3 words/second).

### Pricing (March 2026)
| Tier | Kie.ai | fal.ai |
|------|--------|--------|
| Kling 2.1 Standard | ~$0.125/5s clip | ~$0.084-0.168/sec |
| Kling 3.0 | Higher tier | Check current rates |

---

## Cost Comparison: 60-Second Ad Production

Assuming 12 clips at ~5 seconds each (60 seconds total generated video):

| Model | Via Kie.ai | Official API | Best For |
|-------|-----------|-------------|----------|
| Sora 2 Pro (720p) | ~$2.70 | ~$18.00 | Narrative + character |
| Sora 2 Pro (1080p) | ~$6.50 | ~$30.00 | High-quality narrative |
| Veo 3.1 Fast | ~$3.00 | ~$9.00 | Rapid iteration |
| Veo 3.1 Standard | ~$18.60 | ~$24.00 | Hero quality |
| Seedance 1.5 | ~$12.00 | ~$15.00 | Multilingual |
| Kling 2.1 Standard | ~$1.50 | ~$5.00 | Budget production |

**Add to generation costs:** ElevenLabs voiceover (~$5-15), background music ($0-10), assembly time (1-2 hours).

**Total per 60-second ad:** $10-50 via Kie.ai (DIY), vs $1,100-7,000 traditional production.

---

## Model Selection Decision Tree

```
Need talking head with dialogue?
├─ English → Veo 3.1 (native audio + lip-sync)
├─ Other language → Seedance 1.5 (8+ languages)
└─ Character must persist across many clips → Sora 2 Pro (Cameo)

Need product demo?
├─ Product held/used by person → Kling 3.0 (multi-reference)
├─ Product hero rotation → Veo 3.1 (material physics)
└─ Product in environment → Sora 2 Pro or Veo 3.1 (I2V)

Need cartoon/animation?
├─ Anime or stylized → Sora 2 Pro
├─ Consistent character across clips → Kling 3.0 (multi-ref)
└─ Convert existing footage to cartoon → DomoAI

Need atmospheric b-roll?
├─ Water, fabric, hair, liquid → Veo 3.1 (physics)
├─ Long continuous shot → Sora 2 Pro (25s)
└─ Budget → Veo 3.1 Fast or Wan 2.6

Need maximum volume/testing?
└─ Veo 3.1 Fast ($0.05/sec via Kie.ai) or Kling 2.1 ($0.125/clip)
```
