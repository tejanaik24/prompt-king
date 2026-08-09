# Prompt King — Full System (Video, Research, Interview, Packaging) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Extend `prompt-king` from a static image-prompt reference into a full agentic
prompt-engineering system (image + video, research-capable, interview-capable,
self-critiquing) and package it as a public GitHub repo.

**Architecture:** Single unified skill (`SKILL.md` stays the Claude Code entry point)
built around the 3-stage pipeline from the design spec — INTERVIEW → RESEARCH → DIRECT
— with DIRECT branching into image or video command libraries. Heavy reference
material (video commands, platform cheat-sheets) lives in separate `reference/*.md`
files, linked not inlined, per the spec's file-organization decision. A parallel
`prompt-king.md` at repo root is the Claude-Code-agnostic copy-paste version.

**Tech Stack:** Markdown only (skill content). `gh` CLI for repo creation
(already authenticated as `tejanaik24`). No code/tests in the traditional
sense — verification is scenario-based subagent dispatch, per
`superpowers:writing-skills`' testing methodology (this is documentation, not
software).

## Global Constraints

- Canonical vocabulary source is `SKILL.md` (per spec) — reference files link to it,
  never fork/duplicate command definitions.
- Every researched platform fact must carry a source and a timestamp ("per [source],
  as of [date]") — no undated claims, no fabricated specifics (spec's Research System
  requirement: avoid hallucinated facts).
- MIT license, repo name `prompt-king`, owner `tejanaik24`.
- No implementation before this plan is reviewed and an execution mode is chosen
  (per user instruction — do not start early).
- Follow the existing repo structure already created: `c:\claude code\prompt-king\`
  with `docs/superpowers/specs/` and `docs/superpowers/plans/` already present.

---

## Component Specifications (Phase 2)

Each component below is specified before its implementation task.

### A. Video Generation System

- **Purpose:** Give prompt-king the same depth for video that it has for images —
  not "image + motion," a distinct discipline covering time, motion, sound, and
  cross-frame continuity.
- **User-facing behavior:** User asks for a video prompt (any platform or unnamed) →
  skill produces a structured, production-ready video prompt covering shot type,
  camera movement, pacing, continuity, and (if relevant) sound/dialogue direction.
- **Architecture:** New `VIDEO INTELLIGENCE SYSTEM` section in `SKILL.md`, structurally
  parallel to the existing image command library (named, purpose-tagged commands
  grouped by discipline). Platform-specific cheat-sheets live separately in
  `reference/platform-cheatsheets.md` so they can be re-researched/updated without
  touching the stable taxonomy.
- **Files:** Modify `SKILL.md` (add taxonomy). Create `reference/platform-cheatsheets.md`.
- **Dependencies:** None (taxonomy is authored directly, like the image library was).
  Platform cheat-sheets depend on live web research (Task 2).
- **Inputs:** User's video request (subject, purpose, platform if named).
- **Outputs:** Structured video prompt in the same OUTPUT MODE contract as images
  (selected type, purpose, selected commands, final prompt, format/duration, avoid-list).
- **Edge cases:** Platform not in cheat-sheets → model-agnostic base layer still
  produces a usable prompt (camera/motion/scene language transfers across tools).
  Multi-scene request → continuity section governs cross-scene consistency.
- **Testing:** Scenario suite entries under VIDEO (Phase 8).
- **Acceptance criteria:** Given a video request, skill selects from the correct
  taxonomy groups (not image groups), produces a prompt with duration + aspect ratio
  + platform fit, and does not silently invent unresearched platform facts.

### B. Research System

- **Purpose:** Let the skill go verify current model behavior instead of relying
  solely on static (and eventually stale) built-in knowledge.
- **User-facing behavior:** Invisible when not needed. When triggered, the skill's
  final prompt/answer includes a visible source + timestamp for any live-researched
  claim.
- **Architecture:** A `RESEARCH PROTOCOL` section in `SKILL.md`: trigger conditions
  (named platform / trend language / staleness risk — per spec), a fixed procedure
  (identify objective → determine necessity → search → cross-check sources →
  separate fact from assumption → flag contradictions → cite → flag uncertainty),
  and an explicit "when NOT to research" list to prevent over-triggering.
- **Files:** Modify `SKILL.md`.
- **Dependencies:** WebSearch/WebFetch tools (Claude Code); "if you have browsing"
  fallback language for the universal copy-paste version.
- **Inputs:** The trigger signal from the request; search results.
- **Outputs:** A structured findings block (claim, source, date, confidence) folded
  into the final prompt, never presented as unsourced fact.
- **Edge cases:** No browsing tool available → skip silently, flag staleness (per
  spec's edge case). Contradictory sources → surface the contradiction, don't
  silently pick one. Platform with no public documentation → say so, don't guess.
- **Testing:** Scenario suite entries under RESEARCH (Phase 8) — including an
  adversarial case (a made-up platform name) to confirm it doesn't hallucinate.
- **Acceptance criteria:** Fires only on the documented trigger conditions; every
  live-researched claim in output carries a source and date; explicitly declines
  to fabricate when sources don't exist.

### C. Interview / Requirements-Gathering System

- **Purpose:** Close information gaps in a vague brief without turning every request
  into an interrogation.
- **User-facing behavior:** Clear brief → no questions, prompt produced immediately.
  Vague brief → 1-3 questions, each earning its place, then a prompt.
- **Architecture:** An `INTERVIEW PROTOCOL` section in `SKILL.md`: a gap-detection
  step (what's missing from PURPOSE/AUDIENCE/PLATFORM/etc. that can't be reasonably
  inferred), a question-value ranking (ask the single highest-value gap first), a
  stop condition (enough information exists once PURPOSE + PLATFORM + SUBJECT are
  known, even if secondary details are inferred), and a brief-structuring step that
  converts answers into the same intake format the ART DIRECTION SYSTEM already uses
  (SUBJECT/PURPOSE/AUDIENCE/PLATFORM/...).
- **Files:** Modify `SKILL.md`.
- **Dependencies:** None.
- **Inputs:** The user's original request, prior answers in the same conversation.
- **Outputs:** Either a direct prompt (gap-free) or 1-3 questions, then a prompt.
- **Edge cases:** User declines to answer → proceed with best-judgment assumptions,
  stated explicitly in the output (never block indefinitely). Follow-up request in
  same session with brief already established → don't re-ask.
- **Testing:** Scenario suite entries under INTERVIEW (Phase 8), including a
  conflicting-requirements adversarial case.
- **Acceptance criteria:** Never asks a question answerable from context already
  given; never asks more than 3 questions; always eventually produces a prompt.

### D. Prompt Optimization / Self-Critique System

- **Purpose:** Make the skill critique its own draft before returning it, catching
  ambiguity/conflicts/bloat instead of shipping the first draft.
- **User-facing behavior:** Invisible — the user sees only the final, already-critiqued
  prompt (already partially present as the QUALITY CONTROL 20-point checklist; this
  formalizes it into an explicit loop with a defined entry/exit).
- **Architecture:** A `SELF-CRITIQUE LOOP` section in `SKILL.md` implementing the
  chain: DRAFT → ANALYZE → AMBIGUITIES → CONFLICTS → REDUNDANCY → SPECIFICITY →
  COMPOSITION CHECK → STYLE-CONSISTENCY CHECK → REFERENCE-CONTROL CHECK → TEXT CHECK
  → PLATFORM-FORMAT CHECK → FINAL. Runs after DIRECT assembles a draft, before output.
  Reuses the existing QUALITY CONTROL checklist and PROMPT OPTIMIZATION rules
  (adjective-stripping) already in `SKILL.md` as the concrete checks inside this loop,
  rather than inventing new ones.
- **Files:** Modify `SKILL.md`.
- **Dependencies:** Existing QUALITY CONTROL and PROMPT OPTIMIZATION sections.
- **Inputs:** The draft prompt from DIRECT.
- **Outputs:** Final prompt, revised if the loop found issues.
- **Edge cases:** Loop finds an unresolvable conflict (e.g. user demanded two
  incompatible styles) → surface it to the user instead of silently picking one
  (consistent with the Interview System's conflict handling).
- **Testing:** Scenario suite entries under PROMPT OPTIMIZATION (Phase 8).
- **Acceptance criteria:** A deliberately bloated/contradictory draft input produces
  a visibly tightened, non-contradictory final prompt.

### E. GitHub Packaging

- **Purpose:** Make the skill installable and readable by someone who has never seen
  it, as a standalone public repo.
- **User-facing behavior:** `git clone` → README explains what it is, shows a
  before/after example, and gives both the copy-paste prompt and the Claude Code
  install path.
- **Architecture:** Standard OSS repo layout, adapted from the spec:
  ```
  prompt-king/
  ├── SKILL.md                          # Claude Code native skill (canonical vocabulary)
  ├── prompt-king.md                    # universal copy-paste version
  ├── README.md
  ├── CHANGELOG.md
  ├── LICENSE                           # MIT
  ├── reference/
  │   ├── image-commands.md             # index/pointer into SKILL.md groups, not a fork
  │   ├── video-commands.md             # same, for the video taxonomy
  │   └── platform-cheatsheets.md       # Veo3/Kling/Runway/Pika/Luma, timestamped
  ├── examples/
  │   └── *.md                          # before/after prompt examples, one per discipline
  ├── tests/
  │   └── eval-suite.md                 # Phase 8 scenario suite
  └── docs/
      └── superpowers/{specs,plans}/    # already exists — design history
  ```
  Note: `commands/` and `schemas/` from the user's suggested layout are dropped —
  the vocabulary already lives in `SKILL.md`/`reference/`, and there's no machine
  schema to validate against (this is a prompt, not an API). YAGNI.
- **Files:** Create `README.md`, `CHANGELOG.md`, `LICENSE`, `reference/*.md`,
  `examples/*.md`, `prompt-king.md`. Move/copy `~/.claude/skills/prompt-king/SKILL.md`
  into the repo (repo becomes the source of truth; the `~/.claude/skills/` copy stays
  in sync manually or via a symlink — see Task 6).
- **Dependencies:** All content tasks (A-D) complete, since README examples reference
  the video system and self-critique behavior.
- **Inputs:** Finished `SKILL.md`, reference files.
- **Outputs:** A `gh repo create` push.
- **Edge cases:** Repo name collision on GitHub → check availability before creating.
- **Testing:** Manual — clone-free review that README instructions are followable
  as written.
- **Acceptance criteria:** A stranger reading only the README can (a) understand what
  the tool does in one screen, (b) copy-paste `prompt-king.md` into any chat tool and
  get a working result, (c) install the Claude Code version if they use Claude Code.

### F. Companion Resources

- **Purpose:** Point users at execution/QA tooling the skill itself doesn't do
  (batch generation, automated image QA) without duplicating that content.
- **User-facing behavior:** Already live — the BrightPool course repo section added
  earlier. This phase only extends it if video-specific companion resources exist.
- **Architecture:** No new architecture — existing `COMPANION RESOURCE` section
  pattern in `SKILL.md` is reused for any video-specific find.
- **Files:** Modify `SKILL.md` only if a genuinely relevant video-prompting companion
  resource is found during research (Task 2's web research may surface one — e.g. a
  FAL/Veo cookbook). If none is found, this component produces no changes — don't
  force a companion resource that doesn't exist.
- **Dependencies:** Task 2 (platform research) may surface candidates.
- **Testing:** N/A (content addition, not behavior).
- **Acceptance criteria:** Either a genuinely useful addition, or explicitly
  skipped with a one-line note in the plan's task log — never a padded, low-value
  link added just to check the box.

### G. Tests / Evaluation

- **Purpose:** Give the skill a repeatable way to verify it still behaves correctly
  after edits, without a compiler to catch regressions.
- **User-facing behavior:** N/A — internal quality gate before publishing/each update.
- **Architecture:** `tests/eval-suite.md` — a fixed list of scenarios, each with: a
  prompt, the expected pipeline path (INTERVIEW/RESEARCH/DIRECT and which combination),
  and pass/fail criteria. Run by dispatching a fresh subagent per scenario with only
  `SKILL.md` loaded (per `superpowers:writing-skills`' testing methodology — this IS
  that methodology, applied post-launch as a regression suite, not just a one-time
  pre-launch check).
- **Files:** Create `tests/eval-suite.md`.
- **Dependencies:** All other components complete (the suite tests the whole pipeline).
- **Inputs:** `SKILL.md` in its current state.
- **Outputs:** Pass/fail per scenario, with the agent's actual output attached for
  human review of borderline cases.
- **Coverage (Phase 8 requirement):** IMAGE, VIDEO, RESEARCH, INTERVIEW, PROMPT
  OPTIMIZATION, REFERENCE HANDLING, CHARACTER CONSISTENCY, BRAND CONSISTENCY,
  TYPOGRAPHY, MULTI-TURN CONTEXT, AMBIGUOUS REQUESTS, CONFLICTING REQUIREMENTS,
  PLATFORM FORMATS — positive and adversarial cases each.
- **Acceptance criteria:** Every category above has at least one positive and one
  adversarial scenario; a scenario run against the current `SKILL.md` passes before
  publishing.

### H. Documentation

- **Purpose:** Explain the system to a future maintainer (including future-you),
  not just to a first-time GitHub visitor (that's README's job).
- **Architecture:** `docs/` already holds the spec/plan trail. Add a short
  `docs/architecture.md` summarizing the 3-stage pipeline and pointing to the spec
  for full detail, so a maintainer doesn't have to re-read the whole spec to get
  oriented.
- **Files:** Create `docs/architecture.md`.
- **Dependencies:** None.
- **Acceptance criteria:** A maintainer with zero context can read this one file and
  know where to look for anything else.

---

## Task 1: Author the Video Intelligence System taxonomy

**Files:**
- Modify: `C:\Users\user\.claude\skills\prompt-king\SKILL.md` (append new section)

**Interfaces:**
- Consumes: existing `SKILL.md` structure/format conventions (command name +
  `Purpose:` one-liner, `====` section dividers, matching the image library's style).
- Produces: a `VIDEO INTELLIGENCE SYSTEM` section with 19 named subsections (listed
  below) that Task 2 (platform cheat-sheets), Task 5 (self-critique loop), and
  Task 8 (eval suite) all reference by these exact subsection names.

- [ ] **Step 1: Write the taxonomy content**

Append to `SKILL.md`, structured exactly like the existing image library (group
header, command names, one-line purposes):

```
============================================================
VIDEO INTELLIGENCE SYSTEM
============================================================

Video is not "image + motion." It adds time, motion, sound, and continuity
across frames — treat it as its own discipline.

-------------------------
01. SHOT TYPES
-------------------------
WIDE_SHOT / MEDIUM_SHOT / CLOSE_UP / EXTREME_CLOSE_UP / ESTABLISHING_SHOT /
OVER_THE_SHOULDER / POV_SHOT / TWO_SHOT / INSERT_SHOT / CUTAWAY / MASTER_SHOT

-------------------------
02. CAMERA MOVEMENT
-------------------------
STATIC / PAN / TILT / DOLLY_IN / DOLLY_OUT / TRACKING_SHOT / CRANE_SHOT /
HANDHELD / STEADICAM / WHIP_PAN / ARC_SHOT / ZOOM / RACK_FOCUS / DRONE_SHOT /
GIMBAL_MOVE

-------------------------
03. SUBJECT MOVEMENT & BLOCKING
-------------------------
Subject enters/exits frame, turns, crosses the frame; foreground-midground-
background choreography; blocking relative to camera axis.

-------------------------
04. CINEMATOGRAPHY LANGUAGE
-------------------------
Framing, coverage, eyeline continuity, the 180-degree rule. Violate only
when the request explicitly wants disorientation.

-------------------------
05. LENS LANGUAGE FOR VIDEO
-------------------------
Same focal-length purposes as image (see PHOTOGRAPHIC ART DIRECTION), plus
motion-specific behavior: anamorphic flare under movement, rack-focus pulls,
lens breathing.

-------------------------
06. LIGHTING FOR VIDEO
-------------------------
Cross-reference the image LIGHTING SYSTEM for base vocabulary; add motion-
specific: PRACTICAL_TRANSITION (light source changes within a shot),
CONTINUOUS_LIGHT_MATCH (consistency across cuts in one scene), FLICKER.

-------------------------
07. TRANSITIONS
-------------------------
CUT / MATCH_CUT / JUMP_CUT / CROSS_DISSOLVE / WIPE / SMASH_CUT / L_CUT /
J_CUT / WHIP_TRANSITION

-------------------------
08. EDITING LANGUAGE / PACING
-------------------------
Cut frequency by genre (fast for social/ads, slower for documentary), rhythm,
deliberate breathing room vs. relentless pacing — must match PURPOSE, not
default to fast cuts.

-------------------------
09. STORYBOARD & SHOT LISTS
-------------------------
Shot-list format: shot number, shot description, camera (type + movement),
duration, notes. Produce this structure whenever a request implies multiple
shots/a sequence, not just a single clip.

-------------------------
10. CONTINUITY
-------------------------
CHARACTER_CONTINUITY / ENVIRONMENT_CONTINUITY / PROP_CONTINUITY /
WARDROBE_CONTINUITY — cross-reference CHARACTER_CONSISTENCY_SYSTEM and
WORLD_BUILDING_SYSTEM from the image library; same rules, applied across time.

-------------------------
11. PRODUCTION CATEGORIES
-------------------------
PRODUCT_DEMONSTRATION / ADVERTISEMENT / SOCIAL_SHORT_FORM / REEL /
CINEMATIC_SEQUENCE / DOCUMENTARY / INTERVIEW / EXPLAINER_VIDEO / UGC_STYLE /
PRODUCT_VIDEO — each implies default duration/pacing/aspect-ratio norms,
overridable by explicit user instruction.

-------------------------
12. MOTION GRAPHICS & TITLE SEQUENCES
-------------------------
KINETIC_TYPE / TITLE_CARD_TIMING / LOWER_THIRD / END_CARD

-------------------------
13. VFX CONCEPTS
-------------------------
Describe the effect GOAL (e.g. "seamless product materialization," "subtle
environment particle life"), not a VFX pipeline. This system writes prompts,
not compositing instructions.

-------------------------
14. SOUND DESIGN DIRECTION
-------------------------
AMBIENT_BED / FOLEY_HIT / SILENCE_AS_TOOL / SOUND_TRANSITION — note which
target platforms/models actually generate audio (see platform cheat-sheets)
vs. which need sound added in post.

-------------------------
15. MUSIC DIRECTION
-------------------------
Tempo/mood matched to cut pacing; NEEDLE_DROP (existing-track feel) vs.
SCORE (composed-for-this feel).

-------------------------
16. DIALOGUE / VOICEOVER PLANNING
-------------------------
VO_TONE / VO_PACING / SYNC_TO_VISUAL_BEATS — preserve user-provided wording
exactly, same rule as image typography.

-------------------------
17. TECHNICAL PARAMETERS
-------------------------
Duration and aspect ratio by platform (see FORMAT DIRECTIVES in the image
system for the social/platform table — same table governs video). Frame rate:
24fps (cinematic), 30fps (standard/social), 60fps+ (slow-motion source),
variable frame rate (speed ramps).

-------------------------
18. FIRST-FRAME / HOOK STRATEGY
-------------------------
The first 1-3 seconds must justify the watch: motion into frame, pattern
interrupt, or an immediate text hook. Never open on a static, unclaimed frame
for social/ad contexts.

-------------------------
19. SCENE-TO-SCENE CONTINUITY
-------------------------
For multi-scene sequences: character, environment, and lighting logic must
hold across cuts unless the request is explicitly about transformation/time-skip.
```

- [ ] **Step 2: Verify structural consistency**

Grep the new section for the `====` divider style and confirm every command
group follows `NAME / NAME / NAME` or `NAME\nPurpose:\n...` format matching
the existing image library — no format drift.

- [ ] **Step 3: Commit**

```bash
cd "C:\Users\user\.claude\skills\prompt-king"
git init 2>/dev/null; git add SKILL.md
git commit -m "Add Video Intelligence System taxonomy"
```

(Note: `~/.claude/skills/prompt-king` is not yet a git repo — Task 6 reconciles
this with the `c:\claude code\prompt-king` repo. Until then, commit locally here
so history isn't lost.)

---

## Task 2: Research and write platform cheat-sheets

**Files:**
- Create: `c:\claude code\prompt-king\reference\platform-cheatsheets.md`

**Interfaces:**
- Consumes: Task 1's `VIDEO INTELLIGENCE SYSTEM` section names (cheat-sheets
  reference back to these, e.g. "prefers explicit SHOT TYPES per beat").
- Produces: `platform-cheatsheets.md` with one entry per platform, each entry
  consumed by `SKILL.md`'s RESEARCH PROTOCOL (Task 3) as the thing that gets
  refreshed when the protocol fires, and by the eval suite (Task 8) as ground
  truth for platform-specific test scenarios.

- [ ] **Step 1: Define the research procedure**

For each of Veo 3, Kling, Runway, Pika, Luma, search for: (a) official prompting
guide/docs, (b) current max duration and aspect ratios supported, (c) whether it
generates native audio/dialogue, (d) known prompt-structure preferences (e.g.
"responds better to shot-by-shot breakdowns" vs. "single flowing paragraph"),
(e) any recent (last 90 days) capability changes.

- [ ] **Step 2: Run the research** (dispatch WebSearch/WebFetch per platform)

- [ ] **Step 3: Write findings to file**, one section per platform:

```markdown
## Veo 3

- Source: [URL], accessed [date]
- Native audio/dialogue: [yes/no + detail]
- Max duration / aspect ratios: [...]
- Prompt structure preference: [...]
- Quirks: [...]
- Last verified: [date]
```

Repeat for Kling, Runway, Pika, Luma. Any claim without a source is not written —
if research turns up nothing solid for a field, write "not confirmed, needs
verification" rather than guessing.

- [ ] **Step 4: Cross-link from SKILL.md**

Add a one-line pointer in the `VIDEO INTELLIGENCE SYSTEM` section: "Named-platform
quirks (Veo 3, Kling, Runway, Pika, Luma): see `reference/platform-cheatsheets.md`,
refreshed via the RESEARCH PROTOCOL when stale."

- [ ] **Step 5: Commit**

```bash
cd "c:/claude code/prompt-king"
git add reference/platform-cheatsheets.md
git commit -m "Add researched platform cheat-sheets for video generation"
```

---

## Task 3: Author the Research Protocol

**Files:**
- Modify: `SKILL.md` (add `RESEARCH PROTOCOL` section)

**Interfaces:**
- Consumes: nothing new (reads the user's request text for trigger signals).
- Produces: a documented protocol that Task 5 (self-critique loop) and Task 8
  (eval suite) both reference for "did RESEARCH fire correctly."

- [ ] **Step 1: Write the protocol**

```
============================================================
RESEARCH PROTOCOL
============================================================

TRIGGER CONDITIONS (any one fires research):
- A specific model/platform is named.
- The request uses trend language ("trending", "viral", "what's working now").
- The relevant built-in reference (e.g. a platform cheat-sheet) is flagged stale
  or missing.

DO NOT RESEARCH WHEN:
- The request is generic/platform-agnostic (a poster, a book illustration with
  no named tool or trend claim).
- The built-in reference for what's being asked is already current and specific
  enough to answer.
- Research would only confirm something already unambiguous from the brief.

PROCEDURE WHEN TRIGGERED:
1. State the research objective in one line (what fact is actually needed).
2. Identify likely authoritative sources (official docs > verified news/reviews >
   forums/social — in that priority order).
3. Search and read.
4. Separate confirmed fact from assumption — if a source implies but doesn't
   state something, mark it as inference, not fact.
5. If sources disagree, surface the disagreement rather than picking one silently.
6. Note freshness — how recently was this true? Flag if the source itself is old.
7. Write findings with source + date attached to every claim.
8. If nothing solid is found, say so explicitly — never fill the gap with a
   plausible-sounding invented fact.

OUTPUT: findings fold into the final prompt as grounded specifics ("per
[source], as of [date], X"), not as a separate research report unless the user
asked for research specifically.
```

- [ ] **Step 2: Verify against the spec's edge cases**

Re-read the design spec's "Edge Cases" section (no web access, unnamed platform,
mixed signals) and confirm each is addressed by this protocol's DO-NOT-RESEARCH
and PROCEDURE steps. Fix any gap found.

- [ ] **Step 3: Commit**

```bash
cd "C:\Users\user\.claude\skills\prompt-king"
git add SKILL.md
git commit -m "Add Research Protocol"
```

---

## Task 4: Author the Interview Protocol

**Files:**
- Modify: `SKILL.md` (add `INTERVIEW PROTOCOL` section)

**Interfaces:**
- Consumes: the existing `ART DIRECTION SYSTEM` intake list (SUBJECT/PURPOSE/
  AUDIENCE/PLATFORM/...) as the checklist against which gaps are detected.
- Produces: a documented protocol Task 8's eval suite tests directly.

- [ ] **Step 1: Write the protocol**

```
============================================================
INTERVIEW PROTOCOL
============================================================

GAP DETECTION: Check the request against the ART DIRECTION SYSTEM intake list
(SUBJECT, PURPOSE, AUDIENCE, PLATFORM, CONTEXT, EMOTION, MESSAGE). Anything
reasonably inferable from context (e.g. platform obvious from "Instagram post")
is NOT a gap — don't ask about it.

QUESTION SELECTION: Of the remaining true gaps, ask only the single
highest-value one first — the one whose answer most changes the resulting
prompt (usually PURPOSE or PLATFORM, rarely secondary style details).

STOP CONDITION: Once SUBJECT + PURPOSE + PLATFORM are known (explicitly or by
reasonable inference), stop interviewing — proceed to DIRECT even if minor
details remain, filling them with stated best-judgment assumptions.

ADAPTATION: Each question's answer can eliminate other planned questions
(e.g. "who's it for" often answers "what platform" too) — re-evaluate the gap
list after every answer instead of asking a fixed sequence.

HARD LIMIT: Never ask more than 3 questions total for one request. If gaps
remain after 3, proceed with stated assumptions rather than continuing to ask.

OUTPUT: once gaps are resolved (by answer or by assumption), convert into the
same structured brief the ART DIRECTION SYSTEM already uses before handing off
to DIRECT.
```

- [ ] **Step 2: Commit**

```bash
cd "C:\Users\user\.claude\skills\prompt-king"
git add SKILL.md
git commit -m "Add Interview Protocol"
```

---

## Task 5: Author the Self-Critique Loop

**Files:**
- Modify: `SKILL.md` (add `SELF-CRITIQUE LOOP` section, referencing existing
  `QUALITY CONTROL SYSTEM` and `PROMPT OPTIMIZATION` sections rather than
  duplicating them)

**Interfaces:**
- Consumes: existing `QUALITY CONTROL SYSTEM` (20-point checklist) and
  `PROMPT OPTIMIZATION` (adjective-stripping rules) sections already in `SKILL.md`.
- Produces: the formal loop Task 8's eval suite tests with a deliberately
  bloated/contradictory input scenario.

- [ ] **Step 1: Write the loop**

```
============================================================
SELF-CRITIQUE LOOP
============================================================

Runs after DIRECT produces a draft prompt, before it is shown to the user.

DRAFT
  → ANALYZE (read the draft as if seeing it fresh)
  → AMBIGUITIES (any instruction that could be read two ways? resolve or flag)
  → CONFLICTS (any two instructions that fight each other? surface to the user
    rather than silently picking one — same rule as the Interview Protocol)
  → REDUNDANCY (remove repeated or restated instructions)
  → SPECIFICITY (run the PROMPT OPTIMIZATION adjective-stripping pass — replace
    vague intensifiers with measurable visual/motion instructions)
  → COMPOSITION CHECK (does the composition choice actually serve the stated
    PURPOSE?)
  → STYLE-CONSISTENCY CHECK (do the selected commands actually combine, per the
    DO-NOT-COMBINE-RANDOMLY rule — no clashing style/era/medium mashups)
  → REFERENCE-CONTROL CHECK (if references were provided, does the draft specify
    what was and wasn't meant to transfer, per REFERENCE IMAGE INTELLIGENCE?)
  → TEXT CHECK (if typography/copy is present, is it exactly the user's wording,
    minimal, and legible at output size?)
  → PLATFORM-FORMAT CHECK (aspect ratio / duration match the named or implied
    platform?)
  → FINAL (revised draft, or the original if the loop found nothing to fix)

If CONFLICTS surfaces something unresolvable, this loop's output is a question
back to the user, not a forced prompt.
```

- [ ] **Step 2: Commit**

```bash
cd "C:\Users\user\.claude\skills\prompt-king"
git add SKILL.md
git commit -m "Add Self-Critique Loop"
```

---

## Task 6: Reconcile the two SKILL.md locations and scaffold the repo

**Files:**
- Modify: `c:\claude code\prompt-king\` (add README.md, LICENSE, CHANGELOG.md,
  reference/image-commands.md, reference/video-commands.md, examples/*.md,
  prompt-king.md)
- Decide and implement: single source of truth between
  `~/.claude/skills/prompt-king/SKILL.md` (used live by Claude Code) and
  `c:\claude code\prompt-king\SKILL.md` (published copy)

**Interfaces:**
- Consumes: the finished `SKILL.md` from Tasks 1-5.
- Produces: the public repo tree the README and eval suite both reference.

- [ ] **Step 1: Pick the sync mechanism**

Windows symlinks need elevated permissions and are fragile across machines —
use a copy-on-publish step instead: the repo's `SKILL.md` is the source of
truth; a one-line `scripts/sync-to-claude.sh` copies it to
`~/.claude/skills/prompt-king/SKILL.md` after edits. Simpler than a symlink,
no permissions issue, and matches YAGNI (no sync automation needed until edits
actually happen post-launch).

- [ ] **Step 2: Copy the current SKILL.md into the repo and create the sync script**

```bash
cp "C:/Users/user/.claude/skills/prompt-king/SKILL.md" "c:/claude code/prompt-king/SKILL.md"
```

```bash
# c:/claude code/prompt-king/scripts/sync-to-claude.sh
#!/bin/bash
cp SKILL.md "C:/Users/user/.claude/skills/prompt-king/SKILL.md"
echo "Synced to Claude Code skills directory."
```

- [ ] **Step 3: Write `reference/image-commands.md` and `reference/video-commands.md`**

Each is a short index, NOT a fork of the content:

```markdown
# Image Commands

The full image command library (36 capability groups — illustration, graphic
design, typography, art direction, photography, lighting, color, and more)
lives in [`SKILL.md`](../SKILL.md). This file is a pointer, not a duplicate,
so the vocabulary never drifts out of sync between two copies.

Groups: [list the 36 group names with line-anchor links into SKILL.md]
```

(Same pattern for `video-commands.md`, listing the 19 subsections from Task 1.)

- [ ] **Step 4: Write `prompt-king.md`** (universal copy-paste version)

Copy `SKILL.md`, strip the YAML frontmatter, and replace Claude-Code-specific
tool references in the RESEARCH PROTOCOL with: "If you have web browsing
available, use it for the research steps below. If not, skip research and rely
on the reference tables, flagging that results may be based on knowledge as of
[skill version date]." Everything else is directly portable.

- [ ] **Step 5: Write `LICENSE`** (MIT, standard text, copyright Teja / current year)

- [ ] **Step 6: Write `CHANGELOG.md`**

```markdown
# Changelog

## 0.1.0 — 2026-08-09
- Initial public release.
- Image system: 36-group command library, illustration/graphic-design/art-direction
  systems, quality-control checklist.
- Video system: 19-group taxonomy, platform cheat-sheets (Veo 3, Kling, Runway,
  Pika, Luma).
- Agentic pipeline: Interview Protocol, Research Protocol, Self-Critique Loop.
```

- [ ] **Step 7: Write `examples/*.md`**

At minimum: `examples/image-before-after.md` and `examples/video-before-after.md`,
each showing a vague one-line user request next to the final structured prompt
prompt-king would produce, so a README reader sees the value in 10 seconds.

- [ ] **Step 8: Write `README.md`**

Structure: one-line hook → the copy-paste prompt (`prompt-king.md` contents, or
a fenced link to it) → one before/after example → Claude Code install
instructions (`cp SKILL.md ~/.claude/skills/prompt-king/SKILL.md` or clone into
the skills dir) → link to `reference/` and `examples/` → license.

- [ ] **Step 9: Commit and push**

```bash
cd "c:/claude code/prompt-king"
git add -A
git commit -m "Scaffold public repo: README, LICENSE, CHANGELOG, reference index, examples"
```

(Push to GitHub happens after Task 8's eval suite passes — see Task 9.)

---

## Task 7: Companion resources check

**Files:** Modify `SKILL.md` only if warranted.

- [ ] **Step 1: Review Task 2's research output** for any genuinely useful
  video-prompting companion resource (cookbook, notebook repo, official prompting
  guide worth linking).

- [ ] **Step 2a (if found):** Add it to the existing `COMPANION RESOURCE` section
  in `SKILL.md`, same format as the BrightPool entry, then commit.

- [ ] **Step 2b (if not found):** No changes. Note in the plan execution log:
  "No additional companion resource found for video — skipped rather than padded."

---

## Task 8: Build and run the evaluation suite

**Files:**
- Create: `c:\claude code\prompt-king\tests\eval-suite.md`

**Interfaces:**
- Consumes: the finished `SKILL.md` (all prior tasks).
- Produces: pass/fail record used as the publish gate (Task 9).

- [ ] **Step 1: Write the scenario list**

One table per category, each row: scenario prompt, expected pipeline path,
pass criteria. Minimum required (positive + adversarial per category, per spec):

```markdown
## IMAGE
| Scenario | Expected path | Pass criteria |
|---|---|---|
| "Book cover for a thriller novel" | DIRECT (no interview, no research) | Uses BOOK_COVER + genre-appropriate commands |
| "Make me an image" (adversarial: no info) | INTERVIEW fires | Asks ≤3 targeted questions, doesn't guess wildly |

## VIDEO
| "Veo 3 ad for a coffee brand, trending style" | RESEARCH + DIRECT | Cites sourced/dated Veo 3 facts; uses video taxonomy not image |
| "Video" (adversarial: no info) | INTERVIEW fires | Same as image case |

## RESEARCH
| "What's a good FooBarVideoGen9000 prompt" (adversarial: fake platform) | RESEARCH fires, finds nothing | Explicitly states no source found, does not invent quirks |
| "Minimalist poster, no platform named" | RESEARCH skipped | No search triggered, uses built-in reference only |

## INTERVIEW
| "Something for my business" (adversarial: maximally vague) | INTERVIEW fires | ≤3 questions, converges to a brief |
| "Instagram carousel, handwritten note style, my brand colors" | INTERVIEW skipped | Goes straight to DIRECT |

## PROMPT OPTIMIZATION
| Deliberately bloated/contradictory draft (adversarial) fed as a follow-up correction request | SELF-CRITIQUE LOOP triggers | Output is shorter, non-contradictory, or surfaces the conflict to the user |

## REFERENCE HANDLING
| "Use this reference photo but only the lighting" | DIRECT | Draft explicitly scopes to lighting only, not identity/pose |

## CHARACTER CONSISTENCY
| Follow-up request reusing a previously defined character | DIRECT | Locked identity traits preserved, not silently altered |

## BRAND CONSISTENCY
| Multi-request session with stated brand colors | DIRECT | Colors persist across requests without re-asking |

## TYPOGRAPHY
| Request with exact headline text specified | DIRECT | Output preserves wording exactly, doesn't invent copy |

## MULTI-TURN CONTEXT
| Brief established in turn 1, refined in turn 2 | DIRECT | Turn 2 doesn't re-run INTERVIEW for already-known facts |

## AMBIGUOUS REQUESTS
| "Make it pop" (adversarial: no measurable instruction) | SELF-CRITIQUE LOOP or INTERVIEW | Vague intensifier is not passed through unmodified |

## CONFLICTING REQUIREMENTS
| "Make it look handwritten and ultra-luxury fashion editorial" (adversarial: clashing styles) | Conflict surfaced | Skill flags the clash instead of blending incompatible styles |

## PLATFORM FORMATS
| "Instagram Story" vs "YouTube thumbnail" same subject | DIRECT | Correct aspect ratio (9:16 vs 16:9) per FORMAT DIRECTIVES |
```

- [ ] **Step 2: Run each scenario**

Dispatch a fresh subagent per scenario with only the repo's `SKILL.md` as loaded
context (mirrors real usage) and the scenario prompt as the user message. Record
pass/fail and the actual output.

- [ ] **Step 3: Fix any failing scenario**

Failures go back to the relevant task's file (Task 1-5) for a fix, then re-run
just that scenario.

- [ ] **Step 4: Commit**

```bash
cd "c:/claude code/prompt-king"
git add tests/eval-suite.md
git commit -m "Add and run evaluation suite; all scenarios passing"
```

---

## Task 9: Documentation and publish

**Files:**
- Create: `docs/architecture.md`

**Interfaces:**
- Consumes: the design spec (`docs/superpowers/specs/2026-08-09-prompt-king-agentic-redesign-design.md`).
- Produces: nothing consumed downstream — this is the terminal task.

- [ ] **Step 1: Write `docs/architecture.md`**

Short (under 300 words): the 3-stage pipeline diagram in prose, where each
component lives (file map), and a pointer to the full spec for detail.

- [ ] **Step 2: Final review against acceptance criteria**

Walk every "Acceptance criteria" line in the Component Specifications section
above and confirm it's met. Fix anything that isn't.

- [ ] **Step 3: Create the GitHub repo and push**

```bash
gh repo create tejanaik24/prompt-king --public --description "Agentic prompt-engineering system for image and video generation" --source=. --remote=origin
git push -u origin main
```

- [ ] **Step 4: Commit any final doc changes**

```bash
cd "c:/claude code/prompt-king"
git add docs/architecture.md
git commit -m "Add architecture doc"
git push
```

---

## Task Order

1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 (linear; each task's Interfaces section shows
why — Task 6 needs 1-5's content, Task 8 needs 6-7's finished repo, Task 9 is
the publish gate and needs 8's passing suite).
