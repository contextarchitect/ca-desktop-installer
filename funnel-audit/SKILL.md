---
name: funnel-audit
version: "1.0.0"
description: "Diagnostic teardown of existing funnel pages, product pages, checkout flows, and competitor pages: find the conversion leaks and rank them by impact. Runs Layer 0 foundation gates (awareness match, format fit, premise believability), then RMBC in reverse (Research, Mechanism, Brief, Copy interrogation), then the 15-point advertorial/listicle frame-rules pass, then scores every finding on Leverage x Position Weight and reports only the top 3-5. This is the audit counterpart to funnel-builder (build-mode). Reads brand upstream docs (avatar research, angle roadmap, copywriting guide) when available, and cross-references funnel-builder's format library for structural expectations. Trigger on: 'audit this page', 'audit this funnel', 'why isn't this converting', 'find the leaks', 'leak audit', 'copy teardown', 'tear down this page', 'CRO copy audit', 'review this landing page'."
---

# Funnel Audit Skill

## Purpose

Diagnose why an existing page is not converting and return a short, ranked list of the leaks that matter, with fixes for the top few only. This is the diagnostic counterpart to `funnel-builder`: funnel-builder builds pages forward from research; funnel-audit tears existing pages down in reverse to find what is bleeding conversions.

The discipline of this skill is restraint. Finding fifteen things wrong with a page is easy and useless. The skill is scoring every finding and reporting only the 3-5 that actually move the number, in the order they should be fixed.

## When to Use

- User asks to audit a page, funnel, product page, or checkout flow
- User asks why a page is not converting, or to "find the leaks"
- User wants a copy teardown or CRO copy audit of a landing page
- User wants a competitor page torn down to learn from it
- A funnel-builder page has shipped and underperformed (see funnel-builder's ecosystem note: funnel-audit is the diagnostic path)

## Scope

Existing funnel pages (advertorials, listicles), product pages, checkout flows, and competitor pages. Anything with copy that is live and can be read line by line.

This skill diagnoses. It does not rebuild the page end to end. It hands its ranked findings and top-item fixes to the operator (or to `funnel-builder` in build-mode) for the actual rewrite.

## Inputs

### The page under audit (required)

The live URL, a screenshot set, or the pasted copy of the page. Line-level work needs the actual words, not a summary.

### Brand upstream docs (read when available)

These are the intended-argument baseline. When they exist for the brand, the audit checks the page *against* them; when they do not, the audit proceeds on the page alone and flags that the intended argument could not be verified against source.

- **Avatar Research (Phase 2)** - the real voice-of-customer, awareness stage, objections, emotional drivers. The believability and identification checks lean on this.
- **Angle Roadmap (Phase 4.5)** - the intended argument for this page. Read against two layers, by their real schema names (see `../angle-roadmap/references/angle-card-schema.md`): the roadmap's **Root Cause Narrative** (Step 1A) and **Solution Mechanism Narrative** (Step 1B) sections, and the driving **angle card**'s fields: **Root Cause Frame**, **Mechanism Frame**, **Lead Emotion** (the opening emotional trigger), **Core Feeling** (the one core feeling the angle serves; enum canonical source `../copywriting-guide/SKILL.md` §8.7 The Five Core Feelings Library), **Alternative Attack**, **Key Objection to Preempt**, **Lead Framing Route**, **Recommended Format**, and **Schema Version**. This is the baseline the page is measured against. Drift from the angle card is a high-priority finding: the page's opening emotion should match Lead Emotion and its emotional through-line should serve Core Feeling. Read the card's **Schema Version** and, for any required field that is absent, apply the schema's missing-field precedence matrix (see `../angle-roadmap/references/angle-card-schema.md` "Missing-field precedence") rather than assuming a fixed default.
  - Terminology. This skill uses the ContextArchitect names Root Cause Narrative and Solution Mechanism Narrative; the RMBC framework calls these the Unique Mechanism of the Problem (UMP) and Unique Mechanism of the Solution (UMS), per the canonical precedence in the angle-card schema's "Canonical sources and terminology" section. The angle card's Lead Framing Route field carries literal enum values defined in the angle-card schema; read them verbatim as that field's values.
- **Copywriting Guide (Phase 4)** - the §8 universal structural rules are the line-level standard the Copy stage checks against.

### Format library (cross-reference)

`../funnel-builder/references/format-library.md` and `../funnel-builder/references/advertorial-framework.md` define the structural expectations for each format. Use them to judge whether the page's architecture fits its format and its traffic.

## The Audit Engine

Run these four steps in order. Do not start line-level work before the foundation gates and the RMBC-reverse pass, because a page can be word-perfect and still fail Layer 0.

### (a) Layer 0: Foundation Gates (disqualifiers, checked first)

Before any line-level work, check the three foundation gates. A failure here is foundational: it caps the page's ceiling no matter how good the copy is, so flag it before proceeding. Any Layer 0 failure enters triage at high Leverage (typically 4-5).

1. **Awareness-level match.** Does the copy's entry point match the awareness level of the traffic being sent to it? Cold, problem-aware traffic dropped onto a product-aware offer page (or the reverse) leaks at the top no matter what the body says. Check the traffic source against the entry point. A special case: a **Most-Aware** audience should not have been sent through an interstitial funnel page at all (funnel-builder's Step 0.1 awareness early-exit gate routes most-aware traffic straight to the offer); a most-aware audience on a full funnel page is itself a Layer 0 awareness-match failure. (See `_frameworks/awareness-vocabulary.md`, funnel-builder's Step 0.1 gate, and the angle card's awareness stage.)

2. **Format fit.** Is the format right for the product, the audience, and the traffic temperature? A high-resistance skeptical audience on a thin PAS page, or warm product-aware traffic forced through a full 9-section advertorial, is a format mismatch. Check the page's format against the format-library selection logic.

3. **Core premise believability.** Would a skeptical reader accept the page's central premise without a leap of faith? If the core claim or the core mechanism requires belief the page has not earned, nothing downstream converts. Read the premise as the most skeptical reader in the target market would.

If any gate fails, flag it as foundational before moving on. You still run the rest of the audit, but the Layer 0 finding is the headline.

### (b) RMBC, Run in Reverse

The page was (implicitly or explicitly) built through Research, Mechanism, Brief, Copy. Interrogate each stage backward to locate where the argument breaks. Copy is checked LAST, because a beautifully worded page built on a broken mechanism is still a broken page.

**R - Research.** Is the page built on real voice-of-customer, or on marketer assumptions? Does the pain language match how the avatar actually talks (check against avatar research)? Generic, invented, or marketer-voice pain is a Research failure that shows up as copy that does not resonate.

**M - Mechanism.** Is the Root Cause Narrative present, and is it revealed BEFORE the Solution Mechanism Narrative? Are both mechanisms named and specific, or vague and interchangeable with any competitor? A missing Root Cause Narrative, a Solution Mechanism Narrative that arrives before the problem is understood, or two competing mechanisms fighting each other are all Mechanism failures.

**B - Brief.** Does the sequence follow the persuasive spine as defined in funnel-builder Core Principles (the canonical statement in `../funnel-builder/SKILL.md`, "The Persuasive Spine and Entry Point")? This stage does not re-enumerate that order; it applies the audit-specific checks that are not order restatements: is proof adjacent to the claim it supports, not stranded paragraphs away? Are there dead-end sections where the reader can comfortably stop? Does each section hand off with a warm transition (an open loop) to the next step? Sequence, proof-adjacency, and hand-off failures are Brief failures.

**C - Copy (checked LAST).** Only now, line-level craft: sentence rhythm and burstiness, front-loaded points, one idea per sentence, bucket-brigade transitions, forbidden constructions. The line-level standard is `../copywriting-guide/SKILL.md` §8 (universal structural rules) and its humanization rules. Do not spend the audit here until R, M, and B pass.

### (c) Advertorial / Listicle Frame Lens

If the page is an advertorial or a listicle, run the 15-point frame-rules pass in `references/frame-rules.md`. Each rule is a PASS/FAIL gate on whether the page holds its editorial frame (verdict/reveal timing, balance/coverage including the 2:1 competitor-coverage ratio, voice/source integrity, congruence/continuity, transition integrity). Every FAIL is a candidate finding that feeds into triage.

### (d) Triage: Score, Rank, Report the Top 3-5

Every finding from (a), (b), and (c) gets scored with the rubric in `references/triage-rubric.md`:

- **Leverage (1-5)** - how much fixing it moves conversions.
- **Position Weight (1-5)** - how many readers still encounter it (attrition-adjusted).
- **Score = Leverage x Position Weight (max 25).** Ties break by fix cost and dependency. The one judgment override: a Leverage-5 finding at the point of purchase is must-fix-same-day regardless of raw score.

**Finding fifteen things is easy and useless. Restraint is the skill.** Report only the top 3-5 findings by score.

## Output Contract

Deliver, in this order:

1. **A ranked leak table**, sorted by total score descending, top 3-5 only:

   | Leak | Leverage (+ rationale) | Position Weight (+ rationale) | Total | Priority |
   |------|------------------------|-------------------------------|-------|----------|

2. **Fix recommendations for the top items only.** Do not write fixes for findings that did not make the top 3-5.

If a Layer 0 gate failed, state it as the headline above the table (a foundational cap is more important than any line-level leak). If the page was audited without its angle card or avatar research, state that the intended argument could not be verified against source.

## Cross-References

- **Build-mode counterpart:** `../funnel-builder/SKILL.md`. When a top finding needs a full rebuild, hand it to funnel-builder.
- **Structural expectations:** `../funnel-builder/references/advertorial-framework.md`, `../funnel-builder/references/format-library.md`.
- **Line-level standard:** `../copywriting-guide/SKILL.md` §8 (universal structural rules) and `../copywriting-guide/references/humanization-rules.md`.
- **Intended-argument baseline:** `../angle-roadmap/references/angle-card-schema.md`. Real card fields: Root Cause Frame, Mechanism Frame, Lead Emotion, Core Feeling, Alternative Attack, Key Objection to Preempt, Lead Framing Route, Recommended Format, Schema Version. Plus the roadmap's Root Cause Narrative and Solution Mechanism Narrative sections (Step 1A/1B).
- **Source manual:** `_frameworks/rmbc-operational-manual.md` (Stages 5 and 6 are transcribed into this skill's reference files).

## What This Skill Does NOT Do

- Does not rebuild the page end to end (produces ranked findings + top-item fixes; funnel-builder rebuilds)
- Does not generate images or deploy anything
- Does not report every leak it finds (reports only the top 3-5 by score; restraint is the point)
- Does not audit brand strategy or run avatar research (reads those as inputs when available)
