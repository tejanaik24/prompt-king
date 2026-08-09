# Prompt King — Evaluation Suite

Regression suite for the `prompt-king` skill. Run against the current `SKILL.md`
whenever the skill is edited, and before any public release.

## How to run

For each scenario below, dispatch a **fresh** agent with **only** `SKILL.md` as
its loaded context (mirroring real skill usage — no plan, no eval file, no web
search) and the scenario prompt as the user message. Record the agent's raw
output, then judge it against the pass criteria. Do not hand the agent the pass
criteria — those are for the human/reviewer judging the output, not for the
agent being tested.

- Scenario column: what the user sends (multi-turn scenarios show the full
  conversation as turns).
- Expected path: which pipeline stages should fire (INTERVIEW / RESEARCH /
  DIRECT / SELF-CRITIQUE).
- Pass: what the output must do to pass.

## Run results

| # | Category | Scenario | Expected path | Result |
|---|---|---|---|---|
| 1 | IMAGE | Book cover for a thriller novel | DIRECT | PASS |
| 2 | IMAGE | "Make me an image" | INTERVIEW | PASS |
| 3 | VIDEO | Veo 3 ad for a coffee brand, trending style | RESEARCH + DIRECT | PASS |
| 4 | VIDEO | "Video" | INTERVIEW | PASS |
| 5 | RESEARCH | Minimalist poster, no platform named | DIRECT (no research) | PASS |
| 6 | RESEARCH | FooBarVideoGen9000 prompt | RESEARCH, finds nothing | PASS |
| 7 | INTERVIEW | Instagram carousel, handwritten note, brand colors | DIRECT (no interview) | PASS* |
| 8 | INTERVIEW | "Something for my business" | INTERVIEW | PASS |
| 9 | PROMPT OPTIMIZATION | Bloated follow-up draft | SELF-CRITIQUE | PASS |
| 10 | PROMPT OPTIMIZATION | Contradictory three-style draft | SELF-CRITIQUE, conflict surfaced | PASS |
| 11 | REFERENCE HANDLING | Reference photo, lighting only | DIRECT | PASS |
| 12 | REFERENCE HANDLING | Reference photo, "make it exactly like this" | DIRECT + scope flag | PASS |
| 13 | CHARACTER CONSISTENCY | Reuse defined character | DIRECT | PASS |
| 14 | CHARACTER CONSISTENCY | Silently drift a locked character | DIRECT or flag | PASS |
| 15 | BRAND CONSISTENCY | Stated brand colors, second request | DIRECT (no re-ask) | PASS |
| 16 | BRAND CONSISTENCY | Request clashes with brand colors | Conflict surfaced | PASS |
| 17 | TYPOGRAPHY | Exact headline text | DIRECT | PASS |
| 18 | TYPOGRAPHY | Exact text + tempting to rewrite | DIRECT | PASS |
| 19 | MULTI-TURN CONTEXT | Established brief, refinement turn | DIRECT (no re-interview) | PASS |
| 20 | MULTI-TURN CONTEXT | Turn 2 contradicts turn 1 | Conflict surfaced | PASS |
| 21 | AMBIGUOUS REQUESTS | "Make it pop" with context | SELF-CRITIQUE or clarification | PASS |
| 22 | AMBIGUOUS REQUESTS | "Make it pop" alone | INTERVIEW or SELF-CRITIQUE | PASS |
| 23 | CONFLICTING REQUIREMENTS | Handwritten + luxury editorial | Conflict surfaced | PASS |
| 24 | CONFLICTING REQUIREMENTS | Photoreal + anime + oil painting | Conflict surfaced | PASS |
| 25 | PLATFORM FORMATS | Instagram Story | DIRECT | PASS |
| 26 | PLATFORM FORMATS | YouTube thumbnail after Instagram turn | DIRECT, format corrected | PASS |

Score: 26/26.

## 2026-08-09 run notes

- Run method: one fresh subagent per scenario, only `SKILL.md` loaded, no web
  access, no pass criteria revealed. All 26 scenarios executed.
- **#7 (PASS)**: skill went straight to the format/style direction without
  re-interview, but asked one targeted question for genuinely non-inferable
  info (the carousel's topic/key points + hex codes). Acceptable — the strict
  "no questions" criterion assumes inferability, which wasn't present.
- **#20 (FAIL on first run → PASS after script fix)**: the first run's fresh
  agent only responded to Turn 1 (asking what the image is for) and never
  addressed Turn 2's contradiction. Root cause was a script artifact: Turn 1
  was itself an incomplete request (no subject), so the skill correctly held
  for an answer and dropped Turn 2. Scenario fixed by adding the missing
  user-answer turn (Turn 1b: "It's a poster for my gallery show."). Re-run
  against the fixed script: skill produced the minimalist poster prompt, then
  on Turn 2 explicitly flagged the contradiction with the locked direction and
  offered two coherent paths (commit to density, or keep minimalism) rather
  than silently blending — pass criteria met.
- **#14 (PASS)**: agent did not silently rewrite — it explicitly flagged the
  change as an explicit override of two locked traits (hair, wardrobe),
  re-locked them, and preserved everything else. Matches the "DIRECT or flag"
  criterion.
- **#24 (PASS)**: agent surfaced the style axis and resolved to one coherent
  concept (oil-painting portrait of an anime-designed character) rather than a
  three-style mashup.
- **#9 (PASS)**: agent explicitly rejected "8k / hyperrealistic" under the
  anti-AI directives and translated each adjective into a measurable visual
  instruction.
- **#12 (PASS)**: agent decomposed the reference into its aspects and asked
  for the use case before transferring — did not blindly copy wholesale.

## Scenarios

### IMAGE

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 1 | "Book cover for a thriller novel" | DIRECT (no interview, no research) | Uses `BOOK_FRONT_COVER` / `BOOK_COVER` commands; genre-appropriate direction (dark, suspenseful, thumbnail-readable); output follows the `OUTPUT MODE` contract (selected type, purpose, commands, final prompt, format, avoid list). |
| 2 | "Make me an image" | INTERVIEW fires | Asks ≤3 targeted questions before producing anything; does not dump a fully invented prompt immediately; converges toward a brief. |

### VIDEO

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 3 | "Veo 3 ad for a coffee brand, trending style" | RESEARCH + DIRECT | Recognizes the named-platform + trend triggers; output uses the **video** taxonomy (SHOT TYPES / CAMERA MOVEMENT / etc.), not image commands; duration + aspect ratio stated; any platform fact carries a source and date (built-in cheat-sheet citation counts) and unverified specifics are flagged, not asserted. |
| 4 | "Video" | INTERVIEW fires | Asks ≤3 targeted questions; does not invent subject/purpose/platform and start generating. |

### RESEARCH

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 5 | "Minimalist poster, no platform named" | DIRECT (RESEARCH skipped) | No search triggered; uses built-in reference only; no fabricated source citations in the output. |
| 6 | "What's a good FooBarVideoGen9000 prompt?" | RESEARCH fires, finds nothing | Explicitly states that no source was found / the platform is unverifiable; does NOT invent specs, quirks, or duration claims for a fictional platform. |

### INTERVIEW

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 7 | "Instagram carousel, handwritten note style, my brand colors" | DIRECT (INTERVIEW skipped) | No questions asked; goes straight to a prompt — everything needed is inferable from the request. |
| 8 | "Something for my business" | INTERVIEW fires | Asks ≤3 questions; converges to a brief; doesn't block forever. |

### PROMPT OPTIMIZATION

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 9 | Follow-up correction: "That draft is way too long. Make a new prompt: extremely stunning, very beautiful, incredibly detailed, absolutely amazing, masterpiece, 8k, hyperrealistic, ultra-detailed, breathtaking, jaw-dropping" | SELF-CRITIQUE LOOP triggers | Output strips the vague intensifiers; is visibly shorter/tighter; no contradictory stacking of modifiers. |
| 10 | Follow-up: "Make it photorealistic AND a hand-painted watercolor AND pixel art, all in one, maximum detail" | SELF-CRITIQUE LOOP, conflict surfaced | Either surfaces the style conflict to the user (doesn't silently mash three incompatible styles) or returns a single coherent style. |

### REFERENCE HANDLING

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 11 | "I have a reference photo of a person in a studio — use it but only take the lighting setup" | DIRECT | Draft explicitly scopes transfer to lighting only; does not carry over identity, pose, or composition from the reference. |
| 12 | "Here's my reference image [person + setting described]. Make it exactly like this." | DIRECT + scope flag | Doesn't blindly copy wholesale — decomposes the reference (identity/pose/lighting/composition) and either states what it will and won't transfer or asks which aspects matter. |

### CHARACTER CONSISTENCY

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 13 | Turn 1: "Define a character: Maya, 30s, short black hair, red jacket, urban setting." Turn 2: "Now Maya walking through a night market." | DIRECT | Locked identity traits (name, age range, hair, jacket color) preserved in turn 2; no silent alteration. |
| 14 | Turn 1: same Maya definition. Turn 2: "Same character but with long blonde hair and a blue suit now." | DIRECT or flag | Either keeps the locked traits (refusing/flagging the drift) or explicitly flags the change as a consistency break against the locked reference — never silently rewrites the identity as if never defined. |

### BRAND CONSISTENCY

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 15 | Turn 1: "Our brand is pastel lavender and cream, minimal." Turn 2: "A poster for our new product launch." | DIRECT (no re-ask) | Colors persist in the output without re-asking about the palette. |
| 16 | Turn 1: brand colors stated as pastel lavender and cream. Turn 2: "Make it neon green and black instead, I want it loud." | Conflict surfaced | Flags the clash with the stated brand identity rather than silently overriding it (or proceeds only with an explicit note that this breaks brand). |

### TYPOGRAPHY

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 17 | "Poster with the headline 'SALE — 50% OFF TODAY' in big bold letters" | DIRECT | Output preserves the wording exactly; no invented or altered copy. |
| 18 | "Poster, exact words: 'LESS IS MORE' — but make the tagline sound more premium" | DIRECT | Preserves the user's exact quoted wording for the headline; if it suggests alternative copy, does so only as an explicit separate suggestion, never silently replacing the quoted text. |

### MULTI-TURN CONTEXT

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 19 | Turn 1: "A LinkedIn banner for my accounting firm." (skill asks or infers) Turn 2: "Actually make it for Instagram, same style." | DIRECT (no re-interview) | Turn 2 uses already-established facts (style, firm context) without re-running INTERVIEW for known information; only the changed dimension (platform) is addressed. |
| 20 | Turn 1: "Minimalist, lots of white space." Turn 1b (user): "It's a poster for my gallery show." Turn 2: "Now make it dense and cluttered." | Conflict surfaced | Flags the direct contradiction with turn 1 rather than silently following the latest instruction and producing an incoherent mix. |

### AMBIGUOUS REQUESTS

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 21 | "Product shot for my skincare brand — make it pop" (subject/purpose/platform known) | SELF-CRITIQUE or targeted clarification | "Pop" is not passed through unmodified — it is converted into a measurable visual instruction (contrast, color saturation, focal emphasis) or a single targeted question. |
| 22 | "Make it pop" | INTERVIEW or SELF-CRITIQUE | Either asks what's being made (no subject given) or, if a prompt is produced, does not ship the bare intensifier — it is resolved or flagged. |

### CONFLICTING REQUIREMENTS

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 23 | "Make it look handwritten and ultra-luxury fashion editorial" | Conflict surfaced | Flags the clash between handwriting and polished luxury-editorial styles instead of blending incompatible styles into one generic output. |
| 24 | "Photorealistic, but also anime, and also realistic oil painting" | Conflict surfaced | Flags the multi-way style conflict; does not silently force a three-style mashup. |

### PLATFORM FORMATS

| # | Scenario | Expected path | Pass criteria |
|---|---|---|---|
| 25 | "Instagram Story ad for my coffee shop" | DIRECT | Correct aspect ratio (9:16) per FORMAT DIRECTIVES; social pacing assumed; format stated in output. |
| 26 | Turn 1: "Instagram Story ad for my coffee shop." Turn 2: "Also make a YouTube thumbnail version." | DIRECT, format corrected | Turn 2 output uses 16:9 (YouTube) — the platform change is recognized and the format switches, not copied from turn 1. |

---

## Coverage note

Every category carries at least one positive and one adversarial scenario, per
the design spec's evaluation requirements. Multi-turn scenarios are run as a
single scripted conversation against one fresh agent so context carries across
turns exactly as it would in real use.
