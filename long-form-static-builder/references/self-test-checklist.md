# Long-Form Static: Self-Test Checklist

A 14-point check the writer runs against every long-form-static body before output. Each item: one paragraph explaining the test, one paragraph explaining the remedy if failed.

Run this checklist for each of the three POV variants. A failure on any item means the variant goes back for a fix - it does not ship until every item passes.

## 1. Yes-Yes-Yes Chain Test

**Test:** Read the body asking four questions in order. (1) Does the reader believe the root cause? (2) Does the reader believe the mechanism fixes the root cause? (3) Does the reader believe the product delivers the mechanism? (4) Does the reader believe this is the obvious next step? Each answer should be yes by the time the reader reaches it. If any link is weak, the conversion architecture fails.

**Remedy:** Identify which link broke. If the root cause doesn't click, strengthen the desperation frame and discovery story. If the mechanism doesn't connect to the root cause, audit the three-stage explanation - the analogy probably isn't carrying the connection. If the product feels disconnected from the mechanism, the product introduction needs a tighter bridge from the mechanism reveal. If the close feels like a leap, the differentiation block and risk reversal need more weight.

## 2. Identification Before Mechanism Test

**Test:** Find the first sentence that explains how the mechanism works. Count the words before it. The body is healthy if at least 60% of the total word count appears before the first mechanism explanation. If the mechanism appears in the first 30%, the body is structurally inverted.

**Remedy:** Add identification content before mechanism, do NOT compress the mechanism. Pull more raw quotes from avatar research. Expand the antecedent story or failed-solution stack. The identification must earn the mechanism's appearance.

## 3. Hook Quality Test

**Test:** The in-feed visible hook (the first line, before "see more" expansion) must satisfy three rules. (1) Maximum 9 words. (2) Identity marker present (age, role, geographic context, or condition). (3) Info gap created (something promised but not revealed). All three must hold; missing any one drops scroll-stop rate sharply.

**Remedy:** If the hook exceeds 9 words, cut adjectives and connecting phrases first. If the identity marker is missing, add a specific role or age in the first 6 words. If the info gap is missing, replace the resolution with a promise of resolution. "I beat my migraines" is a resolution; "What my doctor told me at 3 AM changed everything" is an info gap.

## 4. Sound-Off Friendliness Test

**Test:** The in-feed visible portion must work visually plus caption only. The image alone should communicate the angle's emotional weight; the hook alone should pose the info gap. Together, they should be readable in three seconds without sound, motion, or expansion.

**Remedy:** If the image is too generic to communicate the angle, change the subject to one that more directly mirrors the avatar's experience (per the image-spec subject-to-trigger mapping). If the hook depends on the rest of the body to make sense, rewrite to be standalone-readable.

## 5. Bridges Test

**Test:** Cover the first sentence of any section. Read the last sentence of the previous section, then jump to the second sentence of the section. If the connection is unclear, the bridge is missing or weak. Every section transition must have an explicit connector sentence as its first line.

**Remedy:** Add the bridge sentence. See `named-patterns.md` pattern 5 for bridge-sentence templates. The bridge does not have to be elaborate; one sentence that names the connection is enough. Do not skip this on the assumption that the reader will figure it out.

## 6. Time-Delay Anchoring Test

**Test:** Search the body for results-related verbs (noticed, felt, saw, started, stopped, realized, changed, improved). Each one should be preceded by a time anchor within the same paragraph. Generic claims without time anchors are a writing failure.

**Remedy:** Add the time anchor before the results verb. "By day 14" rather than "after a while." "Three weeks in" rather than "before long." If the writer doesn't know the actual timeframe, the angle hasn't been clarified enough; check with the user before fabricating a number.

## 7. One Core Feeling Sustained Throughout

**Test:** Pick five sentences at random from the body. Each should clearly serve the chosen core feeling (vindication, loss aversion, betrayal, desperation, or identity). Sentences that are feeling-neutral or that serve a different feeling dilute the emotional pull.

**Remedy:** Either rewrite the off-feeling sentences to serve the chosen feeling, or cut them. If multiple sentences fail this test, reconsider whether the chosen feeling is correct for the angle. The angle card's emotional trigger should map cleanly to one of the five core feelings; if it doesn't, the angle card itself may need refinement.

## 8. POV Stability Test

**Test:** Read the body looking for the first sentence that uses third-person voice for the brand or product. Any third-person brand reference is a POV break. The protagonist names the brand; the brand never names itself.

**Remedy:** Rewrite the third-person sentences into first-person. The product is something the protagonist found, not something the brand did. "When I learned about [mechanism], I started looking for the cleanest version of it I could find" rather than "[Brand] developed the cleanest version of [mechanism]."

## 9. "Best Ads Can Start at Any Line" Test

**Test:** Cover the hook and first paragraph. Does the second paragraph still work as a hook? Test it again: cover the first two paragraphs. Does the third still pull a reader in? A strong long-form static is dense with re-entry points; a reader who skipped the opener should still get pulled into the body.

**Remedy:** If only the hook works as a hook, the body is front-loaded. Add identity markers and info gaps deeper in the body. The antecedent story should have its own hook-like opening; the desperation frame should have one too; even the mechanism reveal should open with a small info gap.

## 10. No Verbatim Rosabella Copy Test

**Test:** Search the body for any 15-or-more-word string that appears in the Rosabella reference material. This is a copyright and competitive-intel boundary. Specific named patterns (e.g., "the desperation frame," "the discovery story") are concept names and can be referenced; verbatim sentences are not.

**Remedy:** Paraphrase any flagged passage. The structural pattern can stay; the wording must be original. If the writer cannot paraphrase the passage without losing its meaning, the passage is doing too much specific work and should be reconceived from the angle card directly.

## 11. Voice Rules Enforcement Test

**Test:** Run the copywriting-guide AI Detection Firewall checks. Specifically: (1) Zero em dashes in the body; (2) No forbidden vocabulary (delve, unlock, revolutionize, transformative, embark, journey, etc.); (3) Contractions used naturally; (4) High burstiness (sentence lengths vary dramatically).

**Remedy:** Replace em dashes with periods, semicolons, or rewritten sentences. Replace forbidden vocabulary with the avatar's actual language from research. Add contractions wherever the protagonist would naturally use them. Vary sentence length; if every sentence is the same length, rewrite some to be much shorter or much longer.

## 12. Three POV Variants Distinct Test

**Test:** Read the three POV variants back to back. They should differ in: identity marker (different ages, roles, life situations); failed-solution stack (different specific solutions); discovery moment (different unusual decisions); emotional response (different but compatible reactions). If the variants are word-substitutions of each other, the three-lead rule failed.

**Remedy:** Rewrite the failing variant from a structurally different storyteller's vantage point. Don't substitute "my mother" for "I"; tell a different person's story end to end. The mechanism, the differentiation, and the risk reversal can remain functionally the same; the rest must be re-told.

## 13. Image Spec Match Test

**Test:** The image specification (subject, lighting, framing, exclusion layer) must match the angle's emotional tone per the subject-to-trigger mapping in `image-spec.md`. A vindication angle with a desperation-style image (hospital corridor) creates emotional dissonance; a desperation angle with a vindication-style image (lab report) does the same.

**Remedy:** Pull the angle's emotional trigger and re-pick the subject from the mapping table. If the brand has additional image-style constraints from `brand-guidelines`, layer those on top of the Reddit-native style without losing the candid markers.

## 14. CTA Destination Compliance Test

**Test:** The CTA destination must be a sales-page lander, listicle, or advertorial - never a direct PDP. This is per Sufian's funnel guidance: long-form-static traffic is too cold to convert directly on a product page. The pre-checkout step needs to be a content page that continues the warming.

**Remedy:** If the user provided a PDP URL as the CTA destination, push back. Recommend either a funnel-built advertorial or a listicle (run `funnel-builder` first if neither exists), or a brand-built content page. Do not output the ad with a PDP destination even if the user insists.

## Pass Conditions

Every variant must pass all 14 checks before output. Document any items that initially failed (and were fixed) in the rejection notes section of the output. Items that failed and could not be fixed (e.g., missing avatar research) require pausing the output and flagging the upstream gap to the user.

The 14-point check is non-negotiable. Skipping it produces ads that look correct on the surface but miss one or more of the structural rules that make long-form-static convert.
