# sisko

<!-- Context: sisko/root | Priority: critical | Version: 1.0 | Updated: 2026-06-28 -->

Control plane for all workspace projects. sisko oversees — projects execute.

## Purpose
Single source of truth for project status, priorities, standards, and cross-project memory. Agents read this first.

## Architecture
sisko is a polyrepo overseer. Each project under `workspace/` is self-contained with its own `AGENTS.md` and `PROJECT.md`. sisko points to them but does not own them.

```
workspace/
├── sisko/              ← Control plane (this repo)
├── basicly/
├── jamboree/
└── ...
```

## How agents should use sisko
1. **Start here.** Read `dashboard.md` for current priorities.
2. **Check `PROJECTS.md`** for the manifest and status of all projects.
3. **Read the target project's `PROJECT.md`** before working on it.
4. **Update after every session.** Append to `sessions/YYYY-MM-DD.md` and update `dashboard.md` if priorities changed.
5. **Follow `standards/`** for conventions that apply across projects.

## Rules
- sisko is Markdown-first. No databases, no APIs, no build steps.
- One file per project in `projects/`. One file per session in `sessions/`.
- `dashboard.md` must stay under 200 lines. Archive old state to sessions.
- Every change to priorities or status must update `dashboard.md` and the affected `projects/*.md`.
- Never delete session files — they are the cross-project memory.

## Related
- `PROJECTS.md` — full manifest
- `dashboard.md` — current operating state
- `standards/` — conventions
