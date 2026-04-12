# Assembly Guide — Remotion Programmatic Pipeline

Automated video assembly using Remotion (React-based). This is the primary assembly method for production-scale ad generation. For manual one-off edits, see `assembly-guide.md`.

---

## Why Remotion

Remotion treats video as React components. This means:
- **Version-controlled templates** — ad formats are code, not CapCut project files
- **Parameterized rendering** — swap clip URLs, voiceover, captions, and headlines via props
- **Programmatic batch production** — render 20-40 ad variants from the same template
- **Consistent branding** — safe zones, fonts, colors, and text overlays enforced in code
- **Reproducible** — same inputs always produce same output

## Architecture Overview

```
Generated clips (Kie API) → Download to local/S3
                                    ↓
ElevenLabs voiceover → Download MP3
                                    ↓
Remotion template (React) ← Props: clip URLs, voiceover URL, captions, headlines
                                    ↓
Render via CLI / Lambda → Final MP4 (platform-specific format)
```

## What Remotion Handles

### 1. Clip Sequencing
Place AI-generated clips on a frame-accurate timeline using `<Sequence>` and `<OffthreadVideo>`. Hard cuts between clips (no transitions needed for UGC).

```tsx
<Sequence from={0} durationInFrames={150}>
  <OffthreadVideo src={props.hookClipUrl} />
</Sequence>
<Sequence from={150} durationInFrames={120}>
  <OffthreadVideo src={props.problemClipUrl} />
</Sequence>
```

### 2. Text Overlays (All Overlay Text Lives Here)
This is where headlines, CTAs, product names, captions, and data callouts are added. The video skill's "Category 1: Overlay Text — NEVER Generate" content gets created here.

```tsx
<Sequence from={0} durationInFrames={90}>
  <div style={{
    position: 'absolute',
    bottom: '25%',
    fontSize: 48,
    fontWeight: 'bold',
    color: 'white',
    textShadow: '2px 2px 4px rgba(0,0,0,0.8)',
  }}>
    {props.hookHeadline}
  </div>
</Sequence>
```

### 3. Audio Layering
ElevenLabs voiceover as primary track, background music at 10-20% volume.

```tsx
<Audio src={props.voiceoverUrl} volume={1} />
<Audio src={props.musicUrl} volume={0.15} />
```

### 4. Captions
Use `@remotion/captions` for TikTok-style word-by-word animated captions. Generate caption data from ElevenLabs timestamps or Whisper transcription.

### 5. Safe Zones
React components that enforce platform-specific safe areas:
- TikTok: top 15% (username), bottom 20% (caption area)
- Instagram Reels: bottom 25%
- Meta Feed: bottom 10%

```tsx
const SafeZone = ({children}) => (
  <div style={{
    position: 'absolute',
    top: '15%',
    bottom: '20%',
    left: '5%',
    right: '5%',
  }}>
    {children}
  </div>
);
```

### 6. Transitions
Hard cuts are default (matches the video skill's guidance). Cross-dissolves for before/after via opacity interpolation.

### 7. AI Disclosure
Automated disclosure overlay per platform requirements (NYC Law, EU AI Act, Meta, TikTok).

## Template Architecture

### Parameterized Ad Template

A single Remotion composition accepts props that define the entire ad:

```tsx
interface AdProps {
  // Clips (URLs from Kie API output)
  hookClipUrl: string;
  problemClipUrl: string;
  solutionClipUrl: string;
  productHeroClipUrl: string;
  ctaClipUrl: string;
  
  // Audio
  voiceoverUrl: string;
  musicUrl: string;
  
  // Text overlays
  hookHeadline: string;
  ctaText: string;
  productName: string;
  productPrice: string;
  
  // Captions (from ElevenLabs/Whisper)
  captionData: CaptionWord[];
  
  // Platform
  platform: 'tiktok' | 'reels' | 'meta_feed';
  
  // Brand
  brandColor: string;
  brandFont: string;
}
```

### Reusable Templates for E-Commerce

Define once, render many variants:

- **UGC Testimonial 30s** — Hook → Problem → Solution → Product → CTA
- **Product Showcase 15s** — Hero shot → Features → CTA
- **Before/After 20s** — Before state → Product → After state → CTA
- **Animated Explainer 30s** — Problem → Mechanism → Product → CTA

Each template is a React component. New ad variants come from new props (different clips, different copy), not new code.

## Rendering Options

### Local CLI (Development / Low Volume)
```bash
npx remotion render UGCTestimonial out/ad-v1.mp4 --props='./props.json'
```

### VPS Automation (Medium Volume)
Run on the existing AWS t3.medium VPS. Cron job or webhook-triggered renders.

### AWS Lambda (High Volume)
Remotion Lambda renders in parallel across multiple Lambda functions. Cost-effective for 20-40+ variants/month. Videos uploaded to S3 for distribution.

## Integration with Video Skill Pipeline

```
1. PLAN       Shot list (this skill) → defines clips needed
2. STILLS     Nano Banana Pro → anchor still images
3. CLIPS      Kie API (Sora/Veo/Kling) → video clips
4. VOICEOVER  ElevenLabs API → MP3 + word timestamps
5. ASSEMBLE   Remotion template → pass all URLs as props
6. RENDER     CLI/Lambda → final MP4 per platform
7. QA         Brand check, AI disclosure, safe zones
8. PUBLISH    Upload to Meta/TikTok/YouTube
```

Steps 1-4 produce the raw assets. Step 5-6 is where Remotion takes over. The test runner (`regrowth/video/test-runner/`) handles steps 2-3 programmatically. Remotion handles step 5-6.

## Batch Production Workflow

For generating multiple ad variants efficiently:

1. **Generate asset library** (steps 1-4 above) — shared across variants
2. **Define variant matrix** — different headline/CTA/voiceover combinations
3. **Render all variants** via Remotion with different props per variant
4. **Export per platform** — TikTok (9:16, 21-34s), Meta Feed (1:1/4:5, 30-60s)

**A single clip library of 8-12 clips can produce 3-5 unique ad variants** through different sequencing, different voiceover scripts, and different text overlays. At Kie.ai pricing plus Remotion rendering costs, this is $15-50 per batch of variants.

## Cost

- **Remotion open source**: Free for personal use
- **Remotion Company License**: Required for commercial use (see remotion.pro/license)
- **Lambda rendering**: ~$0.01-0.05 per render depending on duration and complexity
- **Total per ad variant**: Generation costs (Kie) + Voiceover (ElevenLabs) + Render (Lambda) = ~$5-15 per variant
