# Deep Avatar Research Prompt

A paste-ready Deep Research prompt template for producing avatar specificity beyond what Phase 2 typically supplies. Used at the avatar depth audit step (Step 1.5 in SKILL.md) when Phase 2 research lacks the texture long-form static requires.

## When to use this

Phase 2 avatar research is sufficient for most workflows in this skill's broader pipeline (advertorials, listicles, scripts). Long-format static is the format that pushes hardest on avatar specificity, because the identification opener, antecedent story, and failed-solution stack sections each draw directly from raw avatar quotes. A thin Phase 2 produces ads that read like a brand voice imitating an avatar, not an avatar telling their own story.

Use this prompt when Phase 2 lacks any of the following:

- **The morning-it-clicked moment.** A specific date / time of day / scene where the problem became impossible to ignore. Generic "I started noticing" doesn't work; the writer needs "It was a Tuesday in October, I was kneeling to tie my shoe, and I couldn't stand back up."
- **Exact internal monologue verbatim.** 10-15 self-talk phrases the avatar uses in their own head. "I'm just not a morning person." "Maybe this is what 45 feels like." "I'm running on fumes." These are the exact phrases the ad will reuse, paraphrased only as much as necessary for paragraph flow.
- **Sequenced failed-attempts list with named products and durations.** Not a generic list, but a specific sequence with brands, dosages, and durations. "Iron supplement (Slow-Fe, 6 weeks) → melatonin (5mg, 3 months) → sleep app (Calm, 2 months) → expensive mattress ($1,800, kept 2 years) → doctor visit with normal bloodwork."
- **Relationships affected with specific people and named consequences.** Who noticed, who picked up the slack, who made a comment that stung. Specific, not abstract.
- **The unspoken fear.** What the avatar does not say out loud. Missing kids' childhood, marriage falling apart, getting fired, becoming their parent. The emotional engine of the ad.

This prompt is independent of swipe research and TrendTrack availability (see `swipe-research-protocol.md`). Avatar depth and competitive intelligence are different surfaces; both can be run, neither is required by the other.

## How to use this

1. Copy the prompt template below.
2. Fill in CONTEXT (brand, product, primary avatar from Phase 2) and SOURCES (competitor product names for Amazon review searches, niche-specific subreddits, niche-specific Facebook groups).
3. Paste into Deep Research.
4. Wait for output. Typical runtime: 1-2 hours.
5. Returns a structured markdown document, ~1,500-2,500 words, with raw quotes preserved verbatim and source per quote.
6. Bring back to the long-form-static-builder workflow at the INGEST step (Step 1) and re-attempt the avatar depth audit (Step 1.5).

The output is raw material, not a finished avatar profile. The writer pulls verbatim phrases, sequences, and moments directly into the ad without paraphrasing beyond what paragraph flow requires.

## The prompt template

```
DEEP AVATAR RESEARCH FOR LONG-FORM STATIC AD
============================================

CONTEXT
-------
Brand: [brand name]
Product: [product name + 1-line description]
Primary avatar from Phase 2: [age range, role, condition or situation,
  Phase 2 demographic / psychographic summary]
Existing Phase 2 gaps to fill: [list the specific items missing from
  Phase 2 that this research must produce; reference the five required
  outputs below]

OBJECTIVE
---------
Produce avatar-depth research suitable for writing a 500-1,000 line
narrative-driven Facebook ad. The ad reads as a personal story; it
requires specificity Phase 2 does not always supply. The writer will
pull verbatim phrases and specific moments directly into the ad copy.
Do not synthesize quotes into narrative; preserve raw quotes with
source attribution.

REQUIRED OUTPUTS (five sections, each populated with verbatim quotes)
---------------------------------------------------------------------

1. THE MORNING IT CLICKED
   Find 5-10 specific moments from real customers (in source list below)
   where someone realized the problem had reached a tipping point.
   Capture: date or season, time of day, what they were doing, what
   specifically broke, what they thought in the moment. Source per quote.

2. INTERNAL MONOLOGUE
   Find 10-15 verbatim self-talk phrases from real customers describing
   the problem in their own head. These are the phrases the ad will reuse.
   Examples of the right shape: "I'm just not a morning person." "Maybe
   this is what 45 feels like." "I'm running on fumes." Avoid paraphrased
   summaries; preserve verbatim. Source per quote.

3. FAILED ATTEMPTS SEQUENCE
   For the primary avatar, find 3-5 typical sequences of things they
   tried, in order, with named products and durations. Format:
   "[Product 1] ([brand], [dosage], [duration]) → [Product 2] ...".
   The ad will mirror one of these sequences in the failed-solution
   stack section. Source per sequence.

4. RELATIONSHIPS AFFECTED
   Find 5-10 examples of how the problem affected relationships. Who
   noticed (spouse / child / coworker / parent), who picked up the
   slack, who made a comment that stung. Specific people, specific
   moments, not abstract claims about "my family suffered". Source
   per example.

5. THE UNSPOKEN FEAR
   Find 3-5 examples of the fear customers do NOT say out loud, but
   that surfaces in their writing under emotional pressure. Common
   shapes: missing kids' childhood, marriage falling apart, getting
   fired, becoming their parent, losing identity. Source per example.

SOURCES (research these in order of priority)
---------------------------------------------
- Amazon reviews (1-star and 5-star) of: [list 3-5 competitor products
  in the same category, including the strongest direct competitor]
- Reddit search: "[niche] frustrated", "[niche] nothing works",
  "[niche] giving up", "[niche] tried everything"; subreddits
  [list 2-3 niche-specific subreddits]
- Facebook groups for [avatar demographic], particularly groups with
  500-5,000 members where members share daily struggles
- Customer support tickets if the brand will share them
- Customer call transcripts if the brand records and will share them

OUTPUT FORMAT
-------------
Structured markdown, 1,500-2,500 words. Each of the five required
output sections is its own heading. Each quote is preserved verbatim,
with source on the same line in italics. No paraphrased summaries
unless the source is too long to quote in full, and even then preserve
the most emotionally specific 1-2 sentences verbatim.

CRITICAL: this is research, not writing. Do not write the ad. Do not
synthesize quotes into a narrative. The writer needs the raw material;
narrative synthesis is the writer's job, not the researcher's.
```

## Source priority

When the researcher cannot find enough material in one source, prioritize in this order:

1. Amazon reviews (1-star and 5-star of direct competitor products)
2. Reddit threads (problem-keyword searches, niche-specific subreddits)
3. Facebook groups (avatar demographic, 500-5,000 members)
4. Customer support tickets (require brand cooperation)
5. Customer call transcripts (require brand cooperation and recording infrastructure)

The first three are accessible without brand-side data. The last two require brand cooperation and may not be available; the prompt produces a usable research document from sources 1-3 alone if needed.

## What to do with the output

The output feeds the identification opener, antecedent / catalyst story, and failed-solution stack sections of the ad specifically. Other sections of the long-form static draw from different sources:

- **Mechanism reveal** draws from the angle card's root cause + mechanism narratives, not from this avatar research.
- **Differentiation block** draws from product specifics and brand guidelines, not from this avatar research.
- **Authority closure** draws from the angle card's authority pattern selection (`named-patterns.md` pattern 8), not from this avatar research.
- **Results timeline** draws from product testimonials and brand-supplied transformation timelines, not from this avatar research.

Mirrors the shape of `../../angle-roadmap/references/root-cause-research-prompt.md`. If the angle-roadmap research prompt was already run for this brand, the deep-avatar prompt complements it; the angle-roadmap prompt produces the root-cause + mechanism narrative, the deep-avatar prompt produces the avatar specificity that becomes the identification + antecedent + failed-solution sections.

## What this file does NOT cover

- Phase 2 avatar research itself (run via `avatar-research` skill)
- Angle card generation (run via `angle-roadmap`)
- Swipe research (see `swipe-research-protocol.md`)
- Brand voice or compliance constraints (see `copywriting-guide` Phase 4 outputs)
