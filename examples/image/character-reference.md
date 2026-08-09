# Example: Character Reference Prompt

This example shows how Prompt King defines character details and clothing textures while maintaining a consistent visual identity.

## User Request
> "Character design sheet for a cyberpunk hacker named Jax. Needs to show face and clothing detail clearly."

---

## Compiled Prompt King Output

### 1. SELECTED VISUAL TYPE
Character Design Sheet — Cyberpunk Character Visual (`CHARACTER_DESIGN` + `REALISTIC_CHARACTER_CONCEPT`)

### 2. PURPOSE
Production art and reference visual for a cyberpunk character pipeline, designed to clearly show facial structure, costume materials, and key tech details.

### 3. SELECTED COMMANDS
`2037 CHARACTER_DESIGN`, `2047 REALISTIC_CHARACTER_CONCEPT`, `063 EYE_LEVEL`, `074 CENTERED_COMPOSITION`, `4:5`

### 4. FINAL PRODUCTION PROMPT

```text
Create a character design sheet for a cyberpunk hacker.

Subject:
A three-quarters portrait of a young man named Jax in his late 20s. He has a shaved head with subtle dark stubble, a small cybernetic implant along his left temple, and focuses a sharp, calm gaze forward. He wears a high-collar jacket made of matte black tech-wear fabric with dark green stitched seam piping.

Visual language:
Character concept art, realistic character illustration, detailed tech-wear style, high visual clarity.

Composition:
Centered composition, medium closeup shot focusing on the character's upper torso and face. Clean, plain dark gray background to isolate the character silhouette.

Camera:
Eye-level perspective, shot on a 50mm lens equivalent, sharp focus on facial features and jacket textures, soft depth of field falloff in the background.

Lighting:
Key light coming from a side-angle, simulating a soft green computer monitor glow reflecting on the left side of his face and shoulder, with a neutral white fill light from the right.

Materials:
Matte synthetic tech-wear fabric, carbon-fiber textured shoulder plates, polished metal and polymer cybernetic temple implant, natural human skin texture with pores and minor scars.

Environment:
Minimalist studio gray background with zero environmental clutter.

Realism:
Believable human anatomy and facial proportions, realistic skin textures, physically plausible light reflections on metal and fabric surfaces, no plastic airbrushed skin.

Mood:
Focused, silent, tech-oriented, stoic.

Aspect ratio:
4:5
```

### 5. ASPECT RATIO
4:5 (Standard portrait character sheet format)

### 6. OPTIONAL NEGATIVE / AVOID LIST
*Generated via Negative Prompt Intelligence Engine (Negative base: `NEG-V1`)*
```text
Avoid: fused fingers, deformed hands, broken wrists, distorted face, melted face, asymmetric eyes, dead eyes, porcelain skin, uncanny face, over-saturated neon glows, generic 3D CGI look, default digital art style, airbrushed textures, cropped head, floating background elements.
```
