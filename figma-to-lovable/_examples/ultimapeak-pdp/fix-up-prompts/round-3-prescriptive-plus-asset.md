# Round 3 fix-up - 3 issues

I need 3 specific fixes. Apply each fix in isolation. Do NOT modify any other component or section.

## Fix 1: Hero icons - correct asset assignments

The icons in the hero section are currently using the wrong asset files. The previous fix-up had the asset URLs reversed. Here is the correct mapping:

### Hero LEFT-MIDDLE column - the 3 dark gradient CARDS adjacent to the main product image

(These are the wider rounded cards stacked vertically with a gold icon at top and white text caption below. Captions: "For Nights She Can't Walk After" / "2+ Inches In 2 Weeks" / "She Taps Out. You Keep Going.")

Required icon assignment:
- Card 1 ("For Nights She Can't Walk After"): `${ASSET_BASE}/feature-icon-1.svg`
- Card 2 ("2+ Inches In 2 Weeks"): `${ASSET_BASE}/feature-icon-2.svg`
- Card 3 ("She Taps Out. You Keep Going."): `${ASSET_BASE}/feature-icon-3.svg`

### Hero RIGHT column - the 3 narrow CHIPS below the product title

(These are the smaller rounded dark pills with a small icon left and white text right. Texts: "Harder. Fuller. Every Single Round." / "She Finishes Before You Do." / "Destroyed Mattresses.")

Required icon assignment:
- Chip 1 ("Harder. Fuller. Every Single Round."): `${ASSET_BASE}/benefit-icon-harder-bg.svg`
- Chip 2 ("She Finishes Before You Do."): `${ASSET_BASE}/benefit-icon-harder.svg`
- Chip 3 ("Destroyed Mattresses."): `${ASSET_BASE}/benefit-icon-mattress.svg`

**Important: the previous round used the reverse mapping. The `feature-icon-*` files belong with the BIG CARDS in the left-middle column. The `benefit-icon-*` files belong with the SMALL CHIPS in the right column. Swap your current assignments to match the above.**

After this change, the large gold intimacy/banana icons should appear in the wide black cards next to the main product image, and smaller gold icons should appear inside the narrow chips to the right.

## Fix 2: Immediate-difference section - product image

The image was uploaded to Supabase under this exact URL:

`${ASSET_BASE}/immediate-difference.webp`

Replace the gray "Lifestyle imagery" placeholder in the right column of the "AN IMMEDIATE DIFFERENCE." section with:

```jsx
<img
  src={`${ASSET_BASE}/immediate-difference.webp`}
  alt="UltimaPeak Performance Gummies"
  className="w-full h-full object-cover rounded-[20px]"
/>
```

Make sure the image's containing element has the correct height to display the image fully. If the image is being clipped or shows weirdly, check the parent container's height/aspect-ratio settings.

## Fix 3: Immediate-difference dark card STILL has dead space

In the previous round you reported applying h-fit to the left column and items-start on the parent grid, but the rendered output shows the dark card still stretched well past its content. Either the change did not take effect, or there is another container in the chain forcing the height.

Please perform the following:

1. Locate the ImmediateDifference component file.
2. Find the OUTER container that holds the two columns (text+card on left, image on right). Whether it is a flex row or a grid, set its alignment so children DO NOT stretch:
   - If flex: add `items-start` (and remove `items-stretch` if present)
   - If grid: add `items-start` on the grid container (and ensure the dark card child has no `h-full` or `h-screen` or fixed pixel height)
3. Find the dark gradient card div (the one with the 4 "For The Guy..." rows). Set its className to include `h-fit` and remove any `h-full`, `h-screen`, or `min-h-*` classes.
4. Find the LEFT column wrapper (containing the heading, subtitle, and dark card). Set its className to include `h-fit` and remove any height-stretching classes.

After this change, the dark card should be as tall as its content (4 rows + padding) and stop there. The right-column image will be its own height. The two columns no longer need to align in height.

If after applying step 4 the card is STILL stretching, run a console.log in a useEffect that prints the rendered heights:

```jsx
useEffect(() => {
  const card = document.querySelector('[data-immediate-card]');
  const leftCol = document.querySelector('[data-immediate-left]');
  if (card) console.log('[IMMEDIATE-DEBUG] card height:', card.getBoundingClientRect().height);
  if (leftCol) console.log('[IMMEDIATE-DEBUG] left col height:', leftCol.getBoundingClientRect().height);
}, []);
```

Add `data-immediate-card` attribute to the dark card and `data-immediate-left` to the left column. Run the preview, copy the console output, and paste it back so we can debug what is forcing the height.

## What NOT to change

- Do not modify any other section
- Do not change copy text
- Do not change the brand palette
- Do not change responsive breakpoints
- Do not "improve" anything not called out above

Apply only the 3 fixes above.
