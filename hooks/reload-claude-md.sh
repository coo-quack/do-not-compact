#!/bin/bash
# Reload CLAUDE.md files after compaction and inject as additionalContext
set -euo pipefail

INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd')

CONTEXT=""

# ~/.claude/CLAUDE.md
if [[ -f "$HOME/.claude/CLAUDE.md" ]]; then
  CONTEXT+="--- ~/.claude/CLAUDE.md ---"$'\n'
  CONTEXT+="$(cat "$HOME/.claude/CLAUDE.md")"$'\n\n'
fi

# Collect CLAUDE.md files from cwd up to $HOME
dir="$CWD"
claude_files=()
while [[ "$dir" != "/" && "$dir" != "$HOME" ]]; do
  if [[ -f "$dir/CLAUDE.md" ]]; then
    claude_files+=("$dir/CLAUDE.md")
  fi
  dir=$(dirname "$dir")
done
if [[ -f "$HOME/CLAUDE.md" ]]; then
  claude_files+=("$HOME/CLAUDE.md")
fi

# Output in top-down order (reverse of collected order)
for (( i=${#claude_files[@]}-1; i>=0; i-- )); do
  f="${claude_files[$i]}"
  CONTEXT+="--- $f ---"$'\n'
  CONTEXT+="$(cat "$f")"$'\n\n'
done

if [[ -n "$CONTEXT" ]]; then
  jq -n --arg ctx "$CONTEXT" '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      additionalContext: $ctx
    }
  }'
fi

exit 0
