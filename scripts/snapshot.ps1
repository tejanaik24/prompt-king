# snapshot.ps1
# VERSION stage: snapshot the canonical SKILL.md into data/versions/ before a
# deploy, so a failed deploy can be rolled back. Run before every sync/promote.
# Usage: powershell -File scripts/snapshot.ps1

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$skill = Join-Path $root "SKILL.md"
if (-not (Test-Path -LiteralPath $skill)) { throw "SKILL.md not found: $skill" }

$verDir = Join-Path $root "data\versions"
if (-not (Test-Path -LiteralPath $verDir)) { New-Item -ItemType Directory -Force -Path $verDir | Out-Null }

$stamp = Get-Date -Format "yyyy-MM-dd-HHmm"
$dest = Join-Path $verDir "SKILL-$stamp.md"
Copy-Item -LiteralPath $skill -Destination $dest
Write-Output "Snapshot: $dest"
