# detect-patterns.ps1
# EVALUATE / DETECT stage: scan data/experiences/ and flag failure codes that
# meet the promotion detection threshold (>=5 occurrences, or >=3 at high
# severity). Also applies ~90-day decay: records older than 90 days are counted
# at reduced weight so stale single failures lose signal.
# Usage: powershell -File scripts/detect-patterns.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root "data\experiences"
$now = Get-Date
$decayDays = 90

if (-not (Test-Path -LiteralPath $dir)) {
    Write-Output "No experiences directory yet. Nothing to detect."
    exit 0
}

$tally = @{}
$files = Get-ChildItem -LiteralPath $dir -Filter *.md | Where-Object { $_.Name -ne "README.md" }
foreach ($f in $files) {
    $content = Get-Content -LiteralPath $f.FullName -Raw
    if ($content -notmatch "failure_code:\s*(.+)") { continue }
    $code = $Matches[1].Trim()
    $severity = if ($content -match "severity:\s*(\w+)") { $Matches[1].Trim() } else { "low" }
    $occ = if ($content -match "occurrences:\s*(\d+)") { [int]$Matches[1] } else { 1 }

    # decay: full weight within decay window, half after
    $age = ($now - $f.LastWriteTime).Days
    $weight = if ($age -le $decayDays) { 1.0 } else { 0.5 }

    if (-not $tally.ContainsKey($code)) {
        $tally[$code] = @{ weight = 0.0; high = 0; records = @() }
    }
    $t = $tally[$code]
    $t.weight += $occ * $weight
    if ($severity -eq "high") { $t.high += $occ }
    $t.records += $f.Name
}

$detected = @()
foreach ($code in ($tally.Keys | Sort-Object)) {
    $t = $tally[$code]
    $met = ($t.weight -ge 5) -or ($t.high -ge 3)
    if ($met) {
        $detected += [PSCustomObject]@{
            FailureCode = $code
            Weighted = [math]::Round($t.weight, 1)
            High = $t.high
            Records = ($t.records -join ", ")
        }
    }
}

if ($detected.Count -eq 0) {
    Write-Output "No pattern reached detection threshold. ($($tally.Count) distinct failure codes tracked)"
} else {
    Write-Output "DETECTED PATTERNS (candidate for HYPOTHESIZE):"
    $detected | Format-Table -AutoSize
}
