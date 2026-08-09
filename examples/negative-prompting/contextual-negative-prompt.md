# Example: Contextual Negative Prompting

This example demonstrates how Prompt King's Negative Prompt Intelligence Engine generates specific, content-type-matched avoid lists rather than generic low-quality tails.

---

## Scenario A: Book Cover Deliverable
*   **User request**: "Front cover for a historical fiction novel."
*   **Prompt King analysis**: A book cover's primary failure modes are garbled text, misplaced/distorted figures, and lack of print margins.
*   **Generated Avoid List**:
    ```text
    Avoid: garbled text, misspelled words, gibberish letters, placeholder text, lorem ipsum, distorted face, extra limbs, warped anatomy, cropped subject at frame boundaries, missing print safe margins, 3D cartoon style, generic AI art look. (Negative base: NEG-V1)
    ```

---

## Scenario B: Commercial Product Shot Deliverable
*   **User request**: "Skincare bottle product photo."
*   **Prompt King analysis**: Product photography failure modes are cheap plastic look, reflection/glare errors, warped text, or floating bottles.
*   **Generated Avoid List**:
    ```text
    Avoid: cheap plastic sheen, warped bottle geometry, asymmetrical cap, crooked label, garbled text on label, blown-out highlights, harsh glare, lens flare overload, floating bottle without support, messy cluttered background. (Negative base: NEG-V1)
    ```

---

## Scenario C: Minimalist Poster with Conflict
*   **User request**: "A minimalist poster for a coffee shop. Give me a soft lighting, plain background. For the avoid list, make sure to include: harsh shadows and busy background."
*   **Prompt King analysis**: The requested negative terms "harsh shadows" and "busy background" align with the positive directions ("soft lighting", "plain background"). The engine runs its `CONFLICT CHECK` and safely includes them.
*   **Generated Avoid List**:
    ```text
    Avoid: harsh shadows, busy background, generic AI art look, default digital art style, glossy render look, stock photo look, lens flare overload, over-saturated colors, cropped subject, cut-off edges. (Negative base: NEG-V1)
    ```
