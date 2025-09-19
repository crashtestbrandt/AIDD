---
name: "Task"
description: "Per-prompt unit of work or small developer action supporting a Story."
title: "[Task] <Actionable verb + object>"
labels: ["type: task"]
assignees: []
---

## Story Link
Parent Story: #<StoryID>

## Objective
What this Task achieves toward the Story.

## Steps (as applicable)
- [ ] Update/define contracts (OpenAPI/Proto/GraphQL SDL)
- [ ] Write acceptance tests (ATDD/BDD) and unit/property tests
- [ ] Implement code changes against tests
- [ ] Add/adjust metrics, logs, traces
- [ ] Update documentation/runbook

## Outputs
- PR: #<PR-ID>
- File(s): <path>
- Tests: <path to test suites>

## Traceability
Map to Story acceptance criteria and ADRs touched.

## Definition of Done (Task)
- [ ] Tests written and passing locally/CI
- [ ] Changes linked to Story; references ADRs if applicable
- [ ] Code reviewed/approved or attached to PR
