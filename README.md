# Prompt King

Turn "I need a cover for my book" into a production-ready image or video
prompt — content type, visual style, composition, camera language, and
format all chosen for the audience, platform, and purpose before you ever
hit generate.

## Use it

**Copy-paste anywhere:** grab [`prompt-king.md`](prompt-king.md) and paste it
in as a system/instruction prompt for any LLM with image or video generation
in mind. It's tool-agnostic — no Claude Code dependency.

**Claude Code skill:** clone this repo into your skills directory, or run the
sync script from inside the repo:

```bash
bash scripts/sync-to-claude.sh
```

This copies `SKILL.md` to `~/.claude/skills/prompt-king/SKILL.md`. Re-run it
any time you pull updates.

## What it does

Give it a one-line request. It figures out the content type, purpose,
format, visual style, composition, and camera/lighting language, then hands
back a structured, production-ready prompt — not a vague style suggestion.

**Example — one line in, full prompt out:**

> "I need a cover for my book about staying calm as a founder while your
> company is on fire."

becomes a fully specified `BOOK_FRONT_COVER` prompt with subject, visual
language, composition, camera, lighting, typography, aspect ratio, and an
avoid-list — see the full before/after in
[`examples/image-before-after.md`](examples/image-before-after.md).

There's a video equivalent too — a one-line product-video request turned into
a shot-by-shot, platform-specific prompt — in
[`examples/video-before-after.md`](examples/video-before-after.md).

## Reference

- [`reference/image-commands.md`](reference/image-commands.md) — index of the
  image command library's groups and systems, pointing into `SKILL.md`.
- [`reference/video-commands.md`](reference/video-commands.md) — index of the
  19-subsection video taxonomy.
- [`reference/platform-cheatsheets.md`](reference/platform-cheatsheets.md) —
  sourced, dated notes on Veo 3, Kling, Runway, Pika, and Luma.

`SKILL.md` is the single source of truth for the actual command vocabulary —
the reference files are pointers into it, not copies, so nothing drifts out
of sync.

## License

MIT — see [`LICENSE`](LICENSE).
