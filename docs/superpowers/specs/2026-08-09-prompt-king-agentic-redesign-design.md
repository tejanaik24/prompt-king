# Prompt King — Agentic Redesign & Public Launch

Date: 2026-08-09
Status: Approved, pending implementation

## Problem

The current `prompt-king` skill (`~/.claude/skills/prompt-king/SKILL.md`) is a static
340-command reference for image-generation prompts. It has three gaps:

1. **Image only** — no video-generation prompting capability.
2. **Static** — no mechanism to stay current as image/video models change monthly.
3. **Not portable** — only usable inside Claude Code via the Skill tool; can't be
   shared as a standalone artifact.

Goal: turn it into an agentic, video+image prompt engineering system, then publish
it as a public GitHub repo (`tejanaik24/prompt-king`) designed to be broadly useful
outside Claude Code too.

## Architecture: 3-Stage Pipeline

Replaces the single static lookup with a pipeline, two of three stages conditional:

1. **INTERVIEW** (conditional, scales to ambiguity) — a clear, specific brief skips
   this. A vague brief ("make me an image for my business") triggers 1-3 targeted
   questions (purpose, platform, audience) before any prompt is written.
2. **RESEARCH** (conditional, signal-triggered) — fires when the request:
   - names a specific model/platform, or
   - uses trend language ("trending", "viral", "what's working now"), or
   - touches an area where built-in reference data is likely stale.
   Otherwise skipped, so simple requests stay fast.
3. **DIRECT** — the existing engine: select commands from the library, assemble the
   production-ready prompt. Branches into an image path (existing library) or a new
   video path.

## Components

- **Core orchestration** (`SKILL.md`) — the 3-stage logic, output contract, stage
  trigger conditions. Kept lean; heavy reference material lives in separate files.
- **Image command library** — existing ~340-command library, unchanged.
- **Video command library** (new) — parallel structure: shot type, camera move,
  motion/pacing, duration, audio/dialogue handling, transitions. Includes named
  cheat-sheets for **Veo 3, Kling, Runway, Pika, Luma**, each timestamped with
  when it was researched. Stays usable for any model not on that list via a
  model-agnostic base layer (camera/motion/scene language that transfers).
- **Trend-research playbook** — reference explaining what to search for when the
  RESEARCH stage fires, and how to fold findings into a prompt with a visible
  timestamp/source ("per [source], as of [date], Veo 3 responds better to X") so
  staleness is never silent.
- **Universal copy-paste version** (`prompt-king.md`) — the same orchestration
  logic minus Claude-Code-specific tool syntax (WebSearch/WebFetch calls become
  "if you have browsing, use it; otherwise rely on the reference tables below").
  This is the version most GitHub visitors will actually use, pasted into
  ChatGPT/Gemini/Claude/Cursor/anything.

## Data Flow (worked example)

Request: *"Make me a Veo 3 prompt for a product ad, coffee brand, trending style"*

1. Specific platform named ("Veo 3") + trend keyword ("trending") → **RESEARCH**
   fires: current Veo 3 prompting behavior + what's currently landing in
   coffee-brand video ads.
2. Brief is already specific (platform, subject, style) → **INTERVIEW** skipped.
3. **DIRECT**: assembles the video prompt using the Veo 3 cheat-sheet plus research
   findings, in the standard output contract — selected visual type, purpose,
   selected commands, final production prompt, format/duration, avoid-list.

## Edge Cases

- **No web access** (plain copy-paste version, no browsing tool available) → skip
  research silently, use built-in reference tables, and flag the prompt: "based on
  knowledge as of [date] — verify if this platform shipped an update since."
- **Unnamed/new platform** not in the cheat-sheets → always research; no built-in
  fallback to guess wrong from.
- **Mixed signals** (e.g. says "video" but names photography-specific commands) →
  resolved via the INTERVIEW stage, never silently guessed.

## GitHub Packaging

- Repo: `prompt-king`, MIT license.
- Structure:
  - `SKILL.md` — Claude Code native skill.
  - `prompt-king.md` — universal copy-paste system prompt, featured first in README.
  - `reference/image-commands.md`, `reference/video-commands.md`,
    `reference/platform-cheatsheets.md` — heavy reference material, linked not inlined.
  - `examples/` — before/after prompt examples.
  - `README.md` — leads with the copy-paste prompt + a before/after example;
    Claude Code install instructions second.

## Testing

Reference/orchestration skill, not a hard discipline rule — verified with 3
scenarios instead of full TDD pressure-testing:

1. Vague brief → should trigger INTERVIEW.
2. Named-platform or trend-language brief → should trigger RESEARCH.
3. Clear generic brief → should skip both, go straight to DIRECT.

Confirm the pipeline picks the correct path in each case before publishing.

## Out of Scope (this pass)

- Actually growing repo stars/virality (marketing, promotion) — a follow-up
  concern once the content and packaging exist.
- Video command library content itself is not written yet — the deep research
  on Veo 3/Kling/Runway/Pika/Luma current behavior happens during implementation,
  not during this design.
