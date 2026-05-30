# Video Script Generator - Skill ↔ Prompt Alignment Mapping

**Purpose:** documents the derivation of `ideate-spark-chat`'s `video-chat` Edge Function `VIDEO_SYSTEM_PROMPT` from this skill (`SKILL.md`). When the skill changes, this mapping is the contract that lets reviewers verify the prompt still mirrors the skill's load-bearing rules. The drift-detection Codex prompt at the bottom of this document is the runnable check.

**Authored:** plan Session 55 (disk session 94, 2026-05-01)
**Skill version covered:** v1.6.0 (canonical SHA `30475374c10ae165422d59de9ba0c9c845efcf11`, line counts as of Session 109 push)

---

## Atomic-update rule

When `SKILL.md` changes, the SAME commit (or a commit chain that lands within the same review cycle) MUST update all five surfaces below. Updating a subset recreates the v1.0.0/v1.3.0 distribution drift Session 91 caught.

1. **`context-architect-brands/_skills/video-script-generator/SKILL.md`** - source of truth
2. **`ca-desktop-installer/video-script-generator/SKILL.md`** - distribution copy used by the desktop installer; must share SHA with #1
3. **`ca-desktop-installer/VERSION`** - bump if a versioned release goes out
4. **`ideate-spark-chat/supabase/functions/video-chat/systemPrompt.ts`** - the runtime prompt's cross-reference comments AND its rule content. Edits to skill rules that change the rule's substance MUST update the prompt text, not just the comment.
5. **`context-architect-brands/_skills/video-script-generator/alignment-mapping.md`** (this file) - if a section was renamed, added, or removed, update the mapping table below.

The drift-detection prompt in §3 is the runnable verifier of #4 vs #1. Run it before merging any change that touches #1 or #4.

---

## 1. Mapping table

Every section in `VIDEO_SYSTEM_PROMPT` derives from a section (or specific paragraphs) in `SKILL.md`. Entries are ordered by the prompt's section order, not the skill's.

| Prompt section (heading in `systemPrompt.ts`) | Source in `SKILL.md` (verbatim) | What the prompt copies | Notes |
|---|---|---|---|
| `# Your Role` | `## Purpose` (§17) - including the "Core principle:" emphasized line on line 21 | The "script writer not strategist" framing + the canonical "awareness stage determines script structure" sentence | "Core principle:" is inline emphasis, not its own heading. Cross-reference comment in `systemPrompt.ts` notes this explicitly. |
| `# Concept-First Flow` | `## Concept Structure (Pre-Script)` (new in v1.6.0) | The two-stage concept-then-script flow and the ConceptCard schema: format, awareness_stage, hook_angle, structural_approach, key_beats (3-8 ordered); optional cta_hook / target_duration_seconds / concept_id / title; one-concept-to-many-scripts; one-conversation-to-many-concepts; concept-shape-mirrors-awareness-stage | Skill section added in F.3a (Session 109). `systemPrompt.ts:98` `# Concept-First Flow` already teaches this flow inline; F.3b drops the forward-pointing suffix on the `systemPrompt.ts:99` comment now that the skill section exists. |
| `# Awareness Stage Is the Primary Axis` | `## Awareness Stage Architecture (PRIMARY FRAMEWORK)` (§96) | Per-stage avatar state, job, hook strategy, beat structure, and product-entry percentage for all four stages. The prompt also surfaces the Frustration-to-Eureka sub-pattern as optional. | Product-entry percentages (65-70 / 60-65 / 55-60 / first 30%) are load-bearing - drift here breaks scripts. Drift detection MUST verify these match. |
| `# Hook Construction Rules` | `## Hook Construction Rules` (§289) | The open-loop principle, the four anti-patterns, the 2-3 hook options pattern when uncertain, the "promise + withhold" quality test | Stage-by-stage hook table summarized rather than copied verbatim - drift detector should accept summarization but flag substantive divergence. |
| `# Logic Flow` | `## Logic Flow Rule` (§401) | "Every line must connect logically" + the connection-phrases list (5 phrases verbatim) | Connection phrases must match exactly. |
| `# No Meta-Commentary` | `## No Meta-Commentary Rule` (§451) | Five forbidden patterns + the pivot-phrase exception with the two allowed examples ("Here's what I need you to understand." and "This is the part that's going to make everything click.") | The pivot-phrase exception is the only allowed deviation. |
| `# Sensory Moments` | `## Sensory Snapshot Moments` (§358) | "Make the avatar's experience visualizable" + the "ASK before inventing if avatar research is sparse" rule | The skill goes deeper into sensory-moment construction; the prompt summarizes because the LLM applies the principle, not the construction algorithm. Drift detector should accept this. |
| `# Product Introduction Sequence` | `## Product Introduction Sequence` (§573) | The five-step sequence (name → describe → who-it's-for → how-it-works in human language → connect to result) | Human-language requirement and the explicit "the way it works is simple" pattern are load-bearing. |
| `# CTA Integration` | `## CTA Integration` (§793) | "CTA is user-specified - ask the user" rule | Load-bearing rule. The prompt MUST not invent a CTA. |
| `# Humanization Rules` | `## Humanization Rules` (§777) | FORBIDDEN VOCABULARY list (verbatim, every word) + REQUIRED list (contractions, sentence-length variance, sensory specifics, one-idea-per-sentence, human phrasing) + the "could a real person say this at dinner" test | **The forbidden-vocabulary list is the most drift-sensitive surface.** Drift detector MUST do an exact-match comparison on every word. Brand-level forbidden vocabulary is additionally applied at runtime via context block. |
| `# Em Dash Ban (CE-wide rule)` | NOT in skill - CE convention. The v1.0.0 skill mentioned em dashes for pauses; v1.3.0 superseded with line-break-as-pacing. | Em dash ban statement | This is the one section deliberately not in the skill; the comment in `systemPrompt.ts` notes the rationale. |
| `# Output` | `## Output Format` (§647) | Default = script content only; visual notes optional at end | |
| `# Tool Use` | NOT in skill - runtime-only. | Per-tool description for `present_script` / `save_script` / `update_script` / `list_scripts` | Tool semantics are runtime concerns, not methodology. The skill is silent on tools. |
| `# Non-Blocking Quality Validation` | NOT in skill - runtime-only. Source: `VIDEO_SCRIPT_WRITER_DESIGN.md` §5.5 (non-blocking semantics) and Plan Session 56 implementation. | LLM-facing behavior on `quality_result` payload from `save_script` / `update_script`: surface failures, offer revisions, do NOT retry the save. The CHECK criteria themselves derive from skill §"Quality Checklist (Run Before Delivery)" but live in `qualityValidation.ts`, not the prompt. | This section is the structural anti-Pattern-2 instruction - without it the LLM may interpret `overall_pass: false` as a save failure and loop. The skill is silent on LLM tool-use behavior; the criteria the validator enforces ARE in the skill, the response protocol is not. |
| `# Cross-format change` | NOT in skill - runtime-only. Source: `VIDEO_SCRIPT_WRITER_DESIGN.md` §1.2 (immutable format decision). | "Format is immutable per conversation; start a new chat to switch" rule | |

### Format-conditional blocks (NOT in static prompt)

The six format-specific rules blocks live in `assembleVideoContext.ts:FORMAT_BLOCKS` and are injected dynamically (one of six per turn, based on the user's selected format). They mirror `SKILL.md` §`Format-Specific Rules` (§723) entries:

| Format value | Block content sourced from `SKILL.md` §"Format-Specific Rules" sub-section |
|---|---|
| `yap` | "Voiceover Monologue (Primary Format)" (§725) |
| `podcast` | "Podcast Two-Host" (§737) |
| `animation` | "Animation / Character" (§744) |
| `static` | "Static / Reverse Psychology" (§750) |
| `ugc` | "UGC Emotional Testimonial" (§756) |
| `ai_slop` | "AI Slop / Personified Chain" (§762), including the three sub-types (blame_something_else / chain_of_blame / investigation) |

Drift detection MUST cross-check each FORMAT_BLOCKS entry against its SKILL.md sub-section. Sub-types under `ai_slop` are part of this check.

### Pending prompt absorption (scheduled for F.3b)

These v1.5.0 (and one v1.4.0) skill sections have no `systemPrompt.ts` mirror yet. F.3b lifts them into the prompt; at that point each becomes a row in the mapping table above. They are listed here as bullets, not as table rows, so the §3 drift detector does not read them as "skill present, prompt absent" drift before F.3b runs. Source: `ideate-spark-chat/docs/SESSION_107c_VIDEO_SKILL_V150_RECHECK.md` §2 and §2.5.

- `## Upstream Format Sources` (v1.4.0) -> future prompt section `# Upstream Format Sources`
- `### Three-Variable Hook Framework` (under `## Hook Construction Rules`) -> future `# Three-Variable Hook Framework`
- `## Three-Stage Mechanism Pattern` -> future `# Three-Stage Mechanism Pattern`
- `## Discovery Frame vs Desperation Frame` -> future `# Frame Choice: Discovery vs Desperation`
- Required Inputs item 4.5, Identification-Before-Mechanism (SKILL.md line ~85) -> future `# Narrator Identity`
- `### Core Feeling Alignment` (under `## Sensory Snapshot Moments`) -> future `# Core Feeling Alignment`
- `### Discovery Story Format Hook (when applicable)` (under `## Hook Construction Rules`) -> folds into future hook / frame prompt content
- Hook cross-skill openers, copywriting-guide §8.4 + §8.8 (SKILL.md line ~309) -> integrate into prompt `# Hook Construction Rules`
- Awareness-vocabulary first-use qualifier (SKILL.md line ~67) -> qualifier near prompt `# Awareness Stage Is the Primary Axis`
- UGC Lead-Variants integration (`## Format-Specific Rules` -> `### UGC Emotional Testimonial`) -> `assembleVideoContext.ts` UGC FORMAT_BLOCKS entry

### Sections in skill but NOT directly in prompt

These skill sections inform the LLM via the principles already covered, but don't have their own prompt heading:

- `## Required Inputs (Elicit if Missing)` (§47) - runtime input gating handled by `validateVideoConversationContext` + the "ask before generating" rule embedded in awareness-stage section
- `## Angle Variation Framework` (§243) - same-villain / different-entry-point pattern. The LLM applies this when generating multiple scripts; not load-bearing for a single-script flow.
- `## Early Context Establishment` (§329) - "is this for me?" qualifying-context rule. Implicitly applied via beat structures.
- `## Partial Solution Framing` (§479) - applied as needed; not stage-required.
- `## Technical Education Option` (§532) - situational add-on; not load-bearing.
- `## External Content → Angle Conversion` (§604) - external-content handling; not in this Edge Function's scope (lives in `import-angles`).
- `## Quality Checklist (Run Before Delivery)` (§816) - implemented in `qualityValidation.ts` (plan Session 56). The validator returns a structured `QualityResult` to the LLM via tool result; the prompt section `# Non-Blocking Quality Validation` (mapped above) tells the LLM how to react. The CHECK CRITERIA derive from this skill section; the BEHAVIOR PROTOCOL is runtime-only.
- `## Iteration Patterns` (§1071) - implicit in the `update_script` tool flow.

- `## Schwartz Structural Layer (Gated)` (SKILL.md:846-902) - DELIBERATE OMISSION. CE's video-chat prompt carries no Schwartz, sophistication-stage, technique-density, 38-method, or camouflage content, and no `phase-4.5-angle-roadmap/schwartz-applied.md` reference. Confirmed by grep in Session 107c (2026-05-27). Intentional, not drift. Gating Schwartz into the CE prompt would be a separate F.4+ decision. Sibling to the External Content omission above.
- `## Cross-Reference Disciplines` skill-internal sub-rules (SKILL.md:811-830): §8.5 Disambiguation Discipline, Awareness-Vocabulary Disambiguation, Variant Name Canonical Match, Step 1C UGC Creator Brief Canonical Match. These govern how the skill cites sibling corpus skills; no LLM-facing CE prompt surface. Deliberately not mirrored.
- `### Format Names as Cross-Skill Contracts` (SKILL.md:832-842) is the one CE-relevant Cross-Reference Disciplines sub-rule. Its CE-side embodiment is tracked operationally via BACKLOG #77 (RESCOPED): the `FORMAT_DISPLAY` map duplicated across `ScriptCard.tsx:38` and `VideoConceptCard.tsx:37`. The stable 6-format contract is what makes #77 load-bearing. No LLM-facing prompt teaching is required, since the LLM does not author cross-skill artifacts.
If any of these later become load-bearing for the prompt, lift them into a new prompt section AND add a row to the mapping table.

---

## 2. First-fire sanity check

After plan Session 55 deploy (this session), the drift-detection prompt below was run against the just-shipped state. Expected: zero findings. If the first-fire returns findings, either the prompt drifted from skill during authoring OR the mapping mis-states a derivation. Resolve before commit.

**First-fire timestamp:** 2026-05-01 (recorded in `ideate-spark-chat/docs/SESSION_94_LOG.md`)
**First-fire result:** Codex `/codex:adversarial-review` round 1 covered alignment-mapping fidelity (every prompt section maps to a real SKILL.md section) AND drift-detection prompt completeness as part of the broader adversarial pass. Round 1 returned two MEDIUM findings - both correctness issues unrelated to skill↔prompt drift (one about prompt-size budget excluding the static prompt; one about cache_control breakpoint placement). Round 2 after fixes returned APPROVE with no material findings. **Conclusion: zero drift findings between SKILL.md v1.3.0 and systemPrompt.ts at session-close state.** A targeted drift-detection-only run can be scheduled as routine housekeeping per the §3 "When to run" cadence.

---

## 3. Drift-detection Codex prompt (copy-paste)

When `video-chat/systemPrompt.ts` is edited (or `SKILL.md` changes affect any of the prompt-mapped sections above), run this prompt against the working tree before merging. Embed the prompt in a fresh Codex `/codex:adversarial-review` invocation OR run it as part of the standard pre-commit Codex pass.

```
TASK: detect drift between context-architect-brands/_skills/video-script-generator/SKILL.md and ideate-spark-chat/supabase/functions/video-chat/systemPrompt.ts (and assembleVideoContext.ts FORMAT_BLOCKS).

INPUTS to read:
1. context-architect-brands/_skills/video-script-generator/SKILL.md (source of truth)
2. ideate-spark-chat/supabase/functions/video-chat/systemPrompt.ts (the prompt)
3. ideate-spark-chat/supabase/functions/video-chat/assembleVideoContext.ts (FORMAT_BLOCKS constant)
4. context-architect-brands/_skills/video-script-generator/alignment-mapping.md (this file's mapping table)

FOR EACH ROW in the mapping table:
- Locate the named SKILL.md section
- Locate the named systemPrompt.ts section
- Compare their semantic content

FLAG ANY of the following as findings:

A. Substantive divergence in load-bearing rules:
   - Awareness-stage product-entry percentages drift between skill and prompt (e.g. skill says "65-70%", prompt says "70%")
   - Beat-structure ordering differs between skill and prompt for any stage
   - The Frustration-to-Eureka sub-pattern's structure differs

B. Forbidden-vocabulary list mismatch:
   - Words present in SKILL.md §Humanization Rules forbidden list but missing in systemPrompt.ts
   - Words present in systemPrompt.ts forbidden list but missing in SKILL.md
   - Order of words doesn't matter; presence/absence does

C. Connection-phrases drift:
   - Phrases in SKILL.md §Logic Flow Rule "Connection Phrases" missing from prompt
   - Phrases in prompt that aren't in skill

D. Pivot-phrase exception drift:
   - The two allowed pivot phrases ("Here's what I need you to understand." and "This is the part that's going to make everything click.") differ in any way between skill and prompt

E. Format-conditional block drift (assembleVideoContext.ts):
   - Any of the six FORMAT_BLOCKS entries differs in substance from its SKILL.md sub-section under §Format-Specific Rules
   - The three ai_slop sub-types (blame_something_else / chain_of_blame / investigation) are misnamed or have drifted descriptions
   - Sub-section structural elements (line-break rules for yap, HOST/GUEST roles for podcast, *[bracket]* convention for animation, THE FLIP for static, 80/20 split for ugc, "---" separators for ai_slop) drift

F. Prompt adds rules not present in skill:
   - Any prompt rule (in any section) that has no source in SKILL.md or in the alignment-mapping table's "NOT in skill - runtime-only" rows

G. Prompt drops rules present in skill (for any section listed in the mapping table):
   - Skill rule absent from prompt without explicit "NOT in prompt" rationale in the mapping

H. Cross-reference comments wrong:
   - A `// → SKILL §"..."` comment naming a section that doesn't exist in SKILL.md
   - A `// → SKILL §"..."` comment naming the wrong section for the rule below it

OUTPUT: structured list of findings, each with:
- Severity (HIGH if substantive rule divergence; MEDIUM if structural; LOW if cosmetic)
- Source line in SKILL.md
- Target line in systemPrompt.ts or assembleVideoContext.ts
- Brief description of divergence
- Recommended fix (which side to update - typically the skill is the source of truth, so fix the prompt to match unless the skill change is the deliberate driver)

If zero findings, return: "No drift detected. Prompt and skill are aligned at SKILL.md SHA <X> and systemPrompt.ts SHA <Y>."
```

### When to run

- **Before any commit that touches `systemPrompt.ts`** - even a comment-only edit, because comment edits often signal intent to change rule content.
- **Before any commit that touches `_skills/video-script-generator/SKILL.md`** - even prose-only patches.
- **Before any commit that touches `assembleVideoContext.ts:FORMAT_BLOCKS`** - these are the format-specific rules surface.
- **Quarterly housekeeping**, even if no edits - catches latent drift from sibling repo changes (e.g. SKILL.md edited in `ca-desktop-installer/` distribution copy without source-of-truth update).

### Expected zero-finding state

The drift detector returning zero findings is the contract. Any non-zero finding either:
1. Surfaces unintended drift (FIX: update whichever side is wrong)
2. Surfaces deliberate drift that the alignment-mapping hasn't caught up to (FIX: update this file's mapping table to reflect the deliberate change, then re-run)

---

## 4. Skill section anchor verification

Per Session 92's design-doc-vs-actual-codebase gap class (BACKLOG entry, methodology): every section name referenced in this mapping is verbatim from `SKILL.md`'s `^## ` or `^### ` headings, except where explicitly noted otherwise. Verified by Claude Code on VPS during plan Session 55 implementation (disk session 94, 2026-05-01). F.3a (Session 109) verified the new `## Concept Structure (Pre-Script)` anchor and the v1.5.0 section names in the Pending prompt absorption list against canonical SKILL.md v1.6.0.

Notable details:
- "Core principle" is **inline emphasis** in the §`Purpose` section (line 21 of SKILL.md), NOT its own header. The mapping row for `# Your Role` notes this.
- The format-conditional sub-sections (Voiceover Monologue, Podcast Two-Host, etc.) are `### ` headings under `## Format-Specific Rules`. Verified line numbers match Session 91-shipped v1.3.0.

---

**END OF ALIGNMENT MAPPING**
