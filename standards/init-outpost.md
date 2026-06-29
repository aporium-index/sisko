---
type: standard
tags: [initialization, agent-prompt, outpost]
timestamp: 2026-06-28
---

# Standard: Outpost Initialization Prompt

Copy this block into any outpost repo. The agent will review the repo against ADAMA standards, update the state file, and report where the system falls short for this specific project.

```
You are reviewing this repo for ADAMA, the workspace control plane.

## Concept

ADAMA (`workspace/ADAMA/`) is a Markdown-based control plane. Every outpost carries a single state file — `<slug>-state.md` — with YAML frontmatter and a markdown body. The dashboard reads these files to track status, compliance, and direction across all outposts. The state file is this outpost's only interface to the control plane.

You are acting on behalf of this outpost. A state file already exists — your job is to review it, make it accurate, fill gaps, and report where the ADAMA template and standards fall short.

## Step 1 — Read the Standards

Read these to understand what's expected:

1. `workspace/ADAMA/standards/outpost-state.md` — the state file template (fields, enums, phase model, body sections)
2. `workspace/ADAMA/standards/agents.md` — agent behavior (AGENTS.md required, commit+push on every session)
3. `workspace/ADAMA/standards/git.md` — git conventions (.gitignore minimum, single branch, commit format)
4. `workspace/ADAMA/standards/okf.md` — frontmatter convention (--- fences, type, tags, timestamp)

## Step 2 — Explore This Repo

- What does this project do? Read README, docs, package manifests, handoff files.
- What's the stack? Language, frameworks, build tools, package manager, platform.
- What's active? `git log --oneline -10`, `git status --short`
- What's the repo structure? Key directories, entry points, config files.
- Are there tests? Linting? Typechecking? How do you run them?
- What are the long-term ambitions? Phases? Milestones? Vision past current focus?
- What's the next 6-12 months look like? Known inflection points?
- Anything unusual? Unconventional layout, legacy cruft, iCloud constraints, missing tooling.

## Step 3 — Audit Against Standards

| Standard | Check | Source |
|----------|-------|--------|
| AGENTS.md exists | `ls AGENTS.md` | standards/agents.md §1 |
| .gitignore exists AND covers minimum | File exists AND contains `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/` | standards/git.md § Repo Structure |
| Single default branch | `git branch` — only main or master, no stale branches | standards/git.md § Branch Policy |
| Recent push | Pushed within stale_threshold_days | standards/git.md § Always Commit + Push |
| State file OKF frontmatter valid | State file starts with `---`, has `type: project`, `tags`, `timestamp` | standards/okf.md, standards/outpost-state.md § Field Reference |
| State file body sections present | All 10 body sections present (including `## Template Feedback`) | standards/outpost-state.md § Body Section Reference |
| has_agents_md accurate | Matches reality | State file frontmatter |
| has_gitignore accurate | Matches reality | State file frontmatter |
| last_active current | Within stale_threshold_days | State file frontmatter |

**Note:** `has_gitignore: true` means the file exists — it does NOT mean the .gitignore meets the git.md minimum. Check contents separately. If the file exists but is missing required entries, `has_gitignore` stays `true` and the gap goes in `## Compliance Gaps`.

For each gap: cite the specific standard and describe the fix. Collect every next action — top 3 go in the state file, rest in `## Full Backlog`.

## Step 4 — Update the State File

The state file already exists. Update it:

**YAML frontmatter to verify/correct:**
- `type: project` — OKF requirement, first field after `---` fence
- slug, name, category, domain — identity
- description — move any existing body description here
- location — path on disk
- primary_language, languages, frameworks, platform — from exploration
- repo_url, repo_type, default_branch — from exploration
- has_agents_md, has_gitignore — set true/false based on audit
- last_active, last_checkin, timestamp — set to today
- tags — 3-5 keywords
- file_version — set to "1.1"

**YAML fields to NOT touch:**
- phase, status, condition — ADAMA assigns
- priority, criticality — ADAMA assigns
- owner, owner_type — ADAMA assigns
- depends_on, depended_on_by — ADAMA assigns

**Body sections to update:**

- `## Current Focus` — what's being worked on now. One sentence based on git log and dirty files.
- `## Full Backlog` — all next actions in priority order. Mark the **top 3** with a bold label prefix (e.g., `**Top 1:**`, `**Top 2:**`, `**Top 3:**`) so the immediate focus is unambiguous. Remaining items follow as plain checkboxes.
- `## Blockers` — anything preventing progress. "None." if empty.
- `## Compliance Gaps` — each gap cites the specific standard and fix.
- `## Long-Term Direction` — phases, milestones, 6-12 month vision, thresholds that would change phase or priority.
- `## Open Decisions` — questions waiting on input. "None." if empty.
- `## Decisions` — reverse-chronological decision log. Date, decision, rationale. This is the project's institutional memory.
- `## Repo Notes` — gotchas, surprises, unusual conventions for future agents.
- `## Links` — wikilinks to related files, home pages, external docs.
- `## Template Feedback` — where the state file template falls short for THIS repo. This is the most important output — it's how ADAMA improves.

## Step 5 — Template Feedback

Where does the state file template fall short for THIS repo? Are YAML fields missing? Do the enums not cover your case? Is anything confusing or overkill? What would you change about ADAMA standards to better support this outpost?

Write your feedback at the bottom of the state file under `## Template Feedback` (add this section if missing). This is the most important output — it's how ADAMA improves.

## Step 6 — Git Commit + Push

```
git add -A
git commit -m "maintenance: ADAMA init review — audit, update state, flag gaps"
git push
```

Commit all changes from the audit — state file updates, .gitignore fixes, AGENTS.md creation, any cleanup. If no remote: note in Compliance Gaps.

## Step 7 — Report

```
## Init review: <name>

### Standards audit
- met: <N>, gaps: <N>

### State file updated
- <N> frontmatter fields corrected
- Body sections updated: <list>

### Top template feedback
- <most important suggestion>
```
```
