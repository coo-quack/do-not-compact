# Don't Compact CLAUDE.md

Claude Code plugin that reloads CLAUDE.md files into context after conversation compaction.

## Problem

When Claude Code compacts the conversation to stay within context limits, the contents of CLAUDE.md files (user instructions, project rules, git conventions, etc.) may be lost or summarized. This can cause Claude to forget important rules like commit message conventions or coding standards.

## Solution

This plugin hooks into the `SessionStart` event with a `compact` matcher. After compaction, it collects all CLAUDE.md files from the directory hierarchy and injects them back into context as `additionalContext`.

Files collected (in order):
1. `~/.claude/CLAUDE.md` (user global instructions)
2. `~/CLAUDE.md` and parent directories up to cwd (project hierarchy)

## Installation

```bash
npm install -g @coo-quack/do-not-compact
claude plugin install @coo-quack/do-not-compact
```

## Requirements

- `jq` must be installed and available in PATH
