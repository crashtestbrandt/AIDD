#!/usr/bin/env bash
# Hook: PostToolUse (Bash commands matching "git commit")
# Warns if staged files include architecture-sensitive paths but the commit
# message does not reference an ADR.
#
# Reads tool input JSON from stdin.
# Exits non-zero with a warning if ADR reference is missing.

set -euo pipefail

# Read the tool input from stdin
INPUT=$(cat)

# Extract the command that was run
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only check git commit commands
if ! echo "$COMMAND" | grep -q 'git commit'; then
  exit 0
fi

# Architecture-sensitive path patterns
ARCH_PATTERNS='(^contracts/|^api/|^openapi/|^proto/|^schema/|^db/|^migrations/|^infrastructure/|^infra/|^k8s/|^helm/|^terraform/|^pulumi/|^prompts/|^prompt_registry/|^services/.*/contracts/)'

# Check staged files for architectural paths
STAGED_FILES=$(git diff --cached --name-only 2>/dev/null || true)

if [ -z "$STAGED_FILES" ]; then
  exit 0
fi

ARCH_FILES=$(echo "$STAGED_FILES" | grep -E "$ARCH_PATTERNS" || true)

if [ -z "$ARCH_FILES" ]; then
  exit 0
fi

# Architectural files found — check for ADR reference in commit message
COMMIT_MSG="$COMMAND"
ADR_PATTERN='ADR-[0-9]+'

if echo "$COMMIT_MSG" | grep -Eq "$ADR_PATTERN"; then
  exit 0
fi

echo "WARNING: Architectural files are staged but commit message has no ADR reference."
echo "Files triggering this check:"
echo "$ARCH_FILES" | sed 's/^/  - /'
echo ""
echo "If this change requires an architectural decision, run /draft-adr first."
echo "Then include the ADR reference (e.g., ADR-001) in your commit message."
exit 1
