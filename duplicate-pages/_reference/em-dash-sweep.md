# Em-dash sweep

Universal Context Architect rule: no shipped artifact contains an em-dash (the Unicode character at codepoint U+2014). This applies to every artifact this skill produces.

This file deliberately avoids the literal em-dash character so that the sweep gate (which searches for the character across the whole skill directory) does not false-positive on the file that documents the rule. Operators reading this file see Unicode codepoint references; the actual character only appears via the grep patterns below at runtime.

## Why this rule exists

The em-dash is a strong AI-generated-text tell. Direct-response brands target readers who recognize the difference between human and AI-generated copy at a glance. Shipping copy that reads as AI-written undermines the brand voice this skill is producing.

The rule also catches a sub-problem: the en-dash (Unicode codepoint U+2013) is sometimes used in place of em-dash and has the same effect. Both are banned.

## What gets swept

- The intent-spec being pasted to Lovable
- The asset manifest CSV (in any `notes` column or semantic_role descriptions the operator authors)
- Every fix-up prompt sent to Lovable
- The brand-identity block extracted in `_reference/brand-token-extraction.md`
- The README files in `_examples/`
- Anything else this skill produces that is user-visible or fed to Lovable

## Procedure

Run before sending any artifact. The grep pattern uses PCRE Unicode escapes so this command can be copied from anywhere without the literal character being present in the source file:

```bash
grep -nP '[\x{2013}\x{2014}]' <file-path>
```

Or for the em-dash-only check:

```bash
grep -nP '\x{2014}' <file-path>
```

Verify zero hits. If hits exist, replace each occurrence with one of:

- A hyphen (ASCII `-`) when the offending character was joining two clauses that read naturally with a hyphen or comma. Example before: `produced 80% production-quality output [U+2014] the remaining 20% was surgical fix-ups`. Example after: `produced 80% production-quality output - the remaining 20% was surgical fix-ups`.
- A period (`.`) and a new sentence when the offending character was breaking a long sentence into two thoughts. Example before: `Approach B produced cleaner output [U+2014] the fix-up cycle was shorter`. Example after: `Approach B produced cleaner output. The fix-up cycle was shorter.`
- A comma (`,`) when the offending character was adding a parenthetical aside. Example before: `Lovable owns implementation [U+2014] including breakpoints and image cropping`. Example after: `Lovable owns implementation, including breakpoints and image cropping.`

(`[U+2014]` in the examples above is a placeholder for the actual character. The actual sweep target is the Unicode codepoint U+2014.)

## When to run the sweep

- After authoring the intent-spec, before pasting to Lovable.
- After authoring any fix-up prompt, before sending.
- After filling the asset manifest, before committing.
- After authoring an example README, before committing.

The sweep is a pre-output gate. It blocks shipping if it finds matches.

## Sweep-all script

For convenience, this one-liner sweeps the entire skill output for a given page:

```bash
grep -rnP '[\x{2013}\x{2014}]' \
  _skills/figma-to-lovable/ \
  _brands/<brand>/figma-to-lovable/<page-slug>/ \
  && echo "FAIL: em-dash or en-dash found" \
  || echo "PASS: no em-dash or en-dash"
```

The `||` returns PASS when grep finds zero matches (grep exits non-zero when no matches found).

## Note on existing materials

`_tests/` files predate this skill and may contain em-dashes. They are read-only reference inputs for this skill, not artifacts the skill produces. The sweep applies to skill outputs, not to `_tests/` inputs.

## Note on this file

This documentation file uses Unicode codepoint references (U+2013, U+2014) in prose so that the literal em-dash and en-dash characters do not appear in the file's source. This is the only way the sweep gate can run across the whole skill directory without explicitly excluding this file. If you edit this file, do not paste actual em-dashes into the prose. Use the codepoint references or the `[U+2014]` placeholder bracket notation.

## Cross-references

- The em-dash rule is also referenced in `SKILL.md` under "Em-dash sweep rule"
- Pre-commit gate in the session plan runs this sweep as a blocking check
