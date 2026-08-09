#!/bin/bash
set -e
DEST="$HOME/.claude/skills/prompt-king/SKILL.md"
cp SKILL.md "$DEST"
echo "Synced to $DEST"
