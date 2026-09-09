# Copywriting Guide Output Structure

This is the structural template for the final output. The skill populates each section from extracted inputs. Sections marked [CUSTOMIZED] are populated from avatar research and brand guidelines. Sections marked [UNIVERSAL] are brand-agnostic and generated from this skill's own text. Appendices marked [UNIVERSAL, VERBATIM] are file copies of a reference file and are never rewritten, paraphrased or brand-adapted.

The universal rule sets do not live inline any more. `../references/humanization-rules.md` and `../references/line-level-rules.md` are embedded verbatim as Appendix C and Appendix D, so a universal change is propagated by replacing the appendix body and the `appendices:` line of the provenance stamp, with no regeneration of any brand section.

---

## Provenance stamp

The guide's first lines, above the title:

```
generated-by: copywriting-guide v1.5.0
appendices: humanization-rules v1.5.0 sha256:<first 16 hex>, line-level-rules v1.5.0 sha256:<first 16 hex>
generated: [YYYY-MM-DD]
```

This block is the same schema SKILL.md Step 10 states, and the two must stay identical; where they ever differ, Step 10 wins and this file is the bug. Each appendix version is read from the `<!-- universal appendix: ... -->` comment on line 1 of the corresponding reference file, and each digest is the sha256 of that file computed at generation time. **A stamp missing either digest, or carrying a digest that disagrees with the appendix actually embedded, fails the Step 10 verification gate and the guide is not delivered.**

---

## Final Document Structure

```
# Human-Centered Copywriting Guide: [BRAND_NAME]

## SECTION 1: Why Human-Centered Copy Matters [UNIVERSAL]
  - The problem with AI-generated copy
  - What makes copy "human" for [BRAND_NAME]
  - Three pillars: confident voice, linguistic rhythm, customer-centric empathy

## SECTION 2: The [BRAND_NAME] Voice [CUSTOMIZED]
  - Voice Pillar 1: [Name] (definition, sounds like, doesn't sound like, application)
  - Voice Pillar 2: [Name] (same structure)
  - Voice Pillar 3: [Name] (same structure)
  - [Optional Pillars 4-5]

## SECTION 3: The AI Detection Firewall [BRAND ADDITIONS]
  The universal rule set (Rules 1-17, the severity tiers, the do-not-sanitize list
  and the fact rule) is NOT restated here. It is Appendix C, embedded verbatim.
  This section is what the brand adds on top of it.
  - 3.1: Brand-specific forbidden words (avatar research "language to avoid")
  - 3.2: Brand-specific approved vocabulary (avatar "language that resonates")
  - 3.3: Category-specific claim rules (business validation regulatory findings)
  - 3.4: Positioning-specific tone rules (premium/mid/budget calibration)
  - 3.5: Geography-specific language notes (UK vs US English, regional colloquialisms)
  - 3.6: Brand-calibrated examples for the rules that need a voice to illustrate them
         (Rule 2 burstiness, Rule 5 strategic imperfection, Rule 12 escalation instead
         of stacking, and this brand's tagged Redefinition lines under Rule 13)

## SECTION 4: The Customer Archetypes [CUSTOMIZED]
  - Archetype 1: [Name] (who, emotions, tone, resonant language, avoid, structure, example, promise)
  - Archetype 2: [Name] (same structure)
  - Archetype 3: [Name] (same structure)
  - [Additional archetypes as needed]

## SECTION 5: The Humanization Checklist [UNIVERSAL]
  - Phase 1: AI Detection Audit, strongest tells first (the seven literal checks,
    each with its planted control: opener stack, short-sentence run, untagged false
    contrast, exclamation count, emoji count, em/en dash count, forbidden vocabulary)
  - Phase 2: Voice Alignment (brand voice, archetype match, confidence, positioning)
  - Phase 3: Emotional Resonance (target emotion, empathy, aspiration)
  - Phase 4: Specificity and Differentiation (concrete details, mechanism, positioning)
  - Phase 5: Voice Preservation (the do-not-sanitize check and the fact rule, run
    against the edits Phases 1-4 produced)

## SECTION 6: Universal Structural Rules [UNIVERSAL]
  - 8.0 The RMBC Frame (Research, Mechanism, Brief, Copy, and where each stage lives)
  - The Bridge Principle, including the connector test
  - The Open-Loop Principle
  - The Time-Delay Introduction Rule
  - Hook Quality Checklist
  - Identification-Before-Mechanism Rule
  - The Discovery Story Format
  - The Five Core Feelings Library
  - Authority Hook Patterns
  - Claim-Proof Adjacency
  - The First-Draft-to-Final Process (body first, lead last)
  The line-level rules are NOT restated here. They are Appendix D, embedded verbatim.
  The persuasive spine's section order is owned by funnel-builder and is not restated.

## SECTION 6A: Structural Moves: The Seven Techniques [CONDITIONAL, CUSTOMIZED]
  Present ONLY when `schwartz-applied.md` exists at the brand repo root. When it is
  absent, this section does not appear and is not mentioned; the guide runs 12 sections.
  Numbered 6A so the presence or absence of the gate never renumbers Sections 7-12.
  - The seven technique definitions
  - The layering rule
  - One worked example per technique, in the brand's voice for the primary archetype
  - The combinations table
  - The pressure test reminder

## SECTION 7: Common Pitfalls [UNIVERSAL + BRAND EXAMPLES]
  - Problem: Too Corporate/Formal (with brand-specific fix example)
  - Problem: Feature-Dumping (with brand-specific feature to benefit translations)
  - Problem: Sounds Weak/Uncertain (with brand-specific confident rewrite)
  - Problem: Too Generic (with brand-specific specificity example)
  - Problem: Trying Too Hard (with brand-appropriate calibration)

## SECTION 8: Content Type Quick Guides [CUSTOMIZED]
  - Social Media Captions (platform-specific, archetype-specific examples)
  - Email Subject Lines and Body (hooks, openings, CTAs)
  - Website Headlines (homepage, product page, landing page)
  - Product Page Copy (description, benefits, proof)
  - Customer Service / FAQs (support tone shift)
  - Ad Copy (Meta, Google, TikTok variants)
  - Advertorial/Listicle Content (education-led funnel copy)

## SECTION 9: Cultural Considerations and Positioning [CUSTOMIZED]
  - [BRAND_NAME] Values Navigation (embody vs reject)
  - [POSITIONING_LEVEL] Positioning rules (premium/mid/budget calibration)
  - Regional Awareness (geography-specific language notes)

## SECTION 10: [MECHANISM] Messaging Framework [CUSTOMIZED]
  - How to explain the core mechanism (1 sentence, 3 sentences, 1 paragraph)
  - Common objections with approved responses
  - Claim boundaries (what can/cannot be said)
  - Competitor comparison rules

## SECTION 11: Final Instructions [UNIVERSAL]
  - Golden rules summary
  - Priority order for conflicting guidance
  - The ultimate test (read aloud, conversation test, archetype test)

## SECTION 12: The Ultimate AI Detection Test [UNIVERSAL]
  - 5 specific tests to run on every piece of content
  - Scoring rubric for human-sounding copy

## APPENDIX A: Before/After Examples [CUSTOMIZED]
  - 3 content types with bad (AI-sounding) and good (humanized) versions
  - Each pair annotated with which rules were applied

## APPENDIX B: Quick Reference Card [UNIVERSAL + CUSTOMIZED]
  - Non-negotiables table (rules + checks)
  - Voice tests list
  - Archetype quick-reference

## APPENDIX C: Universal Humanization Rules [UNIVERSAL, VERBATIM]
  - The full text of _skills/copywriting-guide/references/humanization-rules.md,
    byte for byte, including its line-1 header comment. Not paraphrased, not
    reordered, not brand-adapted. Identical in every brand's guide.

## APPENDIX D: Universal Line-Level Rules [UNIVERSAL, VERBATIM]
  - The full text of _skills/copywriting-guide/references/line-level-rules.md,
    byte for byte, including its line-1 header comment. Same terms as Appendix C.
```

---

## Section Population Matrix

| Section | Primary Source | Secondary Source | Universal Content |
|---------|--------------|-----------------|-------------------|
| 1 | - | - | 100% universal |
| 2 | Brand Guidelines (voice) | Avatar Research (validation) | Pillar template structure |
| 3 | Avatar Research (vocabulary) | Business Validation (claims) | 0% universal; the universal rules are Appendix C |
| 4 | Avatar Research (all sections) | Brand Guidelines (tone) | Archetype template structure |
| 5 | - | - | 100% universal |
| 6 | - | - | 100% universal |
| 6A (conditional) | `schwartz-applied.md` + Brand Guidelines (voice) | Avatar Research (primary archetype) | Technique definitions universal; worked examples 100% brand |
| 7 | - | Brand-specific examples | 70% universal, 30% brand |
| 8 | Avatar Research (platforms, language) | Brand Guidelines (positioning) | Format templates universal |
| 9 | Brand Guidelines (values, positioning) | Avatar Research (geography) | Structure universal |
| 10 | Business Validation (claims) | Brand Guidelines (mechanism) | Structure universal |
| 11 | - | - | 100% universal |
| 12 | - | - | 100% universal |
| App A | All sources | - | Template universal |
| App B | All sources | - | 50% universal |
| App C | - | - | 100% universal, verbatim file copy |
| App D | - | - | 100% universal, verbatim file copy |

Total: 12 sections + 4 appendices. When `schwartz-applied.md` exists at the brand repo root, Section 6A is generated as well and the guide runs 13 sections + 4 appendices. Section 6A is the ONLY conditional slot; its presence never renumbers anything.

---

## Regeneration policy

Four triggers. They do not imply one another, and a release may fire more than one. Trigger 0 runs once per guide and must run BEFORE any of the others can be applied to a guide written against an older layout.

**0. The guide's layout is older than this template (a one-time schema migration).**
A v1.4 guide has ELEVEN sections and TWO appendices, and its numbers mean different things: its Section 6 is Common Pitfalls, which is Section 7 here, and it has no Universal Structural Rules section at all. **Applying trigger 2 to a v1.4 guide by number would overwrite Common Pitfalls with universal content and leave Sections 7 to 10 carrying stale meanings.** Migrate first, and migrate by MOVING bodies, not by regenerating them:

1. Match each existing section to its new number BY TITLE, never by number: Why Human-Centered Copy Matters to 1, The Voice to 2, The AI Detection Firewall to 3, The Customer Archetypes to 4, The Humanization Checklist to 5, Common Pitfalls to 7, Content Type Quick Guides to 8, Cultural Considerations to 9, the Messaging Framework to 10, Final Instructions to 11, The Ultimate AI Detection Test to 12.
2. Move each matched body verbatim under its new number. Customized content is relocated, never rewritten. A body with no match in this template is surfaced to the operator, not deleted.
3. Create Section 6 (Universal Structural Rules) new, from this skill. It has no v1.4 predecessor.
4. Create Section 6A only if `schwartz-applied.md` exists at the brand repo root. If the v1.4 guide carried a Structural Moves section and the file is now absent, remove the section per the Step 7 gate rather than renumbering around it.
5. Strip the universal rule text out of Section 3, leaving only brand additions, and append Appendices C and D by file copy.
6. Write the provenance stamp, including both digests.

The migration is complete when the guide has 12 sections (13 with 6A), 4 appendices, a stamp, and no section body was rewritten by an LLM.

**Presence or absence of `schwartz-applied.md` is itself an input trigger.** When it appears, generate 6A; when it is removed, delete 6A. Neither event renumbers anything, which is why 6A is lettered.

**1. Brand inputs change** (avatar research, brand guidelines, business validation, moat dispositions, positioning).
Regenerate Sections 2, 3, 4, 6A, 7, 8, 9, 10, Appendix A and Appendix B. Appendices C and D are untouched.

**2. The copywriting-guide skill's version changes.**
Regenerate the universal sections this skill authors: 1, 5, 6, 11, 12. Brand sections are untouched.

**3. An appendix file changes** (`../references/humanization-rules.md` or `../references/line-level-rules.md`).
Appendices C and D are NEVER regenerated by an LLM. They are replaced by copying the current reference file between its two markers, and the `appendices:` stamp line (version and sha256) is updated. What else moves depends on WHAT changed:

Classify the change as EDITORIAL or SEMANTIC. The test is one question: **could a guide surface that restates this rule now be wrong?**

- **EDITORIAL.** Rewording that leaves every rule's meaning, scope and thresholds where they were. A clearer sentence, a better example, a typo. Propagate the appendix body and the stamp line. Nothing else moves.
- **SEMANTIC.** Anything that changes what a rule requires, permits or is called. This includes but is NOT limited to a threshold, a ratio, a ceiling, rule numbering, tier assignment, the Rule 1 vocabulary table, the Redefinition register format, adding or removing a banned form, and changing a carve-out's conditions. Propagate the appendix body and the stamp line, PLUS every surface in the dependency manifest below.

When you cannot tell which it is, it is semantic. The cost of refreshing five surfaces unnecessarily is a few minutes; the cost of missing one is a guide that contradicts its own appendix.

### Appendix dependency manifest

These surfaces RESTATE appendix semantics rather than referring to them, so a semantic change leaves them contradicting the appendix that was just copied in. Refresh these, and only these, in the same pass:

| Surface | What it restates |
|---------|------------------|
| Section 3 | brand-voiced examples of Rules 2, 5, 12 and 13; brand vocabulary rows that mirror a Rule 1 category |
| Section 5 | the seven literal checks, their thresholds and their pass conditions |
| Section 6 | the connector test and any structural rule that restates a line-level or humanization rule |
| Section 11 | golden-rules summary and the priority order for conflicting guidance |
| Section 12 | the five tests and the scoring rubric, wherever they name a rule or a count |
| Appendix A | the per-pair annotations naming which rules each before/after example applies |
| Appendix B | the non-negotiables table |

Nothing else. The brand's voice pillars, archetypes, content-type guides, messaging framework and before/after examples do not move when an appendix does. That is what keeps trigger 3 cheap, and keeping it cheap is the whole reason the appendices are separate files.
