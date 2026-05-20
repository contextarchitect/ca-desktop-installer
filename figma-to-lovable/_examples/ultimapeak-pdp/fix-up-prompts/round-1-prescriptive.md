# Targeted fix-up - 4 specific issues, do not rebuild other sections

I need you to fix 4 specific issues in the current page. Each fix is described below with the exact location and required change. Do NOT modify any other component or section. Do NOT refactor working code. Apply each fix in isolation.

## Fix 1: Star icons are stretched/skewed across the page

Everywhere a star asset is rendered (trust rating in hero, UGC testimonials trust line, women's reviews trust line, individual review card star strips, doctor approved tab) the SVG is stretching to fill its container instead of preserving its native aspect ratio.

The root cause: the star SVG `<img>` elements have no explicit pixel dimensions, so they stretch to whatever their parent allows.

For every `<img>` tag whose `src` references one of these star assets:
- `${ASSET_BASE}/stars-5.svg`
- `${ASSET_BASE}/ugc-stars.svg`
- `${ASSET_BASE}/ugc-mini-stars.svg`
- `${ASSET_BASE}/review-stars-large.svg`

Apply BOTH:
1. Explicit Tailwind width and height classes that preserve a 5:1 horizontal aspect ratio. Suggested sizes:
   - Hero trust rating row (`stars-5.svg`): `w-[120px] h-[24px]`
   - UGC trust line and women's review trust line (`ugc-stars.svg`): `w-[100px] h-[20px]`
   - Individual review/testimonial card star strips (`ugc-mini-stars.svg`): `w-[80px] h-[16px]`
   - Doctor approved tab large stars (`review-stars-large.svg`): `w-[120px] h-[24px]`
2. The inline style attribute `style={{ objectFit: 'contain' }}` as a defensive fallback.

After this change the stars should render at their native aspect ratio everywhere they appear on the page.

## Fix 2: UltimaPeak logo is missing - currently rendered as text + icon

The Header component currently renders "UltimaPeak" as text with a mountain icon next to it. The brand has a real logo asset at:

`https://hlvekxlxsocivhigggzc.supabase.co/storage/v1/object/public/brand-assets/ultimapeak/pdp-rebranded-competitors/logo-webshop.png`

In the Header component, replace the text + mountain icon rendering with an `<img>` tag using:

```jsx
<img
  src={`${ASSET_BASE}/logo-webshop.png`}
  alt="UltimaPeak"
  className="h-[40px] w-auto"
/>
```

Apply the same logo asset in the Footer column 1 brand block:

```jsx
<img
  src={`${ASSET_BASE}/logo-webshop.png`}
  alt="UltimaPeak"
  className="h-[28px] w-auto"
/>
```

If the footer needs a light/inverted variant and the current logo doesn't look right on dark, wrap the footer logo `<img>` in a span with `style={{ filter: 'brightness(0) invert(1)' }}` as a last resort. Try without the filter first.

## Fix 3: Hero section icons are mixed up between two icon sets

The hero section has TWO distinct icon sets that should NOT share assets:

**Set A - the 3 vertical benefit CARDS adjacent to the main product image** (dark gradient cards with gold icon + white caption like "For Nights She Can't Walk After"):
- Card 1 ("For Nights She Can't Walk After"): icon must be `${ASSET_BASE}/benefit-icon-finish.svg`
- Card 2 ("2+ Inches In 2 Weeks"): icon must be `${ASSET_BASE}/benefit-icon-harder.svg`
- Card 3 ("She Taps Out. You Keep Going."): icon must be `${ASSET_BASE}/benefit-icon-mattress.svg`

**Set B - the 3 horizontal benefit CHIPS in the right column of the hero** (rounded dark pills with small icon left + text like "Harder. Fuller. Every Single Round."):
- Chip 1 ("Harder. Fuller. Every Single Round."): icon must be `${ASSET_BASE}/feature-icon-1.svg`
- Chip 2 ("She Finishes Before You Do."): icon must be `${ASSET_BASE}/feature-icon-2.svg`
- Chip 3 ("Destroyed Mattresses."): icon must be `${ASSET_BASE}/feature-icon-3.svg`

These two icon sets are visually similar (both are small gold icons) but they are different assets and should NOT be substituted for each other. Audit your HeroProduct component and ensure each icon is paired with the correct text per the lists above. The benefit-icon-*.svg files belong ONLY in Set A (the vertical cards). The feature-icon-*.svg files belong ONLY in Set B (the horizontal chips). If you currently have any benefit-icon-*.svg referenced inside the chips section or any feature-icon-*.svg referenced inside the vertical cards, swap them.

## Fix 4: 3 vertical benefit cards positioned incorrectly

The 3 vertical benefit cards (Set A from Fix 3 above) are currently positioned to the LEFT of the main product image, stretched vertically. They should be positioned to the RIGHT of the main product image, BETWEEN the main image and the right column (product info + bundle selector).

Required desktop layout structure:

```
[ LEFT: main product image area ]  [ MIDDLE: 3 vertical benefit cards stacked ]  [ RIGHT: product info, bundle selector, tabs ]
```

Three direct children of the hero outer wrapper, side by side at desktop. Each card in the middle column should size to its content naturally - NOT stretch to fill the column height. The middle column itself should be roughly 148-160px wide.

On mobile/tablet (below your desktop breakpoint), the three columns stack vertically: main image first, then the 3 benefit cards (which can become a horizontal row of 3 cards on mobile to save vertical space - your call), then the right column.

The thumbnail strip below the main image should stay aligned with the main image only, not extend across the middle or right columns.

After this change the layout matches the Figma source intent: image on the left, vertical pills in the middle, product info/bundle on the right.

## What NOT to change

- Do not modify the StatsBand, UgcTestimonials, WomensReviews, IngredientsCarousel, JourneyTimeline, ImmediateDifference, FAQ, FinalCta, or Footer components (except for Fix 2 in Footer column 1 logo).
- Do not change any copy text.
- Do not change the brand palette.
- Do not change the responsive breakpoints you already chose.
- Do not change image cropping or aspect ratios for hero/lifestyle photos that are working correctly.
- Do not "improve" or "polish" any section that wasn't called out above.

Apply only the 4 fixes described above. Each fix should be a minimal targeted change to the specific elements named.
