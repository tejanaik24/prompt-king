# data/hypotheses/

Experimental hypotheses — candidate fixes written BEFORE they pass the gate.
Each hypothesis names the detected pattern it addresses and its proposed
change, and is discarded or promoted based on benchmark + regression results.
Promoted hypotheses move to `rules/`; rejected ones are deleted or marked
`rejected`.

Hypothesis format:

```yaml
---
pattern: [failure_code + occurrence count that triggered detection]
proposed_change: One sentence: what the skill should do differently.
benchmark: [pending | pass | fail]
regression: [pending | clean | broke]
status: [open | rejected | promoted]
---
```
