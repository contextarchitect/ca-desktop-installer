# Visual Design Reference: Funnel Page Layout & Component Patterns

## Overview

This reference defines the visual layout patterns, component designs, and section-level specifications for advertorial and listicle funnel pages. It is derived from high-converting advertorial breakdowns and serves as the default design system when a brand does not have its own visual guidelines.

Brand-specific design elements (colors, typography choices, logo placement) come from the brand guidelines (Phase 3). This document covers structural layout, component patterns, and visual hierarchy that apply universally.

## Global Layout Rules

### Content Container
- **Max width:** 720-780px, centered
- **Background:** White or very light neutral (#FAFAFA or similar)
- **Side margins (mobile):** 16-20px
- **Paragraph spacing:** 16-20px between paragraphs
- **Line height:** 1.7 for body text, 1.3 for headlines
- **Body font size:** 16-18px (never smaller than 16px on mobile)

### Text Formatting Principles
- **Short paragraphs:** 2-4 sentences maximum. No text walls.
- **Bold key phrases:** Within body text, bold the single most important phrase per paragraph — the one that carries the core message if someone is scanning
- **No all-caps body text.** Headlines and badges only.
- **Left-aligned body text.** Centered text only for headlines, CTAs, and trust badge rows.
- **High contrast:** Black or near-black text (#1A1A1A to #333333) on white/light background

### Image Rules (Global)
- **Full content width** for hero images, analogy visuals, before/after comparisons
- **Rounded corners:** 4-8px on all images
- **No decorative borders.** Let images breathe against white background.
- **Max 500-600 words between images** (enforced in copy, but design must accommodate this rhythm)
- **Alt text on every image** (accessibility requirement)

---

## Section-by-Section Design Specifications

### 1. ABOVE THE FOLD

The above-the-fold section is the most component-dense area. It must capture attention, qualify the reader, establish credibility, and create desire — all before scrolling.

**Component stack (top to bottom):**

```
┌─────────────────────────────────────────────────┐
│ HEADER BAR: "Advertorial" label left │ Trending/trust badge right │
├─────────────────────────────────────────────────┤
│ URGENCY BANNER: Warning icon + scarcity message + shipping mention │
├─────────────────────────────────────────────────┤
│ HEADLINE (H1): Large, bold, centered or left-aligned                │
├─────────────────────────────────────────────────┤
│ SUBHEADLINE: Problem qualification, highlighted background          │
├─────────────────────────────────────────────────┤
│ AUTHORITY LINE: Stars ★★★★★ + "By Dr. [Name]" + Date              │
├─────────────────────────────────────────────────┤
│ ┌──────────────────┐  ┌──────────────────────┐ │
│ │                  │  │ BENEFIT SIDEBAR:      │ │
│ │  VISUAL HOOK     │  │ Product image +       │ │
│ │  (problem-state  │  │ Benefit headline +    │ │
│ │   images with    │  │ Star rating breakdown │ │
│ │   ✗ / ✓ marks)   │  │ + CTA button (green)  │ │
│ └──────────────────┘  └──────────────────────┘ │
└─────────────────────────────────────────────────┘
```

**Component specifications:**

**Header bar:**
- Full width, light gray or white background
- Left: "Advertorial" text label (small, muted — regulatory transparency)
- Right: Trust badge (e.g., "Trending in the US" with flag icon, or brand trust mark)
- Height: 32-40px
- Font: 12-13px, muted gray

**Urgency banner:**
- Full width, red or orange background (#E53E3E or #DD6B20)
- White text, centered
- Warning/alert icon (⚠️ or similar) before text
- Content pattern: "UPDATE: [Product] is SELLING OUT faster than expected! Lock in your order NOW to get [X]% OFF + FAST SHIPPING to [location]"
- Font: 14-15px, bold
- Padding: 10-14px vertical

**Headline (H1):**
- Font: 28-36px, bold (mobile: 24-28px)
- Color: black (#1A1A1A)
- Max width: content container
- Pattern: "[Authority/Discovery]: [This Is] The [Superlative] Way To [Desired Outcome]"

**Subheadline / Problem Qualification:**
- Font: 16-18px, regular weight
- **Yellow or light-amber highlight background** on the text itself (not a full-width bar — just behind the text)
- Content: Qualifies the reader — directly names their condition and tells them to keep reading
- Example: "If you struggle with [condition] in your [body part], read this short article right now before you do anything else."

**Authority line:**
- Star rating (★★★★★) in gold/amber
- Numerical rating + review count (e.g., "4.8/5 Rating")
- "By [Authority Name]" as a linked text
- Date published
- Font: 13-14px
- Layout: horizontal, left-aligned, single line

**Visual hook showcase:**
- 2-3 images showing problem state → solution state
- Red ✗ on problem images, green ✓ on solution images
- Side-by-side or horizontal strip layout
- Images: real, not stock. Problem images show the actual condition. Solution images show relief/improvement.

**Benefit sidebar (desktop only — stacks below on mobile):**
- Right column on desktop (approximately 35-40% width)
- Contains: product image, benefit-focused headline, customer review star breakdown (5-star bar chart), CTA button
- Light background or subtle border to distinguish from main content
- CTA button: brand primary color (typically green for health), full sidebar width
- On mobile: this entire sidebar moves below the visual hook showcase and becomes full-width

**First CTA (above fold — only for warm/product-aware traffic):**
- Green or brand-primary button
- Full width of sidebar (desktop) or full content width (mobile)
- Font: 16-18px, bold, white
- Rounded corners: 6-8px
- Text pattern: "GET [X]% OFF [Product] NOW!"
- Note: Only show above-fold CTA when traffic is warm (from VSL, retargeting, or product-aware ads). For cold traffic, first CTA appears much later.

---

### 2. LEAD

**Visual treatment:** Clean, text-forward. No visual complexity. The lead is about locking in the reader with empathy and a benefit promise.

**Components:**

**Condition checklist (optional, for health/condition products):**
- Vertical list of conditions the article addresses
- Green circle checkmark (●) before each condition name
- Font: 15-16px, regular
- Conditions that match the reader's situation → they feel qualified to continue reading

**Lead body text:**
- Standard body formatting (16-18px, left-aligned, 1.7 line height)
- 3-5 short paragraphs
- Empathetic, authoritative tone
- Key phrases bolded
- No images in the lead section — text-only to create forward momentum

**Story transition headline:**
- Bold H2 or H3, left-aligned
- Slightly larger than body text (20-24px)
- Creates a visual break between lead and background story
- Often uses emotional or visceral language as the hook into the story

---

### 3. BACKGROUND STORY

**Visual treatment:** Text-dominant with 1-2 supporting images showing the problem state. Images should feel real and relatable.

**Components:**

**Story body text:**
- Standard body formatting
- Short paragraphs (2-3 sentences each)
- Bold emotional phrases
- First-person or third-person narrative voice (per advertorial strategy)

**Problem-state images (1-2):**
- Full content width or slightly indented
- Real photographs, not illustrations or stock
- Show the actual physical problem (swollen legs, thinning hair, skin condition, etc.)
- If showing progression: left-to-right with arrow (→) between images
- Rounded corners, no border

**Turning point indicator:**
- A short, distinct paragraph or subheadline marking the narrative pivot
- Often introduced with language like "That's when everything changed" or "Then I found something"
- Can use a subtle horizontal rule or extra whitespace to create visual separation
- Font: body size or slightly larger, bold or italic

---

### 4. ROOT CAUSE

**Visual treatment:** The most visually rich section of the advertorial. Combines explanatory text with infographics, analogy images, and diagrams. This is where System 1 visual support is critical.

**Components:**

**Section headline:**
- Bold, attention-grabbing
- Pattern: "Shocking Truth: [Root Cause Revelation]" or "[The Real Reason] Behind [Problem]"
- Font: 22-28px, bold

**Medical/scientific diagram (MANDATORY):**
- Side-by-side comparison: "Healthy [System]" vs "[Condition/Obstruction]"
- Clean medical illustration style (not cartoon, not hyper-realistic)
- Labeled with clear text annotations
- Color-coded: healthy = green/blue tones, problem = red/orange tones
- Full content width
- Rounded corners

**Body text with inline explanations:**
- Short paragraphs explaining the root cause in System 1 language
- Bold key terms on first mention
- Bullet points acceptable here for listing symptoms or factors (keep to 3-5 bullets max)

**Analogy image (MANDATORY):**
- Real-world photograph that visualizes the analogy (traffic jam, clogged pipe, etc.)
- Full content width
- The image should be immediately understandable without reading the text
- If using overlays: bold text labels directly on the image (e.g., "DISRUPTED FLOW", "BLOCKED FLUID")
- Color overlays acceptable for emphasis (semi-transparent red/orange over problem areas)

**Consequence progression visual:**
- Shows stages of worsening condition (e.g., Stage 1 → Stage 2 → Stage 3 → Stage 4)
- Horizontal strip of images with stage numbers labeled below each
- Stage labels: bold, numbered, same size
- Images show actual visual progression of the condition
- Creates urgency through visual deterioration

**Clogged pipe / second analogy image (optional reinforcement):**
- Additional real-world analogy photograph
- Reinforces the root cause concept from a different angle
- Full content width

---

### 5. UNIQUE MECHANISM

**Visual treatment:** Shifts from problem visuals to solution visuals. Anatomical or process diagrams showing HOW the fix works. Product starts to appear visually but is not yet named.

**Components:**

**Section headline:**
- Curiosity-driven: "Did You Know [Unexpected Body Part/Process] Plays A Crucial Role in [System]?"
- Font: 22-26px, bold

**Anatomical/process diagram:**
- Shows the mechanism of action visually
- Labeled body illustration or system diagram
- Color-coded: solution elements in blue/green, problem elements fading out
- Arrows showing direction of flow/action
- Full content width or 60-70% width centered

**Product-in-use images (1-2):**
- Show the product being used (e.g., feet on device, applying product, taking supplement)
- Real photography, not renders
- Multiple angles if showing a physical device
- Lifestyle context: someone at home, relaxed, comfortable
- Full content width or side-by-side

**Mechanism body text:**
- Continues analogy from root cause section
- Bold the mechanism name when introduced (branded name)
- Explain in simple cause → effect language
- Short paragraphs, no walls of text

---

### 6. PRODUCT REVEAL

**Visual treatment:** Clean, product-focused. The product is finally named and shown clearly. Images are polished (this is the one section where professional product photography is appropriate).

**Components:**

**Introduction line:**
- "Introducing [Product Name]" — product name as hyperlinked text (brand color)
- Font: 20-24px, bold or medium weight
- Product name can be underlined or colored to stand out

**Product showcase images (1-2):**
- Primary: product in use (lifestyle shot showing actual usage)
- Secondary: product standalone (clear product shot, no distractions)
- Full content width
- High quality — this is where polished photography is expected
- Show important physical details the text describes (surface texture, components, size reference)

**Feature/benefit text:**
- Short paragraphs explaining key features
- Each feature tied back to the mechanism ("It's made from [material] designed for [mechanism purpose]")
- Product name appears as hyperlinked text (clickable to product page) throughout
- Inline social proof: "thousands of people around the world are using [Product Name]"

**Objection handling (inline):**
- Woven into the narrative, not a separate FAQ
- Addresses: ease of use, safety, effort required, timeline to results
- Honest timeline expectations (builds trust, supports subscription/bundle)
- Pattern: "If you're expecting overnight magic, skip it. But if you give it [realistic timeframe]..."

---

### 7. SOCIAL PROOF

**Visual treatment:** High credibility section. Uses external review platforms, user photos, and media logos to validate everything above.

**Components:**

**Third-party review platform widget:**
- Trustpilot, Google Reviews, or similar
- Platform logo + numerical score + review count
- Positioned at the top of social proof section
- Full content width or centered

**User photo grid:**
- 4-8 user-submitted photos showing product in use or results
- Grid layout: 2-4 columns
- iPhone-quality, real people, not studio
- Rounded corners, small gap between images
- These are NOT product photos — they are customer photos

**Individual review cards (2-3 minimum):**
- Format mirrors Amazon review style:
  - Circular avatar photo (40-48px)
  - Reviewer name (bold)
  - ★★★★★ star rating
  - "Reviewed in [location] on [date]"
  - "Verified Purchase" badge (orange/amber text)
  - Review body text (2-4 paragraphs, real language, detailed)
  - User-submitted photos below review text (2-4 images, small thumbnails)
  - "[X] people found this helpful" line below photos
- Light gray or white card background
- Subtle border or shadow for separation
- Full content width per card

**"As Seen On" media bar:**
- Centered row of media outlet logos
- "AS SEEN ON" label above in small red/brand text
- Logos: grayscale or muted, 6-8 outlets
- Horizontal layout, vertically centered
- Spacing: even gaps between logos
- Padding: 20-30px vertical

---

### 8. CLOSE: PRODUCT VALUE FARMING + OFFER

**Visual treatment:** This is the highest-conversion section. Dense with components, intentional visual hierarchy guiding toward the CTA. Multiple sub-sections with distinct visual treatments.

**Sub-section A: Before/After + Future Pacing**

**Before/After comparison:**
- Side-by-side image with labeled overlays ("BEFORE" / "AFTER")
- Full content width
- Real results photography
- Labels: bold white text on semi-transparent dark overlay at bottom of each image half

**Credibility headline:**
- Pattern: "This Device Has Helped Thousands of People Reduce [Problem] And [Outcome]"
- Font: 22-26px, bold

**Future pacing text:**
- "Just imagine..." prompt followed by 3-4 specific scenarios the reader craves
- Bold the desire phrases
- Short, punchy lines — each one is a separate visual moment

**Objection handling checklist:**
- Green ✓ for positive claims, Red ✗ for problems eliminated
- Vertical list, 4-6 items
- Compact, scannable
- Example: "✗ No more hiding your feet" / "✓ Easy 15-minute daily ritual"

**Sub-section B: Price Architecture**

**Section headline:**
- Pattern: "How Can You Get Your Hands on the [Product]?"
- Font: 22-26px, bold

**Story-driven price justification:**
- Body text explaining how the price was set (mission-driven, not profit-driven)
- Mention what experts/industry recommended charging (price anchor HIGH)
- Per-use cost breakdown ("only [cents] per therapy/day")
- Bold the anchor prices and the final price

**Exclusive offer card:**
- Highlighted background (light yellow, light green, or brand accent tint)
- Bold text: "I've Decided To Offer a Special [Discount] Price: Not [Original] but just [Discounted]!"
- Strikethrough original price + bold discounted price
- Font: 18-22px for prices

**Green CTA button:**
- Full content width
- Brand green or primary action color
- White text, bold, 16-18px
- Rounded corners: 6-8px
- Min height: 52-56px
- Pattern: "Get [X]% Off [Product Name] Now!"

**Platform exclusion visual (optional):**
- Image of Amazon/eBay logos with red X marks over them
- Message: "[Product] Is NOT Available Anywhere Else Except on Our Official Website"
- Creates exclusivity and prevents price-shopping

**Sub-section C: Guarantee + Risk Reversal**

**Guarantee badge:**
- Visual: "90 Day Money Back Guarantee" badge/seal image
- Placed next to or above guarantee text
- Prominent, not buried in fine print

**Guarantee text:**
- Clear, specific process described (not just "money back guarantee" — explain HOW)
- Bold key phrases: "completely risk-free", "no questions asked"

**Trust icon row:**
- Horizontal row of 4-6 guarantee/trust icons
- Icons: 90-Day Guarantee, Secure Checkout, Money-Back, No-Hassle Returns, Fast Shipping
- Small text label below each icon
- Centered, evenly spaced
- Size: 48-64px per icon

**Sub-section D: "What's In The Box" (physical products only)**

- Product unboxing or contents image
- List or visual showing everything included
- Reinforces tangible value

**Second CTA button:**
- Same design as first CTA button
- Placed after guarantee section
- Same text or urgency variant

---

### 9. CLOSE: PERSONAL CORE BELIEF + FINAL CTA

**Visual treatment:** Emotionally charged final push. Shifts from logical/value framing to personal/emotional obligation.

**Components:**

**Emotional obligation text:**
- Appeals to family, loved ones, responsibility
- Pattern: "Do it for your [family member]. Do it for yourself."
- Multiple short CTAs woven into text ("Order now", "Click that green button")
- Bold emotional phrases
- 2-3 paragraphs, not long

**Benefit checkmarks list:**
- 4-6 checkmarks summarizing all key benefits
- Green ✓ before each
- Short, scannable lines
- Reinforces everything the reader learned

**Social proof reminder:**
- Single line: "Many of my patients have already done it"
- Or volume stat: "[X,000]+ people have chosen [Product]"

**Final urgency banner/card:**
- Strong background color (red, orange, or dark)
- Contains: urgency text + product image + discount badge (e.g., "50% OFF" circle) + trust icons
- CTA button prominently placed within the card
- Full content width

**Final CTA button:**
- Same green/primary design
- Full content width
- This is the last interactive element on the page
- Pattern: "GET [X]% OFF [Product Name] Now!"

---

## Listicle-Specific Design Notes

Listicle pages share global layout rules but differ in structure:

**No hero image.** Text-first approach — headline + opening paragraph immediately.

**Item layout:**
- Alternating: Image LEFT / Text RIGHT → Text LEFT / Image RIGHT (zigzag)
- 48/48/4 width split (image/text/gap)
- Mobile: stack (image top, text below)
- Each item has a "REASON X" badge in brand accent color, small caps, 12px

**Item images:**
- 1:1 aspect ratio (square)
- Full column width (48% of content area on desktop)
- Rounded corners: 8px
- Vertically centered with text block

**CTA button after Item #1:**
- Full content width
- Brand primary color
- Placed between Item 1 and Item 2

**Mid-page CTA card (after ~60% of items):**
- 2-column: product image left (40%), content right (60%)
- Light accent background
- Contains: headline, 3-4 benefit checkmarks, value proposition, CTA button, trust line

**Final CTA card (after guarantee):**
- 2-column layout same as mid-page
- Strong contrast background (brand primary or dark)
- Urgency-focused copy

---

## Mobile-Specific Rules

- All multi-column layouts stack to single column
- Sidebar content moves below main content
- Images: full width (minus 16-20px margins)
- CTA buttons: full width, minimum 52px height, thumb-friendly
- Sticky CTA: triggers at 40% scroll, fixed to bottom, 56px height, z-index 1000
- Font sizes: body 16px minimum, headlines 22-26px
- Touch targets: 44px minimum
- Urgency banner: text may wrap to 2 lines — keep concise

## Color Usage Principles

These apply when a brand doesn't specify exact colors:

| Element | Color Role | Default |
|---------|-----------|---------|
| CTA buttons | Brand primary / action green | #38A169 or brand-specified |
| Urgency banner | Alert/scarcity | Red (#E53E3E) or orange (#DD6B20) |
| Subheadline highlight | Qualifying emphasis | Light yellow (#FFFBCC) or amber tint |
| Positive indicators (✓) | Benefit, checkmark | Green (#38A169) |
| Negative indicators (✗) | Problem, eliminated | Red (#E53E3E) |
| Trust icons/badges | Neutral authority | Gold/amber for stars, gray for badges |
| Body text | Primary reading | Near-black (#1A1A1A to #333333) |
| Background | Clean canvas | White (#FFFFFF) or off-white (#FAFAFA) |
| Card backgrounds | Subtle separation | Light gray (#F7F7F7) or light accent tint |
| "As Seen On" logos | Understated authority | Grayscale |

## Design Anti-Patterns (Do NOT Do)

- **No full-width horizontal dividers between sections** — creates "false floor" perception (reader thinks page ended)
- **No decorative stock imagery** — every image must serve an educational, proof, or emotional purpose
- **No generic product mockups** — real product photography only
- **No text walls** — maximum 4-5 lines before a visual break (bold text, image, bullet, subhead)
- **No centered body text** — left-aligned only for readability (center only headlines and CTAs)
- **No tiny fonts** — 16px minimum for body text on all devices
- **No complex multi-column text layouts** — single column for body text, two columns only for image+text pairs
- **No autoplay video with sound** — muted autoplay for hero only, click-to-play everywhere else
- **No more than 2 CTA button styles** — one primary (green/brand), one secondary (outlined or muted). Consistency builds trust.
