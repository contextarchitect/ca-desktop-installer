# Round 4 screenshot + plain-English fix-up (succeeded)

**Context for this file.** Three prior rounds of prescriptive CSS class changes (`h-fit`, `items-start`, `aspect-square`, `aspect-[590/613]`) had all failed to resolve a visual issue in the AN IMMEDIATE DIFFERENCE section's dark gradient card. The operator's hypothesis had been that the card itself was stretching to fill the column height. The actual cause turned out to be different.

This is the prompt the operator sent that resolved the issue in one round. It is the canonical example of Pattern 2 (screenshot + plain-English) from `_skills/figma-to-lovable/_reference/lovable-remediation-patterns.md`.

This prompt is reconstructed from the iteration arc described in `_tests/figma-to-lovable-mode-1-findings.md` Bug 9. The exact wording of the plain-English sentence is preserved verbatim.

---

[Screenshot attached via Lovable's image upload control. The screenshot shows the AN IMMEDIATE DIFFERENCE section as rendered: dark gradient card on the left with 4 "For The Guy..." rows, but each row has unnecessary horizontal whitespace, making the card look sparse and the section feel unbalanced against the right-column image.]

As per the screenshot attached, the cards with the black backgrounds should wrap nicely around the text so there is no empty space.

I want each row to be only as wide as its content (icon + text) rather than stretching to fill the available column width. The dark card itself can stay at its current column width, but the chip/row elements inside it should size to their content.

Do not modify any other section. Do not change copy. Do not change the brand palette.

---

## What Lovable did

Lovable identified the actual root cause: the chip rows inside the dark card had `w-full` or equivalent stretching behavior, which made each row span the column width regardless of content length. The operator's earlier hypothesis (card-height-stretching) had been wrong.

Applied fix (in `src/components/ImmediateDifference.tsx`):

- Added `w-fit max-w-full inline-flex` to each chip/row element inside the dark card
- Added `shrink-0` to the icon `<img>` inside each chip to prevent icon collapse

Result: chips sized to their content. Card looked balanced. Section visually matched the Figma source intent.

## Why this worked when 3 prior prescriptive rounds did not

The operator's mental model of the problem was wrong. They saw whitespace around the text and assumed the card was stretching vertically. They tried `h-fit` on the card, `items-start` on the parent grid, `aspect-square` on the right-column image, and `aspect-[590/613]` to match Figma exactly. All of these were targeting the wrong thing.

The screenshot let Lovable see the actual layout: chips inside a card, with the chips themselves stretching horizontally beyond their content. The plain-English sentence let Lovable identify the cause without being constrained by the operator's hypothesis.

This is Bug 9 in `_tests/figma-to-lovable-mode-1-findings.md`. The rule: when a prescriptive CSS fix attempt fails to resolve a visual issue, escalate to screenshot + plain-English rather than iterating prescriptive prompts. The operator's interpretation is bounded by their mental model; a screenshot is a higher-bandwidth signal.

## Operator notes

- The plain-English sentence avoided any CSS terminology ("wrap", "empty space", "cards"). This matters - prescribing CSS in the screenshot prompt re-imports the operator's hypothesis and defeats the purpose of escalating.
- The "do not modify other sections" fence at the bottom is preserved. Pattern 2 prompts still need this because Lovable's instinct to "improve" adjacent code is undimmed by switching prompt patterns.
- The fix that Lovable applied is documented above for reference, but the operator did NOT specify it in the prompt. Lovable identified it from the screenshot.

## Cross-references

- `_skills/figma-to-lovable/_reference/lovable-remediation-patterns.md` Pattern 2 (the canonical pattern definition)
- `_tests/figma-to-lovable-mode-1-findings.md` Bug 9 (the test-pass observation that produced this pattern)
- `_skills/figma-to-lovable/_examples/ultimapeak-pdp/fix-up-prompts/round-4-failed-prescriptive.md` (the immediately-preceding failed prescriptive round - the `aspect-[590/613]` attempt)
