# Session 11 Log - sync-installer.py prerequisite-state check

**Date:** 2026-05-12
**Branch:** `harden/sync-prerequisite-state-check`
**Follows:** PR #5 / SESSION_10 (installer sync recovery)
**Routing:** Opus 4.7 in Claude Code (single-file Python edit + tests)

## Context

PR #4 hit merge conflicts on 2026-05-12 because `sync-installer.py` ran against a divergent local checkout: the working tree's VERSION values didn't match installer remote main, so the script's diff baseline was wrong. PR #5 recovered by hard-resetting first, but the script itself still trusted local state implicitly. This session adds an explicit pre-flight check so the script fails fast when the assumption it depends on is violated.

This is the root-cause fix for the PR #4 failure mode, queued in SESSION_10's "future hardening" section.

## What changed

Single file: `sync-installer.py`. Five insertions:

1. **Import:** added `import subprocess` to the existing stdlib import block.
2. **Function:** new `check_git_state(installer_root, no_git_check)` after `sha256()`. Verifies:
   - Installer root is a git repository
   - `git merge-base --is-ancestor origin/main HEAD` succeeds (HEAD on or descended from `origin/main`)
   - `git status --porcelain` is empty (working tree clean)
   - Any failure prints a clear error message with copy-paste fix commands and exits with code 4
3. **CLI flag:** new `--no-git-check` argparse argument for legitimate-bypass cases (CI with detached HEAD, deliberate work on unrelated branches).
4. **Call site:** `check_git_state(installer_root, args.no_git_check)` invoked at the start of `main()`, right after `installer_root` resolution and before the canonical/installer VERSION existence checks.
5. **Docstring:** new `Prerequisites` section explaining expected pre-run state, the auto-check, and the bypass flag. References the PR #4 precedent.

Net diff: +125 lines, single file.

## Verification

### Syntax + help text

- `python3 -c "import ast; ast.parse(open('sync-installer.py').read())"` returns OK
- `--help` output shows all 4 flags: `--canonical-path`, `--dry-run`, `--yes`, `--no-git-check`
- `grep` post-edit verification: `check_git_state` (1), `--no-git-check` (6), `subprocess` (1), `Prerequisites` (1) - all match expected counts

### Functional test (clean state, post-commit)

`python3 sync-installer.py --canonical-path .../_skills --dry-run` from clean `harden/...` branch (HEAD descends from `origin/main`, working tree clean):

- Pre-flight passes silently
- Sync plan correctly reports "Skills needing sync: _None._" (canonical and installer in sync post-PR-5)
- All 12 distributed skills listed under "Skills NOT needing sync"
- `ad-analysis-tagger` correctly flagged as canonical-only
- `system-prompt=1.2.0` listed as installer-only preserved
- Exit 0

### Negative test (regression test for the PR #4 failure mode)

`echo "# test" >> VERSION` (dirty working tree), then re-run:

- Pre-flight rejects: `ERROR: working tree has uncommitted changes: M VERSION`
- Error message includes the fix recommendation (commit, stash, or discard) + `--no-git-check` bypass hint
- Exit 4

After `git checkout -- VERSION` (clean revert), pre-flight passes again, exit 0.

This confirms the check actually fires on the failure mode it's designed to catch.

### Em-dash sweep

`git diff main -- sync-installer.py | grep -P "^\+.*—|^\+.*–" | wc -l` returns 0.

## Out of scope (future-consideration items, rolled forward from SESSION_10)

- **`_frameworks/` distribution decision.** Skill files contain cross-repo refs to `_frameworks/` documents in canonical. Operators following the installer's skills can't follow those refs without cloning canonical. Either distribute the operator-facing framework docs (`awareness-vocabulary.md` at minimum) or rewrite refs to be self-contained. Content decision; out of scope for this hardening PR.

## Commits

1. `e479d3a` feat(sync): add prerequisite-state check to sync-installer.py
2. (next) docs: add SESSION_11_LOG.md

## Skills consolidation cycle status

With this PR merged, the cycle's tooling is fully hardened:
- Canonical reconciled (commit 247988c on canonical main)
- Installer reconciled (PR #5 on installer main)
- `sync-installer.py` automation in place (PR #5)
- `sync-installer.py` prerequisite-state hardening (this PR)
- Three governance policies locked in

Future skill cycle work is unblocked. Next sync run (after the next canonical skill PR merge) starts with a self-defending script.
