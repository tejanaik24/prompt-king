# Negative Prompt Engine

The full negative-prompt engine — pipeline, versioned knowledge base, and
learning path — lives in [`SKILL.md`](../SKILL.md) (section
`NEGATIVE PROMPT INTELLIGENCE ENGINE`). This file is a pointer, not a
duplicate, so the vocabulary never drifts between two copies.

**Design rationale:** [`docs/negative-prompt-engine.md`](../docs/negative-prompt-engine.md).

**How the avoid list is built** (in SKILL.md):

`REQUEST → CONTENT TYPE → FAILURE MODE MATCH → CATEGORY → NEGATIVE VOCABULARY →
PLATFORM FILTER → CONFLICT CHECK → FINAL NEGATIVE PROMPT`

**Versioned knowledge base:**

- `NEG-V1` (2026-08-09) — baseline categories: HANDS / ANATOMY,
  TEXT / TYPOGRAPHY, FACES / EXPRESSION, STRUCTURE / COMPOSITION,
  STYLE DRIFT / GENERIC, PLATFORM / FORMAT FAILURE, CONTENT MISMATCH / POLICY.

**Learning path:** repeated failures captured by SESSION CLOSE are promoted to
new versions (`NEG-V2+`) through the human-gated self-improvement promotion
gate — never self-edited from a single session.

**Traceability:** every output surfaces its negative base version (e.g.
"Negative base: NEG-V1").
