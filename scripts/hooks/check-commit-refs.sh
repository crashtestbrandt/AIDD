#!/usr/bin/env bash
# Hook: PostToolUse (Bash commands matching "git commit")
# Validates that commit messages contain Story/Task references.
#
# Reads tool input JSON from stdin. The full git commit command
# (including the -m message) is checked for reference patterns.
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

# Check the full command for Story/Task reference patterns (POSIX ERE)
# Matches: #123, STORY-123, TASK-456, EPIC-789, GH-123, PROJ-123
REF_PATTERN='(#[0-9]+|(STORY|TASK|EPIC)-[0-9]+|[A-Z][A-Z0-9]+-[0-9]+|GH-[0-9]+)'

if echo "$COMMAND" | grep -Eq "$REF_PATTERN"; then
  exit 0
fi

echo "WARNING: Commit message does not contain a Story/Task reference."
echo "Expected patterns: #123, STORY-123, TASK-456, or PROJ-123"
echo "Add a reference to maintain traceability (Epic -> Story -> Task)."
exit 1
