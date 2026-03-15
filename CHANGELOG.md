# Changelog

## v1.1.0

- Add marketplace sync to release workflow
- Make marketplace sync step non-blocking
- Update installation instructions to match marketplace format
- Fix sync check to use merge-base --is-ancestor
- Simplify backport workflow with checkout -B and concurrency

## v1.0.0

- Initial release as npm package
- Reload CLAUDE.md files after context compaction
- Collect files from `~/.claude/CLAUDE.md` and directory hierarchy
- Inject as `additionalContext` via `SessionStart` hook
