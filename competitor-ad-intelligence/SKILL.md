---
name: competitor-ad-intelligence
version: "0.1.0"
description: "Automate competitor ad research end to end. Given one or more competitors, retrieve their top-performing Meta ads ranked by reach via the TrendTrack MCP, tag and group them against the ContextArchitect creative taxonomy (ad-analysis-tagger dimensions, ad-style-generator style catalogue, video-script-generator format set), and generate replicas: static images via the Kie image path (nano-banana-prompting by default, gpt-image-2-prompting on request), and video as scripts via video-script-generator (script only, no video rendered). Trigger on: competitor ad research, analyze competitor ads, what is [competitor] running, pull [competitor] winning ads, competitor creative teardown, swipe [competitor], tag [competitor] ads, what ads is [competitor] scaling. This is the Claude Desktop prototype of the Creative Engine (CE) Phase F competitor-intelligence feature; it runs manually in Desktop where the TrendTrack, Meta Ads, and Kie MCPs are connected."
---

# Competitor Ad Intelligence Skill

## Purpose

Turn a list of competitors into a structured, taxonomy-tagged teardown of their winning Meta ads, plus on-request replicas in the target brand's voice. This is the manual, Desktop-run prototype of CE Phase F competitor intelligence. It exists to make competitor research repeatable and comparable instead of ad-hoc: pull what is actually scaling, explain why it works against the ContextArchitect taxonomy, and hand back replicas the operator can ship.

This skill runs in Claude Desktop, where the TrendTrack MCP, the Meta Ads MCP, and the Kie image MCP are connected. It does not run those calls during authoring; the names below are the live tool names to invoke at runtime in Desktop.

## When to Use

- The operator names one or more competitors and wants to know what they are running.
- The operator wants the competitor's top ads ranked by reach, not a raw unranked dump.
- The operator wants competitor ads tagged and grouped against the ContextArchitect creative taxonomy.
- The operator wants replicas of competitor winners: statics rendered via Kie, video as scripts.
- Triggers: "competitor ad research", "analyze competitor ads", "what is [competitor] running", "pull [competitor] winning ads", "competitor creative teardown", "swipe [competitor]", "tag [competitor] ads".

## When NOT to Use

- For tagging a single ad the operator already has in hand, with no retrieval step: use `../ad-analysis-tagger/SKILL.md` directly.
- For generating fresh creative off the brand's own angle cards, with no competitor input: use `../ad-style-generator/SKILL.md` (statics) or `../video-script-generator/SKILL.md` (video).
- For rendering a finished video: out of scope. The video lane produces a script only.

## Runtime layers

This skill composes three layers. Keep them distinct when reasoning about a run.

1. **Data (retrieval, ranking, assets, transcripts, tracker seeding).** The TrendTrack MCP (Pro plan, read and write scopes including `brandtrackers.write`, all confirmed live) is the primary source. The Meta Ads MCP `ads_library_search` is a free, page-id-scoped enumeration fallback that returns ad ids and snapshot URLs only (no reach, no ranking, no asset processing). Use TrendTrack as the default path; reach for `ads_library_search` only when TrendTrack cannot resolve or enumerate a competitor.
2. **Analysis (tagging and bucketing).** Claude reasoning plus Claude vision (vision reads competitor static images directly), routed through `../ad-analysis-tagger/SKILL.md` for the six-dimension breakdown, the `../ad-style-generator/references/style-catalogue.md` style catalogue for visual style assignment, and the `../video-script-generator/SKILL.md` format set for video format matching.
3. **Generation (replicas, on request).** Statics: route the winning pattern through `../ad-style-generator/SKILL.md` to produce a `../nano-banana-prompting/SKILL.md` prompt (default) or a `../gpt-image-2-prompting/SKILL.md` prompt, then render with the Kie MCP (`nano_banana_image` or `gpt_image_2_image`). Video: `../video-script-generator/SKILL.md` produces a replica script only. No video is rendered.

## Inputs the skill collects

Collect these before running. Prompt for any that are missing.

- **Competitors:** one or more, each given as a brand name, a domain, or a Meta page id.
- **Lane:** statics, video, or both. Default both.
- **Count per competitor:** how many winners per lane. Default 5 to 10 winners per lane.
- **Target brand:** the brand the replicas are for. Required for the generation step so statics and scripts use the right brand voice and avatar. If no generation is requested, target brand is optional.

## Step A: Resolve the competitor (mandatory first step, both lanes)

Call TrendTrack `lookup` with the competitor identifier (brand name, domain, or page id). Carry forward the canonical `facebookPageId`, the `domain`, and the `brandtracker_id` if the competitor is already tracked. This call costs zero credits and is the anchor for de-pollution in every later step.

Never start retrieval from a brand-name search without resolving first. Brand-name search is polluted by similarly named advertisers, and the resolved identity (page id plus domain) is the only reliable filter against that pollution.

## Step B: Statics lane

1. **Retrieve.** Call `search_ads` with `searchType` brand, the competitor name, `mediaType` image, `sortBy` reach, `status` all, and `limit` over-fetched to roughly 12 to 15 (so de-pollution still leaves enough survivors to rank).
2. **De-pollute (hard rule).** Drop every returned row whose advertiser identity or landing-page domain does not match the resolved competitor from Step A. Then rank the survivors by reach and take the top N (the requested count). This uses only data already in the `search_ads` response; it costs nothing extra. Rationale: a live Nutrafol search returned the real hair brand plus several ads from an unrelated dropshipper with a similar name, so brand-name search must always be filtered against the resolved identity before ranking.
3. **Scan each survivor.** For each ad in the top N, call `scan_ad` with the Meta Ad Library URL or the ad id. Capture the image asset URL on `medias.trendtrack.io`, the reach, the days running, and the scaling verdict.
4. **Tag and bucket.** Claude vision reads each image directly. Tag the ad via `../ad-analysis-tagger/SKILL.md` across its six dimensions. Assign a visual style by matching against the `../ad-style-generator/references/style-catalogue.md` style catalogue. For each ad, flag whether it fits an existing style bucket or is a candidate new style, with a one-line rationale.
5. **Generate (on request).** Route the winning pattern through `../ad-style-generator/SKILL.md` to a Nano Banana prompt (default) or a GPT Image 2 prompt, render via the Kie MCP, and output the replica image plus the exact prompt used. Generation is opt-in per run, not automatic.

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
2. **Pull transcripts.** Call `get_brandtracker_transcripts` for that `brandtracker_id`, with `sortBy` set to `totalImpressions`, `usageCount`, or `longestRunning`, and `time_period` starting at `last30d`, widened if the result is empty. The grouped usage-count and longest-running fields are themselves the video winner signal: a transcript reused across many ads or running a long time is a proven script.
3. **Capture assets (optional).** For each top transcript, optionally call `scan_ad` on the sample ad to capture the `.mp4` asset URL and the reach magnitude. The transcript tool gives the spoken words plus usage and longevity; `scan_ad` gives the asset URL and the reach number.
4. **Build the structural brief.** From the transcript text plus its metadata, infer: the opening hook (first line), the script structure and arc, the approximate pacing (from transcript length), and the awareness stage. Tag the brief via `../ad-analysis-tagger/SKILL.md`. Match it against the `../video-script-generator/SKILL.md` format set and flag whether it fits an existing format or is a candidate new format.
5. **Generate (on request).** `../video-script-generator/SKILL.md` produces a replica script in the matched format, adapted to the target brand's voice and avatar. No video is rendered. Output the script plus the format and hook rationale. Generation is opt-in per run.

### Video depth caveat (state this in any video-lane report)

`scan_ad` does not transcribe video or analyze visual structure; its hook field is a caption fallback, not a spoken-word transcript. The transcript path (`get_brandtracker_transcripts`) is the source of truth for spoken content, and the structural brief is inferred from that text plus metadata. This is sufficient for talking-head, UGC, yap, voiceover, and podcast formats, which are carried by their spoken script. For animation or heavy-edit formats, where the visual structure carries the ad, the `.mp4` asset URL is the handoff point to a future Gemini video-analysis step, which is out of scope for this Desktop trial.

## Tracker lifecycle

The video lane seeds a brandtracker slot per competitor. The Pro plan has 30 slots. Choose a mode per run; persistent is the default.

- **Persistent (default).** Leave competitors tracked between runs. Transcripts stay warm, repeat runs skip the seed step, and ongoing brand-change monitoring stays available. Cost: one of the 30 Pro slots per competitor, held until released. Re-running on the same competitors is a zero-credit idempotent no-op, so repeat runs do not accrete slots; only distinct new competitors consume additional slots over time. No cleanup is needed by design.
- **Ephemeral (opt-in).** Seed, pull, then call `delete_from_brandtracker` (with the `brandtracker_id` and `confirm` true) in the same run to release the slot. Note that delete is a soft detach: it deactivates the workspace link but preserves TrendTrack's global brand row, so re-adding the same competitor later is cheap. Use ephemeral only when churning through many one-off competitors against the 30-slot cap. On any failure after a successful add_to_brandtracker and before the in-run delete, the run must delete the trackers it created in this run, or if deletion also fails, report them by brandtracker_id as orphaned trackers needing manual removal, so no seeded slot is left behind silently.

## Output deliverable

Produce a single structured report per run. Per competitor, include:

1. **Ranked winner list.** For each winner: ad link, media type, reach, days running, scaling verdict, plus the image (statics) or the transcript and structural brief (video).
2. **Tagged breakdown.** The `ad-analysis-tagger` six-dimension breakdown per ad, with the assigned style or format bucket, or the candidate-new-bucket flag and its one-line rationale.
3. **Gap summary.** A short read of which existing buckets the competitor leans on, and any new buckets flagged across their set.
4. **Replicas (on request).** The generated statics with their exact prompts, and the generated video scripts with their format and hook rationale.

## Notes for future optimization (do not block on these)

These are recorded as notes, not runtime requirements. They cannot be verified during authoring because the TrendTrack MCP is connected in Desktop, not in the authoring environment.

- If `search_ads` with `tracked_pages` set to the resolved page id proves, in practice, to return clean single-competitor results, prefer it over the over-fetch-and-filter path in Step B. It would remove the de-pollution step entirely.
- A brandtracker-scoped retrieval tool such as `analyze_tracked_brand` may give a cleaner per-competitor winner list than brand-name `search_ads`. Worth testing against the Step B path once the tracker is seeded.

## Cross-skill references

- `../ad-analysis-tagger/SKILL.md` (six-dimension tagging)
- `../ad-style-generator/SKILL.md` and `../ad-style-generator/references/style-catalogue.md` (visual style bucketing and static brief generation)
- `../video-script-generator/SKILL.md` (video format set and replica scripts)
- `../nano-banana-prompting/SKILL.md` (default static prompt format)
- `../gpt-image-2-prompting/SKILL.md` (alternate static prompt format)
