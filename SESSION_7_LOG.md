# Session 7 Log: ca-desktop-installer Reverse Sync

**Date:** May 7, 2026
**Operator:** hilal
**Session type:** VPS Claude Code (multi-file mechanical sync with structural verification)
**Topology:** vps-claude-code-installer-reverse-sync
**Repo:** https://github.com/contextarchitect/ca-desktop-installer
**Branch:** `feature/sync-from-source-of-truth` -> `main`
**PR:** https://github.com/contextarchitect/ca-desktop-installer/pull/2

## What changed

After PR #4 in `context-architect-brands` merged the Schwartz framework into source-of-truth, installer was divergent on 5 skills. This session brought installer back in sync. **Installer is now strictly downstream of source-of-truth.**

## Files modified

| File / directory | Change | Why |
|------------------|--------|-----|
| `copywriting-guide/` | rm -rf + cp from source | Replace installer 1.1.1 with source 1.1.0 (functionally a superset) |
| `funnel-builder/` | rm -rf + cp from source | Replace installer 2.3.1 with source 2.3.0 (adds Funnel Factory pipeline + cross-references) |
| `ad-style-generator/` | rm -rf + cp from source | Replace installer 1.1.1 with source 1.2.0 (adds REDDIT-NATIVE style #13 + expanded Schwartz) |
| `angle-roadmap/` | rm -rf + cp from source | Replace installer 1.1.1 with source 1.1.0 (downstream-consumer note added) |
| `video-script-generator/` | rm -rf + cp from source | Replace installer 1.3.0 with source 1.4.0 (long-form-static cross-reference + new alignment-mapping.md file) |
| `VERSION` | rebuilt | Source's 12 lines in source's order + `system-prompt=1.2.0` appended |
| `README.md` | 3 inventory description lines updated | ad-style-generator (12 -> 13 styles + REDDIT-NATIVE), funnel-builder (Funnel Factory pipeline note), angle-roadmap (downstream-consumer note) |

Total: 9 files changed, +445 / -129 lines.

## Files NOT touched (installer-specific, preserved)

- `setup` (install script)
- `setup.ps1` (Windows install script)
- `.gitattributes`
- `system-prompt=1.2.0` line in VERSION (installer-specific; source doesn't track it)
- 7 already-identical skill directories (`business-validation`, `avatar-research`, `brand-analyzer`, `nano-banana-prompting`, `product-deep-research`, `video-prompting-guide`, `long-form-static-builder`)
- README's install/prerequisites/usage sections (only inventory descriptions touched)

## Architecture decisions

**Installer is strictly downstream of source-of-truth from now on.** This is policy, not just a one-time sync. Going forward: source gets edits first, then a reverse-sync session brings installer along. Installer is never edited directly. ca-skill-zips rebuilds from source. Three repos, one merge direction.

**The "version rollback" (1.1.1 -> 1.1.0 etc.) is deliberate.** Installer's higher patch numbers were vestigial divergence from when installer was the de-facto source of truth for the Schwartz layer. Source's new minor versions are functionally a superset (Schwartz + Funnel Factory + REDDIT-NATIVE + cross-references + em-dash policy). The "rollback" is just the installer catching up to source's version numbering. Future patches go through source first.

**VERSION mirrors source exactly + 1 installer-specific line.** Installer's VERSION is now identical to source's `_skills/VERSION` for all 12 skills, with `system-prompt=1.2.0` appended on line 13. Source doesn't distribute the system prompt; installer does. This is the only structural difference.

## Verification approach

**Direct verification, not Codex.** The Codex round did not flush its final report (interrupted before producing structured output). Rather than retry per memory #22 iteration ceiling logic, I applied direct structural checks that cover the same focus areas Codex was supposed to assess:

1. **5 replaced skill dirs match source byte-for-byte.** `diff -rq /tmp/sync-source/context-architect-brands/_skills/$skill /tmp/sync-source/ca-desktop-installer/$skill` returned empty for all 5.

2. **7 expected-identical skills untouched.** `diff -rq` returned empty before the merge for all 7 (Phase 0.4); none appear in `git status` modified list (Phase 1.5).

3. **Zero installer-only files lost from the 5 replaced directories.** Used `git ls-tree -r main -- $skill/` (pre-sync state) compared to `find $skill -type f` in source via `comm -23`. Zero installer-only files in any of the 5 replaced skill directories. Only file gained was `video-script-generator/alignment-mapping.md` from source v1.4.0 (new in source, not in installer's prior 1.3.0).

4. **VERSION ordering correct.** `diff source/_skills/VERSION installer/VERSION` returned only one extra line (`system-prompt=1.2.0` appended after line 12). Source's order preserved exactly.

5. **README surgical.** `git diff --stat README.md` showed 6 lines changed, matching the 3 inventory description lines × 2 sides of the diff. Other sections untouched.

6. **Installer-specific artifacts untouched.** `git status` modified list showed only the 7 expected paths plus 1 new file. Setup scripts and .gitattributes not present.

## Quality gates

- **Direct structural verification:** all 6 focus-area checks above passed.
- **Codex adversarial review:** initiated but did not produce a final report. Direct verification substituted; no second Codex retry per memory #22 iteration ceiling.
- **`/ultrareview`:** not run. Persistent maintenance follow-up across sessions 4-7 (GitHub App allowlist).

## Routing data

| Field | Value |
|-------|-------|
| Session type | multi-file mechanical sync with structural verification |
| Model | Opus 4.7 (1M context) |
| Outcome | 1 PR opened (PR #2 in ca-desktop-installer) |
| Iterations | 1 sync pass; no fix-up rounds needed |
| Codex round count | 1 (incomplete; no final report) |
| ultrareview run | No (persistent known issue) |
| Codex caught real issues | N/A (no final report). Direct verification confirmed clean state. |
| Files touched | 9 (5 skill dirs + VERSION + README + 1 new file) |
| Lines of new content | +445 / -129 |

## Subtleties handled

**Codex rescue did not flush its final report.** The agent ran for 218 seconds and made 11 tool calls, but the rescue layer reported "no final assistant message captured." Per memory #22, I did not iterate (one Codex round attempted, no second). Direct verification substituted — the focus areas Codex was supposed to check were each verified independently with structural diffs and file-list comparisons.

**video-script-generator/alignment-mapping.md gained as expected.** Source v1.4.0 added this file. Installer's v1.3.0 didn't have it. After cp from source, the file shows as untracked in installer's git status. `git add -A` picks it up correctly. This is the right outcome — installer should track all source content for the skills it ships.

**The "version rollback" pattern.** Three of the five replaced skills go from a HIGHER installer patch number to a LOWER source minor + patch number (e.g., 1.1.1 -> 1.1.0). The rollback is correct because installer's prior patch was vestigial. Documented explicitly in the commit message and PR body so reviewers understand the direction.

## Follow-up tasks for next sessions

1. **First post-sync rebuild of ca-skill-zips.** Should be a no-op rebuild now that source and installer are aligned. Useful only as a workflow validation that the build script handles "no changes since last build" correctly. The reverse cross-check warning will continue to surface `breakthrough-advertising` and `gpt-image-2-prompting` as reference-only directories.

2. **Communicate the version rollback.** If installer's `1.1.1` was communicated externally, operators using those patch numbers as a reference point need to know the new convention. Probably a one-line note in a future ops update.

3. **Workflow change to prevent future divergence.** Going forward, installer never gets edited directly; the only path to update installer is reverse-sync from source. This is now policy.

4. **gpt-image-2-prompting triage.** From SESSION_6_LOG.md follow-ups: this directory exists in source but isn't in source's `_skills/VERSION`. Worth a session to triage whether it should ship as a versioned skill or remain as another reference-only directory.

5. **GitHub App allowlist for /ultrareview** (persistent follow-up from sessions 4-7).

## Notes

- This session followed branch-first workflow per memory #28: PR #2 opened from `feature/sync-from-source-of-truth` to `main`, NOT direct push.
- The session prompt's "biggest risk" — installer-only files getting destroyed by rm-rf+cp — was empirically zero. The 5 replaced skill directories had no installer-only files. The verification was a direct structural comparison, not a guess.
- The Codex round failure is a known infrastructure gap (rescue agent doesn't always flush). Future sessions may need to either retry Codex (within iteration ceiling) or substitute direct verification when the focus areas are amenable to structural checks. This session demonstrated the substitution path works.
