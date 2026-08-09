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
- **Image command library** — see [Image Command Library](#image-command-library) below. Canonical implementation lives in `SKILL.md`; this spec documents its architecture, not its content.
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

## Image Command Library

The image side of `SKILL.md` is not a flat list — it's organized into 36 capability
groups, each a distinct discipline with its own vocabulary. This section documents
the architecture and groups; the operational vocabulary (command names, purposes,
combination rules) lives in `SKILL.md` as the single source of truth. Do not
duplicate that vocabulary here — reference it.

### Capability groups

1. Image-generation command taxonomy (the ~340-command base library: handmade,
   information/explainer, photography, camera/composition, cinematic, posters,
   social media, website, books/publishing, branding, product/commercial, real
   estate, education, business/consulting, UI/UX/technology, collage/editorial,
   print/physical media, material/texture, internet-trend visuals, lifestyle,
   cultural/local, advertising)
2. Handmade / human-made visuals
3. Illustration systems (illustration as its own discipline, not a generic style)
4. Drawing and painting systems
5. Printmaking systems
6. Digital illustration
7. Editorial illustration
8. Children's / storybook illustration
9. Character design
10. Comics / sequential art
11. Cultural illustration (with the explicit authentic-vs-reinterpretation-vs-generic
    distinction — never mislabel invented work as historically authentic)
12. Graphic design systems (grids, layout systems, information/wayfinding/publication
    design)
13. Typography systems (treated as its own design system: hierarchy, scale, tracking,
    leading, rhythm)
14. Art-direction system (the SUBJECT → PURPOSE → AUDIENCE → ... intake checklist run
    before any visual concept is chosen)
15. Visual storytelling (hook / context / character / action / conflict /
    transformation / resolution / takeaway)
16. Advertising creative system (hero image, problem/solution visual, social proof,
    curiosity gap, pattern interrupt, etc.)
17. Visual metaphor system (a library of metaphors mapped to what they communicate,
    with an explicit anti-cliché instruction)
18. Photography direction (camera body/lens language, depth of field, exposure, grain)
19. Camera / lens / composition system (focal-length-to-purpose mapping: 24mm
    environmental, 35mm documentary, 85mm portrait, etc.)
20. Lighting system (natural, studio, and named lighting patterns — Rembrandt,
    butterfly, split, chiaroscuro)
21. Color-art-direction system (monochromatic, duotone, palette families including
    Indian earth / heritage palettes)
22. Design-principles system (contrast, balance, hierarchy, rhythm, focal point,
    legibility, accessibility — evaluated on every output)
23. Reference-image intelligence (decomposing a reference into identity / pose /
    lighting / composition / etc. and transferring only what's intended, never
    everything by default)
24. Character-consistency system (locked identity traits, character sheets,
    turnaround/expression/pose sheets — never modified without explicit instruction)
25. World-building (time period, culture, materials, technology — maintained across
    a series of images)
26. Architecture (visualization, technical drawings, masterplans, material boards)
27. Fashion (campaign, editorial, lookbook, technical garment drawings)
28. Packaging (hero, mockup, shelf, exploded, campaign)
29. Books / publishing (cover vs. interior distinction; cover evaluated on genre,
    target reader, shelf impact, thumbnail readability)
30. Websites (hero systems mapped to business objective — cinematic, editorial,
    product, typographic, data hero, etc.)
31. Presentations (slide types driven by visual storytelling, not text-filling)
32. Contemporary visual-trend system (evaluates what "trending"/"2026"/"modern"
    actually means case by case — explicitly forbids defaulting to generic
    futuristic gradients)
33. Quality-control system (20-point QA checklist run before finalizing any prompt —
    purpose clarity, generic-look check, AI-look check, thumbnail-scale check, etc.)
34. Prompt-optimization system (strips decorative adjectives, replaces vague
    intensifiers with measurable visual instructions)
35. Visual-differentiation system (when asked for multiple options, forces
    fundamentally different art directions instead of five minor variations)
36. Creative-director critique behavior (when the user's idea is weak, the skill
    must say so — what's weak, why, and a stronger direction — before producing a
    prompt, rather than blindly generating a weak brief)

### Architectural distinction: commands ≠ templates

**IMAGE COMMANDS ARE NOT PROMPT TEMPLATES.** The command library is a visual
vocabulary — named, purpose-tagged building blocks (`WHITEBOARD_EXPLANATION`,
`REMBRANDT_LIGHT`, `85MM`). It is not a set of fill-in-the-blank templates to
select and paste. The skill must *reason* its way to a combination, not
pattern-match a request to one pre-written template.

The reasoning chain the skill follows for every image request:

```
USER INTENT
  → PURPOSE
  → AUDIENCE
  → PLATFORM
  → COMMUNICATION OBJECTIVE
  → ART DIRECTION
  → VISUAL CONCEPT
  → COMPOSITION
  → CAMERA
  → LIGHTING
  → MATERIAL
  → COLOR
  → TYPOGRAPHY
  → REFERENCE CONTROL
  → REALISM / STYLE
  → OUTPUT FORMAT
  → QUALITY CONTROL
  → FINAL PROMPT
```

Each arrow is a decision point where the skill selects specific commands from the
relevant capability group(s) above, justified by the stage before it — never
combined "because they sound interesting" (the library's own
DO-NOT-COMBINE-RANDOMLY rule). Quality control (group 33) runs as a gate before
the final prompt ships, not as an afterthought.

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
