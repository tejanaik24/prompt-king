# data/

The self-improvement memory layer. Read-write rules are defined in
[`docs/self-improvement-engine.md`](../docs/self-improvement-engine.md).

| Path | Class | Writable by |
|---|---|---|
| `experiences/` | EPHEMERAL EXPERIENCE | Skill (SESSION CLOSE) |
| `preferences/{user}.md` | USER PREFERENCE | Skill, per-user walled |
| `domain/` | DOMAIN KNOWLEDGE | Human, dated + TTL |
| `lessons/` | GLOBAL LESSON | Post-gate only |
| `hypotheses/` | EXPERIMENTAL HYPOTHESIS | Operator |
| `versions/` | VERSION SNAPSHOTS | Operator (promote/rollback) |
| `invariants.md` | PROTECTED INVARIANT | **Human only, engine read-only** |

`rules/` (validated rules) sits alongside `data/` at the repo root.
