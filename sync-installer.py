#!/usr/bin/env python3
"""sync-installer.py - per-PR sync from canonical to installer.

Purpose
-------
Mechanical sync of skill files from the canonical repo
(contextarchitect/context-architect-brands `_skills/`) into this installer
repo (contextarchitect/ca-desktop-installer). Reads canonical's VERSION as
the authoritative source of truth and propagates any skill whose canonical
version is newer than the installer's. The installer's VERSION file is
rewritten to mirror canonical at every sync.

Usage
-----
    python3 sync-installer.py --canonical-path /path/to/_skills [--dry-run]

The script must be run from the installer repo root (it discovers
distributed skills by listing directories at `.`).

Prerequisites
-------------
Before running, ensure the local installer checkout is in a known-clean state:

    git fetch origin
    git checkout main && git pull origin main
    # (or work on a fresh branch off origin/main)

The script's pre-flight check enforces this: it refuses to run if the local
HEAD doesn't match or descend from origin/main, or if the working tree has
uncommitted changes. Bypass with --no-git-check if you have a deliberate
reason (e.g., CI with detached HEAD). The check exists because divergent
local state silently produces sync PRs with wrong diff baselines that hit
merge conflicts (precedent: installer PR #4, 2026-05-12).

Policy reference (locked 2026-05-11, Desktop design conversation)
-----------------------------------------------------------------
- Policy 1: Canonical VERSION is the source of truth. Every session that
  modifies a skill bumps that skill's version in canonical's VERSION file
  as part of the session's commit.
- Policy 2: Installer VERSION mirrors canonical at every sync. No
  independent versioning on installer.
- Policy 3: Syncs happen after every PR merge to canonical that touched a
  skill (per-PR, not batched at cycle-end).

Invariants enforced
-------------------
1. Distributed skills are skills whose directory exists at the installer
   repo root. Canonical-only skills are skipped.
2. Every VERSION entry must correspond to a skill folder on disk. The
   pre-flight `verify_versions_consistent()` guard refuses to sync
   otherwise. There are no installer-only VERSION entries — system prompt
   versioning lives in each brand repo's `system-prompt.md` header, not
   in this manifest.
3. The installer is never ahead of canonical for a distributed skill.
   If detected, the script WARNs and refuses to downgrade - human
   resolution required.
4. File content is compared via SHA-256; identical files are skipped.
5. The script never deletes files from the installer. If a file exists in
   the installer but not in canonical, it is left alone (warned but not
   removed).
"""

from __future__ import annotations

import argparse
import hashlib
import os
import re
import shutil
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

import yaml


VERSION_LINE_RE = re.compile(r"^([A-Za-z0-9_-]+)=(.+)$")

_FRONTMATTER_RE = re.compile(r"\A---\s*\n(.*?)\n---\s*\n", re.DOTALL)

# Contract enforcement: this regex must be byte-identical in
# audit-skill-versions.py and normalize-skill-versions.py. Top-level only —
# no leading whitespace, lowercase `version` only — because yaml.safe_load
# is case-sensitive and the canonical position is column 0.
_TOPLEVEL_VERSION_COUNT_RE = re.compile(r"^version[ \t]*:", re.MULTILINE)

# Filenames sync should never copy from canonical into the installer. OS
# metadata and placeholder files. Extend conservatively — anything not in
# this set is treated as distributable skill content.
EXCLUDED_FILENAMES = {".DS_Store", "Thumbs.db", ".gitkeep"}


def _count_version_lines(fm: str) -> int:
    return len(_TOPLEVEL_VERSION_COUNT_RE.findall(fm))


class VersionContractError(Exception):
    """SKILL.md frontmatter violates the version-field contract.

    Raised for duplicate top-level `version:` keys, malformed YAML, or
    non-string version values (e.g. unquoted `version: 1.4` which YAML
    coerces to a float). The guard collects these and reports all of them
    before exiting; it never silently picks a winner.
    """


def skill_frontmatter_version(skill_md: Path) -> str | None:
    """Return the `version` field from a SKILL.md's YAML frontmatter.

    Uses yaml.safe_load on the frontmatter block — the same parser used by
    audit-skill-versions.py and normalize-skill-versions.py — so all three
    tools agree at the edges (multi-line YAML strings, escaped colons,
    trailing whitespace, BOM).

    Returns None if the file has no frontmatter, the frontmatter is not a
    mapping, or there is no `version` field. Raises VersionContractError for
    duplicate top-level `version:` keys, malformed YAML, or non-string
    version values (e.g. unquoted `version: 1.4` which YAML loads as float).
    """
    text = skill_md.read_text(encoding="utf-8")
    m = _FRONTMATTER_RE.match(text)
    if not m:
        return None
    fm = m.group(1)
    count = _count_version_lines(fm)
    if count > 1:
        raise VersionContractError(
            f"frontmatter has {count} top-level `version:` lines; expected exactly one. "
            "Manual resolution required (likely an unresolved merge conflict)."
        )
    try:
        data = yaml.safe_load(fm)
    except yaml.YAMLError as e:
        raise VersionContractError(f"malformed YAML frontmatter: {e}")
    if not isinstance(data, dict):
        return None
    v = data.get("version")
    if v is None:
        return None
    if not isinstance(v, str):
        raise VersionContractError(
            f"version field must be a quoted string in X.Y.Z form, got "
            f"{type(v).__name__} ({v!r}). Quote the value in YAML: "
            f'version: "1.4.0"'
        )
    return v.strip()


def verify_versions_consistent(root: Path, label: str) -> None:
    """Build-time guard: every skill's frontmatter version must match VERSION.

    `root` is the directory whose VERSION file and skill folders are checked
    (installer root for installer-side calls, canonical _skills/ dir for the
    canonical pre-plan call). `label` is included in error output so a
    failure makes clear which side is broken (e.g. "canonical",
    "installer (pre-sync)", "installer (post-apply)").

    Failure modes, no exceptions:
      1. A SKILL.md frontmatter `version` disagrees with its VERSION entry.
      2. A SKILL.md is missing the `version` field entirely.
      3. A frontmatter violates the contract (duplicate keys, non-string
         value, malformed YAML).
      4. The VERSION file lists a name with no matching skill folder.
      5. A skill folder (any top-level directory containing a SKILL.md) has
         no VERSION entry.

    Called three times from main(): canonical pre-plan, installer pre-sync,
    installer post-apply. See VERSIONING.md for the contract.
    """
    version_records = dict(parse_version_file(root / "VERSION"))
    skill_dirs = sorted(
        d for d in root.iterdir()
        if d.is_dir() and (d / "SKILL.md").exists()
    )
    skill_names_on_disk = {d.name for d in skill_dirs}

    errors: list[str] = []

    for d in skill_dirs:
        name = d.name
        central = version_records.get(name)
        if central is None:
            errors.append(
                f"{name}: skill folder exists with SKILL.md but no entry in VERSION file"
            )
            continue
        try:
            fm_version = skill_frontmatter_version(d / "SKILL.md")
        except VersionContractError as e:
            errors.append(f"{name}: {e}")
            continue
        if fm_version is None:
            errors.append(
                f"{name}: SKILL.md has no `version` field in YAML frontmatter "
                f"(central VERSION says {central})"
            )
        elif fm_version != central:
            errors.append(
                f"{name}: SKILL.md frontmatter version {fm_version!r} != "
                f"central VERSION {central!r}"
            )

    for key in version_records:
        if key in skill_names_on_disk:
            continue
        errors.append(
            f"{key}: VERSION entry has no matching skill folder"
        )

    if errors:
        print(
            f"ERROR: skill version metadata is inconsistent in {label} ({root}).\n"
            "\n"
            "The VERSION file and each skill's SKILL.md YAML frontmatter\n"
            "must agree. See VERSIONING.md for the contract.\n",
            file=sys.stderr,
        )
        for e in errors:
            print(f"  - {e}", file=sys.stderr)
        sys.exit(5)


def parse_version_file(path: Path) -> list[tuple[str, str]]:
    """Parse a VERSION file into an ordered list of (key, value) records.

    Blank lines and comments (#) are dropped. Order is preserved so we can
    write back in the canonical order.
    """
    records: list[tuple[str, str]] = []
    if not path.exists():
        raise FileNotFoundError(f"VERSION file not found: {path}")
    for raw in path.read_text(encoding="utf-8").splitlines():
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        m = VERSION_LINE_RE.match(line)
        if not m:
            raise ValueError(f"Malformed VERSION line in {path}: {raw!r}")
        records.append((m.group(1), m.group(2)))
    return records


def semver_key(ver: str) -> tuple:
    """Compute a sort key for a version string.

    Handles plain `MAJOR.MINOR.PATCH` and prerelease suffixes like
    `1.0.0-beta`. Prerelease sorts BEFORE the release with the same
    numeric prefix (per semver).
    """
    if "-" in ver:
        release, prerelease = ver.split("-", 1)
    else:
        release, prerelease = ver, None
    try:
        nums = tuple(int(p) for p in release.split("."))
    except ValueError as e:
        raise ValueError(f"Cannot parse version {ver!r}: {e}") from e
    # Prerelease ranks below release: (release, 0) for release vs.
    # (release, -1, prerelease) for prerelease.
    if prerelease is None:
        return (nums, 1, "")
    return (nums, 0, prerelease)


def cmp_versions(a: str, b: str) -> int:
    ka, kb = semver_key(a), semver_key(b)
    if ka < kb:
        return -1
    if ka > kb:
        return 1
    return 0


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_git_state(installer_root: Path, no_git_check: bool) -> None:
    """Verify the local installer checkout is in a known-clean state.

    The script's sync correctness depends on the local working directory
    accurately representing what's on the installer's remote main. The
    PR #4 failure (2026-05-12) happened because this assumption was
    silently violated: the local checkout had divergent VERSION values
    relative to remote main, so the script's diff baseline was wrong and
    the resulting PR couldn't merge cleanly.

    This check enforces the assumption explicitly. Three conditions:

    1. The installer root is a git repository.
    2. HEAD is on or descended from origin/main (rejects stale checkouts
       and unrelated branches).
    3. Working tree is clean (no uncommitted changes).

    Pass --no-git-check to bypass (e.g., when running in CI with a detached
    HEAD, or deliberately on a branch that doesn't descend from origin/main).

    The check assumes origin/main is up to date. The operator is responsible
    for running `git fetch origin` before invoking this script. We don't
    auto-fetch to avoid network side effects and credential prompts.
    """
    if no_git_check:
        return

    if not (installer_root / ".git").exists():
        print(
            f"ERROR: {installer_root} is not a git repository.\n"
            "Run this script from a checkout of ca-desktop-installer.\n"
            "If you have a legitimate reason to skip this check, pass --no-git-check.",
            file=sys.stderr,
        )
        sys.exit(4)

    result = subprocess.run(
        ["git", "merge-base", "--is-ancestor", "origin/main", "HEAD"],
        cwd=installer_root,
        capture_output=True,
    )
    if result.returncode != 0:
        try:
            head_sha = subprocess.check_output(
                ["git", "rev-parse", "--short", "HEAD"],
                cwd=installer_root,
            ).decode().strip()
        except subprocess.CalledProcessError:
            head_sha = "(unknown)"
        try:
            origin_main_sha = subprocess.check_output(
                ["git", "rev-parse", "--short", "origin/main"],
                cwd=installer_root,
            ).decode().strip()
        except subprocess.CalledProcessError:
            origin_main_sha = "(unknown - did you run `git fetch origin`?)"

        print(
            f"ERROR: local HEAD ({head_sha}) does not match or descend from "
            f"origin/main ({origin_main_sha}).\n"
            "\n"
            "This likely means your checkout is stale relative to the remote. "
            "If the script runs in this state, the resulting sync diff will "
            "have a wrong baseline and the PR will hit merge conflicts.\n"
            "\n"
            "To fix:\n"
            "  git fetch origin\n"
            "  git checkout main && git reset --hard origin/main\n"
            "  # (or, if on a feature branch: git rebase origin/main)\n"
            "\n"
            "Then re-run this script.\n"
            "\n"
            "If you're deliberately running on a branch that doesn't descend "
            "from origin/main (rare; e.g., CI with detached HEAD), bypass this "
            "check with --no-git-check. The script will trust your local "
            "working tree as-is.",
            file=sys.stderr,
        )
        sys.exit(4)

    status_output = subprocess.check_output(
        ["git", "status", "--porcelain"],
        cwd=installer_root,
    ).decode().strip()
    if status_output:
        print(
            f"ERROR: working tree has uncommitted changes:\n"
            f"{status_output}\n"
            "\n"
            "Commit, stash, or discard these changes before running the sync. "
            "Otherwise the sync diff will include them as if they were part of "
            "the sync, which is almost never what you want.\n"
            "\n"
            "If you have a legitimate reason to run with uncommitted changes "
            "(rare), pass --no-git-check.",
            file=sys.stderr,
        )
        sys.exit(4)


def collect_skill_files(skill_dir: Path) -> list[Path]:
    """Return all distributable files in a skill directory.

    Globs all files recursively, excluding OS metadata and placeholder
    files (see EXCLUDED_FILENAMES). Skills may contain .md, .ps1, .sh,
    .template, image files, or any other content type the skill needs
    to distribute.
    """
    if not skill_dir.exists():
        return []
    return sorted(
        p for p in skill_dir.rglob("*")
        if p.is_file() and p.name not in EXCLUDED_FILENAMES
    )


@dataclass
class SkillSyncPlan:
    name: str
    canonical_version: str
    installer_version: str | None  # None if missing
    files_changed: list[Path] = field(default_factory=list)   # canonical paths
    files_unchanged: list[Path] = field(default_factory=list)
    files_new: list[Path] = field(default_factory=list)       # in canonical, not in installer
    files_orphan: list[Path] = field(default_factory=list)    # in installer, not in canonical
    anomaly: str | None = None  # set if installer > canonical


def build_plan(
    canonical_skills_dir: Path,
    installer_root: Path,
    canonical_versions: dict[str, str],
    installer_versions: dict[str, str],
) -> tuple[
    list[SkillSyncPlan],
    list[SkillSyncPlan],
    list[SkillSyncPlan],
    list[str],
    list[str],
]:
    """Return (to_sync, to_bootstrap, in_sync, excluded, anomalies_text).

    to_sync:      skills where canonical > installer, plan populated with diffs
    to_bootstrap: skills in canonical VERSION whose folder does not yet exist
                  in the installer — first-time distribution
    in_sync:      skills where canonical == installer (no file action expected,
                  but we still verify file content matches)
    excluded:     reserved for operator-driven explicit exclusion of a
                  canonical-listed skill from distribution. Currently no code
                  path populates this; kept for future use.
    anomalies_text: human-readable anomaly notes
    """
    to_sync: list[SkillSyncPlan] = []
    to_bootstrap: list[SkillSyncPlan] = []
    in_sync: list[SkillSyncPlan] = []
    excluded: list[str] = []
    anomalies: list[str] = []

    for skill_name, c_ver in canonical_versions.items():
        installer_skill_dir = installer_root / skill_name
        if not installer_skill_dir.exists():
            # First-time distribution. Trust the pre-plan
            # verify_versions_consistent(canonical) call in main() to have
            # already rejected a canonical VERSION entry without a matching
            # folder — so we know the canonical side is internally consistent
            # and the absence is purely on the installer side. _populate_file_diffs
            # will classify every canonical file as files_new since the
            # installer directory does not exist yet.
            plan = SkillSyncPlan(skill_name, c_ver, None)
            _populate_file_diffs(plan, canonical_skills_dir, installer_root)
            to_bootstrap.append(plan)
            continue

        i_ver = installer_versions.get(skill_name)
        if i_ver is None:
            # Skill directory present in installer but not in VERSION file.
            anomalies.append(
                f"{skill_name}: directory exists in installer but no VERSION entry. "
                "Treating as needs-sync from canonical."
            )
            plan = SkillSyncPlan(skill_name, c_ver, None)
            _populate_file_diffs(plan, canonical_skills_dir, installer_root)
            to_sync.append(plan)
            continue

        cmp = cmp_versions(c_ver, i_ver)
        if cmp == 0:
            plan = SkillSyncPlan(skill_name, c_ver, i_ver)
            _populate_file_diffs(plan, canonical_skills_dir, installer_root)
            in_sync.append(plan)
        elif cmp > 0:
            plan = SkillSyncPlan(skill_name, c_ver, i_ver)
            _populate_file_diffs(plan, canonical_skills_dir, installer_root)
            to_sync.append(plan)
        else:
            # Installer is AHEAD of canonical. Anomaly.
            msg = (
                f"{skill_name}: installer ({i_ver}) > canonical ({c_ver}). "
                "Refusing to downgrade. Human review required."
            )
            anomalies.append(msg)
            plan = SkillSyncPlan(skill_name, c_ver, i_ver, anomaly=msg)
            in_sync.append(plan)  # not actually in sync, but skipped from to_sync

    # Detect installer skills not in canonical VERSION at all
    for skill_name in installer_versions:
        if skill_name in canonical_versions:
            continue
        # Installer-only entry. With verify_versions_consistent() running
        # at the top of main(), this branch is unreachable in practice: any
        # VERSION key without a matching folder is rejected before sync.
        # Kept as defense-in-depth for callers that bypass main().
        d = installer_root / skill_name
        if d.exists() and d.is_dir():
            anomalies.append(
                f"{skill_name}: installer skill directory exists but no canonical "
                "VERSION entry. Skipping."
            )

    return to_sync, to_bootstrap, in_sync, excluded, anomalies


def _populate_file_diffs(
    plan: SkillSyncPlan,
    canonical_skills_dir: Path,
    installer_root: Path,
) -> None:
    c_skill = canonical_skills_dir / plan.name
    i_skill = installer_root / plan.name
    c_files = collect_skill_files(c_skill)
    c_rel = {p.relative_to(c_skill): p for p in c_files}
    i_files = collect_skill_files(i_skill)
    i_rel = {p.relative_to(i_skill): p for p in i_files}

    for rel, c_path in c_rel.items():
        i_path = i_rel.get(rel)
        if i_path is None:
            plan.files_new.append(c_path)
        elif sha256(c_path) != sha256(i_path):
            plan.files_changed.append(c_path)
        else:
            plan.files_unchanged.append(c_path)

    for rel, i_path in i_rel.items():
        if rel not in c_rel:
            plan.files_orphan.append(i_path)


def render_plan(
    to_sync: list[SkillSyncPlan],
    to_bootstrap: list[SkillSyncPlan],
    in_sync: list[SkillSyncPlan],
    excluded: list[str],
    anomalies: list[str],
    canonical_versions: dict[str, str],
    installer_versions: dict[str, str],
) -> str:
    out: list[str] = ["# Sync Plan", ""]

    out.append("## Skills needing sync (canonical > installer)")
    out.append("")
    if not to_sync:
        out.append("_None._")
        out.append("")
    for plan in to_sync:
        i_ver_str = plan.installer_version if plan.installer_version else "(missing)"
        out.append(f"### {plan.name}: {i_ver_str} -> {plan.canonical_version}")
        if plan.files_changed:
            out.append("Files to copy (changed):")
            for p in plan.files_changed:
                rel = _relative_to_skill(p, plan.name)
                out.append(f"  - {rel}")
        else:
            out.append("Files to copy (changed): none")
        if plan.files_new:
            out.append("Files to copy (new):")
            for p in plan.files_new:
                rel = _relative_to_skill(p, plan.name)
                out.append(f"  - {rel}")
        if plan.files_unchanged:
            out.append(f"Files unchanged (skip): {len(plan.files_unchanged)}")
        if plan.files_orphan:
            out.append("Installer-only files (not in canonical, left untouched):")
            for p in plan.files_orphan:
                rel = _relative_to_skill(p, plan.name)
                out.append(f"  - {rel}")
        out.append("")

    out.append(
        f"## Skills to bootstrap ({len(to_bootstrap)} first-time "
        f"distribution{'s' if len(to_bootstrap) != 1 else ''})"
    )
    out.append("")
    if not to_bootstrap:
        out.append("_None._")
        out.append("")
    for plan in to_bootstrap:
        out.append(f"### {plan.name}: (new) -> {plan.canonical_version}")
        if plan.files_new:
            out.append("Files to copy (new):")
            for p in plan.files_new:
                rel = _relative_to_skill(p, plan.name)
                out.append(f"  - {rel}")
        else:
            out.append("Files to copy (new): none")
        out.append("")

    out.append("## Skills NOT needing sync (canonical == installer)")
    out.append("")
    if not in_sync:
        out.append("_None._")
        out.append("")
    for plan in in_sync:
        suffix = ""
        if plan.anomaly:
            suffix = "  [ANOMALY: see anomalies section]"
        out.append(f"- {plan.name} ({plan.canonical_version}){suffix}")
        # If files differ despite same version, surface it (drift bug)
        if plan.anomaly is None and (plan.files_changed or plan.files_new):
            out.append(
                f"  WARN: file content differs despite matching version "
                f"({len(plan.files_changed)} changed, {len(plan.files_new)} new). "
                "Possible content drift."
            )
    out.append("")

    out.append("## Skills explicitly excluded from distribution (currently empty)")
    out.append("")
    if not excluded:
        out.append("_None._")
    for line in excluded:
        out.append(f"- {line}")
    out.append("")

    out.append("## VERSION file update")
    out.append("")
    out.append("Installer VERSION will be updated to mirror canonical for all distributed skills:")
    has_any_bump = False
    for plan in to_sync + to_bootstrap:
        i_ver_str = plan.installer_version if plan.installer_version else "(new)"
        out.append(f"  - {plan.name}: {i_ver_str} -> {plan.canonical_version}")
        has_any_bump = True
    if not has_any_bump:
        out.append("  (no bumps)")
    installer_only_keys = [
        k for k in installer_versions if k not in canonical_versions
    ]
    if installer_only_keys:
        out.append("")
        out.append("Installer-only VERSION keys (preserved verbatim):")
        for k in installer_only_keys:
            out.append(f"  - {k}={installer_versions[k]}")
    out.append("")

    out.append("## Anomalies")
    out.append("")
    if not anomalies:
        out.append("_None._")
    for a in anomalies:
        out.append(f"- {a}")
    out.append("")

    return "\n".join(out)


def _relative_to_skill(file_path: Path, skill_name: str) -> Path:
    """Given e.g. /.../_skills/funnel-builder/references/x.md and skill name
    'funnel-builder', return Path('references/x.md').
    """
    parts = file_path.parts
    # find skill_name in parts; everything after is the relative path
    for i, p in enumerate(parts):
        if p == skill_name:
            return Path(*parts[i + 1:])
    return file_path  # fallback (shouldn't happen)


def apply_sync(
    to_sync: list[SkillSyncPlan],
    to_bootstrap: list[SkillSyncPlan],
    canonical_skills_dir: Path,
    installer_root: Path,
    canonical_versions: dict[str, str],
    installer_versions: dict[str, str],
) -> None:
    """Copy files and rewrite VERSION. No deletions.

    Bootstrapped skills are copied alongside updated skills; dst.parent.mkdir
    materializes the new skill directory. The VERSION rewrite below picks up
    any canonical entries whose folder now exists in the installer via the
    second pass.
    """
    copy_count = 0
    for plan in to_sync + to_bootstrap:
        for c_path in plan.files_changed + plan.files_new:
            rel = _relative_to_skill(c_path, plan.name)
            dst = installer_root / plan.name / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(c_path, dst)
            copy_count += 1
        print(f"  synced {plan.name}: {len(plan.files_changed)} changed, "
              f"{len(plan.files_new)} new")

    # Rewrite VERSION file: distributed skills get canonical values;
    # installer-only entries preserved at their existing values.
    new_lines: list[str] = []
    written_keys: set[str] = set()
    # First pass: preserve installer ordering for keys that exist in installer
    installer_records = parse_version_file(installer_root / "VERSION")
    for k, v in installer_records:
        if k in canonical_versions:
            new_lines.append(f"{k}={canonical_versions[k]}")
        else:
            new_lines.append(f"{k}={v}")
        written_keys.add(k)
    # Second pass: append any canonical skills that exist in installer dir
    # but weren't previously in installer VERSION
    for k, v in canonical_versions.items():
        if k in written_keys:
            continue
        if (installer_root / k).exists():
            new_lines.append(f"{k}={v}")
            written_keys.add(k)
    (installer_root / "VERSION").write_text("\n".join(new_lines) + "\n", encoding="utf-8")
    print(f"\nVERSION file updated. Total files copied: {copy_count}")


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--canonical-path",
        required=True,
        help="Path to canonical's _skills/ directory",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print the sync plan and exit without modifying any files",
    )
    parser.add_argument(
        "--yes",
        action="store_true",
        help="Skip interactive confirmation prompt (apply immediately)",
    )
    parser.add_argument(
        "--no-git-check",
        action="store_true",
        help="Skip the pre-flight check that verifies the local checkout is "
             "in sync with origin/main and has a clean working tree. Use only "
             "if you have a deliberate reason (e.g., CI with detached HEAD).",
    )
    args = parser.parse_args(argv)

    canonical_skills_dir = Path(args.canonical_path).resolve()
    installer_root = Path.cwd().resolve()

    check_git_state(installer_root, args.no_git_check)

    if not (canonical_skills_dir / "VERSION").exists():
        print(f"ERROR: canonical VERSION not found at {canonical_skills_dir / 'VERSION'}",
              file=sys.stderr)
        return 2
    if not (installer_root / "VERSION").exists():
        print(f"ERROR: installer VERSION not found at {installer_root / 'VERSION'}. "
              "Run this script from the installer repo root.", file=sys.stderr)
        return 2

    # Guard call #1: installer pre-sync. Refuse to proceed if the installer
    # checkout is internally inconsistent before any work happens.
    verify_versions_consistent(installer_root, label="installer (pre-sync)")

    # Guard call #2: canonical pre-plan. Refuse to propagate canonical-side
    # inconsistency into the installer. Skipped if --canonical-path resolves
    # to the same filesystem path as the installer root (someone running
    # sync against themselves — pre-sync call already covered it).
    if os.path.realpath(canonical_skills_dir) != os.path.realpath(installer_root):
        verify_versions_consistent(canonical_skills_dir, label="canonical")

    canonical_versions = dict(parse_version_file(canonical_skills_dir / "VERSION"))
    installer_versions = dict(parse_version_file(installer_root / "VERSION"))

    to_sync, to_bootstrap, in_sync, excluded, anomalies = build_plan(
        canonical_skills_dir,
        installer_root,
        canonical_versions,
        installer_versions,
    )

    plan_md = render_plan(
        to_sync, to_bootstrap, in_sync, excluded, anomalies,
        canonical_versions, installer_versions,
    )
    print(plan_md)

    if args.dry_run:
        return 0

    blocking_anomalies = [
        p for p in in_sync if p.anomaly is not None
    ]
    if blocking_anomalies:
        print(
            "\nERROR: blocking anomalies detected (installer ahead of canonical). "
            "Refusing to apply. Resolve manually.",
            file=sys.stderr,
        )
        return 3

    if not to_sync and not to_bootstrap:
        print("\nNo skills need syncing. Done.")
        return 0

    if not args.yes:
        resp = input("\nProceed with sync? [yes/no]: ").strip().lower()
        if resp not in ("yes", "y"):
            print("Aborted.")
            return 1

    apply_sync(
        to_sync,
        to_bootstrap,
        canonical_skills_dir,
        installer_root,
        canonical_versions,
        installer_versions,
    )

    # Guard call #3: installer post-apply. Belt-and-suspenders — should be
    # unreachable as a failure if canonical pre-plan passed and apply_sync
    # is bug-free, but catches the edge case where a faulty apply path
    # produces a drifted installer from a previously-consistent canonical.
    verify_versions_consistent(installer_root, label="installer (post-apply)")

    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
