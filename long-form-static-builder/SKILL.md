---
name: long-form-static-builder
version: 1.2.0
description: "Generate production-ready long-form static ad copy for Facebook/Meta. Long-form advertorials (2,500-3,500 words full variant, 1,000-1,400 medium, 200-300 fake-complaint) embedded as ad primary text alongside a single image. Use when the user wants 'long form static', 'native ad copy', 'in-feed advertorial', 'ad primary text', 'Rosabella-style ad', '2500 word ad copy', or references the long-form-static format. Reads avatar research, angle roadmap, brand guidelines, and copywriting guide as inputs. Sits between video-script-generator and funnel-builder. Long-form-statics are ads, not landing pages."
---

# Long-Form Static Builder Skill

## Purpose

Long-form static is a Facebook in-feed ad format where the entire advertorial body lives as the ad's primary text. The image is a single visual hook (Reddit-native or candid style). The reader scrolls inside the ad, not on a landing page. This skill produces the complete primary text plus the image specification needed to ship the ad.

This is structurally different from a script (which gets performed) and from a landing page (which has its own URL). It is a third format that previously lived in no skill. The Rosabella ad library is the canonical industry reference for what good looks like in this format. Section structure, the three-lead rule, and the desperation-frame discovery story are validated patterns from production ads with extended runtime.

## When to Use

**Trigger phrases:**

- "Build a long-form static" / "long form static ad"
- "Native ad copy" / "in-feed advertorial"
- "Ad primary text" (when the user wants the full body, not just a hook line)
- "Rosabella-style ad" / "Rosabella long-form"
- "2500 word ad copy" / "3000 word ad copy"
- "Fake-complaint ad" / "customer-to-customer Reddit-style ad"

**Also trigger when:**

- User has completed the angle roadmap and wants to test the long-form-static format
- User references Rosabella as a reference brand
- User says "let's try the native style ad format"
- User is working through Phase 4.5+ outputs and needs ads (not scripts, not pages)

## Critical Architecture Rule

Long-form-static is generated as PRIMARY TEXT for a Facebook ad. The output is paste-ready copy plus a separate image specification. It is NOT a landing page. It is NOT a video script.

| Created by THIS skill | Created elsewhere |
|----------------------|-------------------|
| Three POV-variant ad bodies (per the three-lead rule) | Image asset (handed off to ad-style-generator) |
| Hook + headline + PS + PPS for each variant | Landing page (funnel-builder) |
| Image specification (Reddit-native style) | Performed scripts (video-script-generator) |
| Repurposing instructions (notes for video adaptations) | Angle card (angle-roadmap) |

The skill produces the spec for the image but does not produce the image itself. When the ad-style-generator's Reddit-native style is added in its upcoming enhancement, this image spec is the canonical handoff. Until then, the spec is paste-ready for direct Nano Banana use.

## Required Inputs

### From Previous Phases (Read First)

1. **Avatar Research (Phase 2)** - emotional triggers, language patterns, failed solutions, day-to-day struggles, raw quotes. Used to write identification sections in the avatar's own voice.
2. **Brand Guidelines (Phase 3)** - voice pillars, claim boundaries, positioning. Used to keep the ad on-brand and within compliance.
3. **Copywriting Guide (Phase 4)** - humanization rules, forbidden vocabulary, archetype tone. Used to enforce voice during writing.
4. **Angle Roadmap (Phase 4.5) - REQUIRED** - the angle card driving this specific ad. Long-form-static is angle-anchored. Without an angle card the skill cannot proceed; ask the user to run `angle-roadmap` first.

### Per-Request Inputs (Ask via `ask_user_input_v0`)

```
1. Which angle from the roadmap should drive this ad?
   (List angle card names if multiple are available.)

2. Run swipe research?
   [Yes - via TrendTrack MCP (default if connected) /
    Yes - operator will run TrendTrack UI manually /
    No - skip swipe research entirely]
   (See `references/swipe-research-protocol.md` for path detail.
    The choice does not affect downstream writing; it only changes
    how the swipe library is produced.)

3. Which awareness stage is this ad targeting?
   [Defaults to the angle card's stage if Schwartz onboarding is done.
    Override only if the user has a specific reason.]

4. Which format variant?
   [Full long-form (2,500+ words) /
    Medium long-form (1,200 words) /
    Fake-complaint short-form (250 words, solution-aware bottom-funnel only)]

5. POV preference?
   [Default: generate three POV variants per the three-lead rule.
    Override only if the user wants a single POV.]

6. CTA destination?
   [Sales page lander / listicle / advertorial.
    NEVER direct-to-PDP per Sufian's funnel guidance.]
```

Store these as the per-ad configuration. Subsequent ads in the same campaign reuse the same upstream documents but get their own per-request inputs.

## Workflow Overview

```
1.   INGEST          -> Read 4 upstream docs + per-request inputs
1.5. AVATAR DEPTH    -> Audit Phase 2 vs references/deep-avatar-research-prompt.md;
                        if thin, output the prompt and PAUSE workflow
1.7. SWIPE RESEARCH  -> Optional, path-divergent (MCP / manual / skip);
                        produces analyzed swipe library
2.   SELECT          -> Choose format variant + 3 POV variants
3.   STRUCTURE       -> Apply section structure from references/section-structure.md
4.   WRITE           -> Generate body copy following Rosabella playbook
5.   IMAGE-SPEC      -> Generate Reddit-native image spec (handoff to ad-style-generator)
6.   SELF-TEST       -> Run Yes-Yes-Yes self-test + 14-point quality checklist
7.   OUTPUT          -> Deliver three POV-variant copies + image spec + repurposing notes
```

Steps 2-7 are **path-agnostic**. They consume the swipe library if one exists, but do not branch on which path produced it (or whether it exists at all). If Step 1.7 took Path C (skip), Step 3 onwards proceeds from angle card + avatar research alone, with the caveat noted in the session log.

## Step-by-Step Instructions

### Step 1: Ingest

Read the four upstream documents in order. The angle roadmap is hard-required. The other three are strongly recommended; if any are missing, flag it and ask the user whether to proceed with reduced quality or pause and run the upstream skill first.

Read avatar research with the specific angle in mind. Pull raw quotes that match the angle's emotional trigger and core desire. These quotes become the seed material for identification sections.

### Step 1.5: Avatar Depth Audit

Phase 2 avatar research is sufficient for most workflows in this skill's pipeline. Long-format static is the format that pushes hardest on avatar specificity, because the identification opener, antecedent / catalyst story, and failed-solution stack sections each draw directly from raw avatar quotes.

Audit the Phase 2 output against the five required outputs in `references/deep-avatar-research-prompt.md`:

1. The morning-it-clicked moment (5-10 specific tipping-point scenes)
2. Internal monologue verbatim (10-15 self-talk phrases)
3. Sequenced failed-attempts list (3-5 sequences with named brands and durations)
4. Relationships affected (5-10 specific people and named consequences)
5. The unspoken fear (3-5 examples)

If Phase 2 covers all five with sufficient texture: proceed to Step 1.7.

If Phase 2 is thin on any required output: output the prompt template from `references/deep-avatar-research-prompt.md` with CONTEXT and SOURCES filled in from this brand's Phase 2 + competitor list. **STOP. Pause the workflow.** Wait for the user to run the prompt in Deep Research and return with the output (~1-2 hour runtime). Resume at INGEST with the new avatar research document layered on top of Phase 2.

### Step 1.7: Swipe Research

Optional, path-divergent. See `references/swipe-research-protocol.md` for the full protocol. The path was chosen at the per-request inputs step (question 2 in the `ask_user_input_v0` block).

**Path A (TrendTrack MCP).** Run the tool sequence from `references/swipe-research-protocol.md` Path A: `creative_inspiration_pack` (niche + keywords required) → `scan_ad` on top 5-8 candidates (filter to long-format) → optional `search_advertisers` if pack returns repeating brands. Produce an analyzed swipe library per the Output Schema in that file. Tell the user the run will take a few minutes so it does not appear to hang.

**Path B (Manual TrendTrack).** Output the filter recipe and seed brand list from `references/swipe-research-protocol.md` Path B. **STOP. Pause the workflow.** Wait for the operator to run the research in TrendTrack UI (~30-60 minutes) and return with the analyzed swipe library in the Output Schema shape.

**Path C (Skip).** Note in the session log: "Swipe research skipped per operator preference. If first draft underperforms, run swipe research before iteration." Proceed to Step 2.

The swipe library, if produced, is consumed at Step 3 (STRUCTURE) and Step 4 (WRITE) as input alongside the angle card and avatar research. Steps 2 onwards do **not** branch on which path produced the library; they only branch on whether a library exists.

### Step 2: Select Format Variant

Decision logic:

| Awareness stage of angle | Recommended variant | Use case |
|--------------------------|---------------------|----------|
| Problem-aware | Full long-form (2,500+ words) | Default. Reader needs the full discovery arc |
| Solution-aware (high resistance) | Full long-form | Same as above when readers have failed multiple solutions |
| Solution-aware (medium resistance) | Medium long-form (1,200 words) | Faster read, all sections present but compressed |
| Solution-aware (heavy social proof) | Fake-complaint short-form (250 words) | Bottom-funnel only. Customer-to-customer voice. No claims. |
| Problem-unaware | Full long-form | Needs maximum education runway |
| Product-aware | Medium long-form | Less education needed |

The fake-complaint short-form is a different beast. Use ONLY for solution-aware bottom-funnel where the angle has heavy social-proof equity. Reference: Rosabella variant #7 (the customer-to-customer Reddit-style post that complains about something positive, like a renewed sale price or kept free shipping). No mechanism. No story arc. Pattern documented in `references/section-structure.md`.

### Step 3: Apply Section Structure

Read `references/section-structure.md` for the full template. The structure is the same across full and medium long-form; the medium variant compresses each section by roughly 50%, it does not remove sections. Fake-complaint short-form has its own micro-structure documented in the same file.

Map each section to a word budget. Track running word count as you write so the final total lands inside the variant's range.

### Step 4: Write Body Copy

Read `references/named-patterns.md` for the full playbook. The 10 patterns are non-optional structural rules:

1. **The desperation frame** - character in extremis makes an unusual decision (drives 6 hours, talks to a stranger at 2 AM, etc.). This is the discovery vehicle.
2. **The discovery story** - what the character finds at the end of the desperation arc. The mechanism enters here, organically.
3. **Identification before mechanism** - mirror symptoms, lifestyle, and failed solutions BEFORE introducing the mechanism. Mechanism before identification produces no conversions.
4. **Three-stage mechanism explanation** - name, then explain with analogy, then differentiate with numbers. Depth depends on awareness and sophistication.
5. **Bridges between every section** - no abrupt transitions. Every section break gets an explicit connector sentence.
6. **Time-delay anchoring before any results claim** - week-by-week, day-by-day specifics. Not "results fast." Not "many people see results."
7. **One core feeling sustained throughout** - vindication, loss aversion, betrayal, desperation, or identity. Pick one. Every sentence serves it.
8. **Authority hook patterns** - four sub-patterns (Classic, Doctor's Surprise, Doctor's Skepticism, Study/Research). Pick the one that matches the angle.
9. **The three-lead rule** - same body, three POV variants. POV options: first-degree sufferer, family member of sufferer, professional with sufferer experience.
10. **POV stability** - once a POV is chosen, never break it. The product enters from inside the POV, not from a narrator stepping in.

Write the full long-form (or compressed medium) once for the primary POV. Then produce the two POV variants by rewriting from a different storyteller's vantage point. Do not word-substitute; actually re-tell the story from that POV.

If a swipe library was produced at Step 1.7, consume it at this stage: pull lead-style choice, mechanism delivery convention, and image-type signal from the most relevant swipe entries. The library is reference material, not a template; do not copy verbatim.

For beat-level audit reference, see `references/worked-examples.md` (two long-format static ads broken down beat-by-beat, mapped to the section structure and named patterns). Use the example whose lead style most closely matches your angle's POV variant as a pre-draft read; the audit checklist at the end of that file complements the 14-point self-test in Step 6.

### Step 5: Image Specification

Read `references/image-spec.md` for the Reddit-native style spec. Produce ONE image spec per ad (not per POV variant - the same image runs across the three variants).

The spec is a complete Nano Banana prompt with the Reddit-native constraints baked in. Aspect ratio 4:5. Ugly, candid, low-light. No obvious AI tells. The spec is paste-ready for direct Nano Banana use. When ad-style-generator's Reddit-native style is added in its upcoming enhancement, the same spec becomes the handoff payload to that skill.

### Step 6: Self-Test

Read `references/self-test-checklist.md`. Run the 14-point check against each POV variant before output. The mandatory checks are:

- Yes-Yes-Yes chain earned (root cause clicks, mechanism clicks, product clicks, close clicks)
- Identification precedes mechanism
- Hook quality: 9 words max for the in-feed visible portion, identity marker present, info gap created
- Bridges present at every section transition
- Time-delay anchored before any results claim
- One core feeling sustained throughout
- "Best ads can start at any line" test: cut the hook, does line 2 still work as a hook?
- POV stability across the whole body
- Three POV variants are structurally distinct (not word-substitution)

If any item fails, fix before output.

### Step 7: Output

The output contract depends on the format variant selected in Step 2.

**Full long-form OR Medium long-form** (default delivery):

1. Three POV-variant copies (full body, hook, headline, PS, PPS, CTA placement notes)
2. One image specification (paste-ready Nano Banana prompt + handoff format for ad-style-generator)
3. Repurposing instructions (how to convert the same body to a movie-credits scrolling video ad and a UGC long-form yap-session script - hands off to `video-script-generator`)
4. Rejection notes (any quality-checklist items the writer should review before publishing)

**Fake-complaint short-form** (different delivery contract):

1. One to three short complaint-format variants (NOT the three-lead rule. Variants here differ by complaint subject, not by POV. Examples: sale-price renewal complaint, free-shipping complaint, guarantee-extension complaint.)
2. One image specification (Reddit-native, but typically a screenshot-style subject: phone screen, comments thread, order confirmation. Same handoff format as the long-form variants.)
3. NO repurposing instructions (fake-complaint short-form does not adapt cleanly to video; if the user wants video, run `video-script-generator` directly with the angle card)
4. Rejection notes (run only the subset of self-test items that apply: hook quality, voice rules, no verbatim Rosabella, no claims about the product)

## Output Format

### Long-Form Output (Full or Medium variants)

For each of the three POV variants, produce a block in this shape:

```markdown
## VARIANT [N]: [POV NAME, e.g., "Son's perspective"]

### In-feed visible (hook + first line)
[Hook, max 9 words. Then the first line below the fold.]

### Headline
[Display headline if the ad uses one. May be optional depending on placement.]

### Body
[Full long-form body. Section breaks are visual breaks (blank lines).
Bridges between sections. Time-delay anchored before every results claim.
POV stable throughout.]

### PS
[Specific personal detail, callback to story, 2-4 sentences.]

### PPS
[Optional. Second testimonial, urgency, or social proof.]

### CTA placement notes
[Where the CTA links go in the copy. CTA destination per per-request input.]
```

After the three variants, append:

```markdown
## IMAGE SPECIFICATION

**Style:** Reddit-native (4:5)
**Subject:** [Per the angle's emotional tone]
**Nano Banana prompt:**
[Full prompt, paste-ready]

**Handoff format for ad-style-generator (when Reddit-native style #13 is added):**
[Same content in the catalogue style, ready to drop in]
```

```markdown
## REPURPOSING INSTRUCTIONS

**Movie-credits scroll video ad:**
[Notes on which sections to keep, which to cut, voiceover pacing.
Hands off to video-script-generator format: "Static" or new "movie-credits" sub-type.]

**UGC long-form yap-session script:**
[Notes on first-person rewriting, sensory specifics to keep, length target.
Hands off to video-script-generator format: "UGC".]
```

```markdown
## REJECTION NOTES

[Any self-test items that flagged. List by item number with one-sentence
remedy reminder. If no items flagged, state "Self-test passed clean."]
```

### Fake-Complaint Output

For fake-complaint short-form, produce one block per complaint variant (1-3 total):

```markdown
## COMPLAINT VARIANT [N]: [SUBJECT, e.g., "Sale price renewal"]

### In-feed visible (hook + first line)
[Hook, max 9 words. Complaint framing.]

### Body
[200-300 word complaint paragraph. Customer-to-customer voice.
No mechanism. No claims about the product. Implicit social proof.
Implicit urgency.]

### CTA placement notes
[Soft CTA. Where the link goes inside the complaint text.]
```

Then append the IMAGE SPECIFICATION block and REJECTION NOTES block. No repurposing instructions block.

### Delivery Format

**Long-form (full or medium):** Three-POV-variant output is 7,500-10,500 words for full variants, 3,000-4,200 words for medium variants. Deliver as a single downloadable markdown file using `create_file` + `present_files`. Filename convention: `{brand-slug}-{angle-slug}-long-form-static.md`. Do not paste the full output into the chat.

**Fake-complaint short-form:** Output is 200-900 words total (1-3 complaint variants). May be delivered inline in chat OR as a markdown file. Filename convention if file delivery: `{brand-slug}-{angle-slug}-fake-complaint.md`.

## Cross-References to Other Skills

- **Receives angle from `angle-roadmap`** - the angle card is the per-request driver
- **Hands image spec to `ad-style-generator`** - Reddit-native style. If style #13 is not yet added in ad-style-generator's catalogue, the spec is paste-ready for direct Nano Banana use as a fallback
- **Hands repurposing scripts to `video-script-generator`** - movie-credits scroll, UGC yap-session
- **Consumes voice rules from `copywriting-guide`** - forbidden vocabulary, humanization, em-dash policy
- **Does NOT call `funnel-builder`** - long-form-static is an ad, not a landing page. CTAs link to a funnel-built page, but this skill does not produce the page

## Quality Assurance

After Step 7, verify against this checklist:

**Architecture:**
- [ ] Angle card was the per-request driver (no ad without an angle)
- [ ] Format variant matches awareness stage per the decision table
- [ ] Three POV variants are structurally distinct (not word-substitution)
- [ ] Single image spec covers all three variants

**Section structure (full and medium long-form):**
- [ ] All sections present in the order specified by `references/section-structure.md`
- [ ] Word budget per section is within range
- [ ] Total word count is within the variant's range

**Section structure (fake-complaint short-form):**
- [ ] Customer-to-customer voice
- [ ] No mechanism
- [ ] No claims about the product
- [ ] Urgency is the close, not a pitch

**Named patterns:**
- [ ] Desperation frame present
- [ ] Identification before mechanism
- [ ] Three-stage mechanism explanation (name, explain with analogy, differentiate with numbers)
- [ ] Bridges at every section transition
- [ ] Time-delay anchored before every results claim
- [ ] One core feeling sustained throughout
- [ ] POV stable across the whole body
- [ ] Hook is 9 words max with identity marker and info gap

**Image:**
- [ ] Reddit-native style applied
- [ ] 4:5 aspect ratio
- [ ] No obvious AI tells (no glossy skin, no perfect symmetry, no over-saturated colors)
- [ ] Subject matches the angle's emotional tone

**Voice (from copywriting-guide):**
- [ ] No em dashes anywhere
- [ ] No forbidden AI vocabulary
- [ ] Contractions used naturally
- [ ] High burstiness (sentence length varies dramatically)
- [ ] Avatar-appropriate tone

**Compliance:**
- [ ] No verbatim Rosabella copy (>15 words consecutive)
- [ ] Brand-specific claim boundaries observed
- [ ] CTA destination is sales-page-lander, listicle, or advertorial - never direct PDP

## Iteration Patterns

When the user provides feedback after first output, apply these standard fixes:

| Feedback | Fix |
|----------|-----|
| "Hook is too slow" | Rewrite. 9 words max, identity marker, info gap. Cut anything before the gap. |
| "Mechanism appears too early" | Move the mechanism reveal AFTER the failed-solution stack. Identification must precede mechanism. |
| "POV breaks in the middle" | Re-read the body line by line. Anywhere a narrator steps in, rewrite from inside the chosen POV. |
| "All three variants sound the same" | The three-lead rule failed. Rewrite each from a structurally different storyteller (sufferer, family member, professional). Don't word-substitute. |
| "No bridges between sections" | Add explicit connector sentences. Every section break needs one. |
| "Results claim has no time anchor" | Add week-by-week or day-by-day specifics before any results sentence. |
| "Body feels emotionally flat" | Pick one core feeling (vindication, loss aversion, betrayal, desperation, identity). Audit every sentence against it. |
| "Mechanism is confusing" | Apply the three-stage explanation (name, then explain with analogy, then differentiate with numbers). Add the analogy if missing. |
| "Sounds AI-generated" | Re-run copywriting-guide humanization rules. Check forbidden vocabulary list. Check em dashes. Increase burstiness. |
| "Image spec triggers Nano Banana policy filter" | Soften the medical/distress framing. Reference Reddit posts as inspiration without recreating sensitive imagery directly. See `references/image-spec.md` for the safe-prompt patterns. |
| "Want a shorter version, same angle" | Switch to medium long-form variant. Compress each section by ~50%. Keep all sections present. |
| "Want a fake-complaint version" | Confirm the angle is solution-aware bottom-funnel with heavy social proof equity. If not, refuse - the format only works there. |

## Edge Cases

**Angle roadmap not yet built:** This skill cannot proceed without an angle card. Pause and run `angle-roadmap` first. Do NOT generate from a vague "ad about [topic]" prompt; that produces generic Rosabella imitations with no strategic anchor.

**Avatar research thin or missing:** Quality drops sharply. The identification sections rely on raw avatar quotes. If avatar research is missing, ask the user whether to proceed with stub identification (clearly marked for revision) or pause and run `avatar-research` first.

**Brand has strict claim boundaries:** Read the brand guidelines claim section first. Long-form-static is high-runway copy and easy to slip into health/financial/legal claims that exceed compliance. The mechanism section is the highest-risk surface; constrain language there before writing.

**User wants the fake-complaint short-form for a top-of-funnel angle:** Refuse. The format only works for solution-aware bottom-funnel where the brand has heavy social proof equity. Using it for top-of-funnel produces ads that feel hollow and convert poorly. Recommend full or medium long-form instead.

**User wants four or more POV variants:** Stick to three. The three-lead rule is validated; adding a fourth variant produces diminishing returns and dilutes the testing budget. If the user insists, comply but flag the recommendation in rejection notes.

**User wants three same-POV variants (e.g., "three first-person sufferer versions" or "three I-voice versions with different names"):** Refuse. The three-lead rule's value comes from POV diversity, not name diversity. Three same-POV variants with name swaps are word-substitution and fail the self-test (item 12). Counter-offer: either output one strong variant with the requested POV, OR output three variants per the standard sufferer/family-member/professional taxonomy. Do not ship three same-POV name-swap variants under any circumstances.

**User wants the same body for two angles:** Refuse. Each angle gets its own body. The angle is the narrative spine; reusing a body across angles breaks the Yes-Yes-Yes chain.

## What This Skill Does NOT Do

- Does not generate images (produces the spec; ad-style-generator or Nano Banana generates the asset)
- Does not generate landing pages (that is `funnel-builder`)
- Does not generate performed video scripts (that is `video-script-generator`; this skill hands off repurposing instructions)
- Does not select angles (that is `angle-roadmap`; this skill consumes its output)
- Does not write copy without an angle card (hard requirement)
- Does not commit files to GitHub

## Versioning and Changelog

- **1.0.0** (initial): Long-form-static ad format codified. Three section-structure variants (full, medium, fake-complaint short-form). 10 named patterns. Reddit-native image spec for handoff to ad-style-generator. 14-point self-test checklist. Rosabella pattern summary as paraphrased industry reference.
