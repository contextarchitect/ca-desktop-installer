# UltimaPeak PDP - canonical reference implementation

UltimaPeak Performance Gummies product detail page. 12 sections + 3 hidden states. 50+ assets. Iteration date: 2026-05-19.

This is the validation test pass for `figma-to-lovable` Mode 1. The iteration produced the design philosophy validation, the 9-bug ledger, and the v7.1 intent-spec format that the skill's template is built on. It also produced the fix-up prompts that demonstrate the three escalation patterns.

**This directory is reference material.** Do not copy these files when starting a new PDP - use the templates in `_skills/figma-to-lovable/_reference/` instead. This example shows what a real iteration produced; the templates are what new iterations start from.

> **Historical (pre-v3, CDN era).** This example is a pre-v3 iteration. Its asset transport - the upload script, Supabase hosting, and asset-URL resolution - is historical and no longer part of the skill; v3 Mode 1 attaches exported files directly to the Lovable prompt. The 9-bug ledger and the fix-up escalation arc below remain valid and transport-agnostic.

## Files in this directory

```
_examples/ultimapeak-pdp/
├── README.md                       (this file)
├── intent-spec.md                  (the v7.1 prompt that shipped UltimaPeak)
├── asset-script.ps1                (operator's parameterized run of the upload script)
└── fix-up-prompts/
    ├── round-1-prescriptive.md
    ├── round-2-prescriptive.md
    ├── round-3-prescriptive-plus-asset.md
    ├── round-4-failed-prescriptive.md
    ├── round-4-screenshot-success.md
    └── diagnostic-source-code-paste.md
```

## The iteration arc

### Pre-paste

- 12 section node IDs extracted from the Figma file
- 50+ assets enumerated via `Figma:get_design_context` per section
- Asset manifest authored with semantic_role + parent_section + parent_component per row
- Brand identity block extracted (cream + gold gradient + dark gradient palette, Figtree typography)
- Asset upload script run, all assets in Supabase, 5 URLs spot-checked in browser

### Initial paste (v7.1)

`intent-spec.md` was pasted into a fresh Lovable project. Lovable's first generation took ~120 seconds and produced 80%+ production-quality output across all 12 sections. The page rendered at desktop and mobile with the brand palette intact and all asset URLs resolving.

Remaining issues identified in screenshot review:
1. Star icons stretched across the page (no explicit dimensions on the SVG `<img>` elements)
2. UltimaPeak logo rendered as text + mountain icon placeholder, not the actual logo asset
3. Hero benefit card icons mixed up between two icon sets (`benefit-icon-*` and `feature-icon-*`)
4. Hero benefit cards positioned LEFT instead of MIDDLE between main image and right column

These became the Round 1 fix-up.

### Round 1 - prescriptive multi-issue (succeeded for 3 of 4)

`fix-up-prompts/round-1-prescriptive.md` shipped 4 prescriptive fixes in one prompt. Results:
- Fix 1 (star icon stretching): resolved
- Fix 2 (logo asset): resolved
- Fix 3 (hero icon assignment): partially resolved - the asset URL mapping was reversed (Bug 8 - reconstructed from memory rather than from manifest)
- Fix 4 (hero card positioning): resolved

### Round 2 - prescriptive narrower scope (mixed results)

`fix-up-prompts/round-2-prescriptive.md` addressed 3 remaining issues. Results:
- Fix 1 (icon mapping reversal): made one specific card's icon correct, but exposed the broader reversal pattern
- Fix 2 (immediate-difference image): asset was not yet uploaded; placeholder remained
- Fix 3 (immediate-difference card stretching): operator's hypothesis was wrong; persistence

### Round 3 - prescriptive + asset upload (partial)

`fix-up-prompts/round-3-prescriptive-plus-asset.md` corrected the icon mapping (reading from manifest this time), uploaded the missing immediate-difference image to Supabase, and re-issued the dark-card layout fix. Results:
- Hero icons: resolved
- Immediate-difference image: resolved
- Dark-card stretching: persisted (operator's hypothesis was still wrong)

### Round 4 - failed prescriptive (continued)

`fix-up-prompts/round-4-failed-prescriptive.md` was an `aspect-square` / `aspect-[590/613]` change targeting what the operator thought was the cause. Did not resolve.

### Round 4 (continued) - source-code diagnostic

The operator escalated to Pattern 3. `fix-up-prompts/diagnostic-source-code-paste.md` asked Lovable to paste the full `ImmediateDifference.tsx` source. The pasted code showed that the operator's hypothesis was wrong - the card was NOT stretching; the chips inside the card were.

### Round 4 (continued) - screenshot + plain-English success

`fix-up-prompts/round-4-screenshot-success.md` was the prompt that finally resolved the issue. The operator attached a screenshot and wrote the plain-English sentence "the cards with the black backgrounds should wrap nicely around the text so there is no empty space." Lovable identified the real cause (chip widths stretching beyond their text content) and applied the fix in one round.

This is the canonical Bug 9 example.

### Shipped

After Round 4 resolved, the page passed visual review at mobile / tablet / desktop. Shipped to client.

## Lessons mapped to skill structure

The 9 bugs in `_tests/figma-to-lovable-mode-1-findings.md` mapped to skill structure as follows:

| Bug | Where in skill it's prevented |
|---|---|
| 1: page-structure block carries forward unmodified | Approach B's single-paste design (no split prompts) |
| 2: trusting tool error messages without verification | `_reference/operator-workflow.md` "verify before next step" gates |
| 3: skill author hallucinating bugs | `_reference/lovable-remediation-patterns.md` source-code-diagnostic pattern (read before propose) |
| 4: duplicate asset name detection | `_reference/asset-manifest-template.md` duplicate-hash flag (surface, do not silent-dedupe) |
| 5: Lovable rewrites pasted JSX | Approach B itself - skill ships intent, not JSX |
| 6: optimization steps must degrade gracefully | `_reference/asset-upload-script-template.ps1` required vs enhancement stage classification |
| 7: responsive breakpoint must match artboard width | Superseded by Approach B (Lovable owns breakpoints) |
| 8: asset role-to-file mappings reconstructed from memory get reversed | `_reference/asset-manifest-template.md` discipline |
| 9: screenshot + plain English beats prescriptive CSS for visual fixes | `_reference/lovable-remediation-patterns.md` Pattern 2 + iteration ceiling |

## Cross-references

- `_tests/figma-to-lovable-mode-1-findings.md` - the test-pass findings doc
- `_skills/figma-to-lovable/SKILL.md` - skill root
- `_skills/figma-to-lovable/_reference/operator-workflow.md` - end-to-end procedure
- `_skills/figma-to-lovable/_reference/lovable-remediation-patterns.md` - fix-up patterns
