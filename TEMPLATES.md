<!-- ./TEMPLATES.md -->

# TEMPLATES

Objectives:

* **Traceability** (Epic → Story → Task → ADR/tests)
* **Quality gates baked in** (tests, contracts, observability, rollback)
* **AI-first fit** (Task is per-prompt unit of work, but still traceable)

---

* [Home](./README.md)
* [Architecture Decision Record (ADR)](#architecture-decision-record-adr)
* [Feature Epic Template](#feature-epic-template)
* [Story Template](#story-template)
* [Task Template](#task-template)
* [Pull Request Template](#pull-request-template)

---

# Architecture Decision Record (ADR)

## Title
A short, descriptive title (e.g., "Use GraphQL for API contracts").

## Status
Proposed | Accepted | Deprecated | Superseded by ADR-XXX

## Context
What problem are we trying to solve?  
What constraints or forces are shaping the decision?  
What’s the background (e.g., related epics, stories, or incidents)?  

## Decision
The decision we made, in full sentences.  
(Include diagrams, snippets, or contracts if relevant.)

## Rationale
Why this decision?  
What alternatives were considered, and why not chosen?  
What tradeoffs or risks are we accepting?

## Consequences
* Positive outcomes (what this enables, simplifications).  
* Negative outcomes (new risks, added complexity, migration costs).  
* Future considerations (when might this decision be revisited?).  

## References
* Links to related ADRs, epics, stories, contracts.  
* External references (RFCs, docs, benchmarks).  

---

# Feature Epic Template

**Title:** `<Feature Epic Name>`
**Summary:** Brief description of the production-ready feature.

## Architecture Overview

* C4 Model links (Context/Container/Component)
* ADR references (with IDs)
* Architecture conformance notes

## Objectives

* Business/technical goals
* SLOs/SLAs (latency, availability, cost, safety)
* Risk considerations

## Stories

* List of Stories (with links/IDs)
* Traceability: each Story links back to relevant ADRs and this Epic

## Definition of Done (DoD)

* All Stories complete, merged behind feature flag
* Tests pass at all levels (unit, integration, contract, AI eval if relevant)
* SLOs validated in CI/perf tests
* Docs, runbooks, and monitoring updated
* Rollback/feature flag in place

## GitHub Issue Template - Feature Epic

```yaml
name: "Feature Epic"
description: "Production-ready feature composed of multiple Stories."
title: "[Epic] <Feature name>"
labels: ["type: epic"]
assignees: []
body:
  - type: input
    id: summary
    attributes:
      label: Summary
      description: One or two sentences describing the feature.
      placeholder: "Deliver X so that Y can Z."
    validations:
      required: true

  - type: textarea
    id: architecture_overview
    attributes:
      label: Architecture Overview (C4/ADRs)
      description: Link Context/Container/Component diagrams and relevant ADRs.
      placeholder: |
        - C4 Context: <link>
        - C4 Container: <link>
        - C4 Component: <link>
        - ADRs: ADR-001, ADR-002
    validations:
      required: true

  - type: textarea
    id: conformance
    attributes:
      label: Architecture Conformance & Traceability
      description: Explain how this Epic aligns with ADRs and architecture. Include IDs/links.
      placeholder: "Touches ADR-003 and ADR-004; aligns with Component A and Service B."
    validations:
      required: true

  - type: textarea
    id: objectives
    attributes:
      label: Objectives & Success Criteria
      description: Business/technical goals; include SLOs/SLAs and cost/safety targets.
      placeholder: |
        - SLO: p95 latency ≤ 200ms
        - Availability: 99.9%
        - Cost: ≤ $X/1k requests
        - Safety: no PII disclosure in outputs
    validations:
      required: true

  - type: textarea
    id: risks
    attributes:
      label: Risks & Mitigations (risk-first)
      description: Key risks, mitigations, and rollback strategy.
      placeholder: |
        - Risk: schema break → Mitigation: contract tests + deprecation window
        - Rollback: disable feature flag `feature.foo`
    validations:
      required: false

  - type: textarea
    id: stories
    attributes:
      label: Stories (to be created/linked)
      description: List Story issues or planned Story titles. Use checklist for tracking.
      value: |
        - [ ] #<StoryID-or-placeholder> — <title>
        - [ ] #<StoryID-or-placeholder> — <title>
        - [ ] #<StoryID-or-placeholder> — <title>
    validations:
      required: true

  - type: checkboxes
    id: dod
    attributes:
      label: Definition of Done (Epic)
      description: All must be satisfied to close the Epic.
      options:
        - label: All Stories merged behind a feature flag with rollback plan
          required: true
        - label: Tests pass at all levels (unit, integration, contract, perf, security; AI eval if applicable)
          required: true
        - label: SLOs validated (no regression vs. budget)
          required: true
        - label: Observability (metrics/logs/traces) and alerts/dashboards in place
          required: true
        - label: Docs & runbooks updated; ADRs added/updated as needed
          required: true
```

---

# Story Template

**Title:** `<Story Name>`
**Epic Link:** `<Feature Epic ID/Link>`
**Summary:** Concise description of PR-sized functionality.

## Scope

* What’s included
* What’s explicitly out of scope

## Acceptance Criteria

* Gherkin (Given/When/Then) optional
* Concrete observable behavior (tests should assert these)

## Contracts

* OpenAPI/Protobuf/GraphQL SDL updates
* Consumer-driven contract tests (if applicable)

## Test Strategy

* Unit & property-based tests
* Integration slice tests
* Contract tests
* Performance budgets
* Security/abuse cases

## Observability

* Metrics, logs, traces to be emitted
* Alert thresholds, dashboards

## Tasks

* List of implementation Tasks (link each)

## Definition of Done

* All acceptance criteria validated by tests
* Contracts versioned & backward-compatible
* Observability signals in place
* Documentation updated
* Code merged via PR with quality gates passing

## GitHub Issue Template - Story

```yaml
name: "Story"
description: "PR-sized unit of work delivering a vertical slice."
title: "[Story] <Concise description>"
labels: ["type: story"]
assignees: []
body:
  - type: input
    id: epic_link
    attributes:
      label: Epic Link
      description: Link to the parent Feature Epic.
      placeholder: "#<EpicID>"
    validations:
      required: true

  - type: textarea
    id: summary
    attributes:
      label: Summary & Scope
      description: What this Story delivers. Add an explicit out-of-scope list.
      placeholder: |
        In scope:
        - …
        Out of scope:
        - …
    validations:
      required: true

  - type: textarea
    id: acceptance
    attributes:
      label: Acceptance Criteria (ATDD/BDD optional)
      description: Concrete, testable criteria. Gherkin welcome.
      placeholder: |
        - Given …
          When …
          Then …
        - …
    validations:
      required: true

  - type: textarea
    id: contracts
    attributes:
      label: Contracts (API/IPC)
      description: OpenAPI/Protobuf/GraphQL SDL changes; versioning & deprecation policy; consumer-driven contracts.
      placeholder: |
        - OpenAPI: /v1/foo add field `bar` (backward compatible)
        - CDCs: pact between Service A (consumer) and Service B (provider)
    validations:
      required: false

  - type: textarea
    id: test_strategy
    attributes:
      label: Test Strategy
      description: Enumerate tests to add/update.
      value: |
        - Unit & property-based tests
        - Contract tests (provider/consumer)
        - Integration slice (service + datastore + 1 dependency)
        - Performance budget checks
        - Security/abuse cases (authZ/validation; secrets scan baseline)
        - AI evals (if applicable): factuality, safety, cost/latency
    validations:
      required: true

  - type: textarea
    id: observability
    attributes:
      label: Observability Spec
      description: Metrics, logs, traces; cardinality guardrails; dashboards/alerts to update.
      placeholder: |
        - Metric: app.request.duration (histogram), p95 budget 200ms
        - Log: structured error with `error_code`
        - Trace: span names <namespace>/<operation>
    validations:
      required: true

  - type: textarea
    id: tasks
    attributes:
      label: Tasks
      description: Link per-prompt Tasks. Use checklist.
      value: |
        - [ ] #<TaskID-or-placeholder> — Define contract deltas
        - [ ] #<TaskID-or-placeholder> — Write acceptance tests
        - [ ] #<TaskID-or-placeholder> — Implement against tests
        - [ ] #<TaskID-or-placeholder> — Add metrics/logs/traces
        - [ ] #<TaskID-or-placeholder> — Update docs/runbook
    validations:
      required: true

  - type: checkboxes
    id: dod
    attributes:
      label: Definition of Done (Story)
      options:
        - label: Acceptance criteria verified by automated tests
          required: true
        - label: Contracts versioned & backward compatible (CDC/compat checks pass)
          required: true
        - label: Observability signals implemented and documented
          required: true
        - label: Security/SCA/SAST/secrets checks pass; perf within budget
          required: true
        - label: Docs updated; PR merged with all quality gates green
          required: true
```

---

# Task Template

**Title:** `<Task Name>`
**Story Link:** `<Story ID/Link>`
**Summary:** Smallest unit of work, ideally one AI prompt/tool run or developer action.

## Objective

* What this Task achieves in relation to the Story

## Steps

* Contract updates (if any)
* Tests to be authored (unit, property, ATDD/BDD)
* Implementation actions (code, infra, docs, AI-generated artifacts)

## Outputs

* Code/contract changes (link to PR/commit)
* Test artifacts (files, cases)
* Any generated documentation

## Traceability

* Link to Story acceptance criteria this Task supports
* Link to ADRs if architectural decisions are touched

## Definition of Done

* Test(s) written & passing
* Code reviewed/approved
* Artifacts committed & linked back to Story

## GitHub Issue Template - Task

```yaml
name: "Task"
description: "Per-prompt unit of work or small developer action supporting a Story."
title: "[Task] <Actionable verb + object>"
labels: ["type: task"]
assignees: []
body:
  - type: input
    id: story_link
    attributes:
      label: Story Link
      description: Link to the parent Story.
      placeholder: "#<StoryID>"
    validations:
      required: true

  - type: textarea
    id: objective
    attributes:
      label: Objective
      description: What this Task achieves toward the Story.
      placeholder: "Generate OpenAPI delta + scaffolding tests for /v1/foo"
    validations:
      required: true

  - type: checkboxes
    id: steps
    attributes:
      label: Steps (as applicable)
      options:
        - label: Update/define contracts (OpenAPI/Proto/GraphQL SDL)
        - label: Write acceptance tests (ATDD/BDD) and unit/property tests
        - label: Implement code changes against tests
        - label: Add/adjust metrics, logs, traces
        - label: Update documentation/runbook

  - type: textarea
    id: outputs
    attributes:
      label: Outputs
      description: PR/commit links, generated files, test artifacts.
      placeholder: |
        - PR: #1234
        - File: openapi/foo.yaml
        - Tests: tests/foo_spec.py
    validations:
      required: true

  - type: textarea
    id: traceability
    attributes:
      label: Traceability
      description: Map to Story acceptance criteria and any ADRs touched.
      placeholder: "- Supports AC-2 and AC-3; references ADR-005"
    validations:
      required: false

  - type: checkboxes
    id: dod
    attributes:
      label: Definition of Done (Task)
      options:
        - label: Tests written and passing locally/CI
          required: true
        - label: Changes linked to Story; references ADRs if applicable
          required: true
        - label: Code reviewed/approved or attached to PR
          required: true
```

---

# Pull Request Template

## Summary
<!-- High-level description of the change. What problem does it solve? -->

## Related Work
- **Feature Epic(s):** #EPIC-ID
- **Story(ies):** #STORY-ID
- **Task(s):** #TASK-ID
- **ADR(s):** [ADR-###](./docs/adr/ADR-###-title.md)

## Architecture Impact
<!-- Does this PR introduce or modify architecture? -->
- [ ] No architectural changes
- [ ] Yes, ADR(s) linked above

If "Yes," summarize:
- **Contracts/Interfaces Changed:**  
- **Persistence/Infra Changes:**  
- **New Dependencies:**  

## Tests & Quality Gates
- [ ] Unit tests added/updated  
- [ ] Property/contract tests added/updated  
- [ ] Integration tests added/updated  
- [ ] AI evals run (if applicable)  
- [ ] Coverage ≥ target  
- [ ] Mutation score ≥ target  

## Observability & Ops
- [ ] Metrics/logs/traces updated  
- [ ] Alerts/dashboards updated  
- [ ] Runbooks updated  

## Checklist
- [ ] Code follows style guidelines  
- [ ] Docs updated (README, ADRs, etc.)  
- [ ] Feature behind a flag  
- [ ] Rollback plan documented  



