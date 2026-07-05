# Triage Rubric (Leverage x Position Weight)

Transcribed from the RMBC operational manual, Stage 5 (`_frameworks/rmbc-operational-manual.md`). This is the mechanical scoring rubric funnel-audit uses to rank leaks. You do not fix leaks in the order you noticed them. You fix them in order of **Leverage x Position Weight**.

The point of the rubric is restraint. Finding fifteen things wrong with a page is easy and useless. Scoring every finding forces you to report only the few that actually move conversions, in the order they should be fixed.

---

## Scoring Leverage (1-5): how much does fixing this move conversions?

- **5 - Foundational.** Breaks belief or blocks the sale outright. A contradiction, a wrong audience, an unbelievable core claim. Fixing it changes whether people buy at all.
- **4 - Structural.** The right elements exist but are in the wrong order or the wrong emphasis, costing conversions across the whole page.
- **3 - Meaningful.** A weak-but-functioning section: soft pain, buried proof, a diluted CTA. Fixing it lifts the section.
- **2 - Polish.** A line or word that could be sharper. Real, but small.
- **1 - Cosmetic.** Formatting, a nitpick, personal taste.

## Scoring Position Weight (1-5): how many buyers does this leak touch?

Score by percentage of readers who still encounter the leak, because attrition is brutal as you scroll.

- **5 - Above the fold / hook.** ~100% of visitors see it. Banner, headline, hero subhead, first CTA.
- **4 - Early body.** ~60-70% remain. The pain section, the first mechanism beat.
- **3 - Mid page.** ~40% remain. Ingredient detail, secondary proof.
- **2 - Late body.** ~20-25% remain. Deep science, FAQ, brand story.
- **1 - Footer.** <10% remain. Fine print, closing lines.

## The score

**Score = Leverage x Position Weight (max 25). Fix highest first.**

## Tie-break and the one judgment override

- **Ties break by fix cost and dependency.** When two findings score the same, the cheaper, zero-downside fix goes first, and the bigger deliberate rebuild goes immediately after. (Example below: a one-line banner delete outranks a full hero restructure at the same score of 20.)
- **The Leverage-5-at-point-of-purchase override.** A Leverage-5 finding that sits exactly at the point of purchase is a must-fix-same-day regardless of its raw score. Position Weight can rank it lower because fewer readers reach the buy point, but a credibility-killer at the decision point is flagged as must-fix anyway. This is the single exception where judgment overrides the number. Everywhere else, the number rules.

---

## Canonical worked example (the five Regrowth+ leaks)

This is the reference scoring table from the manual. Use it as the model for how to reason Leverage and Position Weight for each finding you report.

| # | Leak | Leverage | Why that leverage | Position Wt | Why that weight | Score | Priority |
|---|------|----------|-------------------|-------------|-----------------|-------|----------|
| 1 | "Summer heat" banner contradicts the water angle | 4 | Structural - it fights your whole mechanism before it starts | 5 | Top banner, ~100% of visitors | 20 | 1 |
| 2 | Best line (shower-drain subhead) buried under a corporate headline; dual CTA | 4 | Structural - strongest hook is misplaced and action is split | 5 | Hero, ~100% of visitors | 20 | 2 |
| 3 | "4.9 stars" in hero vs "No Reviews" on product card | 5 | Foundational - a credibility contradiction that kills belief at the buy point | 3 | Product card, mid-page ~40% - but it's the decision point | 15 | 3 |
| 4 | Pain section is mechanical, not emotional; misses the expat identity moment | 3 | Meaningful - functioning but underpowered emotionally | 4 | Early body, ~60-70% remain | 12 | 4 |
| 5 | Week 1/3/6 timeline (strong) buried in "Why It Works" | 3 | Meaningful - great asset in the wrong place | 3 | Mid-page, ~40% remain | 9 | 5 |

**Reading the tie and the near-tie:**

- Leaks 1 and 2 both score 20. Break the tie by fix cost and dependency: killing the banner (1) is a one-line delete with zero downside, so it goes first; the hero restructure (2) is a bigger job that you want to do deliberately right after.
- Leak 3 scores 15 despite being the only Leverage-5 item, because far fewer readers reach the product card than the hero. But because it is Leverage-5 AND sits exactly at the decision point, treat it as a must-fix-same-day even though the math ranks it third. When a Leverage-5 lands at the point of purchase, flag it regardless of raw score. That is the one exception where you let judgment override the number.

---

## Output contract

The audit output is a **ranked leak table**, sorted by total score descending, reporting only the **top 3-5 findings**:

| Leak | Leverage (+ rationale) | Position Weight (+ rationale) | Total | Priority |
|------|------------------------|-------------------------------|-------|----------|

Follow the table with fix recommendations for the top items only. Do not write fixes for findings that did not make the top 3-5. Restraint is the skill.
