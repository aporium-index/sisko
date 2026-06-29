---
type: guide
tags: [ADAMA, agents, control-plane]
timestamp: 2026-06-28
---

# ADAMA

Control plane for all workspace outposts. ADAMA oversees — outposts execute.

## Purpose
Single source of truth for outpost status, priorities, standards, and cross-outpost coordination. Agents read this first.

## Architecture
ADAMA is a polyrepo overseer. Each outpost under `workspace/` is self-contained with its own `AGENTS.md` and `<slug>-state.md`. ADAMA's `outposts/` directory contains symlinks to each state file — no duplication.

```
workspace/
├── ADAMA/              ← Control plane (this repo)
│   ├── outposts/       ← Symlinks to state files
│   │   ├── aporium-state.md → ../../_aporium/aporium-state.md
│   │   ├── basicly-state.md → ../../basicly/basicly-state.md
│   │   └── ...
│   ├── standards/      ← Conventions that span all outposts
│   ├── dashboard.md    ← Derived view from state file frontmatter
│   └── hot.md          ← Chronological change log
├── _aporium/           ← iCloud vault dev-state
├── basicly/
├── jamboree/
└── ...
```

## How agents should use ADAMA
1. **Read `dashboard.md`** for current outpost states, priorities, and blockers.
2. **Read the target outpost's state file** via the symlink in `outposts/`.
3. **Read the outpost's `AGENTS.md`** for repo-specific rules.
4. **Follow `standards/`** for conventions that apply across outposts.

## Rules
- ADAMA is Markdown-first. No databases, no APIs, no build steps.
- Outposts own their state files. ADAMA points to them via symlinks.
- `dashboard.md` is derivable — always verifiable against state file frontmatter.
- Every outpost must commit + push after every session.
- No session files. OpenCode logs sessions. ADAMA uses `hot.md` for chronological context.

## Related
- `dashboard.md` — derived view of all outpost states
- `hot.md` — chronological change log
- `standards/` — conventions
