---
type: standard
tags: [initialization, agent-prompt, outpost]
timestamp: 2026-06-28
---

# Standard: Outpost Initialization Prompt

Copy this block into any outpost repo. The agent will review the repo against ADAMA standards, update the state file, and report where the system falls short for this specific project.

```
You are initializing this repo for ADAMA, the workspace control plane.

## Concept

ADAMA (`workspace/ADAMA/`) is a Markdown-based control plane. Every outpost (this repo) carries a state file — `<slug>-state.md` — with YAML frontmatter and a markdown body. The dashboard reads these files to track status, compliance, and blockers. The state file is this outpost's only interface to the control plane.

You are acting on behalf of this outpost. A state file already exists in this repo — your job is to review it, make it accurate, fill gaps, and report where the ADAMA template and standards fall short for this specific project.

## Step 1 — Read the Standards

Read these files to understand what's expected of every outpost:

1. `workspace/ADAMA/standards/outpost-state.md` — the state file template (required fields, enums, who-writes-what)
2. `workspace/ADAMA/standards/agents.md` — agent behavior rules (AGENTS.md required, 3 next actions, commit+push)
3. `workspace/ADAMA/standards/git.md` — git conventions (.gitignore, branch policy, commit format)
4. `workspace/ADAMA/standards/okf.md` — frontmatter convention (--- fences, type, tags, timestamp)

## Step 2 — Explore This Repo

Investigate thoroughly:
- What does this project do? Read README, docs, package manifests, handoff files.
- What's the stack? Language, frameworks, build tools, package manager, platform.
- What's active? `git log --oneline -10`, `git status --short`
- What's the repo structure? Key directories, entry points, config files.
- Are there tests? Linting? Typechecking? How do you run them?
- What are the long-term ambitions? Phases? Milestones? What's the vision past the current focus?
- What's the next 6-12 months look like? Any known inflection points?
- Anything unusual? Unconventional layout, legacy cruft, iCloud constraints, missing tooling.

## Step 3 — Audit Against Standards

Compare this repo against ADAMA standards. For each standard, flag: met, not met, or not applicable.

| Standard | Check | Source |
|----------|-------|--------|
| AGENTS.md exists | `ls AGENTS.md` | standards/agents.md § Every Outpost Must Have |
| .gitignore covers minimum | Has `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/` | standards/git.md § Repo Structure |
| Single default branch | `git branch` — only main or master, no stale branches | standards/git.md § Branch Policy |
| Recent push | `git log origin/main -1` — pushed within stale_threshold_days | standards/git.md § Always Commit + Push |
| OKF frontmatter valid | State file has `---` fences, `type` field present | standards/okf.md § Required Fields |
| All required fields present | Compare state file against template field reference | standards/outpost-state.md § Field Reference |
| has_agents_md accurate | Matches reality | standards/outpost-state.md |
| has_gitignore accurate | Matches reality | standards/outpost-state.md |
| last_active current | Within stale_threshold_days | standards/outpost-state.md |

For each gap: describe the specific standard being violated and what the fix is.

Collect any next actions discovered during the audit. Do NOT limit yourself to 3 — list every concrete improvement this repo needs, prioritized. The state file will show the top 3, but report all of them.

## Step 4 — Update the State File

The state file already exists. Update it:

**Frontmatter fields to verify/correct:**
- slug, name, category, domain, primary_language, languages, frameworks, platform
- repo_url, repo_type, default_branch
- has_agents_md, has_gitignore (set true/false based on audit)
- last_active, timestamp (set to today)
- tags (3-5 keywords)

**Frontmatter fields to NOT touch:**
- state, condition, priority, criticality (ADAMA assigns these)
- owner, owner_type (ADAMA assigns these)

**Body sections to update:**

`## Current Focus` — what's actually being worked on right now, based on git log, dirty files, and project understanding. One sentence.

`## Next Actions` — top 3 prioritized from the full list you collected. The remaining items go in `## Full Backlog` below.

`## Blockers` — anything preventing progress. If none, "None."

`## Full Backlog` — NEW. All next actions discovered during audit, not just the top 3. Priority order. This gives ADAMA a broader view of the project's needs.

`## Long-Term Direction` — NEW. Phases, milestones, ambitions beyond current focus. What's the 6-12 month vision? Known inflection points? Any thresholds that would change the project's state or priority?

`## Open Decisions` — questions waiting on input. If none, "None."

`## Decisions` — reverse-chronological log of important choices made. Each entry has date, decision, rationale. This is the project's institutional memory — why were choices made? What did we try that failed? An agent reading this 6 months later should understand the project's trajectory without reading git history.
```
| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-01-15 | Chose SQLite over Postgres | Single-user app, zero ops burden |
| 2026-02-01 | Rolled back WebSocket approach | Connection instability on mobile; replaced with polling |
```

`## Compliance Gaps` — renamed from before. Each gap with the specific standard it violates and the fix.
```
- **No AGENTS.md** (standards/agents.md §1) — create at repo root with `touch AGENTS.md`
- **.gitignore missing .venv/** (standards/git.md § Repo Structure) — add line `.venv/`
```

`## Repo Notes` — special considerations, gotchas, surprises for future agents.

`## Template Feedback` — where does the outpost-state template fall short for THIS repo? Are fields missing? Enums don't cover your case? Something confusing or overkill? What would you change about ADAMA's standards to better support this outpost?

## Step 5 — Git Commit + Push

```
git add <slug>-state.md
git commit -m "maintenance: ADAMA init review — audit, update state, flag gaps"
git push
```

## Step 6 — Report

```
## Init review: <name>

### Standards audit
- <N> met, <N> not met, <N> gaps found

### State file updated
- <N> frontmatter fields corrected
- Added: Full Backlog (<N> items), Long-Term Direction, updated Decisions

### Top template feedback
- <most important suggestion>
```
```
