# AI-Driven Development & Delivery (AIDD)

A lean, Claude Code-native framework for running software delivery with AI in the loop. AI agents draft ADRs, contracts, tests, and scaffolding; humans approve, refine, and own architectural decisions. Install and go.

## Work hierarchy

| Type | Scope | Size |
|------|-------|------|
| **Epic** | Production-ready feature | Multiple Stories, multiple sprints |
| **Story** | Vertical slice of functionality | PR-sized, carries acceptance criteria |
| **Task** | Single prompt or small dev action | Supports one Story acceptance criterion |
| **ADR** | Architecture Decision Record | Created when contracts/infra/persistence change |

## Pipeline

```mermaid
sequenceDiagram
    participant Epic as Feature Epic
    participant ADR as ADR Gatekeeper
    participant Story as Story
    participant Task as Task
    participant CI as CI Quality Gates
    participant Release as Release

    Epic->>ADR: Architecture overview
    ADR-->>Epic: ADR drafted if needed

    Epic->>Story: Decompose into risk-ordered Stories
    Story->>Task: Break into Tasks

    Task->>Task: Contract-first, test-first
    Task->>CI: Submit work
    CI-->>Story: Merge behind feature flag

    Story->>Epic: Contribute toward Epic DoD
    Epic->>Release: Enable flag when DoD met
```

## Getting started

### For Claude Code users

1. Clone this repo (or copy its structure into your project).
2. `CLAUDE.md` auto-loads on every conversation, teaching Claude the AIDD methodology.
3. Use the built-in slash commands:

| Command | Purpose |
|---------|---------|
| `/plan-epic <description>` | Decompose a feature into risk-ordered Stories |
| `/plan-story <description>` | Break a Story into ordered, test-first Tasks |
| `/draft-adr <change>` | Evaluate if a change needs an ADR; draft one if so |
| `/submit-pr` | Generate a PR body from the current diff |

4. Hooks in `.claude/settings.json` automatically warn on:
   - Commits missing Story/Task references
   - Architectural file changes without ADR references

### For other AI tools

The methodology in `CLAUDE.md` is plain Markdown and works as context for any AI assistant. Feed it as a system prompt or project instructions file.

## Bootstrap prompts

### Fresh project

```
Review https://github.com/crashtestbrandt/AIDD and its CLAUDE.md.

This repository needs to follow the AIDD framework. Generate an implementation
plan covering: folder layout, templates, quality gates, slash commands, and
how to maintain consistency with the AIDD methodology over time.
```

### Existing project

```
Review https://github.com/crashtestbrandt/AIDD and its CLAUDE.md.

Adapt this project to comply with the AIDD framework. Produce a phased plan:
Phase 1 (quick wins), Phase 2 (deeper integration), Phase 3 (process embedding).
Include a baseline assessment of what already aligns and what's missing.
```

## Repository structure

```
CLAUDE.md                          # Framework brain (auto-loaded by Claude Code)
README.md                          # This file
.claude/
  settings.json                    # Hooks + config
  commands/                        # Slash commands
scripts/hooks/                     # Hook scripts for commit validation
.github/
  pull_request_template.md         # PR template
  ISSUE_TEMPLATE/                  # Epic, Story, Task templates
  workflows/pr-quality-gates.yml   # CI enforcement
docs/adr/                          # Architecture Decision Records
```
