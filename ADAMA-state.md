---
slug: ADAMA
name: ADAMA
category: control-plane
domain: meta
sensitivity: internal
primary_language: markdown
languages: []
primary_framework: none
frameworks: []
platform: cross-platform
repo_url: local
repo_type: local
default_branch: main
has_agents_md: true
has_gitignore: true
state: operational
condition: condition-green
priority: P1
criticality: tier-0
owner: josh
owner_type: human
last_active: 2026-06-28
last_checkin: 2026-06-28
timestamp: 2026-06-28
stale_threshold_days: 7
depends_on: []
depended_on_by: [_aporium, basicly, jamboree, quotaz, prosodymaker, mac-optimization-audit, ml-feedback-program]
tags: [ADAMA, control-plane, meta]
file_version: "1.0"
---

# ADAMA

Control plane for the workspace. Single source of truth for outpost status, priorities, standards, and cross-outpost coordination. ADAMA oversees — outposts execute.

## Location

`workspace/ADAMA/`

## Current Focus

Architecture consolidation: symlink-based outpost tracking, derived dashboard, state file standard. obsidian-skills installed. OKF frontmatter applied to all ADAMA files.

## Next Actions

- [ ] Delete old PROJECTS.md and sessions/
- [ ] Replace outpost files with symlinks to state files
- [ ] Rebuild dashboard as derived view

## Blockers

None.

## Open Decisions

- Dashboard as webview UI? (long-term — markdown for now)
- Should ADAMA track opencode configuration as a dependency or outpost?

## Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-06-28 | projects/ → outposts/ | Distinct term avoids collision with generic project vocabulary |
| 2026-06-28 | State files replace PROJECT.md | Single file per outpost. Dashboard derived from frontmatter. |
| 2026-06-28 | Symlinks in outposts/ | No duplication. Outpost owns its state file. ADAMA points to it. |
| 2026-06-28 | No sessions/ directory | OpenCode logs sessions. ADAMA doesn't duplicate. |

## Notes

ADAMA is tier-0 infrastructure. If ADAMA is down, agents lose their bearings. Keep it minimal: no databases, no APIs, no build steps.

## Links

- AGENTS.md
- dashboard.md
- standards/
