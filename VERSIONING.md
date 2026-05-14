# Skill Versioning Contract

This installer ships 13 skills. Every skill has a version that must be
visible in exactly two places, and those two places must agree.

## Where the version lives

1. **Skill frontmatter** — each skill's `SKILL.md` YAML frontmatter carries a
   `version:` field. This is the version embedded in the artifact the user
   installs, so it's the version Claude Desktop can see at runtime.

   ```yaml
   ---
   name: funnel-builder
   version: 2.5.0
   description: "…"
   ---
   ```

2. **Root `VERSION` file** — one line per skill in the form `<name>=<version>`.
   Every entry must correspond to a skill folder on disk; there are no
   manifest-only entries.

The two must agree. `sync-installer.py`'s `verify_versions_consistent()` runs
three times per sync (canonical pre-plan, installer pre-sync, installer
post-apply) and refuses to proceed when they don't.

> System prompt versioning lives in each brand repo's `system-prompt.md`
> header (`V X.Y.Z` at the top), not in this installer manifest. The
> installer manifest covers skills only.

### Strict format requirements

The `audit-skill-versions.py`, `normalize-skill-versions.py`, and
`sync-installer.py` tools share one byte-identical
`_TOPLEVEL_VERSION_COUNT_RE` regex and one `yaml.safe_load` extractor, and
they all enforce the same four rules. A SKILL.md fails the contract — and
the audit reports it, the normalizer skips it, and the guard exits non-zero
— when any of these is violated:

- **Top-level position.** The `version:` field must appear at the top level
  of the YAML frontmatter, at column 0 (no leading whitespace, lowercase
  `version` only). Nested under another mapping doesn't count; the tools
  won't find it.
- **Quoted string value.** The value must be a quoted string in `X.Y.Z` or
  `X.Y.Z-suffix` form — for example `version: "1.4.0"` or
  `version: "1.0.0-beta"`. Unquoted values like `version: 1.4` are
  **rejected**, because YAML coerces `1.4` to a float and the equality
  check against the central `VERSION` manifest (a string) would silently
  fail or, worse, silently coerce in unexpected ways across implementations.
- **Exactly one `version:` line.** Duplicate top-level `version:` keys are
  rejected outright. PyYAML silently keeps the last value on duplicates,
  which could let a stale `version` line linger above a fresh one — the
  parser would accept the file but the artifact would carry two
  contradicting declarations. Most commonly arises from a half-resolved
  merge conflict.
- **Matches the root `VERSION` file.** The string returned by the extractor
  must equal the value on the corresponding `<name>=<version>` line in the
  root manifest, byte-for-byte.

If any of the four is violated, the fix is to make the SKILL.md valid —
never to relax the tools.

## How to bump a skill version

1. Edit `<skill>/SKILL.md` and bump the `version:` field in frontmatter.
2. Edit the root `VERSION` file and bump the matching `<name>=<version>` line.
3. Commit both in the same commit. The message should name the skill and the
   bump direction (e.g. `funnel-builder: 2.5.0 -> 2.6.0`).
4. The next `sync-installer.py` run validates consistency before doing any
   work. If you forgot to update one of the two locations, the build fails
   fast with a clear list of every mismatched skill.

If `sync-installer.py` reports drift, the fix is always to make the
frontmatter and `VERSION` agree — never to disable the check.

## Why this exists

The original distribution model carried a per-brand `skill-versions.md` file
that recorded which skill version each brand had installed. That file drifted
silently from the canonical `VERSION` source whenever a sync didn't propagate
cleanly or someone bumped one side without the other. Spurious "skill out of
date" warnings followed, even when the installed skill was current.

The fix is to embed the version inside the artifact itself. The skill's own
`SKILL.md` carries its version in frontmatter; that single file is what gets
synced; runtime checks read it directly. The root `VERSION` file remains as
the manifest the sync tool consults, but it's no longer the only source — it's
verified against the frontmatter on every sync, so drift is impossible to
introduce without being noticed immediately.
