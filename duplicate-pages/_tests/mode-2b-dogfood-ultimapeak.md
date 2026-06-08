# figma-to-lovable Mode 2 - Dogfood Run (Mode 2B)

Living document. Captures the step-by-step Mode 2B process as run for real, including friction, decisions, and skill-spec implications. The synthesis at the end becomes the basis for the Mode 2 skill build.

**Status:** COMPLETE. All 8 steps executed across two sessions. Findings S1-S20 locked. See consolidated skill-spec implications for Mode 2B skill build.

---

## Run parameters

- **Mode:** 2B (copy competitor structure + story arc AND mock a new product the brand does not currently sell, via Nano Banana, to test demand before real product development).
- **Brand:** UltimaPeak (men's vitality). Brand context lives in a SEPARATE repo: `UltimaPeak-Claude/UltimaPeak` (Phase 1-9 docs). NOT in `context-architect-brands`.
- **Competitor source:** `https://cubesofficial.com/products/spicy-cubes` - "Kinky Cubes," a couples aphrodisiac gummy PDP.
- **Deploy target:** Lovable (same downstream interaction layer as Mode 1).
- **Output shape:** intent-spec + asset manifest + fix-up prompts (Mode 1 family), with two NEW upstream steps: competitor extraction and product transposition design.
- **Mode 2B intent for this run:** Option 1 (category-jump) chosen as the test case because it is the strictest/superset case. Operator flagged real brands span all options; the SKILL must expose the choice, not hardcode one.

## Relationship to Mode 1

Per Mode 1's SKILL.md, Mode 2 is a SEPARATE skill sharing Mode 1's Lovable interaction layer (intent-spec, fix-up ladder, em-dash sweep, locked-vs-flexible contract) but with a different upstream pipeline. Mode 1 input = Figma file (design ground truth). Mode 2 input = competitor URL + screenshots (competitor is layout reference; we transpose our brand onto it). Proposed eventual home: `_skills/figma-to-lovable-mode-2/`.

---

## Step 0: Context loading

Read UltimaPeak Phase 3 brand guidelines (59KB) in full. Phase 4 copywriting guide identified, NOT yet read (base 70KB + v1.3 16KB + v1.4 16KB) - FIRST task on Step 4 resume.

Key brand facts (Phase 3):
- Sage(60%)/Caregiver(40%) men's vitality brand. Tagline: "Your body, working the way it should."
- Core mechanism thesis: DAILY/CUMULATIVE ("one gummy every morning," "weeks 2-3," "97% adherence IS the mechanism").
- Palette: Deep Navy #1B2A4A, Slate White #F5F5F0, Forest Teal #2A7D6E, Warm Stone #D4C5B2, Amber Gold #C4913A (sparingly).
- Hard prohibited words: testosterone booster, alpha/beast mode/dominate, breakthrough/revolutionary, anti-aging, erectile/dysfunction/ED, fix/broken, proprietary blend, instant/overnight, ancient secret.
- Forbids: fake urgency, fake scarcity, sexually explicit imagery, before/after transformation, shame/fear motivators.
- Reference brands (emulate): Hims, Thorne, Transparent Labs, AG1, Ritual. (Avoid: Nugenix, Gorilla Mind, ExtenZe, Amazon T-boosters.)
- David persona (relationship/intimacy buyer, 10-15%) + Female Gift-Buyer (20-35% revenue) = emotional bridge to intimacy category. Brand addresses sexual health in a RESTRAINED register ("she noticed before I did," never explicit).
- Precedent: `new-product-exploration/tanning-gummy/` = a 32KB deep-research brief. Brand explores new categories, via a heavyweight artifact.

---

## Step 1: Competitor source intake + section ordering

### Test
Operator supplied URL + 8 full-page screenshots in randomized order with randomized filenames. Can Claude determine section order from screenshots alone, or must the operator label them?

### Result
- Claude visual-only reconstruction: 5, 4, 1, 2, 6, 7, 8, 3
- Authoritative live-URL DOM order: 5, 6, 7, 8, 1, 2, 4, 3
- **Score: 2/8** (only structural anchors: hero=top, FAQ/close=bottom). All 6 interior sections misplaced.

Live DOM order:
1. Hero + buy box
2. "The Numbers Speak For Themselves" (stat band)
3. "Real Couples. Real Nights." (video UGC, 4)
4. "Why Our Customers Love Us" (written reviews, 4)
5. "What's In Our Gummies?" (4 ingredients)
6. "Your Journey to Better Intimacy" (3-phase timeline by time-after-dose)
7. "An Immediate Difference" (who-it's-for, 4 segments + product shot)
8. FAQ (8 Qs) + money-back guarantee + CLAIM NOW

### Friction
Error was SYSTEMATIC: Claude assumed a textbook arc (education, then mechanism, then social proof, then close). Real page front-loads ALL social proof after the buy box, then education, then close. Two blocks inverted. Systematic-wrong is MORE dangerous than random-wrong: it reads as a plausible funnel and could be accepted without checking. Live fetch returned complete DOM order incl. below-the-fold detail screenshots missed.

### Decision
Section order from live URL, never screenshot inference. (1) Primary: fetch URL, parse DOM. (2) Screenshots = visual reference only. (3) Fallback if URL unfetchable: operator-labeled screenshots with numeric prefixes.

### Implication
Mode 2 analog of Mode 1 Bug 8. Skill gate: "Confirm section order against live URL DOM (or operator labels) before extraction. Do NOT order by funnel convention." Evidence: 2/8.

---

## Step 2: Competitor extraction

### Four-layer extraction (Kinky Cubes)
- **Layer 1, sequence + function:** 8 sections, each tagged by funnel function.
- **Layer 2, per-section technique:** hero = outcome language + benefit chips + warning-as-potency-signal; stats experiential not clinical; video UGC = explicit before/after discovery arcs; reviews vary speaker/objection; ingredients colloquial felt-benefit; timeline narrates forward in time with escalating intensity; who-it's-for = self-selection into emotional segments; FAQ sequences logistics, then efficacy, then skeptic objection, then safety, then risk reversal.
- **Layer 3, visual rhythm:** alternating pink/maroon bands; heavy social-proof imagery; one ingredient image per card; product hero shots (floating among gummies; in-hand UGC); rounded display font + italic serif accents.
- **Layer 4, competitor product spec:** 16 gummies/bag, "hot peach + chili," couples intimacy, ACUTE (2 cubes, 30 min onset, up to 3 hrs). Buy-box ingredients: L-Citrulline 1500mg, Beetroot 300mg, Panax Ginseng 200mg, Mucuna 150mg, Saffron 30mg. Price ~$39.99 (from $79.99 anchor), tiers to Buy 2 Get 1.

### Central finding: two-layer transposition model
NOT "copy competitor + swap product." It is:
- **Transposable layer (from competitor):** sequence, section function, persuasion mechanics, visual-rhythm structure.
- **Regenerated layer (from brand, never competitor):** voice, tone, register, claims, vocabulary, imagery style, explicitness ceiling, allowed proof types.
Mode 2 analog of Mode 1's locked-vs-flexible contract: "competitor controls structure / brand controls everything expressive."

### Conflict map (brand-agnostic machinery)
Skill reads brand guidelines + competitor techniques, diffs them, shows the operator where competitor techniques contradict brand guidelines. UltimaPeak vs Cubes conflict is severe (explicit narrative, fake urgency, reverse-psychology potency, crude register, nearly all prohibited by UltimaPeak).

### TWO distinct conflict TYPES (not one)
1. **Expression conflict:** competitor register vs brand expression rules (tone/words).
2. **Mechanism conflict:** competitor ACUTE same-night vs brand DAILY-cumulative thesis (product, independent of tone).
Separable; decided separately; skill detects and surfaces both.

### Central finding (operator correction): fidelity is an OPERATOR INPUT
Degree of brand-layer regeneration is the operator's lever. Skill: (a) operator chooses at outset, (b) conflict map shown so choice is informed, (c) execute faithfully. Levels: strict / brand-flexible / competitor-faithful. Skill does NOT choose.

### Refinement: fidelity is SEPARABLE LEVERS
This run: expression/palette = flexible, mechanism = acute (competitor-faithful), imagery = flexible-intimate. Three dials, three positions. Expose each separately.

### Hard ceiling at ALL fidelity levels
(a) Brand hard-prohibitions (regulatory words, fake scarcity) stay in force, flexibility bends register not guardrails. (b) Imagery ceiling stays non-explicit regardless of fidelity.

---

## Step 3a: Product transposition design (2B-unique)

- **Name:** UltimaPeak Intimacy (brand convention: [Brand] + [Descriptive], no invented names). Competitor-faithful variation used "ULTIMAPEAK SPARK."
- **Mechanism:** ACUTE/same-night (operator decision; overrides brand daily thesis to match competitor category). Mechanism-fidelity = competitor-faithful while expression-fidelity held tighter.
- **Ingredients (locked):** Maca (desire, non-hormonal, real hero ingredient), L-Citrulline (blood flow), Panax Ginseng (arousal/energy), Saffron (mood/desire). Dropped Cubes' Cayenne for Maca (brand continuity).
- **Claims:** prohibited-words gate; "supports/promotes/helps maintain"; FDA disclaimer.
- **Price:** premium, NOT discount-anchored fake-urgency.

### Findings
- Product mock = LIGHTER artifact than the brand's heavyweight new-product-research template. Skill does NOT invoke the heavy template.
- Mechanism-conflict detection is a required PRE-mock step.

---

## Step 3b: Product visual mock (Nano Banana via Kie.ai MCP)

### Approach
Generated 3 packaging mockups = the 3 fidelity levels (strict/flexible/competitor-faithful), 2K PNG, for an approval gate BEFORE full page imagery. Operator approves one, then supporting imagery generated to match.

### The 3 mockups (2K PNG)
- **A (strict):** navy/white/teal, clean wordmark, discreet/premium, Hims/Ritual-adjacent.
- **B (brand-flexible):** warm plum-amber gradient, soft gold, cream, premium-sensual but tasteful. OPERATOR APPROVED.
- **C (competitor-faithful):** vivid red-maroon, bold bubble lettering "SPARK," provocative DR energy.
All 3 first-try, 53-128s, text clean on approved variation.

### Key finding: seeing rendered options changed the choice
Operator stated UltimaPeak leans competitor-faithful in the abstract, but on seeing the mocks chose brand-flexible. Stated vs visual preference diverged. Skill default: generate the fidelity spectrum, operator picks, then generate supporting imagery at chosen level.

### Supporting image set (Variation B fidelity, all 1K JPG)
9 images, all first-try, 21-50s, 8 credits each (72 total): hero pouch (1K re-render), 4 ingredients (Maca, L-Citrulline via watermelon+powder, Panax Ginseng, Saffron), 2 lifestyle/couple (in-bed non-explicit; woman holding pouch UGC), 2 product-in-context (floating among gummies; on nightstand). All approved.

### Findings
- **RESOLUTION DISCIPLINE (hard rule):** all site imagery 1K JPG always (load speed). 2K only for mockup/approval. Re-render approved 2K hero to 1K JPG before ship.
- **Not every image slot needs generation.** Avatars/badges/UI chrome = placeholder/UI-element, not generation. Classify each slot GENERATE/PLACEHOLDER/UI-ELEMENT before spending credits.
- **Some ingredients need a visual proxy** (L-Citrulline = compound, no raw look; used watermelon+powder).
- **Shared style clause** repeated across every prompt for a coherent art-directed set.
- **Product consistency across independent generations is the open risk.** Fix-pattern: pass approved hero as `image_input` reference to subsequent product shots if drift appears. (This run judged consistent enough to proceed.)
- **Approval-before-full-generation** sequence avoids wasted credits.

### Image asset URLs (TEMPORARY, Kie.ai tempfile, ~24h expiry)
Per operator: final Lovable prompt will include links + instruct Lovable to download/store locally. On resume, if expired, regenerate from prompts in the conversation transcript using the Variation B style clause.
- Hero pouch 1K: .../1779863180736-lah79u3iosh.jpg
- Maca: .../1779863192462-4q66xjeqd6a.jpg
- L-Citrulline: .../1779863190562-s22h7cn77c.jpg
- Panax Ginseng: .../1779863195505-a8stxta4ygu.jpg
- Saffron: .../images/1779863183815-5a4qlac428q.jpeg
- Couple in bed: .../images/1779863191344-qbz56gldo3i.jpeg
- Woman holding pouch: .../1779863226170-vtqhpsq7dvs.jpg
- Pouch floating: .../1779863222142-qd0l5xtf52t.jpg
- Pouch nightstand: .../1779863226984-h68q6fhrgzn.jpg

---

## Step 4: Copy transposition (COMPLETE)

Read Phase 4 copywriting guide: base (70KB) + additions v1.4 + v1.3. Transposed all 8 sections at Variation B fidelity.

Key finding during execution: initial transposition defaulted to Level 2-3 intensity without surfacing the choice to the operator. Operator caught this on review - competitor runs at Level 4 (testimonial-raw) throughout. Re-ran at Level 4 after operator specified.

Critical clarification locked as S20: the non-explicit ceiling means no graphic ACT NARRATION. It does not mean no physical outcome language. "Him hard. Her dripping." / "Sheets ruined." are within ceiling at all fidelity levels. Conflating the two produces copy 2 levels below the correct register.

Approved Level 4 copy produced for all 8 sections. Em-dash sweep clean. Prohibited-words gate clean. Non-explicit ceiling confirmed.

Register calibration confirmed (Variation B, Level 4):
- Hero chip: "Him hard. Her turned on." (competitor: "Him Hard. Her Dripping.")
- Guarantee: "Wet Sheets Or Your Money Back." (competitor: "Wet Sheets Or Your Money Back.")
- UGC: "Sheets ruined. Already reordered." (competitor: "I soaked through the sheets.")

## Step 5: Intent-spec assembly (COMPLETE)

Three passes required to reach production-quality output:
- Pass 1 (prose-only intent-spec): Structurally correct, visually divergent. Lovable defaulted to its own design system. Root cause: insufficient layout specification density.
- Pass 2 (prose + competitor screenshots attached): Identical output to Pass 1. Confirmed finding S17: screenshots attached to Lovable prompt have no reliable effect. Visual fidelity comes from spec density, not screenshot reference.
- Pass 3 (Layer B component inventory tables + prose): Visually close to competitor. Two remaining issues caught: hero benefit card count wrong (2 vs 3, finding S19), copy register too low (finding S18/S20). Fixed in Pass 4.
- Pass 4 (full component tables + Level 4 copy): Landed cleanly. Operator signed off.

Key methodology locked: Mode 2 intent-spec requires TWO extraction layers before writing:
- Layer A (done in Step 2): section function, persuasion mechanics, fidelity conflict map.
- Layer B (done before spec write): per-section component inventory table (component / type / count / layout / treatment). Table format enforces explicit enumeration. Prose extraction allows silent count/type errors.

Image asset workflow confirmed: Kie.ai MCP generates in-session, temp URLs go directly into Lovable prompt with instruction to download and store locally on first render. No Supabase upload step. This is the Mode 2 asset workflow (different from Mode 1).

## Step 6: Fix-up prompts (COMPLETE - subsumed into Pass 4)

The fix-up ladder was pre-empted by regenerating the full intent-spec at Pass 4 with correct component tables and Level 4 copy. The three remaining issues (3rd benefit card, copy intensity, component inventory tables) were structural enough to warrant a full spec rewrite rather than targeted fix-up prompts.

Fix-up prompts remain the correct tool for post-render visual adjustments (spacing, color, mobile breakpoints). For structural component count errors or copy register errors caught before paste, a spec rewrite is more reliable than attempting fix-up on a wrongly-scaffolded render.

## Step 7: Skill signoff (COMPLETE)

Mode 2B V1 signed off by operator. Skill will be improved over time as client feedback comes in. Findings S1-S20 are the basis for the Mode 2 skill build.

---

## Consolidated skill-spec implications

1. **[S1] Section order from live URL (primary) or operator-labeled screenshots (fallback). Never unlabeled-screenshot inference.** Evidence: 2/8. Mode 2 analog of Mode 1 Bug 8.
2. **[S2] Two-layer transposition:** transposable layer (structure) from competitor; expression layer (voice/claims/imagery) regenerated from brand.
3. **[S2] Competitor-vs-brand conflict map** before transposition; shown to operator regardless of fidelity.
4. **[S2] Brand fidelity is an explicit operator input** chosen with the conflict map visible. Three levels. Skill surfaces tension, executes choice, does not choose.
5. **[S2] Fidelity is SEPARABLE LEVERS** (expression/mechanism/imagery), not one slider.
6. **[S2] Two conflict TYPES:** expression (tone/words) and mechanism (acute-vs-daily). Detect/surface both.
7. **[S2] Hard ceiling at all fidelity levels:** brand prohibitions + non-explicit imagery hold. Fidelity bends register, not guardrails.
8. **[S3a] Product mock is a LIGHT artifact,** not the brand's heavyweight research template.
9. **[S3a] Mechanism-conflict detection is a required pre-mock step.**
10. **[S3b] Product-mock approval gate = generate the fidelity spectrum, operator picks, then generate supporting imagery at chosen level.** Seeing options changes the choice.
11. **[S3b] RESOLUTION DISCIPLINE (hard rule):** site imagery 1K JPG; 2K only for approval; downgrade approved hero before ship.
12. **[S3b] Classify each image slot GENERATE/PLACEHOLDER/UI-ELEMENT** before spending credits.
13. **[S3b] Flag ingredients needing a visual proxy** (compounds/extracts).
14. **[S3b] Reusable style clause** appended to every supporting-image prompt for a coherent set.
15. **[S3b] Product-consistency fix-pattern:** pass approved hero as `image_input` to subsequent product shots when independent generations drift.
16. **[Meta] Mode 2 is a long, multi-gate, multi-session workflow.** Unlike single-session Mode 1, it needs an explicitly RESUMABLE design: a state doc capturing progress so it runs across sessions. Evidence: this dogfood had to checkpoint and pause at Step 4.
17. **[S17] Screenshots attached to Lovable prompt have no reliable effect on visual output.** Mode 2 visual fidelity comes from Layer B component inventory density in the spec, not from screenshot reference. Prose layout description alone produces structurally correct but visually divergent output. Layer B component tables are the mechanism that constrains Lovable's layout defaults.
18. **[S18] Copy intensity is a separable sub-lever of expression fidelity requiring explicit elicitation before copy transposition begins.** When competitor register diverges from brand default, the skill must surface the gap and present the operator with a choice: match competitor intensity / use brand default / specify custom level. Do not resolve silently. Confirmed by dogfood: operator did not notice the defaulting until seeing rendered output.
19. **[S19] Layer B component extraction must produce a structured inventory table per section (component / type / count / layout / treatment) before the intent-spec is written.** Table format enforces explicit enumeration. Count errors in prose extraction propagate silently into the spec and are only caught at render time. The table is the verification artifact between screenshot observation and spec writing. Operator reviews the table before copy transposition begins.
20. **[S20] The non-explicit ceiling means no graphic act narration.** It does not mean no physical outcome language. "Him hard. Her dripping." and "Sheets ruined." are within ceiling at all fidelity levels. Conflating the two produces copy 2 levels below the correct register. Clarify this in the skill's fidelity definition layer.

---

## Process finding: GitHub MCP tooling

During the session-close commit, `create_or_update_file` failed repeatedly with opaque "Tool execution failed" errors (no GitHub API error body), across both repos, all paths, all content sizes. Initial (wrong) diagnosis was "Desktop MCP is read-only by design." A single probe with `push_files` succeeded immediately, proving writes work and auth/permissions are intact. Root cause is isolated to the `create_or_update_file` tool (likely its internal get-SHA-before-write step mishandling the new-file case), not to writes in general. WORKAROUND: use `push_files` for MCP writes from Desktop until `create_or_update_file` is fixed. Cleanup item: `_mcp-write-probe.txt` was created on context-architect-brands main (commit e216676) during diagnosis and must be removed.
