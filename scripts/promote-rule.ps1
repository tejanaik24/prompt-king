# promote-rule.ps1
# PROMOTION GATE: move a validated candidate from data/hypotheses/ to rules/
# ONLY when the evidence is complete. This script enforces the mechanics of the
# gate; it does NOT replace human approval — the operator runs it deliberately
# after (a) benchmark pass, (b) clean regression, (c) explicit sign-off.
# Usage: powershell -File scripts/promote-rule.ps1 -HypothesisFile data/hypotheses/<name>.md -ApprovedBy "Teja"

param(
    [Parameter(Mandatory = $true)][string]$HypothesisFile,
    [Parameter(Mandatory = $true)][string]$ApprovedBy
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$hypPath = Join-Path $root $HypothesisFile
if (-not (Test-Path -LiteralPath $hypPath)) { throw "Hypothesis not found: $hypPath" }

$content = Get-Content -LiteralPath $hypPath -Raw
$required = @("benchmark: pass", "regression: clean", "status: promoted")
foreach ($req in $required) {
    if ($content -notmatch [regex]::Escape($req)) {
        throw "Gate not passed: missing '$req'. Promotion aborted."
    }
}
if ($content -notmatch "failure_code:\s*(.+)") { throw "Hypothesis missing failure_code." }
$failureCode = $Matches[1].Trim()

$rulesDir = Join-Path $root "rules"
if (-not (Test-Path -LiteralPath $rulesDir)) { New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null }

$reviewBy = (Get-Date).AddDays(180).ToString("yyyy-MM-dd")
$ruleFile = Join-Path $rulesDir (($failureCode -replace '[^a-zA-Z0-9]+', '-').Trim('-') + "-rule.md")
$record = @"
---
rule: $([regex]::Replace($content, '(?s).*?^---\s*$', '').Trim())
failure_code: $failureCode
evidence:
  benchmark: pass
  regression: clean
  approved_by: $ApprovedBy
  approved_date: $(Get-Date -Format "yyyy-MM-dd")
review_by: $reviewBy
---

$content
"@

Set-Content -LiteralPath $ruleFile -Value $record -Encoding UTF8
Write-Output "Promoted: $ruleFile"
Write-Output "Review by: $reviewBy (re-validate within 180 days or the rule expires)"
