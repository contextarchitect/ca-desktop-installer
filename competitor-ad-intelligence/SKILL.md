---
name: competitor-ad-intelligence
version: "0.2.0"
description: "Automate competitor ad research end to end. Given one or more competitors, retrieve their top-performing Meta ads ranked by reach via the TrendTrack MCP, tag and group them against the ContextArchitect creative taxonomy (ad-analysis-tagger dimensions, ad-style-generator style catalogue, video-script-generator format set), and generate concept transpositions, not duplicates, of those winners rebuilt in a target brand's own identity: static images via the Kie image path (nano-banana-prompting by default, gpt-image-2-prompting on request), and video as scripts via video-script-generator (script only, no video rendered). Trigger on: competitor ad research, analyze competitor ads, what is [competitor] running, pull [competitor] winning ads, competitor creative teardown, swipe [competitor], tag [competitor] ads, what ads is [competitor] scaling. This is the Claude Desktop prototype of the Creative Engine (CE) Phase F competitor-intelligence feature; it runs manually in Desktop where the TrendTrack, Meta Ads, and Kie MCPs are connected."
---

# Competitor Ad Intelligence Skill

## Purpose

Turn a list of competitors into a structured, taxonomy-tagged teardown of their winning Meta ads, plus on-request concept transpositions of those winners rebuilt in the target brand's own identity. This is the manual, Desktop-run prototype of CE Phase F competitor intelligence. It exists to make competitor research repeatable and comparable instead of ad-hoc: pull what is actually scaling, explain why it works against the ContextArchitect taxonomy, and hand back transpositions the operator can ship.

This skill runs in Claude Desktop, where the TrendTrack MCP, the Meta Ads MCP, and the Kie image MCP are connected. It does not run those calls during authoring; the names below are the live tool names to invoke at runtime in Desktop.

## When to Use

- The operator names one or more competitors and wants to know what they are running.
- The operator wants the competitor's top ads ranked by reach, not a raw unranked dump.
- The operator wants competitor ads tagged and grouped against the ContextArchitect creative taxonomy.
- The operator wants concept transpositions of competitor winners rebuilt in a target brand's identity: statics rendered via Kie, video as scripts.
- Triggers: "competitor ad research", "analyze competitor ads", "what is [competitor] running", "pull [competitor] winning ads", "competitor creative teardown", "swipe [competitor]", "tag [competitor] ads".

## When NOT to Use

- For tagging a single ad the operator already has in hand, with no retrieval step: use `../ad-analysis-tagger/SKILL.md` directly.
- For generating fresh creative off the brand's own angle cards, with no competitor input: use `../ad-style-generator/SKILL.md` (statics) or `../video-script-generator/SKILL.md` (video).
- For rendering a finished video: out of scope. The video lane produces a script only.

## Runtime layers

This skill composes three layers. Keep them distinct when reasoning about a run.

1. **Data (retrieval, ranking, assets, transcripts, tracker seeding).** The TrendTrack MCP (Pro plan, read and write scopes including `brandtrackers.write`, all confirmed live) is the primary source. The Meta Ads MCP `ads_library_search` is a free, page-id-scoped enumeration fallback that returns ad ids and snapshot URLs only (no reach, no ranking, no asset processing). Use TrendTrack as the default path; reach for `ads_library_search` only when TrendTrack cannot resolve or enumerate a competitor.
2. **Analysis (tagging and bucketing).** Claude reasoning plus Claude vision (vision reads competitor static images directly), routed through `../ad-analysis-tagger/SKILL.md` for the six-dimension breakdown, the `../ad-style-generator/references/style-catalogue.md` style catalogue for visual style assignment, and the `../video-script-generator/SKILL.md` format set for video format matching.
3. **Generation (concept transpositions, on request).** Generation transposes the competitor's concept into the target brand's identity; it never duplicates the source ad. See the Generation method section below for the binding principle, the mandatory brand-kit step, and the per-lane pipelines. Statics: front the work with `../ad-analysis-tagger/SKILL.md` to extract the concept, then route through `../ad-style-generator/SKILL.md` to a `../nano-banana-prompting/SKILL.md` prompt (default) or a `../gpt-image-2-prompting/SKILL.md` prompt, rendered image-to-image on the real target product via the Kie MCP (`nano_banana_image` or `gpt_image_2_image`). Video: `../video-script-generator/SKILL.md` produces a concept-transposed script only. No video is rendered.

## Generation method: transpose the concept, do not duplicate (both lanes)

This section governs every generation step in both lanes. Read it before running any image or video generation.

**Principle.** Generation transposes the concept, it does not duplicate the ad. Keep what makes the original work (its structure and its single most distinctive device). Strip the source brand's identity entirely (its palette, fonts, product form, and naming). Rebuild the concept in the target brand's own identity, using the target brand's real product. A faithful copy of a competitor ad is a failure, not a success.

**Brand resolution (the skill is brand-agnostic).** The target brand is a parameter; resolve everything from it, never from a fixed brand or path. Two repos hold the brand inputs, keyed by the same `<brand-slug>`:

- Brand documents resolve under `contextarchitect/context-architect-brands/<brand-slug>/` (the brand-kit files below).
- Brand assets (product images and logos) resolve under `contextarchitect/brand-assets/<brand-slug>/`, which is where the public image URLs used for `image_input` live.

Resolve `<brand-slug>` by matching the operator's named brand to the folder that exists in the brand-docs repo, not by assuming a fixed string or a slug format; slugs vary between brands (for example, the brand named "Regrowth+" resolves to the folder `regrowth`, shown here only as an illustration, not a default). If no folder matches, stop and ask the operator which brand folder to use.

**Brand-kit loading (pre-generation step).** Load the target brand's kit from `context-architect-brands/<brand-slug>/`. These are runtime brand inputs loaded from that folder, not skill-relative cross-references. The three files are referenced by role with canonical names:

- `brand-guidelines.md` (palette, fonts): required for any visual generation.
- `copywriting-guide.md` (voice, compliance): required for any generation that produces copy or a script. This is the target brand's file under `<brand-slug>/`, distinct from the `_skills/copywriting-guide/` skill.
- `image-reference-index.md` (product image REF and public URLs): required, and a hard stop, ONLY when a visual will actually be rendered, that is a static image or a video with a rendered first frame. Honor the NO-VERBAL-ONLY-PRODUCT-GENERATION rule for those visual renders; if the REF URL is missing or errors, stop and inform the operator.

Allow filename variance: if a canonical name is not present in the brand folder, list the folder and resolve the file by its role rather than hard-failing. Stop and ask the operator only if a required file genuinely cannot be found by role. A script-only video brief or script needs the product facts and the brand voice, but does not hard-stop on the product image REF.

## Inputs the skill collects

Collect these before running. Prompt for any that are missing.

- **Competitors:** one or more, each given as a brand name, a domain, or a Meta page id.
- **Lane:** statics, video, or both. Default both.
- **Count per competitor:** how many winners per lane. Default 5 to 10 winners per lane.
- **Target brand:** the brand the transpositions are for. Required for the generation step so statics and scripts use the right brand voice, avatar, and product reference. If no generation is requested, target brand is optional.

## Step A: Resolve the competitor (mandatory first step, both lanes)

Call TrendTrack `lookup` with the competitor identifier (brand name, domain, or page id). Carry forward the canonical `facebookPageId`, the `domain`, and the `brandtracker_id` if the competitor is already tracked. This call costs zero credits and is the anchor for de-pollution in every later step.

Never start retrieval from a brand-name search without resolving first. Brand-name search is polluted by similarly named advertisers, and the resolved identity (page id plus domain) is the only reliable filter against that pollution.

## Step B: Statics lane

1. **Retrieve.** Call `search_ads` with `searchType` brand, the competitor name, `mediaType` image, `sortBy` reach, `status` all, and `limit` over-fetched to roughly 12 to 15 (so de-pollution still leaves enough survivors to rank). Over-fetch enough to absorb both off-brand pollution and creative-level duplicates (the same creative running under multiple ad ids), so the surviving distinct-creative count still reaches N.
2. **De-pollute (hard rule).** Drop every returned row whose advertiser identity or landing-page domain does not match the resolved competitor from Step A. This uses only data already in the `search_ads` response; it costs nothing extra. Rationale: a live Nutrafol search returned the real hair brand plus several ads from an unrelated dropshipper with a similar name, so brand-name search must always be filtered against the resolved identity before ranking.
3. **Dedupe by creative, then rank.** After de-pollution and before ranking and output, dedupe or visibly group the survivors by creative asset id, so the top N winners are N distinct creatives, not the same creative under multiple ad ids. Then rank the distinct creatives by reach and take the top N (the requested count). Rationale: the trial's reach-ranked top 3 contained the same creative twice. While ranking, detect when a winning static is a carousel cover (a numbered listicle opener, a view-profile style CTA); flag it (carried into the output deliverable) and note that the downstream carousel cards are not retrieved by this skill.
4. **Scan each survivor.** For each ad in the top N, call `scan_ad` with the Meta Ad Library URL or the ad id. Capture the image asset URL on `medias.trendtrack.io`, the reach, the days running, and the scaling verdict.
5. **Tag and bucket.** Get the actual image into vision before tagging. `scan_ad` returns an image asset URL, not a viewable image, and vision cannot read a bare URL. In Desktop, instruct the operator to open or download the asset URL and provide the image back, then tag from the provided image. Never assign visual tags from a URL alone. (Creative Engine will fetch the asset server-side later, closing this loop automatically.) With the image in hand, tag the ad via `../ad-analysis-tagger/SKILL.md` across its six dimensions. Assign a visual style by matching against the `../ad-style-generator/references/style-catalogue.md` style catalogue. For each ad, flag whether it fits an existing style bucket or is a candidate new style, with a one-line rationale.
6. **Generate (on request): the concept-transposition pipeline.** Generation is opt-in per run, not automatic. Follow the Generation method section above (transpose, do not duplicate; load the brand kit first), then run these six moves in order:
   1. Load the target brand kit (palette, fonts, product reference, voice) per the brand-kit step above.
   2. Analyze the original with `../ad-analysis-tagger/SKILL.md`. Extract the transposable concept and isolate the single most distinctive device, the element that actually makes the ad work.
   3. Strip the source brand's identity: palette, fonts, product form, naming, and any competitor wording.
   4. Device-analog preservation. If the distinctive device depends on the source product's physical form, find the target product's honest analog rather than copying the form or dropping the device. Worked example: a competitor supplement ad whose device was cracking a capsule to expose the powder transposes to a shampoo brand as the formula pouring and swirling from the intact bottle.
   5. Write the target-brand headline and any on-image copy now, in the target brand's voice through its `copywriting-guide.md` (the target brand's file under `<brand-slug>/`, not the `_skills/copywriting-guide/` skill), passing the relevant compliance check (for GCC brands, GCC compliance). This happens before prompt construction.
   6. Render image-to-image via `../nano-banana-prompting/SKILL.md` and the Kie path. Build the prompt with the real product as `image_input` (public URL from `image-reference-index.md`), the target palette and fonts, and only the move-5 target copy, with an explicit instruction not to reuse any competitor wording. (Use `../ad-style-generator/SKILL.md` to shape the brief, and `../gpt-image-2-prompting/SKILL.md` as the alternate prompt format on request.)

   Output the transposed image plus the exact prompt used, and the three-part transposition (kept, stripped, applied) for the deliverable.

## Step C: Video lane

### Pre-write safety: capacity preflight and conditional confirmation

The video lane is the only lane that writes to TrendTrack, because it seeds trackers. Before any add_to_brandtracker call, run this preflight every time, without exception:

1. Call list_tracked_brands. Read the current tracked total, and split the run's competitors into already-tracked (re-adding is a zero-credit idempotent no-op) and new (each consumes one of the 30 Pro slots when seeded).
2. Surface a seed plan in the run output before seeding: the new competitors that will be tracked, the already-tracked ones that will no-op, the resulting tracked total, and the remaining slots against the 30-slot cap. The run never seeds invisibly.
3. Conditional confirmation gate. Proceed without pausing only when both of these hold: the run is in the owner's own workspace, and the resulting tracked total stays at or below 25 of 30. Otherwise pause and require explicit operator confirmation before seeding, specifically when seeding would push the total above 25, or when operating in any workspace other than the owner's. Routine owner-workspace runs under the threshold stay hands-free; the gate exists only to prevent silent exhaustion of shared capacity and unintended writes in a client workspace.
4. Hard capacity invariant (absolute, checked before the confirmation gate, not confirmable). Before any add_to_brandtracker call, compute the current tracked total plus the count of distinct new competitors this run would seed. If that sum exceeds 30, the Pro cap, do not call add_to_brandtracker at all. Stop and report: the run would exceed the 30-slot cap, so the operator must either delete existing trackers to free slots, or reduce or split the competitor set to fit, then re-run. This is evaluated before the confirmation gate: an over-cap run aborts and is never offered the pause-and-confirm path. The pause above 25 is a clearable warning; exceeding 30 is never seeded, even with confirmation.
5. Partial-seed handling. Even with the invariant, a stale tracked count or an unrelated add failure can interrupt a multi-competitor seed mid-batch. On any add failure during seeding, stop seeding immediately and report the partial state: the trackers created this run by brandtracker_id, the competitors that failed and why, and the current slot count. Never report the run as successful on a partial seed. In ephemeral mode, delete the trackers created this run per the ephemeral cleanup rule. In persistent mode, retain them, since they are valid intended trackers, but surface the incomplete run so the operator can free slots and re-run for the remainder.

This preflight supersedes any wording elsewhere in this skill that suggests seeding is unconditionally automatic.

1. **Ensure tracked.** Run the pre-write safety preflight above first. If the resolved competitor is absent, call `add_to_brandtracker` with its `facebookPageId` or `domain`, then capture the returned `brandtracker_id`. Seeding is automated and hands-free for routine owner-workspace runs, but it is always subject to the capacity preflight (the seed plan is shown every time), the conditional confirmation gate, and the hard capacity invariant above (no seeding above 30, even with confirmation). (See the tracker lifecycle section for the persistent-vs-ephemeral default.)
2. **Pull transcripts.** Call `get_brandtracker_transcripts` for that `brandtracker_id`, with `sortBy` set to `totalImpressions`, `usageCount`, or `longestRunning`, and `time_period` starting at `last30d`, widened if the result is empty. `time_period` takes a fixed enum, never a day-count: `live`, `last24h`, `last3d`, `last7d`, `last30d`, `last3m`, `last6m`, `last1y`. A value like `last90d` is not in the enum and errors; widen by stepping to `last3m`, `last6m`, or `last1y` instead. The grouped usage-count and longest-running fields are themselves the video winner signal: a transcript reused across many ads or running a long time is a proven script.
3. **Capture the `.mp4` assets.** For each top transcript, call `scan_ad` on the sample ad to capture the `.mp4` asset URL and the reach magnitude. The transcript tool gives the spoken words plus usage and longevity; `scan_ad` returns the `.mp4` URL and the reach number. Keying and the Gemini handoff follow the Gemini video handoff contract below; this step does not restate the mechanism. These `.mp4` link(s) feed both the deliverable and the standard Gemini visual pass.
4. **Build the brief: transcript brief plus a standard Gemini visual pass.** The transcript-based brief is the immediate output: from the transcript text plus its metadata, infer the opening hook (first line), the script structure and arc, the approximate pacing (from transcript length), and the awareness stage. The Gemini visual pass is a standard step, not optional; it is the visual-execution enrichment that the transcript cannot supply (in the trial it caught a format mis-tag and surfaced the on-screen-text, edit-rhythm, and compliance layer). Produce the visual brief via the Gemini video handoff contract below. The skill then tags the returned briefs via `../ad-analysis-tagger/SKILL.md` and match-and-flags them against the `../video-script-generator/SKILL.md` format set (fits an existing format, or candidate new format). The Gemini brief is source-side analysis only; the applied layer, mapping the concept onto a specific target brand, is produced by the generation pipeline once the target brand kit is loaded, not by this analysis pass.
5. **Generate (on request): concept-transposed script.** Follow the Generation method section above: load the target brand kit first (palette, fonts, product reference, voice); transpose the concept, do not duplicate; strip the source brand's identity and any competitor wording; and preserve the distinctive device via the target product's honest analog (the device-analog rule). With the kit loaded, write the target-brand script and any on-screen copy in the brand voice through its `copywriting-guide.md` before finalizing the generation handoff, and instruct not to reuse any competitor wording. `../video-script-generator/SKILL.md` then produces the script in the matched format, rebuilt in the target brand's voice and avatar, not a copy of the source ad. The product facts come from the brand's `image-reference-index.md`; the product image REF is a hard stop only if a first frame is actually rendered downstream in the video tools (a script-only output does not hard-stop on it, per the brand-kit gate). No video is rendered here. Output the script plus the format and hook rationale, and the three-part transposition (kept, stripped, applied). Generation is opt-in per run.

## Gemini video handoff contract (authoritative, single source of truth)

This is the only place in the skill that describes how `.mp4` assets are keyed and fed to Gemini; every other mention defers here. For each winning video, `scan_ad` returns the `.mp4` URL whose basename is the asset id. The lane persists a mapping table in the report: asset id to winner (ad id, reach, transcript group, source `.mp4` URL). The operator downloads each winning video keeping the `<asset_id>.mp4` filename (the URL basename already is the asset id), uploads those named files to Gemini with the batched, filename-keyed analysis prompt below, and each returned teardown keys back to its winner through the table by its `<asset_id>.mp4` heading. Fallback: if any video cannot be downloaded or its asset id cannot be determined, mark that winner's visual brief unavailable, proceed transcript-only for that winner, and flag the gap. Never attach a visual brief without a confirmed asset-id key. The Gemini pass operates on the uploaded named files, not on raw URLs. Creative Engine automates this same contract, keyed on the asset id.

Canonical Gemini prompt (keep it filename-keyed):

   ```
   You are analyzing N separate direct-response social video ads, attached as files
   (use each file's own filename, e.g. 123456.mp4). Analyze each video INDEPENDENTLY
   and completely. Do not blend them. Produce one full teardown per video, then a short
   cross-video synthesis at the end.

   For EACH video, output a section headed with that video's exact filename, then start
   with the exact opening spoken line, then return exactly this structure:

   1. Format and length: production format (UGC talking-head / voiceover-over-broll /
      podcast clip / animation / etc.) and total duration.
   2. Hook (first 3 seconds): the spoken line AND the visual (shot type, setting,
      on-screen text).
   3. Beat-by-beat structure: timestamped list of every beat. For each, note what is
      said and what is shown.
   4. On-screen text: transcribe every caption or overlay verbatim, with timestamps.
   5. Shot and edit rhythm: shot types, approximate cut frequency, overall pacing.
   6. Product moments: every moment the product appears, how it is shown, for how long.
   7. Talent and setting: who is on camera (creator type, not a name), wardrobe,
      location, lighting, vibe.
   8. Audio: voiceover vs sync sound, music presence and mood, sound effects.
   9. CTA: verbal CTA, any on-screen CTA, end-card treatment.
   10. Persuasion read: core emotion, awareness stage (problem / solution / product /
       most aware), and the single mechanism or claim it leans on.
   11. Transposition brief: 4 to 6 bullets using a kept and stripped split. KEEP only
       the transferable concept, structure, and device. STRIP the competitor's wording,
       brand identity, product form, talent, and execution-specific details. Flag
       anything that only works because of this specific product or talent. The applied
       layer, mapping onto a specific target brand, is produced later by the generation
       pipeline, not by this analysis pass.

   After all videos, add:
   === ACROSS ALL ===
   - The shared structure or formula they all follow
   - Common hook devices, mechanisms, and CTAs
   - What varies between them (angle, talent, offer, length)
   - The single most transposable pattern, the one most portable to another brand.

   Watch each video start to finish. Be specific and timestamped. If something is
   absent, write "none"; do not invent. Match each analysis to the correct file by its
   filename.
   ```

### Video depth caveat (state this in any video-lane report)

`scan_ad` does not transcribe video or analyze visual structure; its hook field is a caption fallback, not a spoken-word transcript. The transcript path (`get_brandtracker_transcripts`) is the source of truth for spoken content, and the transcript-based brief is inferred from that text plus metadata. The transcript alone carries talking-head, UGC, yap, voiceover, and podcast formats, which is why the transcript brief is the immediate output. The visual layer (on-screen text, edit rhythm, shot grammar, compliance cues, and the true format) comes from the Gemini pass per the Gemini video handoff contract above. That pass matters for every format and is essential for animation or heavy-edit formats, where the visual structure carries the ad.

## Tracker lifecycle

The video lane seeds a brandtracker slot per competitor. The Pro plan has 30 slots. Choose a mode per run; persistent is the default.

- **Persistent (default).** Leave competitors tracked between runs. Transcripts stay warm, repeat runs skip the seed step, and ongoing brand-change monitoring stays available. Cost: one of the 30 Pro slots per competitor, held until released. Re-running on the same competitors is a zero-credit idempotent no-op, so repeat runs do not accrete slots; only distinct new competitors consume additional slots over time. No cleanup is needed by design.
- **Ephemeral (opt-in).** Seed, pull, then call `delete_from_brandtracker` (with the `brandtracker_id` and `confirm` true) in the same run to release the slot. Note that delete is a soft detach: it deactivates the workspace link but preserves TrendTrack's global brand row, so re-adding the same competitor later is cheap. Use ephemeral only when churning through many one-off competitors against the 30-slot cap. On any failure after a successful add_to_brandtracker and before the in-run delete, the run must delete the trackers it created in this run, or if deletion also fails, report them by brandtracker_id as orphaned trackers needing manual removal, so no seeded slot is left behind silently.

## Output deliverable

Produce a single structured report per run, persisted as markdown. Per competitor, include:

1. **Ranked winner list.** For each winner: ad link, media type, reach, days running, scaling verdict, plus the image (statics) or the transcript brief, the `.mp4` link(s), and the Gemini brief (video). Label any winner that is a carousel cover as a carousel, and note that its downstream cards were not retrieved.
2. **Tagged breakdown.** The `ad-analysis-tagger` six-dimension breakdown per ad, with the assigned style or format bucket, or the candidate-new-bucket flag and its one-line rationale.
3. **Gap summary.** A short read of which existing buckets the competitor leans on, and any new buckets flagged across their set.
4. **Transpositions (on request).** For each generated winner, show three explicit parts: the **concept** (the transposable idea), the single **distinctive device** that makes it work, and the **transposition** broken out as kept (what carried over), stripped (the source brand identity removed), and applied (the target brand identity and product rebuilt in). Include the generated statics with their exact prompts, and the generated video scripts with their format and hook rationale.

## Notes for future optimization (do not block on these)

These are recorded as notes, not runtime requirements. They cannot be verified during authoring because the TrendTrack MCP is connected in Desktop, not in the authoring environment.

- If `search_ads` with `tracked_pages` set to the resolved page id proves, in practice, to return clean single-competitor results, prefer it over the over-fetch-and-filter path in Step B. It would remove the de-pollution step entirely.
- A brandtracker-scoped retrieval tool such as `analyze_tracked_brand` may give a cleaner per-competitor winner list than brand-name `search_ads`. Worth testing against the Step B path once the tracker is seeded.

## Cross-skill references

- `../ad-analysis-tagger/SKILL.md` (six-dimension tagging)
- `../ad-style-generator/SKILL.md` and `../ad-style-generator/references/style-catalogue.md` (visual style bucketing and static brief generation)
- `../video-script-generator/SKILL.md` (video format set and concept-transposed scripts)
- `../nano-banana-prompting/SKILL.md` (default static prompt format)
- `../gpt-image-2-prompting/SKILL.md` (alternate static prompt format)
