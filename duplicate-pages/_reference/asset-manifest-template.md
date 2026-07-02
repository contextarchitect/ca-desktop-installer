# Asset manifest template

The asset manifest is the ground-truth mapping from Figma asset hash to (semantic role in the page, target filename). It is authored at Figma extraction time and read by the intent-spec generator and by the operator when exporting assets and attaching them to the Lovable prompt.

**Never reconstruct this manifest from memory between iterations.** When the skill author rebuilds an asset mapping from context rather than from the manifest file, the mappings get reversed (Bug 8 in `_tests/figma-to-lovable-mode-1-findings.md`). The test-pass iteration spent two fix-up rounds chasing a reversed icon-asset mapping that would have been caught immediately by reading the manifest. See `_examples/ultimapeak-pdp/README.md` for the concrete history of that bug.

## Format

The manifest is a CSV file committed to the brand's asset directory. JSON is acceptable if the operator prefers it, but CSV is recommended because it opens cleanly in any spreadsheet tool and diffs cleanly in git.

### Required columns (validation A: a blank value in any of these fails the manifest)

| Column | Purpose | Example |
|---|---|---|
| `figma_hash` | The asset hash as exported by `Figma:get_design_context` | `<40-char-hex-hash>` |
| `semantic_role` | Human-readable description of what this asset is in the design | `<section> <component> <element-purpose>` |
| `target_filename` | The leaf filename used when exporting from Figma (no path separators, no `..`, alphanumeric + `._-` only) | `<role>-<n>.<ext>` |

### Recommended columns (validation warns if blank)

| Column | Purpose | Example |
|---|---|---|
| `figma_node_id` | The Figma node ID where this asset is referenced (used to trace back to source) | `<frame-id>:<node-id>` |
| `parent_section` | The page section this asset belongs to | `<section-name>` |
| `parent_component` | The component or sub-block within the section | `<component-name>` |

### Optional columns (default behavior applies if blank or missing)

| Column | Purpose | Default if blank | Example |
|---|---|---|---|
| `notes` | Free-form notes from the operator (duplicate flag, designer note, etc.) | `(no notes)` | `Designer reused this image across bundles 1, 2, 3` |
| `aspect_ratio` | Native aspect ratio (when known, helps with placeholder boxes) | `(unknown)` | `5:1` |

## Validation contract

The operator validates the manifest before exporting assets (Step 3 of `_reference/operator-workflow.md`). Any failure of A, B, or C is fatal: fix the manifest before exporting. F is a surfaced warning, not fatal.

| Check | Rule | Why |
|---|---|---|
| **A. Schema completeness** | Every row has non-blank values in `figma_hash`, `semantic_role`, `target_filename`. | Prevents incomplete rows that cannot be exported or referenced in the intent-spec. |
| **B. target_filename safety** | No `/`, `\`, or `..`. No leading `/` or `<drive>:`. Matches `^[A-Za-z0-9._-]+$` (leaf filename only). | `target_filename` is the name the asset is exported as. A malformed value with path separators or parent traversal can write outside the export folder. |
| **C. target_filename uniqueness** | No two rows share a `target_filename` (case-insensitive comparison). | Two rows with the same `target_filename` (distinct `figma_hash` values) collide on export, and the last export wins, leaving multiple manifest roles pointing at one overwritten file. |
| **F. Duplicate figma_hash detection** | Same `figma_hash` in multiple rows triggers a WARN listing every semantic_role involved. Not fatal. | Bug 4 prevention: duplicate hashes are typically intentional content reuse (one image across multiple bundles). Surface them so the operator can confirm with the designer or replace with distinct assets. Surface, do not silent-dedupe. |

If any fatal check fails, fix the manifest before proceeding to Step 3.

## Example row (CSV)

The values below are placeholders showing the column shape. For a real filled example, see `_examples/ultimapeak-pdp/README.md` (which references the iteration's actual manifest).

```csv
figma_node_id,figma_hash,semantic_role,parent_section,parent_component,target_filename,notes
<frame-id>:<node-id>,<40-char-hex-hash>,hero benefit card icon (slot 1),Hero,HeroBenefitCards,benefit-icon-1.svg,(no notes)
```

## Duplicate asset detection

When Figma exports the same hash for multiple semantic roles (e.g. one product image reused across three bundle cards), the manifest has multiple rows with the same `figma_hash` and different `semantic_role` values.

**Surface this as a content-review flag to the operator. Do not silently deduplicate.** The decision to use the same image for three bundles is the designer's call; the skill flags it so the operator can confirm with the designer or override with distinct images. This is Bug 4 prevention.

Example flag output:

```
WARNING: figma_hash <hex-hash> appears in 3 semantic roles:
  - bundle card 1 product thumbnail
  - bundle card 2 product thumbnail
  - bundle card 3 product thumbnail
Confirm with the designer whether all three bundles should display the same image, or request 2 additional unique assets.
```

## How the manifest flows through the pipeline

1. **Extraction step.** The operator runs `Figma:get_metadata` and `Figma:get_design_context` for each section node ID. As each asset hash appears, the operator adds a row to the manifest with the semantic role inferred from the surrounding JSX context.

2. **Attach-to-the-Lovable-prompt step.** The operator exports each asset from Figma as its `target_filename` and attaches the exported files directly to the Lovable prompt (up to 10 per prompt; follow-up prompts attach the remainder). The manifest validation contract above is checked before exporting.

3. **Intent-spec generation step.** When the intent-spec template references an asset, the operator looks up the `target_filename` in the manifest (by semantic role) rather than typing it from memory. Asset references in the spec are always pulled from the manifest.

4. **Fix-up step.** If a Lovable fix-up prompt needs to correct an asset assignment, the operator re-reads the manifest to verify the correct mapping. The fix-up prompt cites the manifest row, not a remembered name.

## Manifest file naming

Commit the manifest at `_brands/<brand>/figma-to-lovable/<page-slug>/asset-manifest.csv` (or wherever the brand's assets directory lives in the operator's working repo). The manifest is part of the page's iteration history.

## Do NOT put example brand data in this template

This template lives in the skill itself. Concrete brand-specific manifest rows (real hashes, real exported filenames, real semantic-role descriptions tied to a specific brand) belong in `_examples/<example-name>/`, not in this file. If you find yourself writing a real brand's hash or filename here, move it to an example directory.
