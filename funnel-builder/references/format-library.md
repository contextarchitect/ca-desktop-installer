# Format Library: 9 Named Landing Page Formats

A landing page is a structured argument. The structure varies by audience awareness, resistance level, and how the traffic was warmed before arrival. This catalogue lists 9 named formats, each with its core structure, when to use it, and the corpus source it derives from.

The default format for ContextArchitect funnels is **Advertorial** (the 9-section structure detailed in `advertorial-framework.md`). The other 8 formats are alternatives operators choose when the audience or category fits a different shape.

## Format Selection Matrix

| Awareness | Resistance | Recommended Format(s) |
|-----------|------------|-----------------------|
| Problem-aware | Low | PAS, BAB, Problem Stack |
| Problem-aware | High | Advertorial, Long-Form |
| Solution-aware | Low | Listicle (Logic), 4P |
| Solution-aware | Medium | SPS, AIDA |
| Solution-aware | High (price-sensitive bottom-funnel) | Fake-Complaint (sub-format of listicle/static) |
| Product-aware | Low | 4P, Listicle (Product) |
| Product-aware | High | SPS, BAB |

In this matrix, "awareness" and "resistance" are used in their plain-language copywriting senses. Awareness is how much the reader already knows about their problem and the available solutions. Resistance is how skeptical the reader is, driven by category maturity, price sensitivity, and the number of alternatives the avatar has already tried. These are universal copywriting concepts and apply to every brand.

The universal 3-value enum (Problem-aware / Solution-aware / Product-aware) is canonical for format selection, and this matrix is expressed entirely in those three stages. A producer (for example avatar research) may emit a 5-value stage; collapse it to the 3-value enum via the normative 5-to-3 mapping in `_frameworks/awareness-vocabulary.md` before reading this matrix. A Most Aware input never reaches this matrix: funnel-builder exits at the Step 0.1 awareness early-exit gate (in the funnel-builder skill) before format selection, because a most-aware reader enters at the offer rather than through an interstitial funnel page (the RMBC entry-point rule). This library defines buildable funnel-page formats only; direct-to-offer routing is not a format and does not live here. The one collapsed extreme this matrix does handle is Unaware:

- **Input mapped from Unaware (folds into Problem-aware):** filtering-required, long-form lead. Filter the reader to the avatar and introduce the problem before treating them as Problem-aware, then lead long (Advertorial with a novel mechanism reveal).

---

## 1. Advertorial (Default: 9-Section Long-Form)

The ContextArchitect default format. Reads like a first-person editorial story; structurally is a 9-section sales argument.

**Structure:** Above the Fold, then Lead, then Background Story, then Root Cause, then Consequences, then Unique Mechanism, then Product Buildup, then Product Reveal, then Close.

**Use when:** Mechanism is novel and needs earning; audience is skeptical; brand has a story (real or analogous) to tell; copy length under 3000 words is acceptable.

**Avoid when:** Audience is already product-aware and just needs to compare options (use Listicle instead); ad format is Advertorial Ad Copy (use Listicle to avoid repeating the emotional arc).

**Reference:** `advertorial-framework.md` for the full 9-section structure.

---

## 2. Listicle (3 Variants: Logic, Emotion, Product)

Numbered list of 5/7/9/11 items. Each item is a discrete claim, social proof, or comparison point.

**Structure:** Opening, then numbered items, then CTA mid-page, then guarantee, then CTA final. Risk reversal (the guarantee) precedes the final ask (the final CTA), matching `listicle-framework.md` and the canonical close order; the mid-page CTA is a permitted interim ask.

**Use when:** Traffic was emotionally warmed by an ad and needs logical validation (Logic variant); audience is solution-aware comparing options (Product variant); audience is curious but needs emotional connection before product (Emotion variant).

**Reference:** `listicle-framework.md` for variant selection and item sequencing.

**Canonical variant names.** The three listicle variants are named `Listicle (Logic)`, `Listicle (Emotion)`, and `Listicle (Product)`, collectively `Listicle (3 Variants: Logic, Emotion, Product)`. These parenthetical forms are canonical across all skills. Downstream consumers that carry a format enum (the angle card's Recommended Format, the ad-analysis-tagger format list) must match them exactly. Hyphen-joined variant spellings (the variant appended to `Listicle` with a hyphen instead of a parenthetical) are non-canonical.

---

## 3. PAS (Problem-Agitate-Solution)

Three-act structure. Cold, pain-aware traffic.

**Structure:** Problem (state it specifically with avatar's words), then Agitate (deepen the felt cost; make the future-state-of-pain vivid), then Solution (introduce mechanism + product as the resolution).

**Use when:** Cold traffic; problem-aware audience with low resistance; short-form copy (1000-1500 words); pain is specific and visceral.

**Avoid when:** Audience is highly skeptical and already category-tired (agitation reads as manipulation); high-resistance category; B2B context (PAS reads as consumer-grade).

**Reference:** Zakaria Video28.

---

## 4. AIDA (Attention-Interest-Desire-Action)

Four-act structure with a logical-emotional-logical flow.

**Structure:** Attention (hook + identity marker), then Interest (problem framing + initial mechanism hint), then Desire (vivid fulfillment + social proof + identity bridge), then Action (CTA with risk reversal).

**Use when:** Broad audience; mid-funnel warming; medium-length copy; the brand voice is conversational rather than story-led.

**Avoid when:** Audience needs novel-mechanism explanation (Advertorial is better); audience has already converted on attention (skip to Desire/Action via SPS or 4P).

**Reference:** Zakaria Video28.

---

## 5. SPS (Story-Problem-Solution)

Story-led narrative; problem and solution are revealed through the story.

**Structure:** Story (specific narrator, specific scene, specific tension), then Problem revealed through story conflict, then Solution revealed through story resolution, then CTA with risk reversal.

**Use when:** Brand has a strong narrative voice; transformation-based selling; audience responds to identification before logic; medium-to-high-resistance categories where story camouflages the sales argument.

**Avoid when:** Audience is product-aware and time-pressed (story feels like padding); ad budget requires short copy under 800 words.

**Reference:** Zakaria Video28.

---

## 6. 4P (Picture-Promise-Proof-Push)

Mobile-scroll optimized format. Each P is a distinct visual block.

**Structure:** Picture (image of fulfilled state with caption), then Promise (one-sentence value prop), then Proof (social proof + mechanism in 2-3 sentences), then Push (CTA with single trust marker).

**Use when:** Mobile-first traffic; product-aware audience; ad budget requires fast-scroll-stopping copy; the product is visually compelling.

**Avoid when:** Mechanism needs explanation longer than 2-3 sentences; audience is skeptical (4P assumes they already trust the category).

**Reference:** Zakaria Video28.

---

## 7. Long-Form (Extended-Argument)

Variant of Advertorial extended to 4000-6000+ words. Used in complex / high-resistance / low-trust markets.

**Structure:** Same as Advertorial 9-section, but each section runs 1.5-2x longer with deeper proof, more specific narrators, more concrete failed-solution detail.

**Use when:** Category is high-trust-cost (financial, medical, legal-adjacent); price is high-ticket ($200+); audience has already cycled through several alternatives; the brand has authority assets (peer-reviewed studies, named specialists, regulatory wins) to deploy.

**Avoid when:** Mobile-first traffic (long-form mobile read-through is brutal); audience is product-aware and time-pressed.

**Reference:** Zakaria Video28.

---

## 8. BAB (Before-After-Bridge)

Fast visual transformation sell. Image-led format.

**Structure:** Before (image of struggle state with one-sentence framing), then After (image of fulfilled state with one-sentence framing), then Bridge (2-3 paragraphs explaining how the product moved Before to After), then CTA.

**Use when:** Product produces a visually dramatic transformation (skin, body, hair, before/after measurements); the audience scrolls past long-form copy; brand is product-aware.

**Avoid when:** Transformation is internal/non-visual (mood, energy, sleep quality without measurable signs); regulatory category prohibits before/after claims.

**Reference:** Zakaria Video28.

---

## 9. Problem Stack

Compounded-frustration narrative. Stacks 4-7 specific failure scenes from the avatar's life into a single momentum-building section.

**Structure:** Open with the smallest frustration (ideally one the avatar wouldn't have flagged as related to the core problem), then stack increasingly significant failures, then reveal the connecting root cause, then mechanism, then product, then close.

**Use when:** Avatar has a "death by a thousand cuts" relationship with the problem (multiple small frustrations, no single dramatic event); root cause is novel and ties together previously disconnected symptoms; brand sells multi-symptom products (energy + libido + recovery + focus, etc.).

**Avoid when:** Single-symptom product (the stack feels artificial); avatar's experience is one major event rather than accumulated small ones.

**Reference:** Zakaria Video28.

---

## Sub-Format: Fake-Complaint (Reddit-Post Style)

Ultra-short solution-aware bottom-funnel format. Single paragraph (200-400 words). Reads as a customer-to-customer Reddit complaint about a checkout problem; structurally is social-proof-heavy reactivation copy.

**Structure:** Opening complaint hook ("Has anyone else's checkout broken?"), then context that reveals the product naturally ("I was trying to reorder the [product] because the sale price renewed and..."), then secondary social proof embedded in the complaint ("My wife also stocked up because last time the price went up $20..."), then resolution that doubles as urgency ("Fixed now apparently, but if you were on the fence I'd lock it in before they pull the price again"), then no explicit CTA: the reactivation is implicit.

**Use when:** Solution-aware audience that has already engaged with the brand; bottom-funnel email/retargeting placement; price-anchor reactivation moment (subscriber price renewal, sale ending, inventory low); the brand has a customer-to-customer voice it can authentically deploy.

**Avoid when:** Cold traffic (the format requires existing brand awareness to land); regulated category where customer-voice claims have compliance risk; brand voice is formal or B2B (the Reddit-post register won't match).

**Reference:** Rosabella variant #7 (validated production ad). The single most distinctive sub-format in the Rosabella corpus and the only one ContextArchitect didn't previously have a pattern for.

**Compliance note:** The fake-complaint format reads as customer-voice but is brand-authored. Some platforms (Meta Ads especially) classify customer-voice ads under stricter review. Verify ad-policy compliance before deploying.

---

## Format-to-Section Cross-References

When using any format above, the writing rules from `copywriting-guide §8 (Universal Structural Copywriting Rules)` still apply:

- **Bridges between sections** (`copywriting-guide §8.1 The Bridge Principle`): every transition between format sections needs an explicit bridge sentence
- **Hook quality** (`copywriting-guide §8.4 Hook Quality Checklist`): every format's opening hook passes the 5-point check
- **Identification before mechanism** (`copywriting-guide §8.5 Identification-Before-Mechanism Rule`): even short formats like 4P or PAS earn the right to explain before they explain
- **One core feeling** (enum canonical source `copywriting-guide §8.7 The Five Core Feelings Library`): every format serves one core feeling; read it from the angle card's `Core Feeling` field. If it is absent, apply the schema's missing-field precedence (legacy card means pick one yourself; current-schema card means flag the defect and pick one to proceed; see the angle-card schema's Schema Version note and funnel-builder Step 0.5)
- **Authority hooks** (`copywriting-guide §8.8 Authority Hook Patterns`): when invoking authority, pick one of the four named patterns

The Format Library tells you WHAT structure to build. The Universal Structural Copywriting Rules tell you HOW TO BUILD it so it lands.
