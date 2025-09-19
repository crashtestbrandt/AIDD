---
name: "Story"
description: "PR-sized slice of functionality that delivers user value."
title: "[Story] <Outcome-oriented title>"
labels: ["type: story"]
assignees: []
about: "A PR-sized unit of work. Represents a coherent slice of functionality (often vertical: UI → API → DB). Carries acceptance criteria, tests, and contracts."
---

## Summary
Brief description of the user or system behavior.

## Acceptance Criteria
- [ ] Given/When/Then #1
- [ ] Given/When/Then #2

## Contracts & Compatibility
- Contract delta(s): <OpenAPI/GraphQL/Protobuf path and version>
- Versioning & deprecation plan: <strategy>

## Test Strategy
- Unit tests: <scope>
- Property tests (if applicable): <scope>
- Contract tests: <scope>
- Integration slice tests: <scope>
- AI evals (if applicable): <scope>

## Observability
- Metrics: name, labels, cardinality budget
- Logs: event names, structure, retention
- Traces: spans/instrumentation updates

## Tasks
- [ ] Task placeholder (link to task issue)

## Definition of Ready (DoR)
- [ ] Acceptance criteria defined
- [ ] Contracts drafted and reviewed
- [ ] Test strategy approved
- [ ] Observability plan documented

## Definition of Done (DoD)
- [ ] All tasks complete and traceable
- [ ] Tests added/updated and passing
- [ ] Observability assets deployed
- [ ] Docs/runbooks updated
- [ ] Feature flag in place with rollback plan
