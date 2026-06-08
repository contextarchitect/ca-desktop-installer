# Round 2 fix-up - 3 remaining issues

I need 3 specific fixes. Do NOT modify any other component or section. Apply each fix in isolation.

## Fix 1: Hero icon mismatch - benefit-icon-finish.svg

In the HeroProduct component, the first vertical benefit card ("For Nights She Can't Walk After") is currently showing the wrong icon. The current icon appears to be a single-figure silhouette. The correct icon from the Figma source is an intimacy pose with two figures.

Please verify what your current code does. The intended state is:
```jsx
<img
  src={`${ASSET_BASE}/benefit-icon-finish.svg`}
  alt="For Nights She Can't Walk After"
  className="w-[72px] h-[72px]"
/>
```

If your code currently references a DIFFERENT asset URL for this card (e.g. you mistakenly used `benefit-icon-harder.svg` or `feature-icon-1.svg`), correct it to use `benefit-icon-finish.svg`.

If your code is already correctly referencing `benefit-icon-finish.svg`, leave it as is. The source asset file in Supabase may have been uploaded incorrectly, in which case fixing this requires a Supabase upload, not a code change. Report which case applies.

## Fix 2: Immediate-difference section is missing its image

The right column of the "AN IMMEDIATE DIFFERENCE." section currently shows a gray placeholder labeled "Lifestyle imagery." Replace this placeholder with the actual product hero image.

The Figma source shows a moody outdoor product shot - the UltimaPeak gummies pouch on a rock with moss in the background, with some loose gummy pieces. This is NOT a lifestyle couple photo (which was my mistake in the original brief).

Try this asset URL first:
`${ASSET_BASE}/immediate-difference.webp`

If that asset returns 404, try these fallback URLs in order (the asset may have been uploaded under different naming):
- `${ASSET_BASE}/immediate-difference-product.webp`
- `${ASSET_BASE}/product-on-rock.webp`
- `${ASSET_BASE}/immediate-product.webp`

Use the first one that successfully loads. If none of them work, leave the placeholder in place and report which URLs you attempted.

Render the image with:
```jsx
<img
  src={`${ASSET_BASE}/immediate-difference.webp`}
  alt="UltimaPeak Performance Gummies"
  className="w-full h-full object-cover rounded-[20px]"
/>
```

## Fix 3: Immediate-difference dark card has excessive dead space

The dark gradient card on the left side of the "AN IMMEDIATE DIFFERENCE." section is currently very tall with significant empty space below the 4 bullet points. The card should size to its content (auto height) and not stretch to match the height of the right-column image.

The current behavior is likely caused by the card being inside a flex/grid layout where it's set to stretch to match its sibling's height. Find the dark card div (the one with the 4 "For The Guy..." bullets inside) and ensure:

- The card itself uses `h-fit` or has no fixed height
- The parent container uses `items-start` instead of `items-stretch` (the default for flex/grid)

After this change the dark card should be roughly the height of its 4 bullets + padding, leaving the right column image at its natural height regardless. The two columns no longer need to match heights.

## What NOT to change

- Do not modify any other section (Header, hero except for Fix 1, StatsBand, UGC, WomensReviews, Ingredients, Journey, FAQ, FinalCta, Footer).
- Do not change any copy text.
- Do not change the brand palette.
- Do not change responsive breakpoints.
- Do not change the layout positioning of the hero benefit cards (Fix 4 from the previous round is correct, leave it).
- Do not "improve" anything not called out above.

Apply only the 3 fixes described above.
