# Asset manifest template

The asset manifest is the ground-truth mapping from Figma asset hash to (semantic role in the page, target filename, target URL). It is authored at Figma extraction time and read by the intent-spec generator and the asset upload script.

**Never reconstruct this manifest from memory between iterations.** When the skill author rebuilds an asset mapping from context rather than from the manifest file, the mappings get reversed (Bug 8 in `_tests/figma-to-lovable-mode-1-findings.md`). The test-pass iteration spent two fix-up rounds chasing a reversed icon-asset mapping that would have been caught immediately by reading the manifest. See `_examples/ultimapeak-pdp/README.md` for the concrete history of that bug.

## Format

The manifest is a CSV file committed to the brand's asset directory. JSON is acceptable if the operator prefers it, but CSV is recommended because it opens cleanly in any spreadsheet tool and diffs cleanly in git.

### Required columns (preflight will hard-fail on any blank)

| Column | Purpose | Example |
|---|---|---|
| `figma_hash` | The asset hash as exported by `Figma:get_design_context` | `<40-char-hex-hash>` |
| `semantic_role` | Human-readable description of what this asset is in the design | `<section> <component> <element-purpose>` |
| `target_filename` | The leaf filename used when uploading to Supabase (no path separators, no `..`, alphanumeric + `._-` only) | `<role>-<n>.<ext>` |
| `target_url` | The full public Supabase URL where the asset will live. **REQUIRED**: preflight asserts this equals the computed URL `https://<project>.supabase.co/storage/v1/object/public/<bucket>/<path>/<target_filename>`. Blank or mismatched values hard-fail. | `https://<project>.supabase.co/storage/v1/object/public/<bucket>/<path>/<role>-<n>.<ext>` |
| `extension` | File extension (lowercase, no dot). Must equal `target_filename`'s suffix (after the last dot), lowercased. | `svg` |

### Recommended columns (preflight warns if blank)

| Column | Purpose | Example |
|---|---|---|
| `figma_node_id` | The Figma node ID where this asset is referenced (used to trace back to source) | `<frame-id>:<node-id>` |
| `parent_section` | The page section this asset belongs to | `<section-name>` |
| `parent_component` | The component or sub-block within the section | `<component-name>` |

### Optional columns (default behavior applies if blank or missing)

| Column | Purpose | Default if blank | Example |
|---|---|---|---|
| `optimize` | Whether to run the ImageMagick raster optimization stage on this row. SVG rows ignore this column. For raster rows, `true` runs `magick -strip -quality 85`, `false` uploads the original. | `false` (no optimization; the asset uploads as downloaded from Figma) | `false` |
| `notes` | Free-form notes from the operator (duplicate flag, designer note, etc.) | `(no notes)` | `Designer reused this image across bundles 1, 2, 3` |
| `aspect_ratio` | Native aspect ratio (when known, helps with placeholder boxes) | `(unknown)` | `5:1` |

## Validation contract

The asset upload script (`_reference/asset-upload-script-template.ps1`) runs a single `Test-ManifestPreflight` pass over the full manifest BEFORE any download or upload. The preflight hard-fails (exit 1) on any of these. Per-row stages run only after every row passes.

| Check | Rule | Why |
|---|---|---|
| **A. Schema completeness** | Every row has non-blank values in `figma_hash`, `semantic_role`, `target_filename`, `target_url`, `extension`. | Prevents silent uploads of incomplete rows. Round 2 finding: target_url was previously allowed to be absent or blank and the script just warned and proceeded. |
| **B. target_filename safety** | No `/`, `\`, or `..`. No leading `/` or `<drive>:`. Matches `^[A-Za-z0-9._-]+$` (leaf filename only). | Round 2 NEW-class finding: `target_filename` is joined directly into `WorkDir` for `Invoke-WebRequest -OutFile` and `Move-Item -Force`. A malformed value with path separators or parent traversal can write outside the work directory before upload validation. |
| **C. target_filename uniqueness** | No two rows share a `target_filename` (case-insensitive comparison). | Round 2 NEW-class finding: the script uploads with `x-upsert=true`. Two rows with the same `target_filename` (distinct `figma_hash` values) would upload sequentially and the last one wins, leaving multiple manifest roles pointing at one overwritten asset. |
| **D. extension-vs-suffix consistency** | For every row, lowercase `extension` column equals lowercase suffix of `target_filename` (everything after the last `.`). | Round 2 SAME-class finding (Bug 6): the WebP guard was previously keyed on the `extension` column while the comment claimed it was keyed on the target_filename suffix. They can diverge. Asserting equality at preflight makes them interchangeable downstream. |
| **E. target_url consistency** | For every row, `target_url` equals the computed `https://<SupabaseUrl>/storage/v1/object/public/<SupabaseBucket>/<SupabasePath>/<target_filename>`. Blank or absent target_url hard-fails (covered by check A). | Round 2 SAME-class finding (Bug 8): a stale or mistyped target_url that survives upload reintroduces the broken-mapping class via the intent-spec generation step. |
| **F. Duplicate figma_hash detection** | Same `figma_hash` in multiple rows triggers a WARN listing every semantic_role involved. Not fatal. | Bug 4 prevention: duplicate hashes are typically intentional content reuse (one image across multiple bundles). The preflight surfaces them so the operator can confirm with the designer or replace with distinct assets. Surface, do not silent-dedupe. |

If any preflight check fails, the script exits with no downloads or uploads attempted. The operator fixes the manifest and re-runs from Step 3 of `_reference/operator-workflow.md`.

## Example row (CSV)

The values below are placeholders showing the column shape. For a real filled example, see `_examples/ultimapeak-pdp/README.md` (which references the iteration's actual manifest).

```csv
figma_node_id,figma_hash,semantic_role,parent_section,parent_component,target_filename,target_url,extension,optimize
<frame-id>:<node-id>,<40-char-hex-hash>,hero benefit card icon (slot 1),Hero,HeroBenefitCards,benefit-icon-1.svg,https://<project>.supabase.co/storage/v1/object/public/<bucket>/<brand>/<page>/benefit-icon-1.svg,svg,false
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

2. **Upload step.** The asset upload script (`_reference/asset-upload-script-template.ps1`) reads the manifest, runs `Test-ManifestPreflight` over every row (validation contract above), then downloads each asset from Figma localhost and uploads to Supabase under `target_filename`. Preflight failures abort before any download or upload.

3. **Intent-spec generation step.** When the intent-spec template references an asset, the operator looks up the `target_url` in the manifest (by semantic role) rather than typing it from memory. Asset references in the spec are always pulled from the manifest.

4. **Fix-up step.** If a Lovable fix-up prompt needs to correct an asset assignment, the operator re-reads the manifest to verify the correct mapping. The fix-up prompt cites the manifest row, not a remembered name.

## Manifest file naming

Commit the manifest at `_brands/<brand>/figma-to-lovable/<page-slug>/asset-manifest.csv` (or wherever the brand's assets directory lives in the operator's working repo). The manifest is part of the page's iteration history.

## Do NOT put example brand data in this template

This template lives in the skill itself. Concrete brand-specific manifest rows (real hashes, real Supabase project IDs, real semantic-role descriptions tied to a specific brand) belong in `_examples/<example-name>/`, not in this file. If you find yourself writing a real brand's hash or filename here, move it to an example directory.
