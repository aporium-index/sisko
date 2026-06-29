---
type: reference
tags: [hot, changelog, chronological]
timestamp: 2026-06-28
---

# hot

Chronological change log for the workspace. Newest at top.

## 2026-06-29

### ADAMA — v1.5 standards from Aporium template feedback (12 items)
- **`last_content_activity`** — new temporal field for content-primary outposts (Markdown, docs)
- **`test_commands`** — replaces single `test_command` string with list of named verification commands (name, command, kind, scope, last_run, result)
- **`repositories`** — optional map for split-topology outposts (state repo + content worktree + external gitdir)
- **`health_metrics`** — optional dated evidence map for knowledge-base/audit outposts
- **`has_agents_md`/`has_gitignore`** → tri-state enum: `compliant | partial | missing` (replaces boolean)
- **OKF compatibility profiles** — `aporium-v1` and `standard` profiles in standards/okf.md
- **External-state exception** — iCloud vault outposts may place state file externally; added to standards/agents.md
- **Review-packet version pinning** — init prompts must pin standards version; agent reports skew before editing
- **Cross-vault link syntax** — outpost-prefixed wikilinks (`[[aporium:wiki/index.md]]`) resolve in linked vault context
- **v1.5 migration diff** — 1.4→1.5 diff in standards/outpost-state.md
- **ADAMA-state.md** — migrated to v1.5, all new fields adopted
- **standards/agents.md** — "End every message with 3 next actions" strengthened (must be exactly 3, never fewer)
- **AGENTS.md (root)** — added "End every message with 3 next actions" rule
- **check-standards** — pending run to verify consistency

### ADAMA — Dashboard rebuilt from state file frontmatter
- Fixed compliance table: Aporium (✓✓→✗✗), jamboree (✗✓→✗✗), quotaz (✗✓→✗✗), prosodymaker (✓✓→✗✗), mac-optimization-audit (✗✗→✓✓)
- Fixed 5 stale `last_active` dates: Aporium, jamboree, quotaz, prosodymaker, mac-optimization-audit
- Added `Status` column per dashboard-derivation.md spec; `Description` → `Focus`
- Compliance score corrected: 11/16 → 5/16
- Dormant rows now show `—` for Phase (was conflating `phase` with `status`)

### ADAMA — agents.md end-of-message rule reverted to original scope
- The "end every message with suggestions" rule applies to ADAMA-scoped tasks only (state reviews, check-ins, dashboard work), not every coding conversation. Original "1-3" language restored.

### ADAMA — Schema migration rule added to outpost-state.md
- New `## Schema Migration` section declares authoritative `file_version: "1.4"`
- Version bump triggers defined: new required fields, renamed fields, new body sections, enum additions
- Cumulative diffs for 1.1→1.2, 1.2→1.3, 1.3→1.4
- Migration procedure: apply diffs in order, re-audit compliance booleans, bump version
- Agent checklist for migrating outpost state files

### ProsodyMaker — Stale `eager-metatarsal` branch + worktree pruned
- Branch was fully merged into `main` with zero unique commits
- Worktree path pointed to pre-rename `Code Projects` location (stale)
- State file updated: compliance gap resolved, backlog item marked done, `file_version` bumped to 1.4

## 2026-06-28

### ADAMA — Template v1.4 (5 mac-optimization-audit feedback items)
- Removed stale `has_gitignore` note in init-outpost.md (said "true means file exists" — contradicted v1.2 convention)
- Dormant outposts exempt from top-three rule: `## Reactivation Checklist` replaces `## Full Backlog` when `status: dormant`
- `documentation` added to `interfaces` enum (audit/docs repos primary interface is not a script)
- `evidence_as_of` + `verification_scope` optional fields — for audit/research outposts where findings expire with OS/hardware/app versions
- Freshness semantics clarified in dashboard-derivation.md: `last_active` (liveness) vs `last_code_activity` (product velocity) vs `last_push` (remote sync)
- file_version bumped to 1.4

### ADAMA — Template v1.3 (6 quotaz feedback items)
- `models` → `local_models` (evaluators catalog remote models but load none locally)
- `platform` split into `interfaces` (cli/web/tui/api/gui) + `platform` (macos/linux/cross-platform)
- `## Health Risks` body section — degradations that don't stop work (broken typecheck, strategic gates)
- `stack_categories` optional map — `{runtime: [...], test: [...], build: [...]}` when `frameworks` is lossy
- `maturity` enum — `prototype`/`pre-release`/`stable` — distinguishes working-but-pre-decision from committed
- `last_push` temporal field — date of last successful git push, distinguishes local activity from remote sync
- init-outpost.md + dashboard-derivation.md updated for all new fields
- file_version bumped to 1.3

### ADAMA — Template v1.2 (6 open jamboree feedback items)
- `runtimes` + `models` optional list fields (orchestration stacks)
- `platform` changed scalar → list of enum (hybrid platforms)
- `repo_layout` + `submodule_count` fields (submodule superprojects)
- `has_gitignore`/`has_agents_md` now mean compliant, not just exists
- `test_command` + `ci` + `hardware_requirements` verification fields
- `last_code_activity` temporal field (admin vs product activity)
- `primary_framework` omit-when-none convention
- init-outpost.md updated with new fields + `last_code_activity` git command
- dashboard-derivation.md updated with `last_code_activity` column
- file_version bumped to 1.2

### ADAMA — Sisko purge + standards check
- bin/serve: `SISKO_ROOT` → `ADAMA_ROOT` (3 references) — last sisko→ADAMA rename leftover
- bin/check-standards: new script — 7 checks for retired enums (`operational`, `commissioning`, `transiting`), retired `state` field, retired `## Next Actions` section, OKF bare `status:`, legacy `sisko` name. All passing.
- Run after any standards change to catch drift early.

### ADAMA — Agent behavior rules added
- standards/agents.md: new "Backlog Hygiene" section — mark done immediately, never suggest already-taken actions, end every message with suggestions
- Triggered by agent suggesting actions that were already completed in a prior commit (items left as `[ ]` instead of `[x]`)

### ADAMA — Status field collision resolved
- OKF `status` (active|draft|archived) renamed to `publication_status` in standards/okf.md
- Outpost lifecycle `status` (dormant|decommissioned|destroyed) unchanged
- Zero-churn fix: no state files or dashboard logic used OKF's status values
- Completes all 3 template gaps surfaced by jamboree init review

### ADAMA — Init process improvements (from jamboree review)
- Reviewed jamboree state file (first outpost to run init) — all claims verified accurate
- **standards/init-outpost.md** strengthened: audit checklist now checks .gitignore *contents* (not just existence); state file OKF frontmatter validation added (`type: project`); `## Template Feedback` added to body section list; top-3 marking convention formalized (`**Top N:**` prefix); commit step now uses `git add -A` (was only adding state file)
- **standards/outpost-state.md** updated: `type: project` added to template frontmatter and field reference; `## Template Feedback` added to body section reference table and template example
- **ADAMA-state.md** — `type: project` added to frontmatter for OKF compliance
- Connected previous opencode sisko chats to ADAMA: updated project.worktree + 6 session.directory paths in opencode.db from `/sisko` to `/ADAMA`
- 3 new top backlog items: add `type: project` to template, resolve OKF/lifecycle `status` collision, strengthen init audit checklist

### ADAMA — Standards self-audit & reconciliation
- **.gitignore** brought up to git.md minimum (added `node_modules/`, `.venv/`, `__pycache__/`)
- **ADAMA-state.md** rewritten: `languages: [python]`, location/notes precise, all 9 body sections refreshed from audit findings, `## Template Feedback` section added (7 items)
- **standards/agents.md** § Three Next Actions Rule → renamed to Top-Three Backlog Rule, now references `## Full Backlog` (was pointing at a non-existent `## Next Actions` section)
- **standards/dashboard-derivation.md** migrated to phase model: column mappings use `phase`/`status`/`condition` (was using retired `state`/`operational`/`commissioning`/`transiting` enums); sorting, aggregations, shell snippets, and output template updated; stale symlink examples fixed
- **Compliance gaps closed:** .gitignore incomplete, dashboard-derivation.md contradicted outpost-state.md, agents.md contradicted outpost-state.md
- **Open:** hot.md was not updated for the phase model overhaul — fixed this entry

### ADAMA — Phase model overhaul
- Replaced starship states with honest `brief → survey → outpost` pipeline
- State files restructured: description/location moved to YAML frontmatter
- Template v1.1: `## Full Backlog` (all actions, top-3 immediate) replaces `## Next Actions`
- `phase`/`status`/`condition` fields replace retired `state` enum
- Init prompt (standards/init-outpost.md) rewritten for broader scope

## 2026-06-28

### ADAMA — Architecture consolidation
- Replaced `projects/` → `outposts/` (distinct term, no collision risk)
- State files replace PROJECT.md: each outpost has `<slug>-state.md` in repo root
- `outposts/` now contains symlinks pointing to real state files — zero duplication
- Dashboard is now derivable from state file frontmatter (see `standards/dashboard-derivation.md`)
- Deleted PROJECTS.md, sessions/ directory
- New standards: `outpost-state.md` (template), `dashboard-derivation.md` (rebuild logic)
- Updated `agents.md` (3 next actions rule, no sessions)
- Updated `git.md` (always commit + push)
- Aporium dev-state dir renamed: `Aporium-dev-state` → `_aporium`

### ADAMA — Bootstrap
- Initialized control plane repo
- Created AGENTS.md, PROJECTS.md, dashboard.md, standards/ (git, agents, okf)
- obsidian-skills cloned to `~/.opencode/skills/obsidian-skills`
- OKF frontmatter applied to all ADAMA files
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
