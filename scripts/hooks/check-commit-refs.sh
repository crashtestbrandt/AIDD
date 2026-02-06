#!/usr/bin/env bash
# Hook: PostToolUse (Bash commands matching "git commit")
# Validates that commit messages contain Story/Task references.
#
# Reads tool input JSON from stdin. Expects a "command" field containing
# the git commit invocation (with -m message).
#
# Exits non-zero with a warning if no Story/Task reference is found.

set -euo pipefail

# Read the tool input from stdin
INPUT=$(cat)

# Extract the command that was run
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only check git commit commands
if ! echo "$COMMAND" | grep -q 'git commit'; then
  exit 0
fi

# Extract commit message from -m flag
COMMIT_MSG=$(echo "$COMMAND" | sed -nE 's/.*-m[[:space:]]*["\x27]([^"\x27]*)["\x27].*/\1/p')

# Also try heredoc-style messages
if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG=$(echo "$COMMAND" | sed -nE "s/.*-m[[:space:]]*\"?\\\$\(cat <<.*EOF//p")
  # If heredoc, try to get the full command as message
  if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="$COMMAND"
  fi
fi

# Check for Story/Task reference patterns
# Matches: #123, STORY-123, TASK-456, EPIC-789, GH-123, PROJ-123
REF_PATTERN='(#[0-9]+|\b(STORY|TASK|EPIC)-[0-9]+\b|\b[A-Z][A-Z0-9]+-[0-9]+\b|\bGH-[0-9]+\b)'

if echo "$COMMIT_MSG" | grep -Eq "$REF_PATTERN"; then
  exit 0
fi

echo "WARNING: Commit message does not contain a Story/Task reference."
echo "Expected patterns: #123, STORY-123, TASK-456, or PROJ-123"
echo "Add a reference to maintain traceability (Epic -> Story -> Task)."
exit 1
