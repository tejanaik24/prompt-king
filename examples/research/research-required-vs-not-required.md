# Example: Research Sourcing Senerios

This example demonstrates how Prompt King distinguishes between requests requiring live platform research and those utilizing built-in capabilities.

---

## Scenario A: Research NOT Required
*   **User request**: "Create a minimalist poster prompt."
*   **Prompt King analysis**: No specific platforms or trending tools are mentioned. Sourcing external databases is unnecessary.
*   **Result**: Skip research. Goes straight to the direct generation path to build a general minimalist poster prompt.

---

## Scenario B: Research Required
*   **User request**: "Need a Veo 3 ad prompt for a coffee brand, trending style."
*   **Prompt King analysis**: Mentions a specific named platform ("Veo 3") and "trending style". This triggers the research pipeline.
*   **Action**: Runs `search_web` for the latest platform facts, aspect ratios, and durations for Veo 3.
*   **Result**: Compiles a prompt leveraging verified Veo 3 parameters (e.g. 1080p, 5-second duration defaults) while citing its sources.
