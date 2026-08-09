# Example: Book Cover Prompt

This example demonstrates Prompt King's compilation of a genre-appropriate book cover, allocating clean negative space for typography.

## User Request
> "Book cover for a mystery thriller set in an isolated lighthouse."

---

## Compiled Prompt King Output

### 1. SELECTED VISUAL TYPE
Book Cover — Front Jacket Illustration (`BOOK_COVER` + `THRILLER_FRAME`)

### 2. PURPOSE
Cover art for a physical or digital thriller novel, designed to create a high-impact focal point, evoke mystery and dread, and leave clean negative space for text layout.

### 3. SELECTED COMMANDS
`151 BOOK_COVER`, `093 THRILLER_FRAME`, `086 MOODY_CINEMATIC`, `073 NEGATIVE_SPACE`, `236 CHIAROSCURO`, `271 REAL_PAPER_TEXTURE`, `2:3`

### 4. FINAL PRODUCTION PROMPT

```text
Create a front book cover visual for a mystery thriller novel.

Subject:
A solitary lighthouse standing tall on a jagged, dark cliff edge. A single beam of light pierces from the top lantern room through thick, swirling sea fog. At the base of the cliff, turbulent waves crash into white foam against the rocks.

Visual language:
Cinematic film still, moody thriller aesthetic, heavy chiaroscuro contrast, atmospheric fog, fine film grain.

Composition:
Asymmetrical composition with the lighthouse positioned on the right third of the frame. The left side is dominated by dark, atmospheric sea mist and sky, creating extensive negative space for title typography.

Camera:
Low angle looking up to emphasize the height and isolation of the lighthouse, 35mm lens, sharp focus on the lighthouse structure with soft falloff in the dark misty foreground.

Lighting:
High-contrast chiaroscuro lighting; the single brilliant beam of light contrasts sharply against the deep, midnight-blue sky and the dark shadow of the cliff.

Materials:
Subtle matte paper texture, rough stone cliff surface, frothy water spray, fine grain.

Typography:
N/A (Composition is pre-arranged to allocate dark negative space in the upper 40% of the frame for display title text, and at the bottom 15% for author name).

Environment:
Isolated coastal cliff at midnight, surrounded by turbulent ocean waves and dense, damp fog.

Realism:
Physically plausible light attenuation in the fog, natural lens flare from the lantern room, organic wave shapes, no default digital glow.

Mood:
Tense, mysterious, claustrophobic, ominous.

Aspect ratio:
2:3
```

### 5. ASPECT RATIO
2:3 (Standard book cover print layout)

### 6. OPTIONAL NEGATIVE / AVOID LIST
*Generated via Negative Prompt Intelligence Engine (Negative base: `NEG-V1`)*
```text
Avoid: garbled text, misspelled words, gibberish lettering, placeholder text, lorem ipsum, distorted anatomy, generic AI art look, default glossy digital render, hyper-saturated neon colors, heavy lens flare overload, airbrushed plastic skin, cluttered composition, cropped subject at frame boundaries, missing print safe margins, 3D cartoon style.
```
