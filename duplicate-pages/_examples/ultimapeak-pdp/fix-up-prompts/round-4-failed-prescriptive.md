# Round 4 fix-up - 1 issue, simple change

The dark card in the "AN IMMEDIATE DIFFERENCE." section is actually NOT stretching. It's sized to its content correctly. The visual "dead space" below the card is because the right-column image is taller than the left-column content, so the section's height matches the taller column.

The fix is to make the image match the card's natural height by reducing the right column's aspect ratio. In Figma the image is 590x613 (essentially square).

## Single change

In `src/components/ImmediateDifference.tsx`, change line ~44:

```jsx
<div className="aspect-[4/5] rounded-3xl overflow-hidden">
```

To:

```jsx
<div className="aspect-square rounded-3xl overflow-hidden">
```

Or if the result is still slightly off, try `aspect-[590/613]` which matches Figma exactly.

## What NOT to change

- Do not modify any other classNames in the file
- Do not change the items-start grid alignment (it's correct)
- Do not change h-fit on the left column (it's correct)
- Do not modify any other section
