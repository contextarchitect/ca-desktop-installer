# Session 9 Log — Sync for Sessions 19, 20, 21 + sync-installer.py automation

**Date:** 2026-05-11
**Branch:** `sync/sessions-19-20-21`
**Companion canonical log:** `context-architect-brands/SESSION_22_LOG.md` (VERSION reconciliation + policy lock-in)
**Routing:** Opus 4.7 in Claude Code (mechanical sync + Python script authoring)

## Scope

Sync skill files from canonical (`contextarchitect/context-architect-brands@main`) covering changes from Sessions 19, 20, 21 (and prior unsynced session work that surfaced during dry-run). Introduces `sync-installer.py` automation so future syncs are per-PR and cheap.

This is the last batched sync. Future syncs follow Policy 3 (per-PR after every canonical skill PR merge).

## sync-installer.py

New file at installer repo root. ~330 lines of self-contained Python 3 (stdlib only).

**Usage:**
```bash
python3 sync-installer.py --canonical-path /path/to/_skills [--dry-run] [--yes]
```

**Invariants enforced:**
1. Distributed skills are skills whose directory exists at the installer repo root. Canonical-only skills are skipped.
2. Installer-only VERSION entries (e.g., `system-prompt=`) preserved verbatim — not read from canonical, not overwritten.
3. Installer never goes ahead of canonical. If detected (installer version > canonical version for a distributed skill), the script WARNs and refuses to downgrade. Human resolution required.
4. File content compared via SHA-256; identical files skipped.
5. Script never deletes files. Installer-only files (in installer but not in canonical) are left alone, surfaced in the plan.

**Comparison logic:** semver-aware (handles `MAJOR.MINOR.PATCH` and prerelease suffixes like `1.0.0-beta`).

## Sync results

Dry-run executed first; plan matched expectations modulo additional drift discovered (see "Drift beyond plan expectations" below). Then applied via `--yes` flag (non-interactive after dry-run review).

### Per-skill copy summary

| Skill | Installer was | Now | Changed | New |
|---|---|---|---|---|
| copywriting-guide | 1.1.1 | 1.2.0 | 1 | 0 |
| funnel-builder | 2.3.1 | 2.5.0 | 3 | 1 |
| ad-style-generator | 1.1.1 | 1.4.0 | 2 | 0 |
| angle-roadmap | 1.1.1 | 1.3.0 | 2 | 0 |
| video-script-generator | 1.3.0 | 1.4.0 | 1 | 1 |
| long-form-static-builder | 1.0.0 | 1.2.0 | 4 | 3 |
| **Total** | — | — | **13** | **5** |

Plus: VERSION file updated to mirror canonical for all 12 distributed skills + `system-prompt=1.2.0` preserved.

Untouched (canonical == installer): business-validation, avatar-research, brand-analyzer, nano-banana-prompting, product-deep-research, video-prompting-guide.

Excluded from distribution: ad-analysis-tagger (in canonical VERSION, no installer directory).

Total files modified: 18 synced + 1 VERSION + 1 sync-installer.py = 20. Well under the 50-file ceiling.

### Drift beyond plan expectations

The original plan anticipated 4 skills needing sync. Dry-run revealed 6 — two additional skills had not been previously synced as the plan assumed:

- **copywriting-guide:** plan assumed in sync at 1.2.0; installer was at 1.1.1.
- **video-script-generator:** plan assumed in sync at 1.4.0; installer was at 1.3.0.

Multiple other skills were further behind than plan estimated (e.g., funnel-builder 2.3.1 vs plan-assumed 2.4.0). All drift handled mechanically by the script per the version comparison logic. No code changes needed; just a larger sync scope than plan estimated.

## Post-sync verification

### VERSION mirror (Stage 3.3)

`cat VERSION` matches canonical for every distributed skill. `system-prompt=1.2.0` preserved.

### Cross-skill ref discipline check (Stage 3.4)

Verified the following ref forms resolve in installer's layout:

- `../<skill>/...` from `<skill>/SKILL.md` (up one level): 6 refs verified, all OK
- `../../<skill>/...` from `<skill>/references/X.md` (up two levels): 5 refs verified, all OK

All cross-skill refs in synced files use relative paths that resolve identically in both canonical (`_skills/<skill>/...`) and installer (`<skill>/...`) layouts. The Session 21 sweep's choice of relative-path Pattern A made the canonical→installer sync trivial.

### `_frameworks/` references (known canonical-side pattern)

Synced files contain references to `_frameworks/awareness-vocabulary.md` and `_frameworks/breakthrough-advertising-brand-onboarding.md`. The `_frameworks/` directory does not exist in the installer repo (it has never been distributed). The reference text reads "see `_frameworks/X.md` in `contextarchitect/context-architect-brands`" — explicitly a cross-repo pointer to canonical, not a local file path. This pre-dates this sync (existed in installer before — verified via `git show main:angle-roadmap/SKILL.md`) and is not a regression introduced here. Treating as known canonical-side pattern; addressing whether/how to surface `_frameworks/` in installer is out of scope for this sync.

### Em-dash sweep (Stage 3.5)

`git diff main -- . | grep -P "^\+.*—|^\+.*–" | wc -l` returns 0. Synced content is em-dash clean (canonical was already cleaned in Session 21).

## Commits planned

1. `feat: sync skills from canonical for Sessions 19, 20, 21 + add sync-installer.py automation` — script + 18 synced files + VERSION
2. `docs: add SESSION_9_LOG.md` — this file

PR target: installer main.

## What this session did NOT do

- Did not distribute new skills (ad-analysis-tagger, breakthrough-advertising, gpt-image-2-prompting remain canonical-only).
- Did not modify `setup` / `setup.ps1` / README — those are independent of skill content.
- Did not touch `system-prompt=1.2.0` (installer-only VERSION key, preserved).
- Did not modify canonical skill content (handled separately in `SESSION_22_LOG.md`).
- Did not run Codex review (mechanical file copy; content already passed Codex review in Sessions 19, 20, 21 canonical PRs).
- Did not auto-resolve `_frameworks/` cross-repo refs (out of scope; canonical-side concern).

## Future workflow (Policy 3)

After every canonical PR merge that touched a skill:

```bash
cd ~/code/ca-desktop-installer  # or wherever installer is checked out
git checkout main && git pull
git checkout -b sync/<short-description>
python3 sync-installer.py --canonical-path /path/to/_skills --dry-run
# Review plan; re-run without --dry-run to apply
python3 sync-installer.py --canonical-path /path/to/_skills
git add . && git commit -m "sync: <skills synced>"
git push -u origin <branch> && gh pr create ...
```

Small mechanical PRs that ship quickly. The script handles version comparison, file diffing, VERSION rewrite, and anomaly detection.

## Skills consolidation cycle status

With this sync, the cycle (Sessions 1, 4, 15, 17, 19, 20, 21) is formally closed end-to-end. Canonical and installer are in sync; per-PR workflow in place going forward.
