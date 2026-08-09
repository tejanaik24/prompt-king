# record-experience.ps1
# Append an experience record to data/experiences/ (SESSION CLOSE).
# Usage:
#   powershell -File scripts/record-experience.ps1 `
#     -FailureCode "HANDS / ANATOMY" `
#     -ContentType "BOOK_FRONT_COVER" `
#     -Symptom "six fingers on character hand" `
#     -Context "cover illustration, cinematic, publisher brief" `
#     -Severity medium
# All params except FailureCode are optional; symptoms are prompted interactively
# when not supplied.

param(
    [Parameter(Mandatory = $true)][string]$FailureCode,
    [string]$ContentType = "",
    [string]$Symptom = "",
    [string]$Context = "",
    [ValidateSet("low", "medium", "high")][string]$Severity = "medium",
    [int]$Occurrences = 1,
    [switch]$SourceUser
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root "data\experiences"
if (-not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

if (-not $ContentType) { $ContentType = Read-Host "content_type" }
if (-not $Symptom)     { $Symptom     = Read-Host "symptom" }
if (-not $Context)    { $Context     = Read-Host "context" }

$stamp = Get-Date -Format "yyyy-MM-dd-HHmm"
$record = @"
---
failure_code: $FailureCode
content_type: $ContentType
symptom: $Symptom
context: $Context
severity: $Severity
occurrences: $Occurrences
source_user: $([bool]$SourceUser)
captured: $stamp
---
"@

$file = Join-Path $dir ("$stamp.md")
Set-Content -LiteralPath $file -Value $record -Encoding UTF8
Write-Output "Recorded: $file"
