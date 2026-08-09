# Example: Experience-to-Rule Self-Improvement Cycle

This example illustrates how Prompt King captures failing prompt experiences during a session close and how they translate into a versioned rule change without self-rewriting risks.

---

## 1. Step 1: Session Close & Experience Capture
During a working session, the user reports that generating an image of a person holding a sword repeatedly resulted in broken fingers and hands fused to the hilt. At session close, Prompt King records this failure in `data/experiences/`:

```yaml
---
failure_code: HANDS / ANATOMY
content_type: FANTASY_CHARACTER
symptom: fingers fused together, hand merging into sword hilt
context: Flux model, high-detail warrior holding sword pose
severity: high
occurrences: 3
source_user: true
---
```

---

## 2. Step 2: Pattern Detection
The operator runs the pattern detection script:
```powershell
./scripts/detect-patterns.ps1
```
The script scans the experiences directory and flags that `HANDS / ANATOMY` has reached the high-severity threshold of 3 occurrences. It creates a **Detected Pattern** in `data/hypotheses/`.

---

## 3. Step 3: Drafting a Hypothesis / Fix Rule
The operator drafts a hypothesis rule to address the hilt-fusing issue, adding explicit positive grip instructions and specific negative avoid terms (`fused fingers, webbed fingers, merged fingers, hand blending into sword hilt`).

---

## 4. Step 4: Regression Testing & Promotion Gate
The operator runs the regression test suite:
```powershell
./scripts/promote-rule.ps1 -RulePath "rules/hands-anatomy-fix.json"
```
The script verifies that the new rule does not cause any regression across the 30-scenario evaluation suite.

Once tests pass, the human operator explicitly approves the candidate fix and merges it into `SKILL.md` as part of the new negative prompt base `NEG-V1+`, completing the human-gated promotion gate.
