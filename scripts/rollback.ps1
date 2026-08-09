# rollback.ps1
# Restore the installed skill copy from the newest versioned snapshot in
# data/versions/. An installed copy (e.g. ~/.claude/skills/prompt-king/SKILL.md)
# is not the same as a git revert of the repo — this script handles the
# installed-copy rollback after a failed deploy.
# Usage: powershell -File scripts/rollback.ps1 [-SkillPath <path>] [-Force]

param(
    [string]$SkillPath = "",
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$verDir = Join-Path $root "data\versions"

if (-not (Test-Path -LiteralPath $verDir)) { throw "No versions directory. Nothing to roll back to." }
$snapshots = Get-ChildItem -LiteralPath $verDir -Filter "SKILL-*.md" | Sort-Object LastWriteTime -Descending
if ($snapshots.Count -eq 0) { throw "No snapshots found in data/versions." }

$newest = $snapshots[0]

if (-not $SkillPath) {
    # Default: the live Claude Code skill location
    $SkillPath = Join-Path $HOME ".claude\skills\prompt-king\SKILL.md"
}
if (-not (Test-Path -LiteralPath $SkillPath)) { throw "Skill copy not found: $SkillPath" }

if (-not $Force) {
    Write-Host "About to overwrite: $SkillPath"
    Write-Host "Restoring from: $($newest.Name) (saved $($newest.LastWriteTime))"
    $confirm = Read-Host "Type 'rollback' to confirm"
    if ($confirm -ne "rollback") { Write-Output "Aborted."; exit 1 }
}

Copy-Item -LiteralPath $newest.FullName -Destination $SkillPath -Force
Write-Output "Rolled back: $SkillPath <- $($newest.Name)"
