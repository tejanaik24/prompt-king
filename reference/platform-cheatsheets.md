# Platform Cheat-Sheets: Video Generation Models

Researched reference for named video-generation platforms. Consumed by
`SKILL.md`'s VIDEO INTELLIGENCE SYSTEM (platform-specific quirks) and by the
RESEARCH PROTOCOL, which refreshes this file when it goes stale. Every claim
below carries a source and an access date. Where research did not turn up a
solid, sourced answer, the field says so explicitly rather than guessing —
do not fill those gaps from memory or plausible-sounding assumption.

Confidence note: fields sourced only from a single third-party blog/aggregator
(not from the platform's own docs) are marked as such inline. Treat those as
lower-confidence than fields confirmed on a first-party page.

---

## Veo 3

- Source: https://deepmind.google/models/veo/prompt-guide/ (official Google
  DeepMind prompt guide), accessed 2026-08-09
- Source: https://www.veo3ai.io/blog/veo-3-1-video-length-limit-max-duration-2026,
  accessed 2026-08-09 (duration/aspect-ratio specifics — not stated on the
  official prompt-guide page itself)
- Native audio/dialogue: Yes. The official guide instructs wrapping exact
  scripted lines in quotation marks and describing sound effects explicitly
  (e.g. "SFX: thunder cracks in the distance"), plus defining the ambient
  soundscape separately. Native audio synthesis (dialogue, SFX, music) is
  scored across the whole clip. A secondary source claims English dialogue
  quality is more reliable than other languages — not confirmed on the
  official page, needs verification.
- Max duration / aspect ratios: Single generation caps at 8 seconds (Veo 3.1
  standard and Fast), per the secondary source above — not stated on the
  official prompt-guide page. An "extend" workflow can chain clips to roughly
  148 seconds total (same secondary source). Aspect ratios: 16:9 and 9:16 are
  natively supported, with 9:16 composed directly rather than cropped from
  16:9 (same secondary source) — not confirmed on an official spec page.
- Prompt structure preference: Official guide favors flowing, integrated
  paragraphs that combine subject, context, action, camera, lighting, style,
  and audio into one description, rather than a rigid shot-by-shot list. For
  complex or fast action, the guide explicitly recommends "extreme detail" —
  mapping out exact play-by-plays.
- Quirks: Dialogue in quotation marks for exact wording; SFX benefits from
  explicit "SFX:" labeling; describe ambient soundscape as its own element,
  separate from dialogue/SFX cues.
- Last verified: 2026-08-09

---

## Kling

- Source: https://kling.ai/quickstart/text-to-video-prompt-guide (official
  Kling AI prompt guide). Direct fetch from this environment returned HTTP
  446 (blocked); content below is drawn from the WebSearch index of this
  page, cross-checked against the secondary source below where they agree.
  Accessed 2026-08-09.
- Source: https://www.atlascloud.ai/blog/guides/kling-ai-video-prompt-guide,
  accessed 2026-08-09
- Source: https://www.pixara.ai/blogs/Kling-ai-maximum-video-length-2026,
  accessed 2026-08-09 (duration)
- Source: https://kie.ai/kling-2-6, accessed 2026-08-09 (native audio, Kling 2.6)
- Native audio/dialogue: Yes for Kling 2.6 — described as "on par with Sora 2
  and Veo 3.1"; Kling 2.6 Pro adds stronger dialogue/scene-level audio
  control. Not confirmed for earlier Kling versions (1.x/2.0) — not confirmed,
  needs verification if targeting those.
- Max duration / aspect ratios: Single generation is 5 or 10 seconds (5s
  default); chained extensions cap around 3 minutes total, per the
  third-party sources above (not confirmed on an official spec page).
  Aspect ratios (Kling 2.6): 16:9, 9:16, 1:1. Resolution up to 1080p at 48fps
  on 2.6; Kling 3.0 is reported at up to 4K/60fps by a third-party source —
  not confirmed on an official spec page, needs verification.
- Prompt structure preference: Official formula is Subject (+ Subject
  Description) + Subject Movement + Scene Description + Camera Language +
  Lighting/Atmosphere. Guidance favors a tight 60-100 word prompt over a
  maxed-out wall of descriptors; the API hard-caps the prompt field and the
  negative-prompt field at 2,500 characters each (separate fields). For
  multi-shot sequences (Kling 3.0), the guide recommends explicitly labeling
  and describing each shot rather than compressing everything into one
  paragraph.
- Quirks: Vague camera terms ("cinematic movement") are called out as the top
  cause of inconsistent output — use explicit terms like "slow dolly-in"
  instead. Negative prompt is a separate field, not appended text.
- Last verified: 2026-08-09

---

## Runway (Gen-4 / Gen-4.5)

- Source: https://academy.runwayml.com/guides/prompting-guide (official
  Runway Academy prompting guide), accessed 2026-08-09
- Source: https://help.runwayml.com/hc/en-us/articles/39789879462419-Gen-4-Video-Prompting-Guide
  (official Runway help center; direct fetch from this environment returned
  HTTP 403, content below drawn from the WebSearch index of this page),
  accessed 2026-08-09
- Source: https://runway.com/research/introducing-runway-gen-4.5 (official
  Runway research announcement, fetched directly), accessed 2026-08-09 —
  page is dated December 1, 2025 and covers only visual capabilities
  (motion quality, prompt adherence, fidelity); it does not mention audio or
  state a duration limit
- Source: https://techcrunch.com/2025/12/11/runway-releases-its-first-world-model-adds-native-audio-to-latest-video-model/
  (news, fetched directly), accessed 2026-08-09 — published December 11,
  2025; quotes Runway describing an update to "its foundational Gen 4.5
  model released earlier in the month" that "brings native audio and
  long-form, multi-shot generation capabilities"
- Native audio/dialogue: Yes, but only from Gen-4.5 onward, added in a
  post-launch update, not in the December 1, 2025 base release (confirmed:
  the official runway.com Gen-4.5 announcement, dated Dec 1 2025, says
  nothing about audio). The exact date of the audio update itself is NOT
  stated anywhere found — TechCrunch's article reporting it is dated
  December 11, 2025 and calls it an update to the model "released earlier in
  the month," but that phrase describes the Dec 1 base release, not the
  audio update's own ship date. Correction from an earlier draft of this
  file: do not read "December 11, 2025" as the confirmed audio-launch date —
  that was this file's own error, not something either source states. Best
  supportable statement: native audio arrived some time between the Dec 1,
  2025 Gen-4.5 launch and the Dec 11, 2025 TechCrunch report — not confirmed
  to a specific day. Gen-4 (pre-4.5) had no native audio. Confirm which model
  name is in play before assuming audio support.
- Max duration / aspect ratios: Two different things are being reported, not
  necessarily a contradiction: (1) individual generations/shots are 5-10
  seconds per clip, per the official Gen-4 help-center guide; (2) Gen-4.5
  adds a multi-shot mode that TechCrunch (quoting Runway) says can assemble
  shots into "one-minute videos with character consistency, native dialogue,
  background audio, and complex shots from various angles." Neither the
  per-shot figure nor the one-minute multi-shot figure is stated on an
  official Runway spec/docs page (the runway.com announcement gives no
  duration numbers at all) — treat both as not confirmed, needs
  verification, and do not assume a single generation can exceed ~10 seconds
  without multi-shot stitching. A reported aspect-ratio list (16:9, 9:16,
  1:1, 4:3, 3:4, 21:9) is from secondary sources only — not confirmed via
  official docs, needs verification.
- Prompt structure preference: Official guidance favors clear, plain-language
  full sentences over rigid structure — "prompts do not need to follow a
  specific structure... full sentences are recommended." Suggested
  templates: Text-to-video: "[Camera] shot of [a subject/object] [action] in
  [environment]." Image-to-video: "The camera [motion description] as the
  subject [action]." For shot-by-shot work: start with one action per prompt
  (e.g. "Woman walks to door" rather than chaining multiple actions), and
  lead with shot type/camera info first so the model frames the rest
  correctly.
- Quirks: Negative prompts are NOT supported for Gen-4 Image and can produce
  the opposite of the intended effect if used. Conversational/chatty prompt
  phrasing adds no value and can hurt results. Input images carrying existing
  motion cues (blur, mid-action pose) can fight the text prompt.
- Last verified: 2026-08-09

---

## Pika

No official first-party documentation page (a `docs.pika.art` site or a
dedicated help-center prompting guide) was located and confirmed reachable in
this research pass. Everything below comes from third-party guides and
aggregator sites, cross-checked against each other for agreement — treat
these claims as lower-confidence than the Veo/Kling/Runway/Luma entries above
and below, which have at least one first-party source.

- Source: https://pikalabsai.org/pika-labs-prompting-guide/, accessed 2026-08-09
- Source: https://fal.ai/models/fal-ai/pika/v2.2/text-to-video, accessed 2026-08-09
- Source: https://maxvideoai.com/models/pika-text-to-video, accessed 2026-08-09
- Source: https://pika-labs.org/faq/, accessed 2026-08-09
- Native audio/dialogue: No. Pika 2.2 outputs silent clips with no native
  audio or voice support, per the fal.ai model listing and maxvideoai.com.
  Not confirmed on a first-party Pika page.
- Max duration / aspect ratios: 5-10 seconds per generation (10s max), per
  fal.ai and maxvideoai.com. Aspect ratios: 16:9, 9:16, 1:1, 4:5, 5:4, 3:2,
  2:3 (seven total), per third-party sources. Resolution: up to 1080p on
  paid tiers (2.2), 480p on the free tier; Pika 2.1 reportedly capped at
  720p. None of this is confirmed on a first-party spec page.
- Prompt structure preference: Not confirmed, needs verification — no
  first-party structural formula (comparable to Kling's Subject + Movement +
  Scene) was found. Third-party guides converge on: keep prompts short and
  action-specific (single subject, single action performs best), state
  camera movement explicitly ("slow zoom in," "pan left to right"), and
  tune the `-motion` parameter (0-4, default 1) and `-gs` prompt-adherence
  parameter (8-24, default 12). Given the lack of a first-party source, treat
  those parameter names and ranges as needing verification before relying on
  them in a generated prompt.
- Quirks: "Pikaffects" are one-click stylistic/meme effects requiring no
  prompting at all — a distinct workflow from standard text/image-to-video
  prompting. Multiple sources describe iterating/rephrasing across several
  generations as the normal workflow, not a sign of a bad prompt.
- Last verified: 2026-08-09

---

## Luma (Dream Machine / Ray)

- Source: https://docs.lumalabs.ai/docs/video-generation (official Luma API
  documentation), accessed 2026-08-09
- Source: https://lumalabs.ai/learning-center/articles/luma-video-models-field-guide
  (official Luma learning-center comparison article), accessed 2026-08-09
- Native audio/dialogue: No native audio in Ray3/Ray3.14, per the official
  field guide ("Ray3.14 gives up character reference and audio, and the
  absence of native audio remains a key limitation"). Sound effects can be
  added as a separate paid add-on rather than generated natively. Audio is
  not mentioned at all in the official API docs page.
- Max duration / aspect ratios: The official API docs list resolution
  options 540p/720p/1080p/4K and show 5s in examples but do not state a hard
  maximum duration. Per the official field guide: Ray3/Ray3.14 support up to
  roughly 18s per generation, extendable to ~30s via orchestration. A newer
  Ray 3.2 figure of up to 20s at 1080p comes from a secondary source
  (ray3.co) and is not confirmed on lumalabs.ai — needs verification.
  Aspect ratios per the official field guide: 9:16, 3:4, 1:1, 4:3, 16:9,
  21:9 (six options).
- Prompt structure preference: Official field guide recommends the template
  "Create a video of [SUBJECT] [MID-ACTION VERB] in [SETTING], [SECONDARY
  MOTION/CONSEQUENCE], [CAMERA MOVEMENT if any], [LIGHTING/MOOD]." Use
  present-tense action verbs ("running," not "begins to run"), include
  secondary consequences (wind in hair, dust, reflections), default to a
  cinematic style unless told otherwise, and keep prompts to roughly 100
  words. For keyframe-based edits, describe only what changes rather than
  re-describing the whole static scene.
- Quirks: Ray models are described as "positive only" — negative prompting
  reportedly backfires and should be avoided. Avoid vague intensifiers like
  "vibrant," "whimsical," "hyper-realistic," which are reported to degrade
  output. Camera movement is controlled through prompt text rather than
  structured parameters, though the API exposes a camera-motion list
  endpoint for discovering supported motion strings.
- Last verified: 2026-08-09
