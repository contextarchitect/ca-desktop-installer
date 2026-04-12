# Assembly Guide — Post-Generation Workflow

From generated clips to published ad. Covers assembly tools, audio pipeline, text overlays, and platform export specs.

---

## Production Pipeline Overview

```
1. PLAN        Shot list + model routing (SKILL.md)
2. GENERATE    Anchor stills via Nano Banana, then video clips via this skill
3. SELECT      Choose best clip per shot (budget 3-5 generations each)
4. ASSEMBLE    Stitch clips into timeline, add transitions
5. AUDIO       Voiceover (ElevenLabs) + background music + SFX
6. OVERLAY     Text, captions, CTAs, product name, pricing
7. QA          Brand check, AI disclosure, safe zones
8. EXPORT      Platform-specific formats
9. PUBLISH     Upload to Meta/TikTok/YouTube
```

---

## Assembly Tools

### For Automated/Programmatic Assembly

**FFmpeg (Free, CLI)**
The universal backend tool. Most automated pipelines use FFmpeg for concatenation, transcoding, and audio mixing.

Concatenate clips:
```bash
# Create a file list
echo "file 'clip01.mp4'" > clips.txt
echo "file 'clip02.mp4'" >> clips.txt
echo "file 'clip03.mp4'" >> clips.txt

# Concatenate with re-encoding for consistency
ffmpeg -f concat -safe 0 -i clips.txt -c:v libx264 -c:a aac -shortest output.mp4
```

Add voiceover to assembled video:
```bash
ffmpeg -i video.mp4 -i voiceover.mp3 -filter_complex \
  "[0:a][1:a]amix=inputs=2:duration=first:dropout_transition=2[a]" \
  -map 0:v -map "[a]" -c:v copy -c:a aac final.mp4
```

Add background music at lower volume:
```bash
ffmpeg -i video_with_vo.mp4 -i music.mp3 -filter_complex \
  "[1:a]volume=0.15[music];[0:a][music]amix=inputs=2:duration=first[a]" \
  -map 0:v -map "[a]" -c:v copy -c:a aac final.mp4
```

**Remotion (React developers, $)**
Programmatic video composition using React components. Good for version-controlled, data-driven templates. Supports text overlays, transitions, and dynamic content.

Best for: Repeatable ad templates where you swap clips/text programmatically across brands or variants.

**Creatomate ($49+/month, API)**
REST API for template-based video assembly. Handles clips, text overlays, transitions, and audio. Supports dynamic content injection.

Best for: Scaling to 20-40 ad variants per month with automated assembly.

**Shotstack ($49+/month, API)**
Similar to Creatomate. REST API for video assembly with JSON-defined timelines.

### For Manual Assembly

**CapCut (Free - $9.99/month)**
Dominant for TikTok-native content. Auto-captions, text overlays, transitions, speed adjustments. Mobile and desktop. Most practitioners use CapCut for final assembly and caption overlay.

Best for: Quick manual assembly, auto-captions, TikTok-optimized export.

**DaVinci Resolve (Free tier available)**
Professional-grade editing. Best for color grading AI clips to match, advanced compositing, and high-quality export.

Best for: Complex edits, color matching between clips, professional output.

---

## Audio Pipeline

### Voiceover

**ElevenLabs (Primary)**
- 32 languages supported
- Natural delivery with emotional inflection
- Clone custom voices or use library voices
- API: `POST /v1/text-to-speech/{voice_id}`
- Studio 3.0 offers timeline-based editing

**Workflow:**
1. Write the complete voiceover script with timing notes
2. Generate via ElevenLabs API or Studio
3. Export as MP3/WAV
4. Time video clips to match voiceover pacing (not the other way around)

**For models with native audio (Veo 3.1, Seedance 1.5):**
Generate video with native audio for lip-sync alignment, then replace the audio track with higher-quality ElevenLabs TTS. Keep the original audio as a timing reference.

### Background Music

**Sources:**
- Fal.ai music generation API (AI-generated, royalty-free)
- Epidemic Sound ($15/month, licensed library)
- Artlist ($16.60/month, licensed library)
- TikTok Commercial Music Library (free for TikTok ads)

**Mixing rules:**
- Voiceover volume: 100% (primary)
- Background music: 10-20% of voiceover volume
- Music should be felt, not heard — it sets mood without competing with voice
- Fade music in during non-speaking moments, duck during speech

### Sound Effects
- Subtle product sounds (bottle click, product squish, water sound) enhance realism
- Use sparingly — one SFX per 10 seconds maximum
- AI-native audio from Veo 3.1 often provides acceptable ambient SFX

---

## Text Overlays

**ALL text is added in post-production. Never generated within AI video clips.**

### Types of Text Overlays

**Captions/Subtitles:**
- Auto-generate using CapCut or Whisper
- Style: bold, high-contrast, 2-3 words visible at a time
- Position: lower third, within safe zones

**Headlines/Hook Text:**
- Large, attention-grabbing text in first 1-3 seconds
- Style: brand font, brand colors, high contrast background
- Example: "Your water is ruining your hair"

**CTA Overlays:**
- Final 3-5 seconds of ad
- "Shop Now," "Link in Bio," "Use Code X for Y% Off"
- Platform-specific CTA buttons where supported

**Product Name/Price:**
- Appears during product reveal section
- Clean, branded typography
- Brief appearance (2-3 seconds)

**Data/Stat Callouts:**
- "93% saw results in 30 days"
- Animated appearance (fade in or slide) using CapCut/Remotion

### Safe Zones
Platforms overlay UI elements that can hide content:

**TikTok (9:16):**
- Top 15%: username, music ticker (avoid placing text here)
- Bottom 20%: caption area, CTA buttons
- Safe zone: middle 65% of the vertical frame

**Instagram Reels (9:16):**
- Similar to TikTok but bottom 25% reserved for captions/UI

**Meta Feed (1:1 or 4:5):**
- More forgiving — most of frame is safe
- Keep critical text away from bottom 10%

---

## Transitions Between Clips

**Hard cuts are the standard.** They mask inconsistencies between separately generated clips. AI-generated clips have slight variations in lighting, color temperature, and motion style — hard cuts make these discontinuities feel intentional.

**When to use other transitions:**
- **Cross-dissolve (0.3-0.5s):** Between "before" and "after" clips for smooth transformation feel
- **Text card bridge:** Insert a brand-colored text card between sections (Problem → Solution) to create natural breaks
- **Product insert bridge:** Cut to a product close-up between scenes to reset the viewer's spatial awareness

**Avoid:** Fancy transitions (wipes, spins, zooms). They draw attention to the edit points and look unprofessional in UGC-style content.

---

## Platform Export Specs

### TikTok
- **Aspect ratio:** 9:16
- **Resolution:** 1080x1920
- **Duration:** 21-34 seconds (optimal), max 60 seconds for ads
- **File format:** MP4 (H.264)
- **Max file size:** 500MB
- **Frame rate:** 24-30fps
- **Captions:** Auto-generated or burned in (essential — 80%+ view with sound off)

### Instagram Reels
- **Aspect ratio:** 9:16
- **Resolution:** 1080x1920
- **Duration:** 15-60 seconds (30-45 optimal for ads)
- **File format:** MP4
- **Frame rate:** 30fps

### Meta Feed (Facebook/Instagram)
- **Aspect ratio:** 1:1 (square) or 4:5 (vertical)
- **Resolution:** 1080x1080 (square) or 1080x1350 (4:5)
- **Duration:** 15-60 seconds
- **File format:** MP4 (H.264)

### YouTube Shorts
- **Aspect ratio:** 9:16
- **Resolution:** 1080x1920
- **Duration:** Up to 60 seconds
- **File format:** MP4

---

## AI Disclosure Requirements

**As of March 2026, several jurisdictions and platforms require disclosure of AI-generated content in advertisements:**

- **NYC Law (Dec 2025):** AI-generated ads must be labeled
- **EU AI Act:** Transparency requirements for AI-generated content
- **Meta:** Requires AI disclosure on ads with AI-generated or AI-modified content
- **TikTok:** Requires AI content labels on ads

**Standard practice:** Include a small text disclosure ("Created with AI" or "AI-generated content") either in the ad itself or in the ad copy/description field. Check current platform policies before publishing.

---

## Quality Assurance Checklist

Before publishing any AI-generated video ad, verify:

- [ ] **Brand consistency:** Product, colors, and visual identity match brand guidelines
- [ ] **Character consistency:** Same person looks the same across all clips
- [ ] **No anatomical artifacts:** No extra fingers, phantom limbs, or face morphing
- [ ] **No visible text generation:** All text is overlaid, none generated within video
- [ ] **Audio sync:** Voiceover and lip movements are synchronized (if applicable)
- [ ] **Caption accuracy:** Auto-generated captions reviewed and corrected
- [ ] **Safe zones:** Critical content not obscured by platform UI elements
- [ ] **AI disclosure:** Required labels or disclosures included per platform policy
- [ ] **Duration:** Within platform optimal range
- [ ] **File specs:** Correct resolution, aspect ratio, file size, and format
- [ ] **Music licensing:** Background music cleared for commercial use
- [ ] **CTA present:** Clear call-to-action in final 3-5 seconds

---

## Batch Production Workflow

For generating multiple ad variants efficiently:

1. **Create the asset library first:**
   - 1 anchor product still (multiple angles if needed)
   - 1 character sheet (if using animated/AI character)
   - 2-3 environment establishing shots
   - 1 ElevenLabs voice profile

2. **Generate all clips for all variants in one session:**
   - Group by model (all Sora clips together, all Veo clips together)
   - This minimizes context switching and API key rotation

3. **Assemble variants in parallel:**
   - Same clips can appear in multiple ad variants with different voiceover/text
   - A 12-clip library can produce 3-5 unique ad variants through different sequencing

4. **Test and iterate:**
   - Publish 3-5 variants simultaneously
   - Kill losers after 48 hours
   - Scale winners
   - Generate new variants of the winning structure with fresh clips

**Target:** 20-40 unique ad variants per month across brands. At Kie.ai pricing, this costs $50-200/month in generation, plus $15-30/month in audio/music licensing.
