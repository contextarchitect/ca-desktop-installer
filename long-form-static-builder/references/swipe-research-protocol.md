# Swipe Research Protocol

Optional research surface that runs between INGEST and SELECT. Produces an analyzed swipe library the writer consumes when structuring and writing. Three paths, one output shape, path-agnostic downstream.

## Why swipes matter

Long-format static is a young format with rapidly evolving conventions. The Rosabella, Derila, Bezk, BBCo, Kitty Sub, and Resilia ads that drive most of the spend in this category share structural conventions that only become visible by reading 5+ in a row. Specifically, swipes inform:

- **Lead style options.** Which of the three POV variants (sufferer / family member / professional, see `named-patterns.md` pattern 9) is currently working in the niche.
- **Hook patterns.** Which 9-word in-feed visible openers stop scroll on this avatar.
- **Mechanism delivery.** Whether the niche is currently using exposition or dialogue framing for mechanism reveals (see `named-patterns.md` pattern 4 dialogue framework).
- **Length calibration.** Whether long-form is converging on the 500-700 line range or compressing toward the 200-280 line medium variant.
- **Image-to-copy ratio.** Whether the Reddit-native subjects in `image-spec.md` are currently dominated by paperwork, body-shot, or comparison framing for the niche.

Skipping swipes risks converging on generic structures that match the named patterns but don't match the avatar's current ad diet. The writer can produce structurally correct long-form that looks unfamiliar to the reader because it doesn't share enough surface texture with what they've recently scrolled past.

## Path Detection

Three paths. The skill asks which to use at the swipe research step.

- **Path A: TrendTrack MCP.** Default if the TrendTrack MCP is connected. Tool sequence runs in-conversation; output lands as an analyzed swipe library directly.
- **Path B: Manual TrendTrack.** Operator runs research in the TrendTrack UI and returns to the conversation with completed analysis. Takes ~30-60 minutes of focused research.
- **Path C: Skip swipe research entirely.** Operator has deep avatar research, format familiarity, and accepts the trade-off of slower iteration on the first draft.

Path Detection happens once per ad. It does NOT cascade. If the operator chooses Path A for one ad and Path C for another, both are valid; the downstream writing step does not branch on which path was used.

## Path A: TrendTrack MCP

Default when the TrendTrack MCP is connected and the brand has an active account.

### Tool sequence

1. **`creative_inspiration_pack`**
   - Inputs (both required): `niche` (the brand's category label, e.g. "joint health", "menopause", "men's vitality"), `keywords` (an LLM-generated list derived from avatar pain language plus the product's mechanism, e.g. ["morning stiffness", "hormone reset", "circulation", "Amish remedy"]).
   - Output: 10-20 active Meta ads with hook lines, landing-page URLs, and copy snippets.
   - Purpose: cast a wide net for niche-relevant inspiration. The keyword list is what determines whether the pack returns long-format or short-format candidates; bias keywords toward the avatar's internal monologue (see `deep-avatar-research-prompt.md`) rather than generic category terms.

2. **`scan_ad` on top 5-8 candidates from the pack.**
   - Input: `ad_identifier` (Meta Ad Library URL, TrendTrack URL, or public ad id from the pack output).
   - Output: source-labeled hook, copy framing, creative structure, lifetime in days, scaling verdict.
   - Purpose: verify long-format and extract structural details. Filter heuristic: discard candidates where the copy framing field reports fewer than 3-4 distinct sections, or where the hook does not pose a clear info gap. These are short-form ads that look long-form in the pack but won't carry structural lessons.

3. **(optional) `search_advertisers`** when the pack returns repeating brand names.
   - Inputs: `query` (the brand's category label or general market term), `sort_by`: one of `active_ads` | `reach` | `growth` | `ads_launched` | `relevance` (default `relevance`).
   - `sort_by` selection guide for swipe research:
     - `active_ads`: high ad volume signals committed long-format spenders.
     - `reach`: high audience reach signals proven scaling.
     - `growth`: 14-day reach growth signals current traction. Use when looking for who is scaling RIGHT NOW.
     - `ads_launched`: launch volume signals testing-velocity. Use when looking for high-iteration advertisers worth modeling.
     - `relevance`: default; matches query semantics.
   - Default for swipe research: `active_ads` or `reach` (proven volume). Switch to `growth` when the seed brand list goes stale.
   - Output: brands sorted by the chosen signal.
   - Purpose: identify the "same brands keep showing up" pattern. If three or four brands dominate the niche's long-format output, those are the seed brands for the next swipe library refresh.

### Concrete example: joint-health niche

For a joint-health brand whose primary avatar is "55-year-old woman, lifelong active, started getting morning stiffness at 50, has tried glucosamine + chondroitin + multiple physical therapists":

```
creative_inspiration_pack(
  niche: "joint health",
  keywords: [
    "morning stiffness",
    "knees crack",
    "glucosamine didn't work",
    "Amish remedy",
    "cartilage rebuild",
    "tried everything"
  ]
)
```

The keyword list weights toward the avatar's internal monologue (the failed-attempt phrases and the unfamiliar-mechanism phrases) rather than generic category terms ("joint pain", "arthritis"). This biases the pack toward long-format candidates because long-format hooks tend to use the avatar's specific phrasing while short-format hooks use generic category language.

Pack returns 15 ads. Filter the list to top 6 by lifetime days; for each, run:

```
scan_ad(ad_identifier: <url-from-pack>)
```

For each candidate, the structured output reports copy framing (sections, length), hook text, lifetime days, and a scaling verdict. Discard any where copy framing reports fewer than 3-4 distinct sections; those are short-form survivors that crept into the pack via keyword match.

If brand names from the pack repeat (e.g., the same brand appears 3+ times in 6 candidates), call `search_advertisers(query: "joint health", sort_by: "active_ads")` once to get the top-N brands in the niche and cross-reference. This identifies the seed brand list for next quarter's refresh.

### Known gap: copy-length filter

`search_ads` does NOT expose a `min_ad_copy_length` parameter. Operator-side TrendTrack research uses an "ad copy length minimum 2000 words" filter that has no direct MCP equivalent.

Workaround: pass `trend_signal: "longest_running"` (or the equivalent in the current tool schema) as a proxy for long-format. Long-running ads in this category are disproportionately long-format because short-format burns out faster. Then verify each candidate via `scan_ad` to confirm long-format structure (3-4+ distinct sections, clear story arc, hook posing info gap). The proxy plus verification produces ~80% of the precision the manual filter delivers, at the cost of ~20% wasted scan_ad calls on short-form survivors.

### Cost and pacing

Roughly 2 tool calls per swipe library entry (1 inspiration pack call covers 10-20 candidates; 1 scan_ad per surviving candidate). For a working swipe library of 5-8 analyzed swipes, expect 10-15 total tool calls.

Tell the user the run will take a few minutes so it does not appear to hang. The inspiration pack call is the slowest step; subsequent scan_ad calls run faster but accumulate.

### Path A output

The analyzed swipe library is structured per the Output Schema below. No path-specific metadata is added; the schema is identical across Paths A and B so downstream is path-agnostic.

## Path B: Manual TrendTrack

Operator runs the research in the TrendTrack UI and returns with completed analysis. Use this path when the TrendTrack MCP is not connected, when the brand declines to share MCP access, or when the operator's TrendTrack workflow uses filters not exposed by the MCP.

### Filter recipe (apply in TrendTrack UI in this order)

- **Status:** Active
- **Days running:** 15+ (start at 15; experiment with 30, 45, 60 to surface proven winners and not just recent launches)
- **Media type:** Image (long-format static is image-anchored; video and carousel ads are different formats)
- **Language:** English (or the brand's primary market language)
- **Ad copy length:** minimum 2,000 words

The 2,000-word filter is the one that has no MCP equivalent; this is the primary reason Path B exists.

### Seed brand list

High-volume long-format static advertisers as of 2026-Q1: Bezk, Redrovine, BBCo, Kitty Sub, Rosabella, Resilia. Plus any brands the angle card targets as alternative attacks (the brands the avatar has tried or is comparing against; pull from the angle card's alternative-attack section).

Refresh annually. Drift is expected; the high-spending advertisers in this format change faster than typical D2C categories because the format itself is still maturing.

### Per-swipe analysis template

Each swipe entry conforms to the Output Schema below. Operator fills in fields directly while reading the ad in TrendTrack UI; analysis takes ~5-10 minutes per swipe.

### Operator instructions

1. Apply the filter recipe in TrendTrack UI.
2. Read 5-8 ads in the result set, prioritizing the seed brand list and any alternative-attack brands from the angle card.
3. Fill in the Output Schema for each ad.
4. Return to the conversation with the completed analysis.

The skill workflow PAUSES at Step 1.7 until the operator returns. SKILL.md explicitly notes this pause condition.

## Path C: Skip

Acceptable when all three of the following hold:

- Operator has deep avatar research (passes the avatar depth audit at Step 1.5; see `deep-avatar-research-prompt.md`)
- Operator has format familiarity (has shipped 3+ long-format static ads in the past 90 days, OR has read the Rosabella pattern summary plus this skill's reference files end-to-end recently)
- Operator accepts the trade-off: slower iteration on the first draft and higher generic-structure risk

When skipping, log the trade-off in the session log: "Swipe research skipped per operator preference. If first draft underperforms, run swipe research before iteration."

Path C should be the exception, not the default. When in doubt, run Path B; the manual research takes 30-60 minutes but compounds across subsequent ads in the same niche.

## Output Schema (Paths A and B produce identical shape)

Every swipe library entry conforms to this schema:

| Field | Type | Notes |
|---|---|---|
| Swipe ID | URL or screenshot reference | TrendTrack URL or Meta Ad Library URL preferred; screenshot path acceptable |
| Brand | string | Brand name as displayed in the ad |
| Niche | string | Category label; should match the brand's primary category |
| Lead style | enumeration | First-degree sufferer / Family member of sufferer / Professional with sufferer experience (see `named-patterns.md` pattern 9 for taxonomy) |
| Hook (first 1-3 lines) | verbatim string | Exact text of the in-feed visible portion before "see more" expansion |
| Mechanism delivery | enumeration | Exposition / Dialogue with authority / Discovery scene (see `named-patterns.md` pattern 4 dialogue framework for the dialogue option) |
| Length estimate | integer (words) or integer (lines) | Either unit is acceptable; record which unit was used |
| Awareness target | enumeration | Unaware / Problem-Aware / Solution-Aware / Product-Aware (see `angle-roadmap` for awareness vocabulary) |
| Image type | enumeration | Problem-state / Lifestyle / Authority figure / Product / Paperwork (see `image-spec.md` for subject taxonomy) |
| Lifetime (days) | integer | If visible in the source; null if not |
| Notable structural moves | free-form string | Anything else worth noting: unusual section ordering, novel hook pattern, distinctive PS structure, etc. |

Target: 5 analyzed swipes minimum for a working library. 3 acceptable if the niche is small or new.

The "Lead style" enumeration uses the same taxonomy as the three-lead rule, not a new vocabulary. The "Mechanism delivery" enumeration includes "Dialogue with authority" specifically to match the pattern 4 dialogue framework. Both fields are designed so the writing step can pull directly from the swipe library without translation.

### Worked example entry (synthetic, illustrative)

```
Swipe ID: trendtrack.io/ad/AB-12345
Brand: Amish Mountain Naturals
Niche: cardiovascular health (beetroot extract)
Lead style: First-degree sufferer
Hook (first 3 lines):
  "67. Two heart attacks. My doctor wanted statins for life.
   Then I drove out to a farm in rural Pennsylvania.
   What I learned changed everything."
Mechanism delivery: Dialogue with authority
Length estimate: 3,100 words / approx 540 lines
Awareness target: Solution-Aware (high resistance)
Image type: Authority figure (older man on porch, candid phone-camera quality)
Lifetime (days): 47
Notable structural moves:
  - Authority character is named only as "the farmer", never named explicitly;
    pre-empts the "is he real" objection through the reader's own assumption
  - Mechanism reveal is delivered across 4 short dialogue exchanges with
    physical gestures (pointed at a tree, held up a glass, scuffed a boot)
  - Product reveal at word ~2,400 (~77% of body); just past 75% threshold
  - PS callback to the farmer's wife's offhand comment
```

This entry would feed the writing step as: lead-style choice (sufferer POV stable through 3,100 words), mechanism delivery (dialogue with informal authority, three physical gestures), late product reveal (post-75% threshold confirmed), Reddit-native subject (older-man-on-porch falls under "authority figure" in `image-spec.md`).

## What this file does NOT cover

- **Avatar deep research.** That lives in `deep-avatar-research-prompt.md`. Avatar depth and swipe research are independent surfaces; both can be run, neither is required by the other.
- **Story architecture decisions.** Those live in `section-structure.md` (section table, word budgets, ordering rules) and `named-patterns.md` (the 10 patterns and their structural tests). The swipe library informs which structural choices to favor for this avatar; it does not redefine the structure.
- **Image generation.** That lives in `image-spec.md` (Reddit-native style, subject taxonomy, Nano Banana prompt skeleton). The swipe library's "Image type" field tells the writer which subjects are working currently; it does not generate or specify the image itself.
- **Angle card schema.** The angle card is upstream input; see `angle-roadmap` for the schema. The swipe library does not modify the angle card.
- **TrendTrack feature requests.** The `min_ad_copy_length` filter gap is documented above as a known limitation with a workaround. Raising the gap with the TrendTrack team is out of scope for this skill.

## Refresh cadence

The swipe library is per-niche and per-quarter. Within a quarter and a niche, reuse the same library across multiple ads. Across quarters, refresh; ad creative drifts faster than a quarter in long-format static. When refreshing, replace ads that have stopped running rather than the entire library; long-running ads are the ones with the strongest structural lessons.
