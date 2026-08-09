# Self-Improvement Engine

How `prompt-king` learns across sessions without ever rewriting its own core
skill from a single interaction. The canonical behavior (`SKILL.md`,
`prompt-king.md`) is **human-owned**; the engine observes, records, and
recommends — it never self-edits.

## The 13-stage pipeline

```
OBSERVE → RECORD → EVALUATE → DETECT → HYPOTHESIZE → EXPERIMENT → BENCHMARK →
REGRESSION CHECK → CANDIDATE → PROMOTION GATE → VERSION → DEPLOY → MONITOR
```

| Stage | Who runs it | Where |
|---|---|---|
| OBSERVE / RECORD | Skill, at SESSION CLOSE | `data/experiences/` |
| EVALUATE / DETECT | Operator (weekly review) | scan of `data/experiences/` |
| HYPOTHESIZE | Operator / reviewer | one candidate fix per pattern |
| EXPERIMENT / BENCHMARK | Operator | eval suite, fresh context |
| REGRESSION CHECK | Operator | eval suite before/after |
| CANDIDATE | Operator | passes benchmark + regression |
| PROMOTION GATE | **Human, always** | see gate below |
| VERSION / DEPLOY | Operator | snapshot + sync |
| MONITOR | Operator | re-check pattern after deploy |

## Seven memory classes (strictly separated)

| Class | Location | Writable by |
|---|---|---|
| EPHEMERAL EXPERIENCE | `data/experiences/` | Skill (SESSION CLOSE) |
| USER PREFERENCE | `data/preferences/{user}.md` | Skill, per-user walled |
| DOMAIN KNOWLEDGE | `reference/` + `data/domain/` | Human, dated + TTL |
| GLOBAL LESSON | `data/lessons/` | Post-gate only |
| EXPERIMENTAL HYPOTHESIS | `data/hypotheses/` | Operator |
| VALIDATED RULE | `rules/` | Post-gate only |
| PROTECTED INVARIANT | `data/invariants.md` | Human only, engine read-only |

## Promotion gate

A candidate fix becomes a canonical change **only** when all of these hold:

1. **Detected pattern** — the failure_code appeared ≥5 times across records,
   or ≥3 times at high severity. A single session is never enough.
2. **Benchmark pass** — the candidate passes the eval suite.
3. **Regression clean** — no previously-passing scenario breaks.
4. **Human approval** — explicit operator sign-off on the canonical change.
   The skill cannot approve its own promotion.

### Single-operator fallback

The global-lesson floor nominally requires ≥2 distinct users. Because
prompt-king is effectively single-operator (one person runs it), the following
fallback is **approved and documented**:

> A pattern detected in a single-operator deployment may be promoted with:
> **≥5 occurrences + severity high or medium-high + benchmark pass + explicit
> human approval + 180-day review window** (the promoted rule carries a
> `review_by` date and expires if not re-validated).

This keeps multi-user evidence as the ideal while letting the real operator
learn at a usable pace. Multi-user evidence, when it exists, is always
preferred.

## Guardrails (anti reward-hacking)

- The eval suite, the invariants (`data/invariants.md`), and the gate
  thresholds are **read-only to the engine** — the skill cannot edit them to
  make its own changes pass.
- Benchmarking uses a **fresh context** with only the skill loaded and no pass
  criteria revealed, so the skill cannot coach the test.
- Experience weight **decays ~90 days** — old single failures lose signal.
- Validated rules carry `review_by` (180 days) and expire without renewal.
- **≤3 promotions per review cycle** (anti bloat).
- Contradiction scan reuses the skill's own CONFLICT CHECK before any
  candidate is written to `rules/`.

## Experience record format

Appended by SESSION CLOSE as YAML to `data/experiences/`:

```yaml
---
failure_code: HANDS / ANATOMY
content_type: BOOK_FRONT_COVER
symptom: character hand rendered with six fingers
context: cover illustration, cinematic style, publisher brief
severity: medium
occurrences: 1
source_user: false
---
```

Rules for capture:
- Only what the user reported or is directly observable — never invented.
- No private client data, no full original prompts, no identifying details.
- Never capture on speculative "what if".

## Rollback

If a deployed change fails in the field, restore from the newest snapshot in
`data/versions/`:

```powershell
powershell -File scripts/rollback.ps1
```

The rollback script restores the installed skill copy from the newest snapshot
(an installed copy is not the same as a `git revert` of the repo).

## Recommended rhythm

- **Every session end** → SESSION CLOSE (record experiences).
- **Weekly** → DETECT patterns + HYPOTHESIZE candidates.
- **On any canonical candidate** → full benchmark + regression.
- **After any promote** → MONITOR the pattern; roll back if it doesn't hold.

## Phase status

- Phase 0 — instrumentation (SESSION CLOSE PROTOCOL): **done** (in `SKILL.md`).
- Phase 1 — record + harness: **done** (`data/experiences/` schema + scripts).
- Phase 2 — detect/hypothesize: **done** (detect script + hypotheses dir).
- Phase 3 — experiment/benchmark/regression: **done** (benchmark script + eval
  suite).
- Phase 4 — gate/version/deploy: **done** (promote script, snapshot, rollback).
- Phase 5 — monitor/decay: **done** (decay in detect script, `review_by`).
- Phase 6 — hardening + adversarial tests: **done** (`tests/adversarial-suite.md`).

See `docs/architecture.md` for the overall system, and `tests/eval-suite.md`
+ `tests/adversarial-suite.md` for how correctness is verified.
