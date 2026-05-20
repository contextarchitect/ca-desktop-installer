# Breakthrough Advertising Guidelines

Quick reference for loading the right Schwartz reference files. Start here, then load only the files needed for the assignment.

## By Use Case

| Use case | Load these files |
|----------|------------------|
| Diagnose a market | `references/mass-desire/checklist.md`, `references/awareness-stages/checklist.md`, `references/sophistication-stages/checklist.md` |
| Generate or audit a headline | `references/headlines/checklist.md`, `references/headlines/rules.md`, plus the relevant awareness or sophistication checklist |
| Audit existing copy | `references/intensification/rules.md`, `references/identification-gradualization/rules.md`, `references/proof-and-focus/rules.md` |
| Plan a campaign | `references/creative-planning/rules.md`, `references/mass-desire/knowledge.md`, `references/awareness-stages/knowledge.md`, `references/sophistication-stages/knowledge.md` |
| Strengthen weak copy | Start with the symptom table below, then load the matching technique rules and examples |

## By Symptom

| If you notice... | Load these files |
|------------------|------------------|
| No clear market hunger | `references/mass-desire/checklist.md`, `references/mass-desire/rules.md` |
| The copy tries to manufacture desire | `references/mass-desire/knowledge.md`, `references/mass-desire/examples.md` |
| The opening feels wrong for the prospect | `references/awareness-stages/checklist.md`, `references/awareness-stages/rules.md` |
| The market has heard the promise before | `references/sophistication-stages/checklist.md`, `references/sophistication-stages/rules.md` |
| The headline feels weak | `references/headlines/checklist.md`, `references/headlines/examples.md` |
| The ad has no planning logic | `references/creative-planning/rules.md`, `references/creative-planning/knowledge.md` |
| Benefits feel abstract or thin | `references/intensification/rules.md`, `references/intensification/patterns.md` |
| The product has no personality | `references/identification-gradualization/knowledge.md`, `references/identification-gradualization/rules.md` |
| The claim feels unbelievable | `references/identification-gradualization/rules.md`, `references/proof-and-focus/rules.md` |
| A product flaw blocks the sale | `references/proof-and-focus/knowledge.md`, `references/proof-and-focus/patterns.md` |
| The mechanism is unclear | `references/proof-and-focus/rules.md`, `references/proof-and-focus/examples.md` |
| Competitors own the desire | `references/proof-and-focus/rules.md`, `references/proof-and-focus/patterns.md` |

## Decision Tree

```text
Fresh assignment
|
+-- Is the market/desire undefined?
|   +-- Load references/mass-desire/checklist.md
|   +-- Then references/awareness-stages/checklist.md
|   +-- Then references/sophistication-stages/checklist.md
|
+-- Is the task a headline?
|   +-- Load references/headlines/checklist.md
|   +-- If audience fit is uncertain, add references/awareness-stages/rules.md
|   +-- If market fatigue is likely, add references/sophistication-stages/rules.md
|
+-- Is the task full campaign planning?
|   +-- Load references/creative-planning/rules.md
|   +-- Add references/mass-desire/knowledge.md for desire selection
|   +-- Add references/awareness-stages/knowledge.md and references/sophistication-stages/knowledge.md for market state
|
+-- Is the copy already written?
|   +-- Thin desire -> references/intensification/rules.md
|   +-- Weak identity -> references/identification-gradualization/rules.md
|   +-- Weak proof or focus -> references/proof-and-focus/rules.md
|
+-- Is the copy failing but the reason is unclear?
    +-- Run references/mass-desire/checklist.md
    +-- Run references/awareness-stages/checklist.md
    +-- Run references/sophistication-stages/checklist.md
    +-- Then choose the missing technique from the symptom table
```

## Definition Ownership

To keep the system consistent, use these files as the canonical definition sources:

| Concept | Canonical source | Other files should... |
|---------|------------------|-----------------------|
| Mass desire | `references/mass-desire/knowledge.md` | Refer to existing desire, not redefine it |
| Five awareness stages | `references/awareness-stages/knowledge.md` | Reference stage labels only |
| Five sophistication stages | `references/sophistication-stages/knowledge.md` | Reference stage labels only |
| 38 headline methods | `references/headlines/rules.md` | Reference the checklist/rules |
| Creative planning sequence | `references/creative-planning/rules.md` | Route to the sequence |
| Intensification | `references/intensification/knowledge.md` | Reference the technique and load rules/examples |
| Identification | `references/identification-gradualization/knowledge.md` | Reference the technique and load rules/examples |
| Gradualization | `references/identification-gradualization/knowledge.md` | Reference the technique and load rules/examples |
| Redefinition | `references/proof-and-focus/knowledge.md` | Reference the technique and load rules/patterns |
| Mechanization | `references/proof-and-focus/knowledge.md` | Reference the technique and load rules/patterns |
| Concentration | `references/proof-and-focus/knowledge.md` | Reference the technique and load rules/patterns |
| Camouflage | `references/proof-and-focus/knowledge.md` | Reference the technique and load rules/patterns |

## File Index

### Mass Desire

| File | Purpose | Lines |
|------|---------|-------|
| `references/mass-desire/knowledge.md` | Defines mass desire, amplification, desire dimensions, and product performance | ~142 |
| `references/mass-desire/rules.md` | Rules for selecting and channeling existing desire | ~93 |
| `references/mass-desire/examples.md` | Schwartz examples of desire alignment and misalignment | ~75 |
| `references/mass-desire/checklist.md` | Diagnostic for whether a usable mass desire is present | ~71 |

### Awareness Stages

| File | Purpose | Lines |
|------|---------|-------|
| `references/awareness-stages/knowledge.md` | Defines the five awareness stages | ~132 |
| `references/awareness-stages/rules.md` | Headline and opening rules by awareness stage | ~116 |
| `references/awareness-stages/examples.md` | Schwartz examples by awareness stage | ~123 |
| `references/awareness-stages/checklist.md` | Diagnostic for prospect awareness | ~112 |

### Sophistication Stages

| File | Purpose | Lines |
|------|---------|-------|
| `references/sophistication-stages/knowledge.md` | Defines the five sophistication stages | ~115 |
| `references/sophistication-stages/rules.md` | Copy moves by sophistication stage | ~96 |
| `references/sophistication-stages/examples.md` | Schwartz examples by stage and market cycle | ~75 |
| `references/sophistication-stages/checklist.md` | Diagnostic for market sophistication | ~62 |

### Headlines

| File | Purpose | Lines |
|------|---------|-------|
| `references/headlines/knowledge.md` | Explains headline purpose and connection to awareness/sophistication | ~129 |
| `references/headlines/rules.md` | The 38 headline strengthening methods, clustered | ~122 |
| `references/headlines/examples.md` | Schwartz headline examples with relevance tags | ~171 |
| `references/headlines/checklist.md` | 38-way headline diagnostic | ~89 |

### Creative Planning

| File | Purpose | Lines |
|------|---------|-------|
| `references/creative-planning/knowledge.md` | Psychological foundation for planning copy | ~135 |
| `references/creative-planning/rules.md` | End-to-end creative planning sequence | ~161 |
| `references/creative-planning/examples.md` | Planning examples from Chapters 5 and 6 | ~75 |

### Intensification

| File | Purpose | Lines |
|------|---------|-------|
| `references/intensification/knowledge.md` | Defines Intensification and its role in desire-building | ~131 |
| `references/intensification/rules.md` | Rules and thirteen moves for intensifying desire | ~138 |
| `references/intensification/examples.md` | Schwartz examples from Chapter 7 | ~195 |
| `references/intensification/patterns.md` | Reusable Intensification patterns | ~192 |

### Identification + Gradualization

| File | Purpose | Lines |
|------|---------|-------|
| `references/identification-gradualization/knowledge.md` | Defines Identification and Gradualization | ~123 |
| `references/identification-gradualization/rules.md` | Rules for product personality and belief architecture | ~106 |
| `references/identification-gradualization/examples.md` | Schwartz examples from Chapters 8 and 9 | ~99 |

### Proof + Focus

| File | Purpose | Lines |
|------|---------|-------|
| `references/proof-and-focus/knowledge.md` | Defines Redefinition, Mechanization, Concentration, and Camouflage | ~123 |
| `references/proof-and-focus/rules.md` | Operating rules for proof and focus techniques | ~113 |
| `references/proof-and-focus/examples.md` | Schwartz examples from Chapters 10-13 | ~131 |
| `references/proof-and-focus/patterns.md` | Technique combinations and selection guide | ~199 |

## Common Combinations

| Scenario | Files to load |
|----------|---------------|
| Market diagnosis before writing | `references/mass-desire/checklist.md` + `references/awareness-stages/checklist.md` + `references/sophistication-stages/checklist.md` |
| Headline rewrite | `references/headlines/checklist.md` + `references/headlines/rules.md` + relevant market-stage rules |
| Body copy feels flat | `references/intensification/rules.md` + `references/intensification/examples.md` |
| Offer feels unbelievable | `references/identification-gradualization/rules.md` + `references/proof-and-focus/rules.md` |
| Campaign from scratch | `references/creative-planning/rules.md` + `references/mass-desire/knowledge.md` + both stage knowledge files |
