# ai-devops
Resources for AI-driven development operations

## AI-Driven Development Pipeline

### Concepts

* **Feature Epic**
  A production-ready feature composed of multiple stories. Anchors architecture, ADRs, and traceability. Lives across multiple sprints if needed.

* **Story**
  A PR-sized unit of work. Represents a coherent slice of functionality (often vertical: UI → API → DB). Carries acceptance criteria, tests, and contracts.

* **Task**
  A per-prompt unit of work. Represents one or a few changes or tool runs that move a story forward (e.g., generating a contract, writing unit tests, updating a migration script). Multiple tasks roll into a story.

This aligns with Scrum/Agile usage: Epics group Stories, Stories decompose into Tasks. The twist is AI-driven “per-prompt” tasks.

### Pipeline Overview

**For each Feature Epic**

* **Architecture Overview + ADRs**

  * Produce a high-level C4 (Context/Container/Component).
  * Record an ADR per significant architectural choice.
  * Establish architecture conformance & traceability (link to ADR IDs, C4 elements touched).

* **Implementation Plan (story-level)**

  * Generate an incremental, risk-first plan consisting of multiple **Stories**.
  * Each Story must show how it aligns with the Epic’s architecture and objectives.

**For each Story**

* **Story Plan**

  * Define scope, acceptance criteria, and test strategy.
  * Specify contracts (OpenAPI/Protobuf/GraphQL SDL), SLAs/SLOs, and observability signals.
  * Break work into **Tasks**.

**For each Task**

* **Task Execution**

  * Start contract-first (API/interface updates).
  * Write acceptance tests (ATDD/BDD optional) and unit/property tests before implementation.
  * Implement against those tests, using AI prompts/tools as needed.
  * Tasks are traceable back to Story acceptance criteria and Feature Epic ADRs.

### Templates

See [Templates](./TEMPLATES.md).

