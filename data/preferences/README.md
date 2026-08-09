# data/preferences/

Per-user preference walls. One file per user: `data/preferences/{username}.md`.
Each file is readable/writable only by its own user's sessions; the
self-improvement engine never promotes a preference into a global rule without
explicit human approval.

Format: free-form Markdown capturing the user's stated preferences (styles,
platforms, tones they favor), with a last-updated date.
