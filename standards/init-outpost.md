---
type: standard
tags: [initialization, agent-prompt, outpost]
timestamp: 2026-06-28
---

# Standard: Outpost Initialization Prompt

Copy this block into any outpost repo. The agent will create a state file for the control plane and report where the system falls short.

```
You are initializing this repo as a ADAMA outpost.

## Concept

ADAMA is a Markdown-based control plane in `workspace/ADAMA/`. Every outpost (this repo) carries a single state file — `<slug>-state.md` — with YAML frontmatter and a markdown body. ADAMA's dashboard reads these files to track status, compliance, and blockers across all outposts. The state file is the outpost's interface to the control plane.

You are acting on behalf of this outpost. Your job: create the state file, fill in everything you can, and tell us where the system falls short for this specific repo.

## Rules
- Do NOT read any ADAMA files. This prompt is all the context you need.
- Do NOT set `state`, `condition`, `priority`, or `criticality`. ADAMA assigns those.
- Fill in what you can. Mark what you can't.
- Be honest about gaps. The template is a draft — your feedback improves it.

## Step 1 — Explore This Repo

Investigate thoroughly:
- What does this project do? Read README, docs, handoff files, package manifests.
- What's the stack? Language, frameworks, build tools, package manager, platform.
- What's active? `git log --oneline -10`, `git status --short`
- What's the repo structure? Key directories, entry points, config files.
- Are there tests? Linting? Typechecking? How do you run them?
- Anything unusual? Unconventional layout, legacy cruft, iCloud constraints, missing tooling.

## Step 2 — Create the State File

Create `<slug>-state.md` at the repo root. The slug is this repo's directory name. Use this template:

```markdown
---
slug: <repo-dir-name>
name: <human-readable name>
category: <application|library|tool|infrastructure|knowledge-base|audit|brand|experiment|control-plane>
domain: <one-word area>
sensitivity: <public|internal|confidential|restricted>
primary_language: <language>
languages: [<list>]
primary_framework: <or "none">
frameworks: [<list>]
platform: <macos|web|cli|cross-platform|cloud|unknown>
repo_url: <github url or "local">
repo_type: <github|local|bare|none>
default_branch: <main or master>
has_agents_md: <true/false>
has_gitignore: <true/false>
state: operational
condition: condition-green
priority: P2
criticality: tier-2
owner: josh
owner_type: human
last_active: <today>
last_checkin: <today>
timestamp: <today>
stale_threshold_days: 14
depends_on: [<slugs>]
depended_on_by: []
tags: [<3-5 keywords>]
file_version: "1.0"
---

# <name>

<One paragraph describing what this project is and does.>

## Location

`workspace/<slug>/`

## Current Focus

<One sentence. What's actually being worked on right now, based on git log and dirty files.>

## Next Actions

- [ ] <Concrete action — biggest gap first>
- [ ] <Concrete action>
- [ ] <Concrete action>

Exactly 3 items. No more, no less. Prioritize gaps found below.

## Blockers

<If none, write "None.">

## Open Decisions

<Questions waiting on input. If none, write "None.">

## Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| <today> | Initialized as ADAMA outpost | Created state file during outpost initialization |

## Compliance Gaps

<Every standard that is not met, one per line. Be specific.>

- **<gap>** — <one-line fix or reason it cannot be fixed>
- e.g. **No AGENTS.md** — create with repo-specific agent instructions
- e.g. **.gitignore missing .venv/** — add `.venv/` to .gitignore
- e.g. **No test suite** — no test command found; recommend adding `npm test`

## Repo Notes

<Special considerations for this repo. Anything an agent working here should know that isn't captured above. Gotchas, unusual setup, conventions.>

## Template Feedback

<How does the state file template fall short for THIS repo? What fields are confusing, missing, or overkill? What would you change about the control plane or standards to better support this outpost?>
```

## Step 3 — Fill In What You Can

Frontmatter fields you should be able to determine from exploration:
- slug, name, category, domain, primary_language, languages, frameworks, platform
- repo_url, repo_type, default_branch
- has_agents_md, has_gitignore
- last_active, last_checkin, timestamp
- tags

Frontmatter fields you CANNOT determine — leave as-is or mark unknown:
- criticality, owner (these come from ADAMA)
- depends_on, depended_on_by (cross-outpost knowledge)

Body sections:
- `## Compliance Gaps` — audit exhaustively. Every file that should exist but doesn't. Every convention that's broken. Be specific.
- `## Repo Notes` — anything surprising. Legacy baggage. Build quirks. "The test command is `./scripts/test.sh` not `npm test`."
- `## Template Feedback` — this is the most important section. Where does the template fail for this specific repo? Is `category` missing a value? Does `platform` not apply? Is 3 next actions too rigid? What field needs to exist but doesn't?

## Step 4 — Git Commit + Push

Commit the state file and any other fixes you made:
```
git add <slug>-state.md
git commit -m "chore: initialize outpost state file"
git push
```

If the repo has no git remote, note it in `## Compliance Gaps`.

## Step 5 — Report

Return:
```
## Initialized: <name>

### State file created
<slug>-state.md — <N> frontmatter fields filled

### Compliance gaps
- <list>

### Top template feedback
- <most important suggestion>
```
```
