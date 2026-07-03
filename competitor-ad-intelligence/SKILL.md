---
name: competitor-ad-intelligence
version: "0.13.0"
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

Clarification for high Visual-Layout Replicability ads: when the tagger scores a static's layout as highly cloneable (4-5), faithfully reproducing the LAYOUT GRAMMAR (composition, hierarchy, framing, treatment, slot positions) is correct and expected; that is not what 'duplicate' means here. Duplication means copying the source brand's identity, product, or copy content. Cloning the layout while replacing all brand identity, product, and copy is a transposition, not a duplicate. The content-leak rule enforces the line: layout grammar clones, source content never does.

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
5. **Tag and bucket -- PAUSE gate (Desktop).** `scan_ad` returns an image asset URL, not a viewable image, and vision cannot read a bare URL.

   **STOP HERE. Do not proceed to tagging until images are in hand.**

   Present the operator with a numbered list of all N image asset URLs from the top winners. Instruct them:

   > "Please open each URL below, screenshot or save the image, and return them in this conversation. Label each image with its ad number before pasting it (e.g. write 'Ad 1:' then paste the image, 'Ad 2:' then the next image, and so on). Do not proceed until all images are returned with their labels."

   Before tagging, verify the returned set: every top-winner ad must have exactly one labeled image. If any image is missing, if any ad number appears more than once, or if any image arrives without a label, STOP immediately. List which ads are missing or ambiguous, and ask the operator to correct the mapping before proceeding. Do not tag any ad until the full labeled set is confirmed complete.

   Once the operator returns all images, tag each ad via `../ad-analysis-tagger/SKILL.md` across its six dimensions, using the returned image as the visual input. The analysis purpose for each ad is: identify the transposable visual structure and distinctive device so it can be rebuilt in the target brand's identity. Assign a visual style by matching against the `../ad-style-generator/references/style-catalogue.md` style catalogue. For each ad, flag whether it fits an existing style bucket or is a candidate new style, with a one-line rationale.

   The tagger now returns a Visual-Layout Replicability score (1-5) for each static, distinct from the overall replicability score. Read it and set the execution path per ad:

   - Score 4-5 (CLONE path): the layout is the replication target. The tagger's Visual Element Classification provides the exact per-element instructions. Reproduce CLONE elements directly (geometry, hierarchy, framing, treatment only, never source text or pixels). Substitute ADAPT elements with a product-contextually relevant equivalent for the target brand (using the contextual function the tagger named). Replace STRIP-REPLACE elements with the target brand's equivalent in the compositional role the tagger named. For MIXED elements, reproduce the clone_aspects (layout grammar) and rewrite the replace_aspects (source content) in the target brand's voice. Never reproduce source text, claims, headlines, or branded pixels; the words in every cloned slot are rewritten.
   - Score 3 (PARTIAL-CLONE path): the tagger's partial Visual Element Classification table contains the surviving elements, which can still include CLONE, ADAPT, STRIP-REPLACE, and MIXED rows. Apply the SAME four-bucket handling as the CLONE path to that partial Visual Element Classification table: reproduce CLONE elements directly (layout grammar only), substitute ADAPT elements with the target-contextual equivalent, replace STRIP-REPLACE elements with the target brand's equivalent in the named compositional role, and for MIXED elements reproduce clone_aspects while rewriting replace_aspects in the target brand's voice. Separately, treat every element in the tagger's 'Entangled Elements Excluded From Clone' section as do-not-clone and transpose those concept-only. Do not reproduce entangled elements.
   - Score 1-2 (TRANSPOSE path): the layout is not the replication target. Extract the concept and the single most distinctive device, rebuild creatively in the target brand's identity. The classification is not produced at this score.
   - Not-produced, reason 'visual-layout replicability 1-2, concept-only target': this is the same as the Score 1-2 TRANSPOSE path. Route to TRANSPOSE. (The tagger emits this reason instead of a classification when the layout is not the replication target.)
   - Not-produced, reason 'non-static input': this should not occur in the statics lane, which feeds only static images. If it does (a misclassified asset, a carousel/video mismatch, or a missing image), STOP. Do not assign an execution path and do not generate. Report the affected ad to the operator and ask them to confirm whether it belongs in the video lane or should be dropped. Generation for that ad does not proceed until a valid static Visual Element Classification exists.

   Record the execution path (CLONE / PARTIAL-CLONE / TRANSPOSE) per ad; it carries to the fit assessment table in Step B.6 and to generation in Step B.7. The content-leak rule is absolute on every path: source text, claims, and branded pixels are never reproduced, only layout grammar is.

   (Creative Engine will fetch the asset server-side later, closing this operator step automatically.)
6. **Fit assessment and recommendation -- PAUSE gate.**

   **Layout-before-angle gate [v0.13 visual-fidelity].** Name the visual structure you are cloning before naming the angle it serves. Describe the layout (spatial hierarchy, headline position, callout structure, camera angle, aspect ratio) before the message it carries. This reinforces the Visual-Layout Replicability routing from Step B.5: the structure is the primary object of the transposition, and the angle rides on it.

   After tagging all N ads, produce a fit assessment table before any generation begins. The table evaluates each ad's transposability specifically against the target brand's product and category. Do not assess fit in the abstract; assess it against what the target brand actually sells.

   For each ad, output:
   - **Ad #** and a one-line description (competitor name, visual style, primary claim)
   - **Fit score**: High / Medium / Low
   - **Execution path**: CLONE / PARTIAL-CLONE / TRANSPOSE (from the Visual-Layout Replicability routing in Step B.5)
   - **`product_form_compat` [v0.13 visual-fidelity]**: enum {compatible, partial_exception, layout_not_transferable, na_concept_only}. Required, named field; do not leave it blank. For CLONE and PARTIAL-CLONE ads, test the target product's physical form against the source's locked composition and record one of {compatible, partial_exception, layout_not_transferable}. For TRANSPOSE ads record na_concept_only. This is the canonical field named in the Step B.7 Gate Emission Schema: Gate 2 reads `product_form_compat` and re-emits it (with any downgrade) before prompt construction, so a blank field blocks generation.
   - **Transposability rationale**: one to two sentences on why this ad ports to the target product. Flag genuine non-fits explicitly; if the ad is built around a product category the target brand does not sell and no honest analog exists, call it a non-fit rather than forcing it.
   - **Leak-control inventory** (mandatory for CLONE and PARTIAL-CLONE ads; not length-capped; the operator must see every item before confirming generation): list, one line per item, every element that will be rewritten, substituted, or excluded:
       - Each ADAPT element and its target-brand contextual substitution.
       - Each STRIP-REPLACE element and its target-brand equivalent in the named compositional role.
       - Each MIXED element's replace_aspects: the source copy, claims, or branded overlay that will be rewritten in the target brand's voice.
       - For PARTIAL-CLONE ads: each item in the tagger's 'Entangled Elements Excluded From Clone' section with its do-not-clone note (transposed concept-only, not cloned).
     If a category has no items, state 'none' for that category explicitly. Do not compress, summarize, or omit items; this inventory is the operator's leak-control checkpoint and every leak-prone element must appear. For TRANSPOSE ads, state 'Leak-control inventory: not applicable (concept-only transposition)'.
   - **Recommended action**: Proceed / Proceed with modification / Skip (with reason)

   **`product_form_compat` field [v0.13 visual-fidelity].** The `product_form_compat` field above is mandatory for every ad, and it is what Step B.7 Gate 2 consumes. Even for a CLONE or PARTIAL-CLONE ad, if the product's form is incompatible with part of the composition, set the field to `partial_exception` (then name the portable grammar that still transfers) or `layout_not_transferable` (the composition cannot port at all), and say why. This is a scalpel, not a blunt skip: `partial_exception` downgrades only the incompatible part and keeps the rest. For TRANSPOSE ads the field is `na_concept_only`, since nothing is cloned. The recorded value carries into Step B.7 Gate 2, which re-emits it before the prompt is written. Validated example: a handheld-device-applied-to-a-body-part pose does not transfer to a full-body mat (a mat is not handheld), so that part is `partial_exception`, but the three-benefit leader-line callout structure does transfer and gets rebuilt on a mat-use scene.

   After the table, provide a brief ranked recommendation: which ads are the highest-value transposition candidates and why, from the perspective of the target brand's avatar and angle roadmap.

   **STOP HERE. Present the table and recommendation to the operator. Ask:**

   > "Which of the above would you like to generate? Please confirm the ads you want to proceed with (by number), and specify the image model: Nano Banana (default) or GPT Image 2."

   Do not begin generation until the operator responds with confirmed ad numbers and a model choice.

7. **Generate (on request): the concept-transposition pipeline.** Generation is opt-in per run, not automatic. Follow the Generation method section above (transpose, do not duplicate).

   **AUTHORITY: B.7 is best-effort guidance, B.8 is the enforcer [v0.13 visual-fidelity].** Read this before trusting the gate flow. The B.7 gate flow below is best-effort pre-generation guidance that reduces obvious composition, reference, and setting errors before a render. It is executed by the model at runtime, not by a script, so it is NOT a machine-enforced contract and it can drift. The AUTHORITATIVE enforcement of visual fidelity is the Step B.8 post-generation pixel fidelity check, which scores rendered pixels against the resolved post-gate spec (`effective_layout_lock` including `resolved_camera_angle`, product integrity, and `accepted_setting`), NOT against the raw source, and regenerates any image that fails composition fidelity, product integrity, or setting plausibility. Scoring against the resolved spec is deliberate: on a relaxed-angle or downgraded case the correct render intentionally differs from the source (the source angle is a forbidden literal), so the target is the emitted spec, not the original ad. Pixels are the one representation in this pipeline that cannot be misread, so B.8 is the enforcer and B.7 is the assist. The named-field discipline below still matters (it makes the guidance consistent and reviewable), but do not mistake it for a guarantee; the guarantee is B.8.

   **Design principle (binding for all of B.7 and B.8) [v0.13 visual-fidelity].** Every value a gate emits is a NAMED FIELD with a defined type or enum, listed once in the Gate Emission Schema below. Every downstream step reads ONLY those named fields. Once an effective or override field exists, no step reads the raw Step B.5 or Step B.6 value it replaced. Prompt construction is gated on a mechanical set-membership check against two explicit literal lists (`prompt_required_literals`, `prompt_forbidden_literals`), not on prose. This schema is the single source of truth; do not redefine any field inline elsewhere. Execution is ONE linear order: Step B.7.0a (initialize, once), Step B.7.0b (select reference, re-runnable), then Gate 1, Gate 2, Gate 3, Gate 4, then the gate report, then the moves. Prompt construction is BLOCKED until the gate report is complete and the mechanical scan passes. Never place gate work inside the moves.

   **Gate Emission Schema (single source of truth) [v0.13 visual-fidelity].**

   | Field | Type / enum | Emitted by | Consumed by |
   |---|---|---|---|
   | `effective_execution_path` | enum {CLONE, PARTIAL-CLONE, TRANSPOSE} | B.7.0a initializes once from the Step B.5 route; Gate 2 is the ONLY step that may overwrite it (downgrade) | Gate 1, Gate 3, Gate 4, all moves |
   | `product_form_compat` | enum {compatible, partial_exception, layout_not_transferable, na_concept_only} | B.7.0a reads Step B.6; Gate 2 re-emits (and on downgrade re-emits na_concept_only) | Gate 2 terminal logic, gate report |
   | `selected_reference` | struct {ref_id, ref_url} OR null | B.7.0b emits, RE-emitted by re-running B.7.0b after any downgrade | Gate 3, move 5 |
   | `reference_outcome` | enum {PASS, DEGRADED_PASS, FAIL} | Gate 3 | gate report terminal logic |
   | `effective_layout_lock` | struct {spatial_hierarchy, headline_position, callout_structure, camera_angle, aspect_ratio, anti_patterns[]}; `camera_angle` is internal pre-resolution state after Gate 3, never prompt-read | Gate 1 | move 5 and scan read every field EXCEPT `camera_angle` (angle is read only via `resolved_camera_angle`) |
   | `angle_resolution_status` | enum {match, relaxed} | Gate 3 | gate report (relaxed-path forbidden-literal assembly) |
   | `resolved_camera_angle` | string (the ONLY camera-angle field the prompt reads) | Gate 3 | move 5, scan |
   | `scale_anchor` | string or "none" | Gate 3 | move 5, scan |
   | `setting_outcome` | enum {plausible, implausible} | Gate 4 | gate report terminal logic |
   | `accepted_setting` | exact string | Gate 4 | move 5, scan |
   | `prompt_required_literals` | string[] | gate report | move 5 (must embed all), scan |
   | `prompt_forbidden_literals` | string[] | gate report | scan (must be absent) |

   Every gate and move below references these exact field names. Do not redefine a field inline.

   **Step B.7.0a -- Initialize (runs ONCE per ad, first pass only) [v0.13 visual-fidelity].** Before any gate runs:
   - Load the target brand kit (palette, fonts, voice) and the brand `image-reference-index.md` per the brand-kit step above. This is the loading that used to sit inside the moves; it is pulled ahead of the gates so no gate depends on a later move.
   - Initialize `effective_execution_path` from the Step B.5 route (CLONE / PARTIAL-CLONE / TRANSPOSE). This is the ONLY point in B.7 that reads the raw Step B.5 path; every later step reads `effective_execution_path`. Read `product_form_compat` from Step B.6. Do not re-run the tagger.
   - B.7.0a NEVER runs again for the same ad. In particular, the Gate 2 downgrade does NOT re-run B.7.0a, so a downgrade to TRANSPOSE can never be erased back to CLONE / PARTIAL-CLONE by a re-read of the raw Step B.5 route.

   **Step B.7.0b -- Select reference (re-runnable) [v0.13 visual-fidelity].** Emit `selected_reference` ({ref_id, ref_url} OR null): SELECT the candidate reference for this ad from the image-reference-index, against the CURRENT `effective_execution_path` and the scene the ad needs. If the index holds no candidate that could serve the scene, set `selected_reference = null` (no string sentinel); Gate 3 reads the null and emits `reference_outcome = FAIL`. B.7.0b is re-runnable: the Gate 2 downgrade re-runs ONLY B.7.0b (reference reselection against the post-downgrade `effective_execution_path`), never B.7.0a.

   **Gate 1 -- Layout Lock (emits `effective_layout_lock`) [v0.13 visual-fidelity].** Lock the composition as the named struct `effective_layout_lock` {spatial_hierarchy, headline_position, callout_structure, camera_angle, aspect_ratio, anti_patterns[]}. The source of the lock depends on `effective_execution_path`:
   - **CLONE / PARTIAL-CLONE (a 5B Visual Element Classification exists):** populate `effective_layout_lock` FROM the tagger's CLONE and MIXED clone_aspects rows, not from scratch.
   - **TRANSPOSE (concept-only, no 5B classification exists):** do NOT read clone_aspects rows, there are none. Populate `effective_layout_lock` headed 'concept-only, authored from brand identity, not cloned from source', authoring the scene from the target brand identity. This is the defined TRANSPOSE outcome; it is not a skip and it is not a hallucinated clone.

   Populate every field of `effective_layout_lock`:
   - `spatial_hierarchy`: the photo zone and the text zone as approximate percentages of the frame (for example, product photo 70 percent, text block 30 percent).
   - `headline_position`: where the headline and any sub-copy sit in the frame.
   - `callout_structure`: the count and arrangement of benefit callouts or leader lines (CLONE and PARTIAL-CLONE: as in the source; TRANSPOSE: as newly authored).
   - `camera_angle`: the shot angle the composition depends on (flat-on, three-quarter, top-down, diagonal). This is internal pre-resolution state: Gate 3 emits `resolved_camera_angle` as the single angle the prompt reads, and on a relaxed angle records this pre-resolution value as a `prompt_forbidden_literals` entry. No prompt-construction step reads `camera_angle` directly.
   - `aspect_ratio`: 9:16 for a vertical source, 1:1 for a square source. Match the source; never default every render to 1:1. Aspect ratio is a real compositional lever, not a formatting afterthought.
   - `anti_patterns[]`: an explicit list of 'do NOT' lines the render must avoid, drawn from the source's real setting and scale (TRANSPOSE: from the authored scene's real setting and scale). State the applicable ones: do NOT render a seamless studio void; do NOT shrink the product below its real scale; do NOT change to a bright clinical room when the source is a lived-in setting; do NOT keep competitor brand colors. These are validated load-bearing constraints, not boilerplate; drop one only when it genuinely does not apply, and add product-specific ones as needed.

   **Gate 2 -- Product-form exception (re-emits `product_form_compat`; the ONLY step that may overwrite `effective_execution_path`) [v0.13 visual-fidelity].** Read the `product_form_compat` value emitted by B.7.0a (B.7.0a is the single step that read it from Step B.6, once) and re-emit it. Gate 2 does NOT re-read Step B.6, so it cannot rehydrate a stale `layout_not_transferable` after a downgrade has re-emitted `na_concept_only`. Prompt construction may not proceed on the B.7.0a value without Gate 2 re-emitting it plus any downgrade. Branch on `effective_execution_path`:
   - **CLONE / PARTIAL-CLONE:**
      - `product_form_compat = compatible` (NON-terminal, the happy path): the product's form fits the locked composition. Re-emit `compatible`, leave `effective_execution_path` unchanged, and proceed to Gate 3. No downgrade, no drop.
      - `product_form_compat = partial_exception` (NON-terminal): only part of the composition fails to port. Keep `effective_execution_path` at PARTIAL-CLONE: drop the declared non-transferable element and salvage the portable grammar. Record the declared-drop element as an exact string for the gate report's `prompt_forbidden_literals`. Validated example: a Joovv Go handheld pose does not transfer to an Elaris full-body mat (a mat is not handheld), so the handheld-application pose is `partial_exception` and dropped, while the three-benefit leader-line callout structure transfers and is rebuilt on a mat-use scene.
      - `product_form_compat = layout_not_transferable` (TERMINAL for the clone path): the whole composition cannot port. It CANNOT proceed as CLONE or PARTIAL-CLONE and its `effective_layout_lock` is discarded, never carried into the prompt. Two forward paths only:
         - (a) DOWNGRADE (default): set `effective_execution_path = TRANSPOSE` and re-emit `product_form_compat = na_concept_only` (the post-downgrade value the gate report consumes, so `layout_not_transferable` is no longer active after the downgrade resolves). This authoritative override replaces the raw B.5 path for every downstream step. Discard the CLONE / PARTIAL-CLONE `effective_layout_lock`, re-run ONLY Step B.7.0b (reference reselection for the concept-only scene, against the now-TRANSPOSE `effective_execution_path`; fresh `selected_reference`, not the frozen pre-downgrade one) and NOT B.7.0a, rerun Gate 1 concept-only (fresh `effective_layout_lock`), then continue to Gate 3 and Gate 4 against the new lock. A downgraded ad cannot downgrade again: as TRANSPOSE its `product_form_compat` is `na_concept_only`, which is non-terminal, so the downgrade happens at most once and cannot loop.
         - (b) SKIP: if no honest concept-only transposition exists (a product category the brand does not sell, no analog), declare a non-fit and stop.
   - **TRANSPOSE:** emit `product_form_compat = na_concept_only` (non-terminal). Nothing is being cloned, so there is no locked source composition to be incompatible with. Gates 3, 4, and Step B.8 still apply.

   **Gate 3 -- Reference Compatibility Check (emits `reference_outcome`, `angle_resolution_status`, `resolved_camera_angle`, `scale_anchor`) [v0.13 visual-fidelity].** Applies to every `effective_execution_path`, because every path renders a real target product image. Read `selected_reference` against `effective_layout_lock`, and emit the named fields. Judge three sub-checks: subject match (same subject type, person-present vs product-only), scale-relationship match (same body relationship: on it, beside it, holding it), and camera-angle match (reference angle compatible with `effective_layout_lock.camera_angle`).

   Emit exactly one `reference_outcome`, plus the resolution fields:
   - **PASS**: subject, scale, and angle all compatible. Set `angle_resolution_status = match`, `resolved_camera_angle = effective_layout_lock.camera_angle`, and `scale_anchor = "none"`.
   - **DEGRADED_PASS**: metadata is unknown, or scale or angle is partially incompatible. When scale is degraded, set `scale_anchor` to the exact scale phrasing that will appear in the prompt; otherwise `scale_anchor = "none"`. When angle is degraded, set `angle_resolution_status = relaxed` and set `resolved_camera_angle` to the reference-supported angle; otherwise `angle_resolution_status = match` and `resolved_camera_angle = effective_layout_lock.camera_angle`. Record why the outcome is degraded. The scale-relationship and camera-angle metadata do not yet exist per entry in the index, so this is a reasoning step, not a lookup; unknown metadata is an explicit DEGRADED_PASS with the reasoning recorded, never a silent assumption.
   - **FAIL**: no usable reference exists (cold start, sparse index, a genuine asset gap, that is `selected_reference = null`). Emit `reference_outcome = FAIL`; the gate report hard-stops. Report the reason (for example, 'asset gap: no male-on-mat reference', per the validated Ad 4 case). Do not silently infer a reference or proceed with none.

   **Angle override rule.** `resolved_camera_angle` is the single camera angle any prompt-construction step reads; `effective_layout_lock.camera_angle` is internal pre-resolution state and is never prompt-read. When `angle_resolution_status = relaxed`, Gate 3 records the pre-resolution (source) `effective_layout_lock.camera_angle` string so the gate report adds it to `prompt_forbidden_literals`, and sets `resolved_camera_angle` to the reference-supported angle. No consumer parses a free-text phrase, and no step reads the original source angle into the prompt. Validated angle relaxation (Elaris HigherDose-mat clone): when no single reference has BOTH the required subject and scale AND the required angle, keep subject and scale (the higher-priority cues) and relax the angle to the reference-supported one. Decouple 'body placement on the diagonal' from 'extreme camera angle': the diagonal body placement is kept while the camera stays at the supported angle. Validated Ad 2 outcome: rendered from MAT_04's from-above angle, not the source's low near-ground angle, which prevented the warp.
   Future enhancement (not this PR): add scale-relationship and camera-angle metadata per entry in the brand image-reference-index so this becomes a lookup instead of a reasoning step.

   **Gate 4 -- Background / Setting Sense-Check (emits `setting_outcome` and `accepted_setting`) [v0.13 visual-fidelity].** Applies to every `effective_execution_path`. Setting is an ADAPT element in the tagger 5B contract for CLONE and PARTIAL-CLONE, and an authored choice for TRANSPOSE. Emit `setting_outcome` (enum {plausible, implausible}) and, when plausible, `accepted_setting` as the EXACT setting string that will appear in the prompt, not a verdict word. Preserve the background's visual ROLE (texture, tone, isolation, mood), not its literal location. Reject any setting where a reasonable buyer would never use the product; electrical corded full-body devices need plausible indoor or home settings. Resolve the plausibility-versus-drama tradeoff toward plausibility for this product category: a dramatic setting a real buyer would never use the product in is `implausible`, not a bold choice. Validated failures this catches: a full-body mat staged on driftwood outdoors, and a fake seamless red studio void. `setting_outcome = implausible` hard-stops prompt construction until the setting is re-chosen and Gate 4 re-run to `plausible`.

   **Gate report (sole chokepoint; assembles the literal lists) [v0.13 visual-fidelity].** The gate report is the only input to prompt construction; there is no alternate path from routing to the moves that bypasses it. It carries every schema field emitted above and assembles the two literal lists as EXACT strings:
   - `prompt_required_literals` (MUST appear verbatim in the final prompt): the `effective_layout_lock.spatial_hierarchy` phrase, `headline_position`, `callout_structure`, `aspect_ratio`, the `resolved_camera_angle`, the `scale_anchor` (only when it is not "none"), each `effective_layout_lock.anti_patterns[]` line, and `accepted_setting`.
   - `prompt_forbidden_literals` (MUST be absent from the final prompt): any `partial_exception` declared-drop terms, competitor brand names, competitor brand color names, and, when `angle_resolution_status = relaxed`, the pre-resolution (source) camera-angle string that Gate 3 recorded. Requiring the resolved angle present is not enough on its own: the source angle must be forbidden-absent so a prompt containing both fails the scan.
   **Terminal states hard-stop before any prompt is built:** `reference_outcome = FAIL`, `setting_outcome = implausible`, and `product_form_compat = layout_not_transferable` prior to its downgrade or skip resolution. Only when no terminal state is active and both literal lists are assembled may the moves run.

   **State-coverage table (`effective_execution_path` x `reference_outcome`; no cell is silent) [v0.13 visual-fidelity].**

   | effective_execution_path | reference_outcome PASS | reference_outcome DEGRADED_PASS | reference_outcome FAIL |
   |---|---|---|---|
   | CLONE | generate | degraded-generate: embed `scale_anchor` and/or relaxed `resolved_camera_angle` | hard-stop (asset gap) |
   | PARTIAL-CLONE | generate (declared-drop in `prompt_forbidden_literals`) | degraded-generate: declared-drop plus `scale_anchor` and/or relaxed `resolved_camera_angle` | hard-stop (asset gap) |
   | TRANSPOSE | generate (concept-only lock) | degraded-generate: embed `scale_anchor` and/or relaxed `resolved_camera_angle` | hard-stop (asset gap) |

   Separate downgrade row: `product_form_compat = layout_not_transferable` on a CLONE or PARTIAL-CLONE ad is terminal for the clone path. It resolves to (a) downgrade to TRANSPOSE (set `effective_execution_path = TRANSPOSE`, re-emit `product_form_compat = na_concept_only`, re-run only B.7.0b reference selection, Gate 1 concept-only, then Gate 3 and Gate 4) and then follows the TRANSPOSE row, or (b) skip as a declared non-fit. It never generates as a clone.

   **The moves (prompt construction and generation; blocked until the gate report passes and the move-6 scan passes):**
   1. Confirm `effective_execution_path` (NOT the raw Step B.5 path; on a downgrade this is TRANSPOSE). Prompt construction reads layout ONLY from `effective_layout_lock` and `prompt_required_literals`; the camera angle comes SOLELY from `resolved_camera_angle` (Gate 3's emitted field), never from the tagger's raw clone_aspects and never from `effective_layout_lock.camera_angle` (which is internal pre-resolution state after Gate 3). Apply the per-path handling:
      - CLONE: the replication targets are the tagger's CLONE and MIXED clone_aspects, carried into the prompt EXCEPT camera angle (angle is taken only from `resolved_camera_angle`). ADAPT, STRIP-REPLACE, and MIXED replace_aspects are substituted with the target brand's equivalents per the tagger's named functions and roles.
      - PARTIAL-CLONE: apply the same four-bucket handling to the partial classification (clone CLONE elements and MIXED clone_aspects, EXCEPT camera angle; substitute ADAPT and STRIP-REPLACE; rewrite MIXED replace_aspects). Do not reproduce anything in the tagger's 'Entangled Elements Excluded From Clone' section; those are concept-only.
      - TRANSPOSE: extract the transposable concept and the single most distinctive device, the element that makes the ad work, and build to the concept-only `effective_layout_lock`.
      On every path, the content-leak rule is absolute: reproduce layout grammar only, never source text, claims, headlines, or branded pixels.
   2. Strip the source brand's identity: palette, fonts, product form, naming, and any competitor wording.
   3. Device-analog preservation. If the distinctive device depends on the source product's physical form, find the target product's honest analog rather than copying the form or dropping the device. Worked example: a competitor supplement ad whose device was cracking a capsule to expose the powder transposes to a shampoo brand as the formula pouring and swirling from the intact bottle.
   4. Write the target-brand headline and any on-image copy now, in the target brand's voice through its `copywriting-guide.md` (the target brand's file under `<brand-slug>/`, not the `_skills/copywriting-guide/` skill), passing the relevant compliance check (for GCC brands, GCC compliance).
   5. Render image-to-image via `../nano-banana-prompting/SKILL.md` and the Kie path. Reaching this move requires `reference_outcome` of PASS or DEGRADED_PASS (FAIL hard-stopped at the gate report), so `selected_reference` is non-null here. Build the prompt with the real product as `image_input` (public URL from `selected_reference.ref_url`, dereferenced only because `reference_outcome` is PASS or DEGRADED_PASS), the target palette and fonts, and only the move-4 target copy, with an explicit instruction not to reuse any competitor wording. The prompt MUST embed every string in `prompt_required_literals` verbatim; that is how `spatial_hierarchy`, `headline_position`, `callout_structure`, `aspect_ratio`, `resolved_camera_angle`, `scale_anchor` (when not "none"), every `anti_patterns[]` line, and `accepted_setting` reach the render. The prompt reads `resolved_camera_angle` only, never a source or original angle. (Use `../ad-style-generator/SKILL.md` to shape the brief, and `../gpt-image-2-prompting/SKILL.md` as the alternate prompt format on request.)
   6. Pre-generation mechanical scan (closed set-membership over the ACCEPTED PROMPT TEXT, run by inspection; never over the gate self-tags). Run this exact closed procedure, with no interpretive step:
      1. Take `prompt_required_literals[]` and `prompt_forbidden_literals[]` exactly as the gate report emitted them (exact strings; do not re-derive, paraphrase, or normalize them).
      2. For each string in `prompt_required_literals`, confirm it appears verbatim in the accepted prompt TEXT. For each string in `prompt_forbidden_literals`, confirm it is absent from the accepted prompt TEXT. Compare the prompt text, never the gate self-tags. `accepted_setting` is an exact string (never a 'plausible' verdict), and declared drops and the relaxed-path source angle are exact forbidden literals (never a semantic check).
      3. If every required literal is present and every forbidden literal is absent, accept the prompt. Otherwise BLOCK, report which literal failed, rewrite the prompt, and re-run this scan from step 1. No generation until the scan passes.

      Honest framing: this scan is a model-run set-membership check, tightened as far as a prose skill allows, and it verifies only that the prompt TEXT carries the required literals and none of the forbidden ones. The deterministic enforcement of visual fidelity is the Step B.8 post-generation pixel check, which scores real pixels, cannot drift, and regenerates any image that fails composition, product integrity, or setting plausibility regardless of what the prompt text contained.

   Then run Step B.8 on the rendered image. Output the transposed image, the exact prompt used, the Step B.7 gate report (schema fields plus both literal lists), the Step B.8 scorecard, and the three-part transposition (kept, stripped, applied) for the deliverable.

8. **Step B.8 -- Post-Generation Fidelity Check (required emitted scorecard + two independent bounded loops) [v0.13 visual-fidelity].** This step did not previously exist, which is why weak images shipped. It runs on every generated image and emits a mandatory scorecard. Skipping it is detectable because the Output deliverable requires the scorecard per image.

   **Emitted scorecard (required, one per generated image).** Emit for each image:
   - **Composition fidelity** (the render matches EVERY `effective_layout_lock` field: `spatial_hierarchy`, `headline_position`, `callout_structure`, the `resolved_camera_angle`, the `aspect_ratio`, and no `anti_patterns[]` 'do NOT' condition is visible in the rendered pixels): score out of 5. This is the full locked spec the authority subsection names, not a subset; a render that clears hierarchy and angle but violates the locked aspect ratio or shows an anti-pattern (a studio void, a shrunk product, a clinical room, competitor colors) fails this axis.
   - **Product integrity** (product undistorted, correctly scaled, in a sensible setting): score out of 5.
   - **Setting plausibility** (the rendered setting matches the emitted `accepted_setting`, and is a real, usable setting, not a void or an implausible location): score out of 5. A render that lands in a different setting than `accepted_setting` fails this axis even if the substitute setting is itself plausible.
   - **Compliance** (brand voice, approved claims only, no borrowed competitor trust marks): pass or fail.
   - **Overall**: pass or fail.
   - **Regeneration count**: how many quality regenerations were spent on this image.
   - **Final accepted prompt**: the exact prompt behind the accepted image.

   The three axes catch genuinely different failure modes and do not substitute for each other: a bare packshot passes product integrity but fails composition; a warped product passes composition but fails product integrity; a forest-staged product passes both composition and integrity but fails setting plausibility.

   **Two independent bounded loops.** Transport retries and quality regenerations are separate mechanisms and must NOT be conflated. A transient transport error is never read as a content or quality problem, and a low quality score is never read as a transport problem.

   - **Transport retry loop (API error, 500, or empty result).** These are transport failures, not quality failures. Bounded policy: the initial attempt, then up to 2 same-model retries, each after a short backoff ('separated' means sequential after a backoff, not concurrent); then exactly 1 alternate-model attempt (GPT Image 2 and Nano Banana swap); then STOP with an explicit failure report to the operator. That is a hard ceiling of at most 3 same-model attempts plus 1 alternate-model attempt per image, so the loop cannot run forever. Do not infer a content cause from a transient error, and do not run the quality loop against a transport failure.
   - **Quality regeneration loop (any axis below 4 or compliance fail).** A SEPARATE loop from transport retries. The thresholds are exact regenerate triggers: an axis at 4 or above passes, an axis below 4 triggers regeneration, and a compliance verdict of 'fail' triggers regeneration regardless of the axis scores. Regenerate targeting the specific failing axis, up to 2 regenerations; then STOP and flag the image for the operator with its scorecard. Never loop unbounded. Every quality regeneration REBUILDS its prompt from the same Step B.7 gate report and MUST pass the Step B.7 move-6 set-membership scan before the new render; there is no alternate generation path that skips move 6. A regenerated prompt that drops a `prompt_required_literals` string or reintroduces a `prompt_forbidden_literals` string is blocked exactly as a first-pass prompt would be.

   The two loops differ on move 6: a transport retry re-sends the SAME accepted prompt (already scanned), so it does not re-run move 6; a quality regeneration produces a NEW prompt, so it always re-runs move 6 before rendering.

   A regenerated image re-enters the scorecard and increments the regeneration count. When the quality loop stops without reaching threshold, deliver the image flagged, with the scorecard showing the failing axis, so the shortfall is visible rather than silent.

## Step C: Video lane

### Pre-write safety: capacity preflight and conditional confirmation

The video lane is the only lane that writes to TrendTrack, because it seeds trackers. Before any add_to_brandtracker call, run this preflight every time, without exception:

1. Call list_tracked_brands. Read the current tracked total, and split the run's competitors into already-tracked (re-adding is a zero-credit idempotent no-op) and new (each consumes one of the 30 Pro slots when seeded).
2. Surface a seed plan in the run output before seeding: the new competitors that will be tracked, the already-tracked ones that will no-op, the resulting tracked total, and the remaining slots against the 30-slot cap. The run never seeds invisibly.
3. Conditional confirmation gate. Proceed without pausing only when BOTH of these hold: the run is in the owner's own workspace, AND the resulting tracked total stays at or below 25 of 30. When both hold, seeding may proceed hands-free.

   STOP HERE if either condition is not met (seeding would push total above 25, or workspace is not the owner's own). Present the seed plan to the operator and ask:

   > "This run would seed [N] new competitor(s): [list]. This would bring the tracked total to [X] of 30 slots[, and/or this does not appear to be the owner workspace]. Please confirm before I proceed. Do not call add_to_brandtracker until you explicitly confirm."

   Do not call add_to_brandtracker until the operator responds with explicit confirmation. The gate exists to prevent silent slot exhaustion and unintended writes in client workspaces.
4. Hard capacity invariant (absolute, checked before the confirmation gate, not confirmable). Before any add_to_brandtracker call, compute the current tracked total plus the count of distinct new competitors this run would seed. If that sum exceeds 30, the Pro cap, do not call add_to_brandtracker at all. Stop and report: the run would exceed the 30-slot cap, so the operator must either delete existing trackers to free slots, or reduce or split the competitor set to fit, then re-run. This is evaluated before the confirmation gate: an over-cap run aborts and is never offered the pause-and-confirm path. The pause above 25 is a clearable warning; exceeding 30 is never seeded, even with confirmation.
5. Partial-seed handling. Even with the invariant, a stale tracked count or an unrelated add failure can interrupt a multi-competitor seed mid-batch. On any add failure during seeding, stop seeding immediately and report the partial state: the trackers created this run by brandtracker_id, the competitors that failed and why, and the current slot count. Never report the run as successful on a partial seed. In ephemeral mode, delete the trackers created this run per the ephemeral cleanup rule. In persistent mode, retain them, since they are valid intended trackers, but surface the incomplete run so the operator can free slots and re-run for the remainder.

This preflight supersedes any wording elsewhere in this skill that suggests seeding is unconditionally automatic.

1. **Ensure tracked.** Run the pre-write safety preflight above first. If the resolved competitor is absent, call `add_to_brandtracker` with its `facebookPageId` or `domain`, then capture the returned `brandtracker_id`. Seeding proceeds hands-free only when the conditional confirmation gate in the preflight has passed (owner workspace AND total at or below 25). When the gate requires confirmation, do not call add_to_brandtracker until the operator explicitly confirms. Seeding is always subject to the capacity preflight (seed plan shown every time), the conditional confirmation gate, and the hard capacity invariant (no seeding above 30, even with confirmation). (See the tracker lifecycle section for the persistent-vs-ephemeral default.)
2. **Pull transcripts.** Call `get_brandtracker_transcripts` for that `brandtracker_id`, with `sortBy` set to `totalImpressions`, `usageCount`, or `longestRunning`, and `time_period` starting at `last30d`, widened if the result is empty. `time_period` takes a fixed enum, never a day-count: `live`, `last24h`, `last3d`, `last7d`, `last30d`, `last3m`, `last6m`, `last1y`. A value like `last90d` is not in the enum and errors; widen by stepping to `last3m`, `last6m`, or `last1y` instead. The grouped usage-count and longest-running fields are themselves the video winner signal: a transcript reused across many ads or running a long time is a proven script.
3. **Capture the `.mp4` assets.** For each top transcript, call `scan_ad` on the sample ad to capture the `.mp4` asset URL and the reach magnitude. The transcript tool gives the spoken words plus usage and longevity; `scan_ad` returns the `.mp4` URL and the reach number. Keying and the Gemini handoff follow the Gemini video handoff contract below; this step does not restate the mechanism. These `.mp4` link(s) feed both the deliverable and the standard Gemini visual pass.
4. **Build the transcript brief, then hand off to operator for Gemini visual pass -- PAUSE gate.**

   **Part A -- Transcript brief (Claude executes).** From the transcript text plus its metadata, produce the transcript brief: opening hook (first line), script structure and arc, approximate pacing (from transcript length), and awareness stage. This is the immediate output Claude can produce without the video file.

   **Part B -- Gemini visual pass (operator-executed manual step). STOP HERE.**

   Claude cannot execute the Gemini pass. Present the operator with:

   1. The `.mp4` download links for each winning video (from the asset mapping table per the Gemini handoff contract).
   2. The exact canonical Gemini prompt from the Gemini video handoff contract section below, pre-filled with the correct N (number of videos) and the correct filenames from the asset mapping table.
   3. These instructions:

   > "Please download each `.mp4` file using the links above, keeping the exact filename shown (e.g. `123456.mp4`). Upload all files to Gemini along with the prompt above. When Gemini returns the analysis, paste the full output back into this conversation. Do not return partial results -- paste the complete Gemini response for all videos before I continue."

   **Part C -- Gemini return validation gate, then tagging (Claude executes, after operator returns Gemini output).**

   Before tagging anything, validate the returned Gemini output against the asset mapping table built in step 3. Validation has two levels that must both pass.

   **Level 1 -- Structural validation (filename headings):**
   - Every winning video in the mapping table must have exactly one section in the Gemini output headed by its exact `<asset_id>.mp4` filename.
   - No expected filename may be missing.
   - No filename may appear more than once.
   - No section heading may reference a filename not in the mapping table.

   **Level 2 -- Content validation (field completeness, per section):**
   For each filename section that passes Level 1, verify the section contains substantive responses for all nine gated fields listed below. These nine are the validation set; they are the fields that feed tagging, fit assessment, and generation. The remaining Gemini prompt fields (1. Format and length, 8. Audio, 10. Persuasion read) are enrichment: valuable when present, but not gating. Duration and coverage completeness are verified through the G0 self-audit block requirement rather than by gating on field 1 directly.

   The nine gated fields are:
   - G0: Self-audit block -- a SELF-AUDIT block must be present for this video, headed with the exact filename, containing all four sub-checks (actual duration, last beat timestamp vs duration, product moments completeness, transposition bullet count) and an overall PASS or FAIL verdict; a missing self-audit block, an incomplete block, or an overall FAIL verdict fails G0; G2 and G5 completeness are verified through this block, not independently by Claude
   - G1: Hook visual -- shot type, setting, and on-screen text at the 3-second mark (maps to prompt field 2)
   - G2: Beat-by-beat structure -- every beat covered start to finish, each with what is said and what is shown, timestamped; coverage completeness is verified by the G0 self-audit beat-timestamp sub-check, not by Claude independently; a section where the G0 self-audit beat sub-check is FAIL fails G2 (maps to prompt field 3)
   - G3: On-screen text -- verbatim transcription or an explicit "none" (maps to prompt field 4)
   - G4: Shot and edit rhythm -- shot types and cut frequency present (maps to prompt field 5)
   - G5: Product moments -- every product appearance enumerated with how it is shown and for how long, or an explicit "none" if the product never appears; coverage completeness is verified by the G0 self-audit product-moments sub-check, not by Claude independently; a section where the G0 self-audit product-moments sub-check is FAIL fails G5 (maps to prompt field 6)
   - G6: Talent and setting -- creator type, wardrobe, location, and vibe present (maps to prompt field 7)
   - G7: CTA -- verbal CTA and on-screen CTA described, or explicit "none" for each (maps to prompt field 9)
   - G8: Transposition brief -- 4 to 6 kept/stripped bullets as required by the canonical Gemini prompt; fewer than 4 bullets, or bullets present but none in the kept/stripped split format, fails G8 (maps to prompt field 11)

   A section fails Level 2 if any gated field (G0 through G8) is missing, empty, refusal-only, or non-substantive (a single word, a placeholder, or a restatement of the field name rather than actual visual content). There is no missing-field tolerance: all nine gated fields (G0 through G8) must be present and substantive. G0 requires a PASS verdict in the Gemini self-audit block; G2 and G5 completeness are verified through that block, not independently by Claude. Enrichment fields that are absent do not trigger a failure.

   If both levels pass for all videos: proceed to tagging. Tag the combined brief (transcript brief + Gemini visual analysis) for each video via `../ad-analysis-tagger/SKILL.md` and match-and-flag against the `../video-script-generator/SKILL.md` format set (fits an existing format, or candidate new format with one-line rationale). The Gemini brief is source-side analysis only; the applied layer is produced by the generation pipeline after the target brand kit is loaded, not by this pass.

   If validation fails for one or more videos: STOP immediately. Report which videos failed validation and why. State the exact failure reason per video: for Level 1 failures, report the structural cause (missing section, duplicate heading, unrecognized filename, or filename mismatch); for Level 2 failures, report which specific field(s) failed and why (missing, empty, refusal-only, or non-substantive), quoting the field name from the canonical nine (G0 through G8); for G0 failures, report which self-audit sub-check failed (duration, beat timestamp, product moments, or transposition bullet count) and state the overall self-audit verdict. Do not tag any video, proceed to fit assessment, or generate scripts for any video until the operator resolves the issue. Present two options to the operator:

   > "One or more videos did not return a valid Gemini section. Options:
   > 1. Re-run: download the missing video(s) again, re-upload to Gemini with the same prompt, and return the corrected output.
   > 2. Explicit skip: confirm which video(s) to drop from this run. Skipped videos will not be tagged, fit-assessed, or scripted.
   >
   > Please choose an option and respond before I continue."
5. **Fit assessment and model confirmation -- PAUSE gate.**

   After tagging all winning videos, produce a fit assessment table before any script generation begins. Assess each video's transposability specifically against the target brand's product and category -- not in the abstract.

   For each video, output:
   - **Video #** and a one-line description (competitor name, inferred format, primary claim or hook)
   - **Fit score**: High / Medium / Low
   - **Transposability rationale**: one to two sentences on why this video structure does or does not port to the target product. Flag genuine non-fits explicitly -- if the competitor's video concept depends on a product category, talent type, or claim the target brand cannot honestly make, call it a non-fit rather than forcing a transposition.
   - **Recommended action**: Proceed / Proceed with modification / Skip (with reason)

   After the table, provide a brief ranked recommendation: which videos are the highest-value transposition candidates, from the perspective of the target brand's avatar and angle roadmap.

   **STOP HERE. Present the table and recommendation to the operator. Ask:**

   > "Which of the above would you like to generate scripts for? Please confirm the videos you want to proceed with (by number). Note: video generation produces scripts only -- no video is rendered."

6. **Generate (on request): concept-transposed script.** Follow the Generation method section above: load the target brand kit first (palette, fonts, product reference, voice); transpose the concept, do not duplicate; strip the source brand's identity and any competitor wording; and preserve the distinctive device via the target product's honest analog (the device-analog rule). With the kit loaded, write the target-brand script and any on-screen copy in the brand voice through its `copywriting-guide.md` before finalizing the generation handoff, and instruct not to reuse any competitor wording. `../video-script-generator/SKILL.md` then produces the script in the matched format, rebuilt in the target brand's voice and avatar, not a copy of the source ad. The product facts come from the brand's `image-reference-index.md`; the product image REF is a hard stop only if a first frame is actually rendered downstream in the video tools (a script-only output does not hard-stop on it, per the brand-kit gate). No video is rendered here. Output the script plus the format and hook rationale, and the three-part transposition (kept, stripped, applied). Generation is opt-in per run.

## Gemini video handoff contract (authoritative, single source of truth)

This is the only place in the skill that describes how `.mp4` assets are keyed and fed to Gemini; every other mention defers here. For each winning video, `scan_ad` returns the `.mp4` URL whose basename is the asset id. The lane persists a mapping table in the report: asset id to winner (ad id, reach, transcript group, source `.mp4` URL). The operator downloads each winning video keeping the `<asset_id>.mp4` filename (the URL basename already is the asset id), uploads those named files to Gemini with the batched, filename-keyed analysis prompt below, and each returned teardown keys back to its winner through the table by its `<asset_id>.mp4` heading. Fallback: if any video cannot be downloaded or its asset id cannot be determined, do not silently proceed transcript-only. Instead, STOP and report to the operator which video(s) could not be keyed, and ask for an explicit decision: re-attempt the download, or explicitly confirm that video is skipped from this run. A skipped video is excluded from tagging, fit assessment, and script generation. Transcript-only continuation is not an autonomous Claude fallback; it requires explicit operator confirmation per video. Never attach a visual brief without a confirmed asset-id key. The Gemini pass operates on the uploaded named files, not on raw URLs. Creative Engine automates this same contract, keyed on the asset id.

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

   After completing the teardown for each video and before moving to the next, add a
   SELF-AUDIT block in exactly this format:

   SELF-AUDIT: [filename]
   - Actual video duration: [mm:ss or seconds]
   - Last beat timestamp in section 3: [timestamp] -- PASS if within 10% of duration, FAIL if not
   - Product moment timestamps in section 6: [list] or none -- PASS if all visible appearances captured or explicitly stated none, FAIL if you noticed appearances not listed
   - Transposition bullets in section 11: [count] -- PASS if 4-6 present, FAIL if fewer than 4
   - Overall: PASS or FAIL

   If the overall result is FAIL, append a one-line reason and correct the failing section(s) before proceeding to the next video.
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
4. **Transpositions (on request).** For each generated winner, show three explicit parts: the **concept** (the transposable idea), the single **distinctive device** that makes it work, and the **transposition** broken out as kept (what carried over), stripped (the source brand identity removed), and applied (the target brand identity and product rebuilt in). Include the generated statics with their exact prompts, and the generated video scripts with their format and hook rationale. For every generated static, the deliverable MUST also carry the Step B.7 gate report (Layout Lock, product-form verdict, reference compatibility block with outcome, plausibility verdict) and the Step B.8 scorecard for that image (the three axis scores, the compliance verdict, overall pass or fail, the regeneration count, and the final accepted prompt) [v0.13 visual-fidelity]. A generated static without its gate report and scorecard is an incomplete deliverable.

## Operational notes

Two cross-cutting levers surface here so they are easy to find. Each is enforced at its canonical location and is not redefined here, so the enforcing gate stays the single source of truth.

- **Aspect-ratio matching [v0.13 visual-fidelity].** Match the render's aspect ratio to the source ad: 9:16 for a vertical source, 1:1 for a square source. Never default every render to 1:1. Enforced in the Step B.7 Layout Lock (Gate 1).
- **Retry on transient failure [v0.13 visual-fidelity].** An API error, a 500, or an empty result is an automatic retry of the SAME model; only escalate to a different model after two or more separated retries fail for the same ad. Do not switch models on a first failure, and do not infer a content cause from a transient 500. Enforced in the Step B.8 Post-Generation Fidelity Check.

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
