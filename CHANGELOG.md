## v1.1.1 (2026-03-31)

### Security

- Add `minimumReleaseAge` to renovate.json to prevent supply chain attacks
  - Waits 7 days before auto-merging dependency updates
  - Reduces risk of package takeover attacks
  - Blocks immediate auto-merge of newly published packages

---

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
