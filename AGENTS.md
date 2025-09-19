# Repository Agent Guidance

## Scope
These instructions apply to the entire repository unless a more specific `AGENTS.md` overrides them in a subdirectory.

## Contribution Guidelines
- Follow the AI-Driven Development (AIDD) workflow: keep Epics, Stories, Tasks, and ADRs in sync using the provided templates.
- When adding new artifacts, place them in the appropriate directory:
  - `docs/adr/` for ADRs (use `ADR-TEMPLATE.md` as the starting point).
  - `.github/ISSUE_TEMPLATE/` for issue templates.
  - `prompts/` for reusable prompts (version them semantically).
  - `contracts/` for source-of-truth interface definitions.
  - `infrastructure/` for infrastructure-as-code assets.
- Maintain traceability between Epics → Stories → Tasks → ADRs by referencing IDs in front-matter or checklists.

## Markdown Style
- Use sentence case for headings and keep line length under 120 characters where practical.
- Prefer unordered lists for checklists and ordered lists only when sequence matters.
- Surround placeholders with angle brackets (e.g., `<placeholder>`).

## Testing
- This repository currently has no automated test suites. If you add executable code, include appropriate tests and document how to run them.
