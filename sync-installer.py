#!/usr/bin/env python3
"""sync-installer.py — per-PR sync from canonical to installer.

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
2. Installer-only VERSION entries (e.g., `system-prompt=`) are preserved
   verbatim across sync. They are neither read from canonical nor
   overwritten.
3. The installer is never ahead of canonical for a distributed skill.
   If detected, the script WARNs and refuses to downgrade — human
   resolution required.
4. File content is compared via SHA-256; identical files are skipped.
5. The script never deletes files from the installer. If a file exists in
   the installer but not in canonical, it is left alone (warned but not
   removed).
"""

from __future__ import annotations

import argparse
import hashlib
import re
import shutil
import sys
from dataclasses import dataclass, field
from pathlib import Path


VERSION_LINE_RE = re.compile(r"^([A-Za-z0-9_-]+)=(.+)$")


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


def collect_skill_files(skill_dir: Path) -> list[Path]:
    """Return all .md files inside a skill directory (recursively),
    plus any optional skill-level non-md files we care to sync.

    Scope: only .md files. Skill directories may contain references/,
    nested data, etc. We sync everything that's .md and skip other files.
    """
    if not skill_dir.exists():
        return []
    return sorted(p for p in skill_dir.rglob("*.md") if p.is_file())


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
) -> tuple[list[SkillSyncPlan], list[SkillSyncPlan], list[str], list[str]]:
    """Return (to_sync, in_sync, excluded, anomalies_text).

    to_sync: skills where canonical > installer, plan populated with diffs
    in_sync: skills where canonical == installer (no file action expected,
             but we still verify file content matches)
    excluded: canonical-only skills (not distributed)
    anomalies_text: human-readable anomaly notes
    """
    to_sync: list[SkillSyncPlan] = []
    in_sync: list[SkillSyncPlan] = []
    excluded: list[str] = []
    anomalies: list[str] = []

    for skill_name, c_ver in canonical_versions.items():
        installer_skill_dir = installer_root / skill_name
        if not installer_skill_dir.exists():
            excluded.append(f"{skill_name} (canonical: {c_ver}; not distributed)")
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
        # Installer-only entry. If a directory exists with that name, it's
        # an installer-only skill (anomaly); otherwise it's an installer-only
        # VERSION key like `system-prompt` (legitimate, preserve).
        d = installer_root / skill_name
        if d.exists() and d.is_dir():
            anomalies.append(
                f"{skill_name}: installer skill directory exists but no canonical "
                "VERSION entry. Skipping."
            )

    return to_sync, in_sync, excluded, anomalies


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

    out.append("## Skills in canonical but NOT in installer (excluded from distribution)")
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
    for plan in to_sync:
        i_ver_str = plan.installer_version if plan.installer_version else "(missing)"
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
    canonical_skills_dir: Path,
    installer_root: Path,
    canonical_versions: dict[str, str],
    installer_versions: dict[str, str],
) -> None:
    """Copy files and rewrite VERSION. No deletions."""
    copy_count = 0
    for plan in to_sync:
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
    args = parser.parse_args(argv)

    canonical_skills_dir = Path(args.canonical_path).resolve()
    installer_root = Path.cwd().resolve()

    if not (canonical_skills_dir / "VERSION").exists():
        print(f"ERROR: canonical VERSION not found at {canonical_skills_dir / 'VERSION'}",
              file=sys.stderr)
        return 2
    if not (installer_root / "VERSION").exists():
        print(f"ERROR: installer VERSION not found at {installer_root / 'VERSION'}. "
              "Run this script from the installer repo root.", file=sys.stderr)
        return 2

    canonical_versions = dict(parse_version_file(canonical_skills_dir / "VERSION"))
    installer_versions = dict(parse_version_file(installer_root / "VERSION"))

    to_sync, in_sync, excluded, anomalies = build_plan(
        canonical_skills_dir,
        installer_root,
        canonical_versions,
        installer_versions,
    )

    plan_md = render_plan(
        to_sync, in_sync, excluded, anomalies,
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

    if not to_sync:
        print("\nNo skills need syncing. Done.")
        return 0

    if not args.yes:
        resp = input("\nProceed with sync? [yes/no]: ").strip().lower()
        if resp not in ("yes", "y"):
            print("Aborted.")
            return 1

    apply_sync(
        to_sync,
        canonical_skills_dir,
        installer_root,
        canonical_versions,
        installer_versions,
    )
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
