# UltimaPeak Performance Gummies PDP - full page build

Build a complete product detail page for UltimaPeak Performance Gummies based on the section-by-section brief below. The goal is a production-quality e-commerce PDP that visually matches the brief's structure and brand identity while being responsive and polished at all viewports.

## How to use this brief

- **Content (copy) and asset URLs are fixed** - use them verbatim. Do not paraphrase the body copy in testimonials, FAQs, or any descriptive text. Do not substitute or omit any of the listed image assets.
- **Brand palette is fixed** - use the colors specified in the brand section.
- **Section structure and order are fixed** - all 12 sections in the order listed, each containing the elements described.
- **Layout details are your call** - exact spacing, padding, margins, breakpoints, image aspect ratios, hover states, grid vs flex, semantic HTML choices, micro-animations. You know how to ship responsive production UIs at all viewports; do that. The brief describes WHAT each section contains and HOW it should feel; you decide HOW to implement it.

The Figma design this is based on was authored at 1440px desktop. The brief reflects its intent. Your implementation should look visually equivalent to the Figma intent at desktop, and respond gracefully on tablet and mobile.

## Brand identity

**Brand name:** UltimaPeak
**Product:** Performance Gummies (male performance supplement)
**Positioning:** Premium, edgy, direct-response e-commerce. Confident, results-driven, slightly provocative copy targeting men 30-55. Not corporate, not clinical. Modern supplement brand with attitude.

**Brand palette (fixed):**
- Primary cream background: `#fdf8ec`
- Alternate body cream: `#fcfaf5`
- Primary text near-black: `#1a1a1a`
- Accent gold gradient: linear gradient from `#ddaf3a` to `#f5e35e` (used for CTAs, badges, highlights, phase pills)
- Dark gradient (cards, premium sections): linear gradient from `#1a1a1a` to `#424242`
- Selected/active state tint: `#fef9e7`
- Warning red: `#dc2626`
- Verified green: `#4caf50`

**Typography:**
- Primary: Figtree (bold for headings, semibold/regular for body)
- Section titles and product names: often uppercase
- Body copy: sentence case, comfortable reading size, line-height ~1.5

**Visual treatment:**
- Dark gradient cards for premium/contrast sections
- Gold gradient for emphasis on CTAs, badges, and key inline text spans
- Cream as the primary light background
- Generous spacing, modern direct-response e-com aesthetic

## Asset base URL

All hosted assets live at this base:
`https://hlvekxlxsocivhigggzc.supabase.co/storage/v1/object/public/brand-assets/ultimapeak/pdp-rebranded-competitors`

Set this as a constant at the top of any component that uses it. Then reference assets as `${ASSET_BASE}/filename.ext`.

Where the brief says "asset to provide" without a URL, render a sensible image placeholder (gray box with appropriate aspect ratio and alt text) - the client will swap in real imagery after.

## Page structure - 12 sections in this order

### 1. Announcement bar

Thin sticky bar at top, dark background. Scrolling marquee (horizontal animated scroll) of the message repeated multiple times: `50% OFF + 90 DAY GUARANTEE - Claim Your Offer`. Each repetition prefixed with a small lightning/sparkle icon. Gold or white text on dark.

### 2. Header

Logo on left (UltimaPeak with small mountain icon - use text + icon for now, asset to provide), nav center (Home, Shop all, Track Order, Contact), language selector "English" + cart icon on right. Clean minimal, white or very light background. Mobile: hamburger menu instead of inline nav. Cart icon includes a "0" count badge.

### 3. Hero / product section

Two-column layout on desktop, stacked on mobile. This is the most critical section.

**LEFT column - product gallery:**
- Main product image: `${ASSET_BASE}/hero-product-main.webp` (the UltimaPeak gummies pouch, dark with gold mountain design, chocolates floating around it)
- Click-to-swap thumbnail strip below the main image with 6 thumbnails:
  - Position 1: same as main (`hero-product-main.webp`)
  - Position 2: `${ASSET_BASE}/hero-thumb-2.webp`
  - Position 3: `${ASSET_BASE}/hero-thumb-3.webp`
  - Position 4: `${ASSET_BASE}/hero-thumb-4.webp`
  - Position 5: `${ASSET_BASE}/hero-thumb-5.webp`
  - Position 6: `${ASSET_BASE}/hero-thumb-6.webp`
- Prev/next arrow overlays on the main image: `${ASSET_BASE}/hero-gallery-prev.svg` and `${ASSET_BASE}/hero-gallery-next.svg`
- Active thumbnail should have a gold border or highlight

**Adjacent to the main image on desktop (column or row of 3 cards, your call):** 3 vertical benefit cards with dark gradient background, each containing a gold icon and a short white text caption:
- Icon `${ASSET_BASE}/benefit-icon-finish.svg` + caption "For Nights She Can't Walk After"
- Icon `${ASSET_BASE}/benefit-icon-harder.svg` + caption "2+ Inches In 2 Weeks"
- Icon `${ASSET_BASE}/benefit-icon-mattress.svg` + caption "She Taps Out. You Keep Going."

In the Figma design these sit as a vertical column of 3 cards to the right of the main image, but if you find a different arrangement responds better, use your judgment.

**RIGHT column - product info + purchase:**

- Trust rating row: 5 gold stars (`${ASSET_BASE}/stars-5.svg`), text "Excellent 4.8/5 110.500+" in bold, 4 small reviewer avatar circles overlapping (`${ASSET_BASE}/review-avatar-1.webp` through `review-avatar-4.webp`)
- Brand label: "ULTIMAPEAK®" small caps
- Product title: "PERFORMANCE GUMMIES" large bold uppercase
- Tagline pill (cream-tinted rounded background): "30 Performance Gummies | 6-in-1 Formula For Your Manhood"
- 3 benefit chips, each a rounded dark gradient pill with small icon left and white text:
  - Icon `${ASSET_BASE}/feature-icon-1.svg` + "Harder. Fuller. Every Single Round."
  - Icon `${ASSET_BASE}/feature-icon-2.svg` + "She Finishes Before You Do."
  - Icon `${ASSET_BASE}/feature-icon-3.svg` + "Destroyed Mattresses."
- Section divider with text "Bundle & Save" centered, horizontal lines on each side
- Bundle selector with 3 options as full-width cards, each with a radio button on the left, product thumbnail `${ASSET_BASE}/bundle-product.webp`, name + sub-label, and price block on the right:
  - **Buy 1 / 1 Pack / $49.95** (strikethrough $54.95) - selected by default, with gold-tinted background `#fef9e7` and a gold border. Radio uses `${ASSET_BASE}/bundle-radio-selected.svg`
  - **Buy 2 Get 1 FREE / 3 Packs / $104.85** (strikethrough $149.95) - has a "MOST POPULAR" badge as a small red/dark ribbon in the top-right corner. Radio uses `${ASSET_BASE}/bundle-radio-unselected.svg`
  - **Buy 3 Get 2 FREE / 5 Packs / $149.70** (strikethrough $299.95) - has a "BEST VALUE" badge as a small gold ribbon in the top-right corner. Radio uses `${ASSET_BASE}/bundle-radio-unselected.svg`
- Shipping info row: green dot + "Arrives by May 18 - May 21" left side, US flag emoji + "FREE Shipping" right side
- Primary CTA: large gold gradient button, full width, bold uppercase text "ADD TO CART - $49.95" (price updates when bundle changes)
- Sub-CTA row: small green checkmark icon `${ASSET_BASE}/check-icon.svg` + "Refill Ships Every 30 Days" / same icon + "Pause, skip, or cancel anytime"
- Guarantee card (cream/yellow tinted background): large gold "60 DAY" guarantee badge on the left (`${ASSET_BASE}/guarantee-badge.webp`), bold title "Perform Better Or We Pay You Back" on the right, body text below: "Give it 60 days. If she hasn't noticed the difference, if you haven't felt it, email us for a full refund and keep the bottle. We don't need it back. That's how certain we are this works."
- Tab system with 3 tabs:

**Tab 1 (default active): Doctor Approved**
5 large gold stars (`${ASSET_BASE}/review-stars-large.svg`), then a blockquote: "Six ancient ingredients that work with your body's natural testosterone and blood flow pathways instead of fighting them with pharmaceuticals. Shilajit and Ashwagandha are cutting cortisol by 27.9%, this is how men were built to perform." Attribution row below: doctor portrait avatar (`${ASSET_BASE}/doctor-portrait.webp`) + "Dr. James R. Cole / Urologist, Men's Sexual Health"

**Tab 2: Why UltimaPeak?**
A short bulleted list comparing UltimaPeak to alternatives. Each bullet has a green checkmark icon and a short benefit:
- 6 clinically-dosed ingredients (vs 2-3 in most competitors)
- Every milligram disclosed on the label (no proprietary blends)
- Third-party tested for purity and potency
- Made in the USA in a GMP-certified facility
- 60-day money-back guarantee (keep the bottle if it doesn't work)
- Free shipping on all orders

**Tab 3: Ingredients**
Quick reference list of the 6 ingredients with one-line descriptions (full carousel is later in the page). Each line: bold ingredient name + dash + description.
- Shilajit 10:1 Extract - The reason she thinks you got bigger.
- Ashwagandha KSM-66® - Blocks cortisol 27.9%. Unleashes the animal.
- L-Arginine - Sends blood where it matters. Harder. Fuller. Faster.
- Horny Goat Weed (Icariin) - Natural PDE5 inhibitor. The reason she's gripping the sheets.
- Black Maca - The reason she's tapping out round 3.
- Ginger Root - Delivers everything deeper so nothing gets wasted.

- Warning banner at the bottom of the right column: red background, warning icon (`${ASSET_BASE}/warning-icon.svg`) on the left, bold "Warning label:" + body: "Adults only. Limit 1 gummy per person per day. Not for those with heart conditions or blood pressure issues. Effects build over 2-4 weeks and get stronger every day. First-timers: your girl is not ready for what's coming."

### 4. Stats band

Cream background (`#fdf8ec`), full-width section. Bold uppercase heading "THE NUMBERS DON'T LIE." centered, with subtitle "Real results from real men." below.

Below the heading: 4 stats in a row at desktop (responsive grid that stacks). **No card backgrounds** - just large bold percentage stacked above a one-line descriptor. The percentages should feel like the visual focus.
- **89%** "Reported noticeably harder erections within 14 days."
- **84%** "Said they lasted three times longer without trying."
- **91%** "Their partner noticed the change before they said a word."
- **86%** "Made her finish from penetration for the first time."

### 5. UGC video testimonials

Dark gradient background section (`#1a1a1a` to `#424242`) with subtle texture overlay `${ASSET_BASE}/testimonials-bg-overlay.webp` at low opacity. Uppercase title "THEY TRIED IT. THEIR BEDROOMS WILL NEVER BE THE SAME." centered, white text. Trust line below: 5 gold stars (`${ASSET_BASE}/ugc-stars.svg`) + "Rated 4.8/5 based on 110,500+ verified reviews".

Below: 4 video testimonial cards in a row at desktop (responsive grid). Each card:
- Video thumbnail (the same image is used for all 4 in the design as a placeholder representing the UGC video frame):
  - Card 1: `${ASSET_BASE}/ugc-video-1-thumb.webp`
  - Card 2: `${ASSET_BASE}/ugc-video-2-thumb.webp`
  - Card 3: `${ASSET_BASE}/ugc-video-3-thumb.webp`
  - Card 4: `${ASSET_BASE}/ugc-video-4-thumb.webp`
- Play button icon overlay centered on the thumbnail: `${ASSET_BASE}/ugc-play-button.svg`
- Below thumbnail: reviewer name in bold + small Trustpilot trust badge `${ASSET_BASE}/ugc-trustpilot-line.webp`
- 5 small gold stars `${ASSET_BASE}/ugc-mini-stars.svg`
- Long-form quote (use verbatim)

Card content (use verbatim) - see findings doc and outputs/v7-1-full-page.md for full testimonial bodies (Ryan M, Trevor A, Paul D, Scott B).

### 6. Women's reviews

White or cream background. Uppercase heading "SHE NOTICED. SHE TOLD HER FRIENDS. THEY ALL ORDERED." centered. Below: 5 gold stars `${ASSET_BASE}/ugc-stars.svg` + "Excellent 4.8/5 based on 110,500+ customer reviews".

Below: 4 review cards in a row at desktop (responsive grid). **Cards MUST use the dark gradient background (`#1a1a1a` to `#424242`) with white text** - this dark-on-light contrast is intentional brand identity. Each card contains:
- 5 gold stars at top (`${ASSET_BASE}/ugc-stars.svg`)
- Bold white headline quote
- Long-form review body in white at smaller text size
- Reviewer attribution row at the bottom: small gold-gradient circle avatar with initial letter inside, name in white, green checkmark icon (`${ASSET_BASE}/review-verified-check.svg`) + "Verified customer" in green

Use verbatim content (Melissa H, Sophie K, Rachel T, Jamie L) - see outputs/v7-1-full-page.md for full review bodies.

### 7. Ingredients

Cream background (`#fdf8ec`). Uppercase title "WHAT'S IN OUR GUMMIES" with subtitle "Six ancient ingredients designed to turn you into a weapon."

Below: 6 ingredient cards in a row at desktop. Each card has the ingredient image floating ABOVE a white rounded card containing the bold ingredient name and a one-line description. Use a horizontal scroll/carousel with arrow controls at the bottom (`${ASSET_BASE}/carousel-arrow-left.webp` and `${ASSET_BASE}/carousel-arrow-right.webp`) OR a responsive grid - your call which works best for 6 items.

Card content (image, name, description):
- `${ASSET_BASE}/ingredient-shilajit.webp` / **Shilajit 10:1 Extract** / "The reason she thinks you got bigger."
- `${ASSET_BASE}/ingredient-ashwagandha.webp` / **Ashwagandha KSM-66®** / "Blocks cortisol 27.9%. Unleashes the animal."
- `${ASSET_BASE}/ingredient-l-arginine.webp` / **L-Arginine** / "Sends blood where it matters. Harder. Fuller. Faster."
- `${ASSET_BASE}/ingredient-horny-goat-weed.webp` / **Horny Goat Weed (Icariin)** / "Natural PDE5 inhibitor. The reason she's gripping the sheets."
- `${ASSET_BASE}/ingredient-black-maca.webp` / **Black Maca** / "The reason she's tapping out round 3."
- `${ASSET_BASE}/ingredient-ginger-root.webp` / **Ginger Root** / "Delivers everything deeper so nothing gets wasted."

### 8-12. Journey timeline / Immediate difference / FAQ / Final CTA / Footer

See outputs/v7-1-full-page.md for sections 8-12 (Journey timeline 3-phase structure, Immediate difference dark card + product image, FAQ 8 questions, Final CTA with dark band, 4-column Footer + disclosure bar).

## What I want you to optimize for

- Visual equivalence to the brief at desktop
- Responsive quality at all viewports (360px-1920px+)
- Conversion (CTA, bundle selector, social proof reinforcement)
- Brand consistency (dark gradient cards, gold accents, cream)
- Modern polish (hover states, transitions, marquee, accordion animations)

## What I trust you to decide

Spacing, padding, breakpoints, aspect ratios, grid vs flex, hover states, semantic HTML, font scale, micro-animation.

## What I do NOT want

- Cropped or compressed hero images at any viewport
- Elements overflowing their containers
- Paraphrased or shortened body copy
- Substituting different images for the asset URLs listed
- Skipping or rearranging any of the 12 sections
- Changing the brand palette
- Generic AI-looking filler text

Build all 12 sections in this single pass. If the response would exceed your output limit, build sections 1-7 in this response and tell me you need a follow-up for sections 8-12.

---

**NOTE (added 2026-05-19 for skill reference):** This is the v7.1 baseline that shipped. The full 28KB verbatim version (with all testimonial bodies and FAQ answers spelled out) is in conversation transcripts. For the production skill, the canonical template is `_skills/figma-to-lovable/_reference/intent-spec-template.md` (to be created in the Mode 1 build session). The full v7.1 is also retained in operator output directory.

Fix-up iteration: 4 rounds (see v7-1-fixup.md, v7-1-fixup-round2.md, v7-1-fixup-round3.md, v7-1-fixup-round4.md, v7-1-immediate-diagnostic.md).
