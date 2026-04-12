# Video Integration Guidance for Funnel Pages

## Overview

This skill does not generate videos. Videos are pre-existing brand assets provided by the user. This guide covers how to place, format, and specify videos within funnel page Lovable prompts.

## When to Include Video

Video on landing pages increases conversion up to 80%, but 60% of viewers drop off after 2 minutes. Use video when:

- Brand has existing product demos, testimonials, or explainer videos
- Advertorial format (video complements story arc)
- High-ticket products where trust-building justifies the asset
- Video testimonials available (stronger than text testimonials)

**Do NOT add video just because you can.** A poorly placed or irrelevant video hurts more than no video. Each video must serve a specific psychological purpose.

## Video Placement by Funnel Type

### Advertorial Placements

| Position | Purpose | Optimal Length | Video Type |
|----------|---------|---------------|------------|
| Hero (above fold) | Attention capture, emotional hook | 15-60 seconds | Short brand/problem video, autoplay muted |
| After problem agitation (~30-40% scroll) | Explain mechanism, show solution | 1-2 minutes | Product demo, explainer |
| Social proof section (~60-70% scroll) | Validate with real customers | 1-3 minutes | Customer testimonial |
| Before final CTA (~90% scroll) | Final persuasion push | 30-90 seconds | Results compilation, transformation |

**Maximum videos per advertorial:** 2 (more than 2 slows page load and fragments attention). Recommended: 1 well-placed video.

### Listicle Placements

| Position | Purpose | Optimal Length |
|----------|---------|---------------|
| After mid-page CTA card | Break up text, demonstrate solution | 1-2 minutes |
| Replace one list item's image | Deep-dive on a specific point | 30-90 seconds |
| Before final CTA | Testimonial or results compilation | 1-2 minutes |

**Maximum videos per listicle:** 1 (listicles are scan-focused; video disrupts scanning rhythm). Place after mid-page CTA where engagement momentum is highest.

## Video Specifications

### Dimension Requirements

| Platform/Context | Dimensions | Aspect Ratio | Notes |
|-----------------|------------|--------------|-------|
| Hero video (full-width) | 1920x1080px | 16:9 | Landscape, autoplay muted |
| Inline video (within content) | 1280x720px minimum | 16:9 | Standard player |
| Mobile-optimized | 1080x1920px | 9:16 (vertical) | If brand has vertical assets |
| Square format | 1080x1080px | 1:1 | Works well in both layouts |

**Recommended default:** 16:9 landscape for desktop/inline, with responsive scaling on mobile.

### Format and Technical Requirements

- **Formats accepted:** MP4 (preferred), WebM (fallback)
- **Codec:** H.264 for MP4
- **Max file size:** Under 50MB for fast load (under 20MB preferred)
- **Autoplay:** Only for hero videos, MUST be muted (browsers block autoplay with sound)
- **Controls:** Always show player controls (play, pause, volume, fullscreen)
- **Captions:** Essential for mobile (most users browse with sound off). If captions file available, include it. If not, note in Lovable prompt that captions should be burned in.
- **Poster image:** Provide a thumbnail/poster frame for each video (displays before play).

### Responsive Behavior

- Desktop: Video at max-width of content container (typically 800px), centered
- Mobile: Full-width, maintain aspect ratio
- Lazy load all videos below the fold
- Hero video: autoplay muted on desktop, poster image on mobile (to save bandwidth)

## Video Naming Convention

```
[funnel-type]-[topic-slug]-video-[position].mp4
```

**Examples:**
- `advertorial-hard-water-damage-video-hero.mp4`
- `advertorial-hard-water-damage-video-testimonial.mp4`
- `listicle-5-reasons-shampoo-video-demo.mp4`

**Poster images follow image naming convention:**
- `advertorial-hard-water-damage-video-hero-poster.png`

## Lovable Implementation

### Embed Pattern for Hosted Videos (YouTube/Vimeo)

In the Lovable prompt, specify:

```
VIDEO EMBED: [Position description]
- Source: [YouTube/Vimeo URL]
- Embed type: iframe (responsive)
- Aspect ratio: 16:9
- Max width: 800px, centered
- Lazy load: yes
- Mobile: full-width
```

### Embed Pattern for Self-Hosted Videos

```
VIDEO EMBED: [Position description]
- Source: [filename.mp4] (uploaded to project)
- Poster: [filename-poster.png]
- Autoplay: [yes (muted) / no]
- Controls: visible
- Max width: 800px, centered
- Lazy load: [yes for below-fold / no for hero]
- Mobile: full-width, poster only on slow connections
```

## Performance Considerations

- **Page load impact:** Each video adds 5-50MB. Lazy loading is mandatory for below-fold videos.
- **Mobile bandwidth:** Consider poster-only on mobile for non-essential videos (user taps to load)
- **Conversion impact benchmarks:**
  - Landing pages with video: 4.8% average conversion
  - Landing pages without video: 2.9% average conversion
  - Video CTAs receive 380% more clicks than static CTAs
  - Vertical videos yield 130% higher engagement than horizontal
  - Thumbnails instead of static images increase CTR 21%
