# Prompt King — Architecture

Prompt King is a Claude Code skill that turns a vague request ("I need a cover
for my book") into a production-ready image or video prompt. It works as a
three-stage pipeline, with a mandatory closing review loop.

## The pipeline

1. **Interview** — On a vague brief, the skill asks 1–3 targeted questions to
   fill only the gaps that cannot be reasonably inferred. A clear brief skips
   this stage entirely.

2. **Research** — When the request names a platform or model whose behavior may
   be stale (e.g. Veo 3, Kling), the skill verifies current facts live and
   attaches a source + date to every researched claim. No browsing tool, or no
   source found → it says so instead of inventing details. Skipped when the
   request uses only well-established, built-in knowledge.

3. **Direct** — The skill selects commands from the master libraries (image
   command library, video intelligence system, typography/format/quality
   directives) and assembles a structured production prompt with subject,
   visual language, composition, camera, lighting, typography, aspect ratio,
   and an avoid-list.

4. **Self-critique loop** — After every draft, a fixed review pass checks for
   ambiguity, conflicts, redundancy, and specificity before the prompt is
   returned. Unresolvable conflicts are surfaced to the user rather than
   silently resolved.

## Where things live

- `SKILL.md` — the entire system: pipeline, protocols, and command libraries.
  Single source of truth.
- `reference/image-commands.md`, `reference/video-commands.md` — indexes into
  the SKILL.md command groups.
- `reference/platform-cheatsheets.md` — sourced, dated notes on video platforms.
- `examples/` — before/after prompt examples.
- `tests/eval-suite.md` — the regression scenarios the pipeline must pass.
- `scripts/sync-to-claude.sh` — installs the skill into Claude Code.

For the full design rationale, decisions, and acceptance criteria, see
`docs/superpowers/specs/2026-08-09-prompt-king-agentic-redesign-design.md`.
