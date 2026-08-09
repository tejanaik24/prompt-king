## Description
Describe the changes introduced by this pull request. If this PR resolves an open issue, link it here (e.g. `Fixes #123`).

## Type of Change
Please delete options that are not relevant.
- [ ] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Documentation update
- [ ] Performance / optimization

## How Has This Been Tested?
Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce.
- Run regression tests: `scripts/promote-rule.ps1`
- Verify eval suite: `tests/eval-suite.md` status.
- Confirm all 30 scenarios pass.

**Test Configuration:**
* OS:
* Target LLM:
* Target Image/Video Model:

## Checklist:
- [ ] My code follows the style guidelines of this project
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings or regressions
- [ ] I have verified that all 30 evaluation scenarios still pass
