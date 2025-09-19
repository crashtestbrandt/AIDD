---
id: STORY-BT-001
status: planned
epic: EPIC-BT-001
task_ids:
  - TASK-BT-001
---

**Title:** Bootstrap prompts
**Epic Link:** [EPIC-BT-001](../feature-epics/bootstrap-tooling.md)
**Summary:** Capture AIDD bootstrap prompts inside the README to guide new and existing projects.

## Scope

* In scope: Documenting bootstrap prompts in the README; ensuring wording remains verbatim per requirements.
* Out of scope: Authoring new templates, modifying existing gates, or altering repository automation.

## Acceptance Criteria

* The README includes a "Bootstrap" section with subsections for fresh and existing projects.
* Each subsection embeds the provided prompt text verbatim, including formatting and bullet structure.
* The Story is traceable back to the Feature Epic and associated Task.

## Contracts

* Not applicable. No API or interface contracts change for documentation updates.

## Test Strategy

* Peer review for formatting accuracy and adherence to verbatim prompt text.
* Markdown linting or preview (manual) to verify headings render correctly.
* Ensure repository guidance links remain valid.

## Observability

* Not applicable. No runtime telemetry changes are introduced.

## Tasks

* [ ] [TASK-BT-001](../tasks/add-bootstrap-prompts-to-readme.md) — Add Bootstrap prompts to README

## Definition of Done

* Acceptance criteria validated via review of the rendered README.
* Documentation updates merged with all required checks passing.
* Traceability confirmed between Epic, Story, and Task metadata.
* Stakeholders notified that bootstrap prompts are available in canonical documentation.
