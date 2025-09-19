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

## Pull request guidelines
- Format PR descriptions to match `.github/pull_request_template.md`. Populate each section in order and keep all
  headings visible, even if the status is "No" or "Not applicable."
- In the **Summary** section, provide a concise description of the change and the problem it solves.
- Use the **Related Work** checklist to reference the relevant Epic(s), Story(ies), Task(s), and ADR(s); if an item does
  not apply, explicitly state `N/A` after the checklist entry.
- Set the appropriate option in **Architecture Impact** and briefly summarize any changes when the answer is "Yes."
- Check only the boxes that reflect work completed in **Tests & Quality Gates**, **Observability & Ops**, and the
  **Checklist**. Include short clarifications where helpful.
- Ensure the PR message you create with `make_pr` mirrors the completed template so reviewers can copy it directly into
  GitHub.

## Markdown Style
- Use sentence case for headings and keep line length under 120 characters where practical.
- Prefer unordered lists for checklists and ordered lists only when sequence matters.
- Surround placeholders with angle brackets (e.g., `<placeholder>`).

## Testing
- This repository currently has no automated test suites. If you add executable code, include appropriate tests and document how to run them.
