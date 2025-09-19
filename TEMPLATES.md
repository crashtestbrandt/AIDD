# TEMPLATES

Each template is designed to double as a GitHub issue template, Jira issue format, Notion page, etc., providing:

* **Traceability** (Epic → Story → Task → ADR/tests)
* **Quality gates baked in** (tests, contracts, observability, rollback)
* **AI-first fit** (Task is per-prompt unit of work, but still traceable)

---

* [Home](./README.md)

---

# 🟣 Feature Epic Template

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

---

# 🔵 Story Template

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

---

# 🟢 Task Template

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

