# TEMPLATES

Objectives:

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

---

Great — here’s a **PR template** designed to align perfectly with the Feature Epic → Story → Task hierarchy. It ensures every pull request is effectively a **Story artifact**: scoped, tested, traceable, and ready for audit.

You can drop this into `.github/pull_request_template.md` (or equivalent for GitLab/Bitbucket).

---

# 📥 Pull Request Template

**Title:** `[Story] <concise description>`
*Linked Story:* #`<Story ID>`
*Linked Epic:* #`<Epic ID>`

---

## 📌 Summary

* What does this PR implement?
* Why is it needed?
* Which acceptance criteria from the Story does it fulfill?

---

## 🗂️ Scope

* ✅ What’s included in this PR
* ❌ What’s explicitly out of scope (to avoid scope creep)

---

## 🔗 Traceability

* **ADR References:** (IDs/links to ADRs affected by this PR)
* **Contracts Updated:** (OpenAPI/Protobuf/GraphQL SDLs)
* **Tasks Completed:**

  * \#`<Task ID>`
  * \#`<Task ID>`

---

## ✅ Acceptance Criteria

*List the acceptance criteria being satisfied (copy from Story). Mark them as completed when implemented.*

* [ ] `<Criterion 1>`
* [ ] `<Criterion 2>`
* [ ] `<Criterion 3>`

---

## 🧪 Test Coverage

* **Unit tests:** \[ ] Added / \[ ] Updated / \[ ] Not applicable
* **Property-based tests:** \[ ] Added / \[ ] Not applicable
* **Integration/contract tests:** \[ ] Added / \[ ] Updated / \[ ] Not applicable
* **Performance budget check:** \[ ] Met
* **Security/abuse cases:** \[ ] Covered

---

## 📊 Observability

* [ ] Metrics emitted
* [ ] Logs/tracepoints added or updated
* [ ] Dashboards/alerts configured (if applicable)

---

## 🛡️ Quality Gates

* [ ] Linting & formatting pass
* [ ] Static analysis (SAST/SCA/secrets) pass
* [ ] Mutation testing score meets threshold
* [ ] Contracts backward-compatible
* [ ] No SLO/SLA regressions

---

## 📝 Documentation

* [ ] README / usage docs updated
* [ ] Runbooks updated (if applicable)
* [ ] ADRs amended/added (if architectural change)

---

## 🧩 Rollout

* [ ] Feature behind flag
* [ ] Rollback plan documented
* [ ] Canary or shadow-mode tested (if applicable)

---

# Reviewer Checklist

*Reviewers can tick these to confirm compliance.*

* [ ] Code is clear and maintainable
* [ ] Tests cover acceptance criteria and edge cases
* [ ] Contracts are accurate and versioned
* [ ] Observability is sufficient for debugging
* [ ] Security and compliance risks addressed
* [ ] Docs and runbooks updated



---



