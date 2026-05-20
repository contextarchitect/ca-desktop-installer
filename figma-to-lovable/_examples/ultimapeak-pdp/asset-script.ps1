# =============================================================================
# UltimaPeak PDP asset upload script - example run
# -----------------------------------------------------------------------------
# This file is the parameterized configuration used for the UltimaPeak PDP
# Mode 1 iteration. It is included here as an example of how the operator
# invokes the generic _reference/asset-upload-script-template.ps1.
#
# The original operator-run script lived in the operator's local working
# environment (outside this repo). This file is a faithful reconstruction
# showing the hardcoded UltimaPeak config, suitable as a reference for
# operators building the next PDP.
#
# For the parameterized template that this is a specialization of, see:
#   _skills/figma-to-lovable/_reference/asset-upload-script-template.ps1
#
# To run the actual generic template against a NEW brand, do NOT copy this
# example file. Instead, run the template directly with the new brand's
# parameters. This example exists only to show what a real run looked like.
# =============================================================================

# Hardcoded UltimaPeak config (kept as example reference)
$ManifestPath        = "C:\Users\<operator>\figma-to-lovable\ultimapeak\asset-manifest.csv"
$SupabaseUrl         = "https://hlvekxlxsocivhigggzc.supabase.co"
$SupabaseBucket      = "brand-assets"
$SupabasePath        = "ultimapeak/pdp-rebranded-competitors"
$AnonKey             = "<redacted - operator's Supabase upload key>"
$FigmaLocalhostBase  = "http://localhost:3845"
$WorkDir             = Join-Path $env:TEMP "figma-assets-ultimapeak"

# The actual script body is identical to:
#   _skills/figma-to-lovable/_reference/asset-upload-script-template.ps1
#
# This file documents the parameterization. To run the upload, the operator
# either:
#
#   (a) calls the template directly:
#       .\asset-upload-script-template.ps1 `
#           -ManifestPath $ManifestPath `
#           -SupabaseUrl $SupabaseUrl `
#           -SupabaseBucket $SupabaseBucket `
#           -SupabasePath $SupabasePath `
#           -AnonKey $AnonKey `
#           -FigmaLocalhostBase $FigmaLocalhostBase `
#           -WorkDir $WorkDir
#
#   (b) or copy the template body inline below these variables, replacing
#       the param block with explicit assignments. The second approach was
#       used in the UltimaPeak iteration so all hardcoded values lived in
#       one file.

# -----------------------------------------------------------------------------
# Iteration notes (for next operator running Mode 1)
# -----------------------------------------------------------------------------
#
# Round 1: ran the script. ImageMagick path was hardcoded to a specific
# install location. The operator's machine had a different ImageMagick
# version installed. Script aborted before uploading any assets. This is
# Bug 6 in _tests/figma-to-lovable-mode-1-findings.md.
#
# Round 2 fix: switched from hardcoded magick.exe path to `Test-CommandAvailable`
# detection. ImageMagick optimization became an enhancement stage that
# degrades gracefully (skips with warning) if `magick` is not on PATH.
# Required stages (download, upload) remained blocking.
#
# Round 3: the `immediate-difference.webp` asset was missing from the manifest.
# The Lovable iteration's fix-up Round 2 sent a fallback URL list to try, and
# Round 3 included an explicit asset-script update to upload the file under
# the correct name. See:
#   _skills/figma-to-lovable/_examples/ultimapeak-pdp/fix-up-prompts/
#     round-3-prescriptive-plus-asset.md
#
# Lesson: an asset present in the spec but not in the upload manifest will
# cause a 404 in the rendered Lovable preview. The manifest is the
# source-of-truth gate before paste (Bug 8 prevention).
