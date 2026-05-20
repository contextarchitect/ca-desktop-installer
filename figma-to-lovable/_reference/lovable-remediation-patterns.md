# Lovable remediation patterns

Three documented patterns for fixing visual issues in Lovable output. Use them in order. Do not skip levels. Do not iterate the same level more than once. Pattern 3 ends with an operator disposition (SHIP-AS-IS / HAND-OFF / SCOPE-DOWN), not a fresh fix attempt; there is no attempt 4 on the same issue.

This document codifies Bug 9 from `_tests/figma-to-lovable-mode-1-findings.md`: the operator's interpretation of a visual problem is bounded by their mental model of the page; a screenshot is a higher-bandwidth signal that lets Lovable see the actual problem directly. The UltimaPeak Round 4 chip-width-wrap fix resolved in one round after three prior prescriptive rounds had failed.

## Pattern 1 - Prescriptive fix prompt

**When to use:** the issue has a clear CSS or structural fix AND the operator has verified the fix against ground truth before prescribing it. Examples: missing logo asset, wrong icon assignment, explicit pixel dimensions for an SVG that is stretching.

**Precondition - ground-truth verification (Bug 3 prevention).** Before authoring a Pattern 1 prompt, the operator must do at least one of:

1. **Compare against the Figma source.** Run `Figma:get_screenshot` on the affected node and confirm the operator's understanding of the intended visual matches Figma. Never override a Figma-authored visual property based on what the operator thinks the design should be.
2. **Read the current Lovable code.** Either via Lovable's read-back of the file or by inspecting the rendered devtools output. The fix must be grounded in the actual class strings as they currently exist, not in the operator's mental model of what Lovable wrote.

If neither check is possible (Figma source unavailable, Lovable code not readable), **skip Pattern 1 and go directly to Pattern 2 (screenshot + plain English)**. Pattern 1 without ground-truth verification is Bug 3 (skill author hallucinating bugs from incomplete evidence) and produces the same kind of speculative fixes that the UltimaPeak v4 audit had to revert. Pattern 2 is the safe escalation when verification is not possible.

**Iteration ceiling:** one round. If the issue persists after a prescriptive fix attempt, escalate to Pattern 2. Do not write a second prescriptive prompt for the same issue.

**Template:**

```markdown
# Targeted fix-up - [N] specific issues, do not rebuild other sections

I need you to fix [N] specific issues in the current page. Each fix is described below with the exact location and required change. Do NOT modify any other component or section. Do NOT refactor working code. Apply each fix in isolation.

## Fix 1: [SHORT_TITLE]

[Describe the symptom in one sentence. Cite the component name and the visual symptom.]

[Describe the root cause **as verified against Figma source or Lovable code**. One sentence. Cite which ground-truth source the operator checked: "verified against Figma node X-Y" or "verified against the current src/components/Foo.tsx readback".]

[Describe the fix:]
- [Specific class change, e.g. "Add `w-[120px] h-[24px]` to the `<img>` tag at line ~42"]
- [Defensive fallback if applicable, e.g. "Also add `style={{ objectFit: 'contain' }}` as a defensive fallback"]

[Specify the affected asset URLs / component file paths verbatim. No paraphrasing.]

After this change [DESCRIBE_EXPECTED_VISUAL_RESULT].

## Fix 2: [SHORT_TITLE]

[Same structure.]

## What NOT to change

- Do not modify any other section.
- Do not change any copy text.
- Do not change the brand palette.
- Do not change responsive breakpoints you already chose.
- Do not "improve" or "polish" any section that wasn't called out above.

Apply only the [N] fixes described above. Each fix should be a minimal targeted change to the specific elements named.
```

**Reference:** the UltimaPeak Round 1 prescriptive fix-up is in `_examples/ultimapeak-pdp/fix-up-prompts/round-1-prescriptive.md`. It fixed star icon stretching, missing logo asset, hero icon mix-up, and hero benefit card positioning - all in one prescriptive prompt.

**Bug 5 note:** even within a prescriptive prompt, Lovable may rewrite parts of working code it considers improvable. The "What NOT to change" block at the bottom is non-negotiable; it explicitly fences the rest of the page.

## Pattern 2 - Screenshot + plain-English prompt

**When to use:**

- A Pattern 1 prescriptive attempt did not resolve the issue.
- The issue is visual and the operator cannot articulate the underlying CSS fix.
- The operator suspects the cause is different from what their initial Pattern 1 hypothesis assumed.

**Iteration ceiling:** one round. If the issue persists after a screenshot prompt, escalate to Pattern 3.

**Sentence pattern (Bug 9 verbatim):**

> "As per the screenshot attached, [describe what is wrong in plain English]."

**Template:**

```markdown
[Attach the screenshot via Lovable's image upload control - the operator does this through Lovable's UI.]

As per the screenshot attached, [DESCRIBE_WHAT_IS_WRONG_IN_PLAIN_ENGLISH].

[Optional second sentence describing the desired end state in plain English, e.g.
"I want [SPECIFIC_VISUAL_OUTCOME] without [SPECIFIC_UNDESIRED_STATE]."]

Do not modify any other section. Do not change copy. Do not change the brand palette.
```

**Why this works:** a screenshot is a higher-bandwidth signal than prose. When the operator describes a visual problem in CSS terms, the description is bounded by the operator's hypothesis about the cause. The screenshot lets Lovable observe the actual rendered state and identify the real cause, which is sometimes different from what the operator assumed.

**UltimaPeak Round 4 example.** Three prior rounds of prescriptive CSS (`h-fit`, `items-start`, `aspect-square`, `aspect-[590/613]`) had failed to resolve a dark-card layout issue. Round 4 sentence: "the cards with the black backgrounds should wrap nicely around the text so there is no empty space." Lovable identified the actual cause (chip widths stretching beyond text content, not card height stretching as the operator had assumed), applied the correct fix (`w-fit max-w-full inline-flex` on the chips, `shrink-0` on the icons), and resolved it in one round.

**Reference:** `_examples/ultimapeak-pdp/fix-up-prompts/round-4-screenshot-success.md` reconstructs this Round 4 prompt as the canonical example.

## Pattern 3 - Source-code diagnostic + operator disposition

**When to use:**

- Patterns 1 and 2 have both failed for the same issue.
- Lovable claims to have applied a fix that is not reflected in the rendered output.
- The operator suspects there is a hidden parent container or class chain that is overriding the fix.

**Iteration ceiling:** one round, and it ends with operator disposition, not a fresh fix prompt to Lovable. Pattern 3 is the exit point for the issue, not a setup for a 4th attempt.

**Round 2 ceiling fix.** Previously this pattern ended with "operator writes a fresh Pattern 1 prescriptive prompt grounded in the real code." A cold operator reads that as permission to make a 4th attempt at the same issue, which is the Bug 9 failure mode the ladder is meant to prevent. The corrected exit is the three-disposition rule below.

**Template:**

```markdown
# Diagnostic - paste the JSX hierarchy of the [SECTION_NAME] section

The [DESCRIBE_SYMPTOM]. I have asked for [WHAT_WAS_ASKED] in [N] prior rounds and the issue persists. There must be something else [DESCRIBE_HYPOTHESIS_ABOUT_HIDDEN_CAUSE]. Help me find it by reporting the actual current state of the file - no modifications.

Open `src/components/[COMPONENT_FILENAME].tsx` (or whatever the file is called for that section) and paste back the FULL component file. Include:
- All imports
- The complete component function
- Every className on every JSX element from the outermost wrapper down to [SPECIFIC_INNER_ELEMENT]

Do not summarize. Do not modify. Just paste the file's contents verbatim from the source.

If the section is broken across multiple files (e.g. parent layout, then [SECTION_NAME], then sub-components), paste all of them.

I need to see the actual class strings as they currently exist so I can identify which parent is forcing the [SYMPTOM].
```

**Variant for asking about rendered widths rather than source code:**

The UltimaPeak iteration used a variant of this pattern that asked Lovable to run `getBoundingClientRect()` on specific refs and paste the actual rendered pixel widths back. Use this variant when the issue is layout sizing rather than class string state. See `_tests/lovable-instrumentation-hero-widths.md` for the instrumentation pattern, and `_tests/lovable-diagnostic-hero-rendered-widths.md` for the read-back diagnostic.

**Reference:** `_examples/ultimapeak-pdp/fix-up-prompts/diagnostic-source-code-paste.md` is the verbatim diagnostic prompt used during the test-pass iteration.

**Critical rule:** the diagnostic prompt does NOT propose fixes. It only asks for code. After Lovable pastes the code, the operator does NOT write another fix prompt against the same issue. Instead the operator picks one of three dispositions below. This is the exit from the iteration ladder for this issue.

### Operator disposition (the exit)

After reading the code Lovable pasted, the operator picks exactly one of these three. Record the choice in the iteration log:

**(a) SHIP-AS-IS.** The issue is cosmetic, the page is shippable in its current state, and continuing to iterate has worse ROI than shipping. Accept the current state and move on to the next issue (or to page sign-off if this was the last issue).

**(b) HAND-OFF.** The diagnostic reveals the issue is outside Lovable's productive iteration envelope (deep parent-chain class conflict, third-party component override, framework-level constraint). Hand the pasted file + the operator's reading of the cause to a human developer for a manual fix outside Lovable. Mark the issue as deferred-to-human.

**(c) SCOPE-DOWN.** The diagnostic reveals the operator was framing the wrong issue. The real problem is different from what Patterns 1 and 2 attempted to fix. Open a **new** issue in the iteration log with the corrected framing, and that new issue gets its own 1+1+1 budget from Pattern 1 onward. This is NOT a 4th attempt on the original issue.

**Discipline for option (c).** The operator must write down in the iteration log, in one sentence, why the new framing is a structurally different issue from the original. "Chip widths stretching, not card heights stretching" is a different issue. "Same problem, different CSS hypothesis" is not. If the operator cannot articulate the difference, the right choice is (a) SHIP-AS-IS or (b) HAND-OFF, not (c).

## Iteration ceiling - summary table

| Attempt | Pattern | Max rounds | Next step if fails / exit condition |
|---|---|---|---|
| 1 | Prescriptive (Pattern 1) | 1 | Escalate to Pattern 2 |
| 2 | Screenshot + plain English (Pattern 2) | 1 | Escalate to Pattern 3 |
| 3 | Source-code diagnostic (Pattern 3) | 1 | Operator disposition: SHIP-AS-IS, HAND-OFF, or SCOPE-DOWN (a new issue) |

**Total budget for any one issue: 3 attempts across the three patterns, ending in an operator disposition.** There is no attempt 4. A SCOPE-DOWN opens a new issue with its own 1+1+1 budget; same-issue iteration ends at Pattern 3.

This ceiling is Bug 9 in `_tests/figma-to-lovable-mode-1-findings.md`: "Same failure class twice in spot-fix loop -> design-first approach. Same class on design-first -> STOP and disposition." Pattern 3 is the disposition step, not another spot-fix.

## What this ladder is NOT

- It is not a sequence to walk through for every fix. Most issues are resolved by Pattern 1 alone. Most pages need 1-4 Pattern 1 fix-ups total (the test-pass iteration), with at most one of those escalating to Pattern 2.
- It is not a way to get more chances at the same prompt. The ceiling is structural: if Pattern 2 fails, do not try Pattern 2 again with different words.
- It is not a substitute for getting the intent-spec right the first time. Most fix-ups are addressing real Lovable judgment calls that diverged from intent; if a page has more than 5 fix-up rounds, the intent-spec is probably under-specified somewhere.
- Pattern 3 is not a setup for a 4th attempt on the same issue. The exit is the operator disposition.

## Cross-references

- `_reference/em-dash-sweep.md` - run before every fix-up prompt ships
- `_examples/ultimapeak-pdp/fix-up-prompts/` - all 4 fix-up rounds from the UltimaPeak iteration, in order, plus the source-code diagnostic
- `_tests/figma-to-lovable-mode-1-findings.md` Bug 9 and validation discipline rule 4 (iteration ceiling)
