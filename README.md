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

### Plugin install (recommended)

Install in two commands from inside a Claude Code session:

**1. Register the marketplace**

```
/plugin marketplace add coo-quack/claude-code-marketplace
```

**2. Install the plugin**

```
/plugin install do-not-compact@coo-quack
```

Done. The hooks are enabled automatically.

> **Keeping up to date:** Third-party marketplaces have auto-update disabled by default. To receive automatic updates, run `/plugin` → **Marketplaces** tab → select the marketplace → **Enable auto-update**. You can also update manually from the same tab. See [Discover and install plugins](https://docs.anthropic.com/en/docs/claude-code/discover-plugins) for details.

<details>
<summary>npm install</summary>

Install globally via npm and configure hooks manually:

```bash
npm install -g @coo-quack/do-not-compact
```

Update to the latest version:

```bash
npm update -g @coo-quack/do-not-compact
```

Then add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": "\"$(npm root -g)/@coo-quack/do-not-compact/hooks/reload-claude-md.sh\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

</details>

<details>
<summary>Manual setup (git clone)</summary>

Clone the repository and configure hooks manually:

```bash
git clone https://github.com/coo-quack/do-not-compact.git ~/do-not-compact
```

Update to the latest version:

```bash
cd ~/do-not-compact && git pull
```

Then add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "compact",
        "hooks": [
          {
            "type": "command",
            "command": "~/do-not-compact/hooks/reload-claude-md.sh",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

</details>

## Requirements

- `jq` must be installed and available in PATH
