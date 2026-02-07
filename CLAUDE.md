# AIDD Framework

This file defines the AI-Driven Development (AIDD) methodology. It is auto-loaded by Claude Code on every conversation in this repository.

## Work hierarchy

| Type | Scope | Maps to |
|------|-------|---------|
| **Epic** | Production-ready feature across multiple Stories | GitHub Issue `[Epic]` |
| **Story** | PR-sized vertical slice with acceptance criteria | GitHub Issue `[Story]` |
| **Task** | Single prompt / small dev action inside a Story | GitHub Issue `[Task]` |
| **ADR** | Architecture Decision Record for significant choices | `docs/adr/ADR-NNN-title.md` |

Rules:
- Epics group Stories; Stories decompose into Tasks.
- Tasks never ship user-visible behavior alone; Stories do.
- Every Story must trace back to an Epic. Every Task must trace back to a Story.
- ADRs are linked from Epics and Stories when architectural decisions are involved.

## Directory conventions

| Path | Purpose |
|------|---------|
| `docs/adr/` | ADRs. Use `ADR-TEMPLATE.md` as starting point. Name: `ADR-NNN-title.md` |
| `contracts/` | Source-of-truth API/interface definitions (OpenAPI, GraphQL SDL, Protobuf, JSON Schema) |
| `infrastructure/` | Infrastructure-as-code (Terraform, Pulumi, Helm, K8s manifests) |
| `.github/ISSUE_TEMPLATE/` | Issue templates for Epics, Stories, Tasks |
| `.github/pull_request_template.md` | PR template |
| `.github/workflows/` | CI/CD workflows including quality gates |

## Workflow rules

### When an ADR is required

An ADR **must** be created or referenced when a change touches:
- `contracts/`, `api/`, `openapi/`, `proto/` (API contracts)
- `schema/`, `db/`, `migrations/` (data/persistence)
- `infrastructure/`, `infra/`, `k8s/`, `helm/`, `terraform/`, `pulumi/` (IaC)
- `prompts/`, `prompt_registry/` (AI prompt/policy assets)
- Any cross-service interface or significant architectural decision

Use `/draft-adr` to evaluate whether a change needs an ADR and draft one.

### Planning flow

1. **Epic planning**: Use `/plan-epic <description>` to decompose a feature into risk-ordered Stories with acceptance criteria, contracts, test strategy, and tasks.
2. **Story planning**: Use `/plan-story <description>` to break a Story into ordered Tasks with a test-first approach.
3. **ADR drafting**: Use `/draft-adr <change description>` to evaluate architectural impact and draft an ADR if needed.
4. **PR submission**: Use `/submit-pr` to generate a PR body from the current diff using the repo's PR template.

### Implementation order

For each Story, follow this sequence:
1. Draft/update contracts (API deltas) — contract-first
2. Write acceptance tests and unit/property tests — test-first
3. Implement against those tests
4. Add observability (metrics, logs, traces)
5. Update documentation

## Code quality expectations

- **Test-first**: Write tests before implementation. Tests must assert acceptance criteria.
- **Contract-first**: Define API/interface changes before writing implementation code.
- **Traceability**: Every commit should reference a Story or Task (`#123`, `STORY-123`, `TASK-456`). Every PR must link related Epic(s), Story(ies), Task(s), and ADR(s).

## Testing expectations

Follow the testing pyramid:
- **Base**: Unit tests and property-based tests (fast, automated, high coverage)
- **Middle**: Contract tests and integration slice tests (service + datastore + 1 dependency)
- **Top**: End-to-end acceptance tests (thin layer: happy paths + critical flows only)
- **AI-specific** (when applicable): Prompt regression, safety/jailbreak tests, accuracy/factuality, cost/latency budgets

## PR standards

Use `.github/pull_request_template.md`. Every PR must include:
- Summary of the change and problem it solves
- Related Work links (Epic, Story, Task, ADR references)
- Architecture Impact assessment (with contract/persistence/infra details if applicable)
- Tests & Quality Gates checklist (only tick what actually exists in the diff)
- Observability & Ops status
- Rollback plan and feature flag name if applicable

## Quality gates (CI)

The `pr-quality-gates.yml` workflow enforces:
- Story/Task reference in PR title or body (`#123`, `STORY-123`, `TASK-456`, `PROJ-123`)
- ADR reference when architectural paths are changed
- ADR lint: required sections (Title, Status, Context, Decision, Rationale, Consequences, References)

## Observability requirements

Every Story should specify:
- **Metrics**: Name, labels, cardinality budget (guard against high-cardinality labels)
- **Logs**: Structured, with event names and retention policy
- **Traces**: Span names following `<namespace>/<operation>` convention
- Alert thresholds and dashboard updates
