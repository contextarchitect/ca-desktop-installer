# Session 10 Log - Installer Sync Recovery (Sessions 19, 20, 21)

**Date:** 2026-05-12
**Branch:** `sync/sessions-19-20-21-recovery`
**Replaces:** Closed PR #4 (`sync/sessions-19-20-21`)
**Companion canonical log:** `context-architect-brands/SESSION_22_LOG.md` (VERSION reconciliation + policy lock-in)
**Routing:** Opus 4.7 in Claude Code (mechanical multi-file sync against a fresh checkout)

## Context

PR #4 was closed because the previous sync ran against a divergent local installer checkout that had not pulled installer remote main. End-state on PR #4 was correct (matched canonical reconciled values) but the diff baseline was wrong, so the PR was `CONFLICTING` against main and would not merge cleanly.

This session is a clean re-run against a freshly-reset installer main, producing a clean diff that maps the actual canonical-vs-installer divergence.

## Recovery process

1. **Salvaged `sync-installer.py`** from closed branch to `/tmp/sync-installer-salvaged.py` before any state changes.
2. **Hard-reset installer main** to `origin/main` (no uncommitted work to preserve).
3. **Confirmed installer main VERSION** matched expected baseline (copywriting-guide=1.1.0, funnel-builder=2.4.0, ad-style-generator=1.2.0, angle-roadmap=1.2.0, long-form-static-builder=1.1.0, video-script-generator=1.4.0).
4. **Closed PR #4** with an explanatory comment.
5. **Deleted branch** `sync/sessions-19-20-21` (local + remote).
6. **Created recovery branch** `sync/sessions-19-20-21-recovery` from clean main.
7. **Installed salvaged script** as first commit on the recovery branch.
8. **Ran dry-run, applied sync, verified post-sync state.**

## Sync results (clean baseline)

### Per-skill copy summary

| Skill | Installer was | Now | Changed | New |
|---|---|---|---|---|
| copywriting-guide | 1.1.0 | 1.2.0 | 1 | 0 |
| funnel-builder | 2.4.0 | 2.5.0 | 3 | 0 |
| ad-style-generator | 1.2.0 | 1.4.0 | 2 | 0 |
| angle-roadmap | 1.2.0 | 1.3.0 | 2 | 0 |
| long-form-static-builder | 1.1.0 | 1.2.0 | 1 | 0 |
| **Total** | - | - | **9** | **0** |

Plus VERSION mirrored to canonical for all 12 distributed skills + `system-prompt=1.2.0` preserved.

Untouched (canonical == installer, content match): business-validation, avatar-research, brand-analyzer, nano-banana-prompting, product-deep-research, video-prompting-guide, video-script-generator.

Excluded from distribution: ad-analysis-tagger (canonical-only).

**Total files modified:** 10 (9 skill files + VERSION) + 1 new (sync-installer.py) = 11 files. Well under 50-file ceiling.

### Why fewer files than PR #4

PR #4 reported 18 synced files; this recovery reports 9. The difference is real: installer main has advanced since PR #4 was first opened. PRs #2 and #3 (`feature/sync-from-source-of-truth` and `sync/sessions-1-4-distribution`) merged Sessions 1, 4, 7 content into installer main, leaving fewer files needing sync for Sessions 19, 20, 21. This is the correct, current divergence picture.

## Post-sync verification

### VERSION mirror

`cat VERSION` matches canonical's `_skills/VERSION` for every distributed skill. `system-prompt=1.2.0` preserved.

### Cross-skill ref discipline check

8 cross-skill refs mechanically verified via `test -e` from each writing file's directory:

- `funnel-builder/SKILL.md` -> `../angle-roadmap/...` (2 refs) OK
- `funnel-builder/SKILL.md` -> `../copywriting-guide/...` (1 ref) OK
- `angle-roadmap/references/angle-card-schema.md` -> `../../funnel-builder/...` (1 ref) OK
- `angle-roadmap/SKILL.md` -> `../funnel-builder/...` (1 ref) OK
- `ad-style-generator/SKILL.md` -> `../angle-roadmap/...` (1 ref) OK
- `ad-style-generator/references/style-catalogue.md` -> `../../long-form-static-builder/...` (1 ref) OK
- `long-form-static-builder/references/worked-examples.md` -> `../../ad-style-generator/...` (1 ref) OK

All cross-skill refs in synced files use relative paths that resolve identically in both canonical (`_skills/<skill>/...`) and installer (`<skill>/...`) layouts.

### Em-dash sweep

`git diff main -- . | grep -P "^\+.*—|^\+.*–" | wc -l` returns 0.

One small fix-up was made during this recovery: the salvaged `sync-installer.py` docstring originally contained two em-dashes (Python comments, not skill copy). To honor the literal sweep policy of "0 matches", these were replaced with `-` and the script's first commit amended. The script's runtime behavior is unchanged.

### `_frameworks/` references (known canonical-side pattern)

As in the prior log, synced skill files reference `_frameworks/X.md` documents in canonical. These are explicit cross-repo pointers ("see `_frameworks/X.md` in `contextarchitect/context-architect-brands`") and have always been part of canonical's authored intent. The installer does not distribute `_frameworks/`. This pre-dates this sync and is not a regression. Whether to distribute some/all `_frameworks/` documents to the installer is a future-consideration item (see "Future hardening" below).

## Commits on `sync/sessions-19-20-21-recovery`

1. `e9f0e31` feat: add sync-installer.py for per-PR sync automation (script-only, amended to drop docstring em-dashes)
2. `709118f` feat: sync skills from canonical for Sessions 19, 20, 21 (VERSION + 9 skill files)
3. (next) docs: add SESSION_10_LOG.md

## Lessons + future hardening

**The recurring failure mode for the previous run was state divergence.** `sync-installer.py` trusts the local installer working tree as-is; it doesn't verify the operator started from `origin/main`. The right fix for next time is one of:

- **Documented prerequisite** in the script's Usage section: "Before running, ensure `git fetch && git status` shows the installer tree matches `origin/main`."
- **Pre-flight check** in the script itself: shell out to `git rev-parse HEAD` vs. `git rev-parse origin/main` and refuse to run if they differ. This is cheap to add but introduces a git dependency in what was a pure-stdlib script.

Not blocking; queued for the next sync run (which under Policy 3 should be soon, since it's per-PR going forward).

**The `_frameworks/` distribution question is also worth a future session.** Operators consuming the installer's skills cannot follow cross-repo refs without cloning canonical. Either: (a) distribute the operator-facing framework docs (`awareness-vocabulary.md` at minimum), or (b) rewrite refs to be self-contained in skill files. Either is a content decision, not a script decision.

## What this session did NOT do

- Did not modify canonical (Session 22 reconciliation already landed at canonical commit 247988c on 2026-05-11).
- Did not re-author sync-installer.py (salvaged from closed branch, docstring em-dashes replaced with hyphens; no logic changes).
- Did not change skill distribution surface (12 distributed skills; ad-analysis-tagger, breakthrough-advertising, gpt-image-2-prompting remain canonical-only).
- Did not modify `setup` / `setup.ps1` / README.
- Did not address `_frameworks/` distribution (logged as future-consideration item).
- Did not implement the prerequisite-state-check hardening for `sync-installer.py` (logged for next sync run).

## Skills consolidation cycle status

With this recovery's PR merged, the cycle (Sessions 1, 4, 15, 17, 19, 20, 21) is formally closed end-to-end. Canonical and installer are in sync; per-PR workflow in place going forward via `sync-installer.py`.
