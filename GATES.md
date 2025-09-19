<!-- ./GATES.md -->

# Quality Gates

This document provides a drop-in [GitHub Actions workflow](#github-actions-workflow) that enforces Story/Task references and ADR linkage whenever architectural/contract/infra/schema/prompt files change. It comments helpful guidance on failure so Copilot/Codex (and humans) know exactly what to fix.

## How it works (and how AI tools “learn” to comply)

* **Triggers an ADR requirement** when files in common “architectural” areas change:

  * `contracts/**` (OpenAPI/GraphQL/Proto), `api/**` contract files
  * `schema/`, `db/`, `migrations/` (data changes)
  * `infrastructure/`, `infra/`, `ops/`, `k8s/`, `helm/`, `terraform/`, `pulumi/`
  * `prompts/`, `prompt_registry/` (your AI prompt/policy assets)
* **Requires Story/Task refs** in the PR title or body (e.g., `#123`, `STORY-42`, `TASK-7`, `GH-99`).
* **Requires ADR refs** (e.g., `ADR-001`) when architectural areas changed.
* **Comments a friendly summary** on every run so Copilot/Codex can pick up the pattern and auto-fill next time.
* **Easy to tune**: edit the regexes at the top of the workflow’s `env:` block.

---

## Small companion tips

1. **Keep your ADR template in the repo** (e.g., `docs/adr/ADR-TEMPLATE.md`) and reference it from your PR template.
2. **Name ADRs consistently** (`docs/adr/ADR-001-title.md`). Tools will learn to suggest the right links.
3. In your **PR template**, include the ADR slot:

   * `**ADR(s):** [ADR-###](./docs/adr/ADR-###-title.md)`
     (You already have this — nice.)
4. If you want stricter enforcement, add a second job to **lint ADR content** (check required headings: Title/Status/Context/Decision/Rationale/Consequences/References). Happy to provide that too if you want it.

## GitHub Actions Workflow

Save as: `.github/workflows/pr-quality-gates.yml`

```yaml
name: PR Quality Gates (Stories & ADRs)

on:
  pull_request:
    types: [opened, edited, synchronize, reopened, ready_for_review]
    branches: [ "**" ]

permissions:
  contents: read
  pull-requests: write

jobs:
  policy-checks:
    name: Enforce Story/Task refs & ADR usage
    runs-on: ubuntu-latest

    # Tune these patterns to match your repo conventions
    env:
      # Accepts: #123 (GitHub issue), STORY-123, TASK-456, or GH-789
      STORY_REF_REGEX: '(#\d+|\bSTORY-\d+\b|\bTASK-\d+\b|\bGH-\d+\b)'
      # ADR references typically look like ADR-001, ADR-42, etc.
      ADR_REF_REGEX: '\bADR-\d+\b'
      # Files that *require* an ADR link when changed
      ADR_REQUIRED_PATHS: |
        ^(contracts/.*\.(ya?ml|json|proto|graphql|gql))$
        ^(api/.*\.(ya?ml|json|proto|graphql|gql))$
        ^(schema/|db/|migrations/) # DB schemas & migrations
        ^(infrastructure/|infra/|ops/|k8s/|helm/|terraform/|pulumi/) # infra/IaC
        ^(prompts/|prompt_registry/) # prompt/policy assets for AI
        ^(services/.*/contracts/.*)$
        ^(proto/.*\.proto)$

    steps:
      - name: Checkout (shallow)
        uses: actions/checkout@v4
        with:
          fetch-depth: 2

      - name: Gather PR metadata & changed files
        id: meta
        uses: actions/github-script@v7
        with:
          script: |
            const pr = context.payload.pull_request;
            const owner = context.repo.owner;
            const repo = context.repo.repo;
            const prNumber = pr.number;

            // PR body + title
            const body = (pr.body || "").trim();
            const title = (pr.title || "").trim();

            // List changed files (max 3000; bump if needed)
            const files = await github.paginate(
              github.rest.pulls.listFiles,
              { owner, repo, pull_number: prNumber, per_page: 100 }
            );
            const changed = files.map(f => f.filename);

            core.setOutput('body', body);
            core.setOutput('title', title);
            core.setOutput('changed', JSON.stringify(changed));

      - name: Evaluate policy
        id: eval
        run: |
          set -euo pipefail

          BODY="${{ steps.meta.outputs.body }}"
          TITLE="${{ steps.meta.outputs.title }}"
          CHANGED_FILES="$(echo '${{ steps.meta.outputs.changed }}' | jq -r '.[]')"

          STORY_REF_REGEX=${STORY_REF_REGEX}
          ADR_REF_REGEX=${ADR_REF_REGEX}

          # Build a single-line regex for ADR-required paths
          mapfile -t ADR_RULES <<< "$(printf '%s\n' "${ADR_REQUIRED_PATHS}")"
          ADR_RULES_CLEAN=()
          for r in "${ADR_RULES[@]}"; do
            # strip comments and blank lines
            rr="$(echo "$r" | sed -E 's/#.*$//' | tr -d '\r')"
            [[ -n "$rr" ]] && ADR_RULES_CLEAN+=("$rr")
          done

          need_adr=0
          adr_required_files=()
          if [[ -n "${CHANGED_FILES}" ]]; then
            while IFS= read -r file; do
              for rule in "${ADR_RULES_CLEAN[@]}"; do
                if echo "$file" | grep -Eq "$rule"; then
                  need_adr=1
                  adr_required_files+=("$file")
                  break
                fi
              done
            done <<< "$CHANGED_FILES"
          fi

          has_story_ref=0
          if echo "$TITLE" | grep -Eq "$STORY_REF_REGEX" || echo "$BODY" | grep -Eq "$STORY_REF_REGEX"; then
            has_story_ref=1
          fi

          has_adr_ref=0
          if echo "$TITLE" | grep -Eq "$ADR_REF_REGEX" || echo "$BODY" | grep -Eq "$ADR_REF_REGEX"; then
            has_adr_ref=1
          fi

          echo "need_adr=$need_adr" >> $GITHUB_OUTPUT
          echo "has_story_ref=$has_story_ref" >> $GITHUB_OUTPUT
          echo "has_adr_ref=$has_adr_ref" >> $GITHUB_OUTPUT

          # Compose a human-friendly summary for the next step
          {
            echo "### PR Quality Gate Results"
            echo ""
            echo "- Story/Task reference present: $([[ $has_story_ref -eq 1 ]] && echo '✅' || echo '❌')"
            if [[ $need_adr -eq 1 ]]; then
              echo "- ADR required (triggered by file changes): ✅"
              echo "  - Files triggering ADR requirement:"
              for f in "${adr_required_files[@]}"; do echo "    - \`$f\`"; done
              echo "- ADR reference present in title/body: $([[ $has_adr_ref -eq 1 ]] && echo '✅' || echo '❌')"
            else
              echo "- ADR required: ❌ (no architectural/contract/infra/schema/prompt changes detected)"
            fi
            echo ""
            echo "**Patterns**"
            echo "- Story/Task: \`${STORY_REF_REGEX}\` (e.g., \`#123\`, \`STORY-42\`, \`TASK-7\`)"
            echo "- ADR: \`${ADR_REF_REGEX}\` (e.g., \`ADR-001\`)"
          } > gate_summary.md

          # Fail if required gates not satisfied
          fail=0
          if [[ $has_story_ref -ne 1 ]]; then
            echo "::error title=Missing Story/Task reference::Add a Story or Task reference to the PR title or body (e.g., #123, STORY-123, TASK-456)."
            fail=1
          fi
          if [[ $need_adr -eq 1 && $has_adr_ref -ne 1 ]]; then
            echo "::error title=ADR required but not linked::Architectural/contract/infra/schema/prompt changes detected. Link an ADR in the PR (e.g., ADR-042) and include it under the 'Related Work' section."
            fail=1
          fi

          if [[ $fail -eq 1 ]]; then
            exit 1
          fi

      - name: Comment results on PR (always)
        if: always()
        uses: actions/github-script@v7
        with:
          script: |
            const fs = require('fs');
            const body = fs.readFileSync('gate_summary.md', 'utf8');
            const pr = context.payload.pull_request;
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: pr.number,
              body
            });
```

---


