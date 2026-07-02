# Duplicate Pages - Mode 2 (Competitor Source)

**Use when:** No Figma file exists. The brand has identified a competitor's
live page with a layout and persuasion architecture worth transposing.

**Variants:**
- **Mode 2A:** Brand already sells this product. Competitor has a better page.
  Transpose layout onto the brand's existing product.
- **Mode 2B:** Brand does not sell this product yet. Transpose layout AND mock
  the product before it exists. Functions as a demand test.

**Input:** Competitor URL + screenshots + brand guidelines + (2A only)
existing product copy and asset library.

**Output:** Lovable intent-spec (single paste) + generated image set.

## The two-layer transposition model

A competitor transposition is not "copy everything and swap the logo." It has
two structurally distinct layers with a hard boundary between them.

**Transposable layer (from competitor):** Section sequence, section function,
persuasion mechanics, component types (carousel vs grid, single card vs
multiple, bare-on-background vs card-contained), layout orientation, visual
rhythm structure. This is the skeleton.

**Regenerated layer (from brand - never from competitor):** Voice, tone,
register, copy, claims, vocabulary, imagery style, explicitness ceiling,
allowed proof types, brand palette, typography. This is the flesh.

The operator sets fidelity levers that control how far the regenerated layer
moves toward or away from the competitor's equivalent.

## Conflict types

Before any fidelity decision the skill diffs brand guidelines against
competitor techniques and produces a conflict map. Two conflict types must be
detected and surfaced separately:

**Expression conflicts:** Competitor register vs brand voice rules. Affects
tone, vocabulary, intensity.

**Mechanism conflicts (2B only):** Competitor product mechanism vs brand's
core product thesis (e.g. competitor is acute/same-night, brand is
daily/cumulative). Architectural conflict independent of tone.

## Fidelity levers

The operator sets each lever independently after seeing the conflict map. The
skill never chooses fidelity. It surfaces tension and executes the operator's
decision.

**Three levels per lever:** strict / brand-flexible / competitor-faithful.

**Four levers:**
1. **Expression fidelity:** How close to the competitor's tone and register.
2. **Mechanism fidelity (2B only):** Competitor mechanism vs brand default.
3. **Imagery fidelity:** How close to the competitor's visual style.
4. **Copy intensity:** Language intensity level within the expression register.
   Must be elicited explicitly before copy transposition begins. Present the
   gap, ask the operator to choose. Do not resolve silently (finding S18).

**Hard ceilings at all fidelity levels (non-negotiable):**
- Brand hard-prohibitions (regulatory words, fake scarcity) hold regardless.
- Non-explicit imagery ceiling holds at all levels.
- Non-explicit means no graphic act narration. It does NOT mean no physical
  outcome language. "Him hard. Her dripping." and "Sheets ruined." are physical
  outcomes, not act narration. They are within ceiling. Conflating the two
  produces copy 2 levels below the correct register (finding S20).
- Em-dash ban holds at all levels.

## Mode 2A vs Mode 2B pipeline comparison

| Step | Mode 2A | Mode 2B |
|------|---------|---------|
| 0. Context loading | Brand Phase 3 + Phase 4 | Same |
| 1. Section ordering | Fetch live URL, parse DOM | Same |
| 2. Layer A + conflict map | Expression conflicts only | Expression + mechanism |
| 2. Fidelity decision | Expression / imagery / copy intensity | + mechanism lever |
| 3a. Product transposition | Skip (product exists) | Required |
| 3b. Image generation | Classify slots, fill gaps only | Full set with approval gate |
| 3c. Layer B + operator review | Component inventory tables | Same |
| 4. Copy transposition + approval | Brand + existing copy as source | Brand only |
| 5. Intent-spec assembly | Tables + copy + palette | Same |
| 6. Lovable paste | Single prompt | Same |
| 7. Visual review + fix-up | Standard 1+1+1 ladder | Same |
| 8. State doc update | Mark complete | Same |

## 9-step pipeline

### Step 0: Context loading

Read brand Phase 3 guidelines (palette, prohibited words, hard ceilings) and
Phase 4 copywriting guide (voice rules, intensity levels, avatar register
guidance). Pull targeted sections only - do not blindly load files over 50KB.
Minimum: operative voice rules, prohibited-words list, humanization patterns,
avatar-specific register guidance.

Identify the most relevant avatar. Note their intensity ceiling and
shame/dignity register requirements.

### Step 1: Competitor source intake and section ordering

**All variants - required inputs:**
- Competitor URL (live, fetchable)
- Full-page screenshots (all sections visible)

**Mode 2A - additional inputs:**
- Existing product copy (accuracy reference for claims and ingredients - not
  used verbatim, used as source material)
- Existing asset library location (for image slot classification)
- Existing PDP URL if any (for structural comparison)
- Fallback if copy unavailable: operator provides a product brief before
  Step 4. Copy transposition cannot proceed without it.
- Fallback if asset library unavailable: all image slots default to GENERATE.

**Section ordering gate (non-negotiable):**
Fetch the competitor URL and parse the DOM to establish authoritative section
order before any extraction work begins. Do not infer from screenshots. Do not
order by funnel convention.

Evidence: screenshot-only ordering scored 2/8 in dogfood testing (finding S1).
The error was systematic - assumed conventional funnel arc, real page inverted
social proof and education blocks. Systematic-wrong is more dangerous than
random-wrong.

Fallback if URL is unfetchable: operator labels screenshots with numeric
prefixes (01-hero, 02-stats) before handing them over. Unlabeled screenshots
are a disqualified input for section ordering.

Output: numbered section list with section name and funnel function label.

### Step 2: Layer A extraction and conflict map

**Four-layer extraction:**
1. Sequence and function: each section tagged by funnel role.
2. Per-section persuasion technique: outcome language, experiential stats,
   discovery arc testimonials, ingredient framing, timeline structure,
   self-selection segments, FAQ objection sequencing, etc.
3. Visual rhythm: background alternation, imagery type, typography treatment,
   component visual style at high level.
4. Competitor product spec (2B only): mechanism, onset, duration, ingredients
   with doses, format, price architecture.

**Conflict map:** Two-column table - competitor technique / brand guideline
conflict. Flag expression conflicts and mechanism conflicts as separate rows.
Show operator before any fidelity decision.

**Fidelity decision gate:** Present conflict map and four levers. Operator
sets each lever. Document positions in state doc. Positions govern every
subsequent step and cannot be changed mid-pipeline without restarting from
this step.

### Step 3a: Product transposition design (Mode 2B only)

Design the mock product before imagery or copy begins. Mechanism-conflict
detection must complete first.

Lock in state doc:
- Product name (follow brand naming convention)
- Mechanism (operator decision - can override brand default if
  mechanism-fidelity = competitor-faithful)
- Ingredients (derived from competitor, substituted for brand continuity,
  nothing the brand prohibits)
- Claims language (prohibited-words gate, "supports/promotes/helps maintain",
  FDA disclaimer)
- Price architecture (brand pricing norms, no fake-urgency unless
  expression-fidelity = competitor-faithful and operator confirms)

Light artifact - not the brand's heavyweight new-product-research template.
Do not invoke the heavy template.

### Step 3b: Image generation

**Mode 2A - classify then fill gaps:**
Each image slot gets one label:
- GENERATE: no suitable existing asset, needs Kie.ai
- USE-EXISTING: brand asset library has a suitable image
- PLACEHOLDER: UI element, no image needed
- UI-ELEMENT: badge, icon, star - handled in code

Only GENERATE slots go to Kie.ai. Document classification in state doc first.

**Mode 2B - full generation with approval gate:**
1. Generate 3 packaging mockups at 2K PNG, one per fidelity level. Present
   all three before generating any supporting imagery. Do not skip. Stated
   vs visual preference diverge - confirmed in dogfood (operator said
   competitor-faithful in abstract, chose brand-flexible on seeing renders).
2. After approval, generate full supporting set at approved fidelity level.
   Classify slots first. For each GENERATE slot, use the shared style clause
   derived from the approved mockup.

**Image generation rules (both variants):**
- Resolution discipline (hard rule): site imagery 1K JPG. 2K only for
  mockup approval. Re-render approved 2K hero to 1K before spec.
- Shared style clause on every prompt for visual coherence.
- Visual proxy rule: flag compounds with no recognizable raw form (e.g.
  L-Citrulline - use watermelon + powder proxy).
- Product consistency fix-pattern: pass approved hero as `image_input` to
  subsequent product shots if drift appears.
- Asset workflow: Kie.ai MCP generates in-session. Temp URLs go directly into
  Lovable prompt with instruction to download and store locally on first
  render. Both modes deliver assets straight into Lovable: Mode 1 by prompt
  attachment, Mode 2 by temp URL in prompt text with a download-and-store-on-
  first-render instruction.

### Step 3c: Layer B extraction and operator review

**This step runs before copy (Step 4). Do not proceed until Layer B tables
are complete and operator-reviewed.**

For each section, produce a structured component inventory table:

| Component | Type | Count | Layout | Treatment |

Table format is mandatory. Prose extraction allows silent count and type
errors caught only at render time. A table makes every count a visible cell
value (finding S19).

Layer B captures per section:
- Exact column count and proportions
- Component types (carousel vs grid, single card vs multiple,
  bare-on-background vs card-contained)
- Layout orientation (vertical vs horizontal)
- Wave/curved section edges vs straight edges
- Mixed-font headline patterns
- Avatar component structure (one card with internal rows vs multiple cards)
- Component counts (cards, tabs, FAQ rows, stat columns, etc.)

**Operator review gate:** Present all Layer B tables before Step 4. A wrong
count in a table is catchable in seconds. The same error in rendered Lovable
output costs a full fix-up round.

### Step 4: Copy transposition and operator approval

**Copy intensity elicitation gate (mandatory before writing any copy):**
Identify competitor's intensity level and brand's default for this avatar.
If they differ, present the gap and ask the operator to choose:

> "The competitor runs at Level [X]. Your brand's default for this avatar is
> Level [Y]. Choose: (A) match competitor, (B) use brand default, (C) specify
> a custom level."

Do not resolve silently (finding S18).

**Non-explicit ceiling - held correctly:**
No graphic act narration. Not no physical outcome language.
- Within ceiling: "Him hard. Her turned on." / "Sheets ruined." (physical
  outcome, not act)
- Outside ceiling: graphic narration of the act itself

Conflating these produces copy 2 levels below correct register (finding S20).

**Hard gates on all copy regardless of fidelity:**
- Brand prohibited-words gate
- Em-dash sweep (zero tolerance on glyph)
- Non-explicit ceiling
- No fake urgency, no fake scarcity at any fidelity level

**Mode 2A copy warning:** Existing copy is source material, not a replacement
for transposition. Regenerate at competitor's structural level and
operator-specified intensity. Use existing copy for claims accuracy only.

**Post-copy operator approval gate (mandatory before Step 5):**
Operator confirms:
1. Copy intensity matches chosen lever
2. Prohibited-words gate clean
3. Em-dash sweep clean
4. Non-explicit ceiling correctly applied
5. Brand voice correct for the avatar

Do not proceed to Step 5 until approved. Unapproved copy in the spec can only
be caught after render.

### Step 5: Intent-spec assembly

Combine Layer B tables + approved copy + brand palette + Lovable build
instructions. Each section block:

1. Component inventory table (from Layer B, operator-reviewed)
2. Layout instructions referencing table counts explicitly
3. Verbatim copy (operator-approved)
4. Asset references (Kie.ai temp URLs with download instruction, or resolved
   paths for USE-EXISTING assets)

**The "Do not" block** at the end is as important as the content. Explicitly
prohibit Lovable's defaults for this spec:
- Card containers where bare-on-background is specified
- Grids where carousels are specified
- Horizontal layouts where vertical is specified
- Multiple cards where a single card with internal rows is specified
- Straight section edges where wave/curved edges are specified
- Paraphrased copy
- Skipped or reordered sections

**Screenshot attachment is not viable:** Do not attach competitor screenshots
to the Lovable prompt. Tested in dogfood, confirmed ineffective - two runs
with and without screenshots produced identical output. Visual fidelity comes
from Layer B spec density, not screenshot reference (finding S17).

### Step 6: Lovable paste

Single prompt, no splits. Wait for first generation. Capture screenshots of
all sections.

### Step 7: Visual review and fix-up

Apply the shared fix-up escalation ladder from `../SKILL.md`. 1+1+1 ceiling
per issue. If structural errors are caught before paste (at Step 3c or Step 4
gates), fix the spec and regenerate rather than fix-up a wrongly-scaffolded
render.

### Step 8: State doc update and session close

Mode 2 is a multi-session workflow. The state doc makes it resumable.

Update the state doc to reflect completed status. Log:
- Locked decisions (fidelity lever positions, approved mockup reference, image
  URLs, copy intensity level)
- New findings from this run
- Deferred items (SHIP-AS-IS dispositions, known visual gaps accepted for V1)
- Resume point if pausing mid-run

State doc naming convention (naming pattern, not a resolvable path):
`../_tests/mode-2[a|b]-[brand]-[product-slug].md`

Example: `../_tests/mode-2b-dogfood-ultimapeak.md`

## Key findings reference (S1-S20)

All 20 findings from the Mode 2B dogfood run are in
`../_tests/mode-2b-dogfood-ultimapeak.md`. Critical ones:

- **S1:** Section order from live URL DOM, never screenshot inference. 2/8
  accuracy when inferred from screenshots.
- **S17:** Screenshot attachment to Lovable prompt has no effect. Visual
  fidelity comes from Layer B spec density only.
- **S18:** Copy intensity must be explicitly elicited. Silent defaulting to
  brand register produces copy 2 levels below competitor without operator
  noticing until render.
- **S19:** Layer B must be a structured table, not prose. Prose allows silent
  count errors that propagate to render.
- **S20:** Non-explicit ceiling = no act narration, not no physical outcome
  language. Conflating them produces systematically under-registered copy.
