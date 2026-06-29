---
type: reference
tags: [hot, changelog, chronological]
timestamp: 2026-06-28
---

# hot

Chronological change log for the workspace. Newest at top.

## 2026-06-28

### sisko — Architecture consolidation
- Replaced `projects/` → `outposts/` (distinct term, no collision risk)
- State files replace PROJECT.md: each outpost has `<slug>-state.md` in repo root
- `outposts/` now contains symlinks pointing to real state files — zero duplication
- Dashboard is now derivable from state file frontmatter (see `standards/dashboard-derivation.md`)
- Deleted PROJECTS.md, sessions/ directory
- New standards: `outpost-state.md` (template), `dashboard-derivation.md` (rebuild logic)
- Updated `agents.md` (3 next actions rule, no sessions)
- Updated `git.md` (always commit + push)
- Aporium dev-state dir renamed: `Aporium-dev-state` → `_aporium`

### sisko — Bootstrap
- Initialized control plane repo
- Created AGENTS.md, PROJECTS.md, dashboard.md, standards/ (git, agents, okf)
- obsidian-skills cloned to `~/.opencode/skills/obsidian-skills`
- OKF frontmatter applied to all sisko files
- Skills consolidated to `~/.opencode/skills/` (single canonical location)
- Custom agent definitions wiped (`~/.config/opencode/agent/` deleted)
- `~/.claude/` deleted

### Aporium
- Cleaned up 4 stale branches + worktrees
- Partial merge from `opencode/witty-otter` (8 files)
- Deleted `opencode/witty-otter` branch + remote

### Workspace
- Renamed `Code Projects` → `workspace`
- Updated symlink at `~/Documents/workspace`

### Project check-ins
- basicly: confirmed Swift native (not Electron). In-memory correction inference active.
- jamboree: local audio pipeline in progress (pedalboard, demucs, whisperx)
- quotaz: pipeline automation active (sync, sweep, update, rank). FORK-PLAN.md under review.
- prosodymaker: tracker/logs-based dev (v0.55.0). Model tracking iterated.
