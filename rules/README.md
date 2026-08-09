# rules/

Validated, promoted rules — written here **only after passing the promotion
gate** (detected pattern + benchmark + regression + human approval). Each rule
file carries the evidence it came from and a `review_by` date; rules expire if
not re-validated within 180 days.

## Rule file format

```yaml
---
rule: One actionable behavioral rule for the skill.
failure_code: [NEGATIVE PROMPT ENGINE category or OTHER]
evidence:
  occurrences: 5
  severity: high
  benchmark: pass
  regression: clean
  approved_by: [human]
  approved_date: YYYY-MM-DD
review_by: YYYY-MM-DD
---

Rule text, phrased so a future session can act on it directly.
```

There are currently no promoted rules. This directory stays empty until the
first pattern clears the gate.
