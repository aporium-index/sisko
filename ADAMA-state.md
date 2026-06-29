---
type: project
slug: ADAMA
name: ADAMA
category: control-plane
domain: meta
description: >
  Control plane for the workspace. Single source of truth for outpost
  status, priorities, standards, and cross-outpost coordination.
  Markdown-first: no databases, no APIs, no build steps.
location: ~/workspace/ADAMA/
location_note: Self-hosted — ADAMA's own state file lives here and is symlinked into outposts/ for uniform discovery
primary_language: markdown
languages: [python]
frameworks: []
runtimes: []
local_models: []
interfaces: [web]
platform: [cross-platform]
stack_categories: {}
repo_url: https://github.com/aporium-index/ADAMA
repo_type: github
default_branch: master
repo_layout: standard
submodule_count: 0
test_command: null
ci: false
hardware_requirements: null
evidence_as_of: null
verification_scope: null
sensitivity: internal
has_agents_md: true
has_gitignore: true
phase: outpost
maturity: stable
status: null
condition: condition-green
priority: P1
criticality: tier-0
owner: josh
owner_type: human
last_active: 2026-06-28
last_code_activity: 2026-06-28
last_push: 2026-06-28
last_checkin: 2026-06-28
timestamp: 2026-06-28
stale_threshold_days: 7
depends_on: []
depended_on_by: [_aporium, basicly, jamboree, quotaz, prosodymaker, mac-optimization-audit, ml-feedback-program]
tags: [control-plane, meta, markdown, standards, dashboard]
file_version: "1.4"
---

# ADAMA

## Current Focus

All three state files touched up to v1.4 (jamboree, quotaz, mac-optimization-audit). All template feedback from jamboree (9), quotaz (9), and mac-optimization-audit (6) resolved and struck through. Next: roll init to ml-feedback-program.

## Full Backlog

- [x] **Add `type: project` + `## Template Feedback` to outpost-state.md template** — `type: project` added to template frontmatter and field reference; `## Template Feedback` added to body section reference and template example
- [x] **Resolve `status` field collision between OKF and lifecycle** — OKF renamed `status` → `publication_status` (active|draft|archived); outpost lifecycle `status` (dormant|decommissioned|destroyed) unchanged; no state files needed updating
- [x] **Strengthen init-outpost.md audit checklist** — .gitignore content check added, OKF frontmatter validation for state file, top-3 marking convention formalized, commit step uses `git add -A`
- [x] Append hot.md entry for phase model overhaul + this audit
- [x] **Rename legacy `SISKO_ROOT` variable in bin/serve** — all 3 references renamed to `ADAMA_ROOT`
- [x] **Standards self-consistency check** — `bin/check-standards` script: 7 checks for retired enums, field names, section names, legacy names; run after any standards change
- [x] **Implement 6 open template feedback items from jamboree** — v1.2: `runtimes`/`models` fields, `platform` → list, `repo_layout`/`submodule_count`, compliance booleans = compliant not just exists, `test_command`/`ci`/`hardware_requirements`, `last_code_activity`
- [x] **Template v1.3: 3 adopt-now quotaz items** — `models` → `local_models`, split `platform` into `interfaces` + `platform`, added `## Health Risks` body section
- [x] **Template v1.3: 3 worth-considering quotaz items** — `stack_categories` map for structured stack, `maturity` enum (prototype/pre-release/stable), `last_push` temporal field
- [x] **Template v1.4: 5 mac-optimization-audit items** — stale `has_gitignore` note removed, dormant exemption from top-three rule, `documentation` interface enum, `evidence_as_of`/`verification_scope` fields, freshness semantics in dashboard-derivation.md
- [x] **Touch up jamboree-state.md** — v1.4 fields applied, Health Risks added, all 9 feedback items struck through, top-3 marking aligned
- [x] **Touch up quotaz-state.md** — v1.4 fields applied, Blockers/Health Risks split, all 9 feedback items struck through
- [x] **Touch up mac-optimization-audit-state.md** — evidence_as_of, verification_scope, documentation interface, Reactivation Checklist, all 6 feedback items struck through
- [ ] Dashboard as persistent background service (launchd) — currently manual start via Serve Dashboard.command
- [ ] AGENTS.md rollout for jamboree, quotaz, ml-feedback-program (see dashboard.md compliance table)
- [ ] Versioned release process for standards — CHANGELOG or version bump automation
- [ ] Consider enriching README.md (currently a stub: `# ADAMA`)

## Blockers

None.

## Health Risks

None.

## Compliance Gaps

- **`hot.md` now current** — phase model overhaul + this audit logged (was stopping at bootstrap day). Fixed this session.
- **`standards/dashboard-derivation.md` now reconciled** — migrated from retired `state`/`operational`/`commissioning`/`transiting` enums to `phase`/`status`/`condition`. Fixed this session.
- **`standards/agents.md` § Top-Three Backlog Rule now aligned** — references `## Full Backlog` per outpost-state.md template (was pointing at non-existent `## Next Actions`). Fixed this session.
- **`.gitignore` now meets git.md minimum** — `node_modules/`, `.venv/`, `__pycache__/` added. Fixed this session.
- **No versioned release process** — standards change often; need CHANGELOG or version bump automation. Open.
- **Dashboard requires manual server start** — should be a background service. Open.

## Long-Term Direction

Phase 1: Stable, internally consistent state model — every standard agrees with every other standard; every outpost file conforms to the template.
Phase 2: Self-updating dashboard (filesystem watch, live rebuild) — replaces the current manual `bin/serve` + hand-rebuilt `dashboard.md`.
Phase 3: Cross-outpost dependency graph (real `depends_on`/`depended_on_by` edges) and automated check-in scheduling.

Threshold: when all non-dormant outposts reach `outpost` phase with `condition-green` AND standards are internally consistent, ADAMA's `criticality` can drop from `tier-0` to `tier-1` (infrastructure is stable, no longer needs watching). 6-12 months: ADAMA becomes a read-only observability surface, touched only on structural changes.

## Open Decisions

- Dashboard as launchd background service, or keep manual `Serve Dashboard.command` start?
- Should ADAMA track opencode configuration (`~/.opencode/`) as a dependency or outpost?
- Should `standards/` enforce a version field per standard (semantic versioning of conventions)?

## Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-06-29 | Template v1.4 — 5 mac-optimization-audit feedback items | Removed stale has_gitignore note; dormant exemption from top-three rule (`## Reactivation Checklist`); `documentation` interface enum; `evidence_as_of`/`verification_scope` fields; freshness semantics in dashboard-derivation.md |
| 2026-06-28 | Template v1.3 — 6 quotaz feedback items | `models`→`local_models`, split `platform` into `interfaces`+`platform`, `## Health Risks` body section, `stack_categories` map, `maturity` enum, `last_push` temporal. All additive |
| 2026-06-28 | Template v1.2 — 6 open jamboree feedback items resolved | Added `runtimes`, `models`, `repo_layout`, `submodule_count`, `test_command`, `ci`, `hardware_requirements`, `last_code_activity`; `platform` scalar→list; compliance booleans now mean compliant not just exists; `primary_framework` omit-when-none convention. All additive — no state file breaks |
| 2026-06-28 | Added `bin/check-standards` self-consistency script | dashboard-derivation.md drifted from outpost-state.md after phase model; a grep for retired values catches this class of error. 7 checks, all passing |
| 2026-06-28 | Renamed `SISKO_ROOT` → `ADAMA_ROOT` in bin/serve | Last sisko→ADAMA rename leftover; cosmetic but confusing for future agents |
| 2026-06-28 | Added Backlog Hygiene rule to agents.md | Agent suggested already-completed actions because backlog items weren't marked done in the same commit; also added "end with suggestions" rule |
| 2026-06-28 | Renamed OKF `status` → `publication_status` | Outpost lifecycle `status` (dormant/decommissioned/destroyed) is established in phase model + dashboard-derivation; OKF's `status` (active/draft/archived) is recommended-only and applies to general markdown files. Renaming OKF's field is zero-churn — no state files or dashboard logic use OKF's status values |
| 2026-06-28 | Reviewed jamboree init — first outpost run | All claims verified accurate (23 tools, 15 docs, 11 submodules, 2 prunable worktrees); surfaced 3 high-impact template gaps now in backlog |
| 2026-06-28 | Connected sisko opencode chats to ADAMA | Updated project.worktree + 6 session.directory paths in opencode.db from /sisko to /ADAMA; project_directory was already migrated |
| 2026-06-28 | Standards reconciled with phase model | dashboard-derivation.md and agents.md were drifting from outpost-state.md after the phase-model overhaul; closed three contradictions in one pass |
| 2026-06-28 | Self-audit landed three standards fixes | ADAMA must conform to its own standards before enforcing them on outposts |
| 2026-06-28 | sisko → ADAMA | sisko looked like "sicko" |
| 2026-06-28 | Phase model: brief → survey → outpost | Starship metaphors were dishonest — no outpost was operational |
| 2026-06-28 | Description/location moved to YAML | Single-value fields don't belong in narrative body |
| 2026-06-28 | projects/ → outposts/ | Distinct term, no collision with generic project vocabulary |
| 2026-06-28 | Symlinks in outposts/ | Zero duplication. Outpost owns state file. ADAMA points to it. |

## Repo Notes

- ADAMA is tier-0 infrastructure. If ADAMA is down or contradictory, agents lose their bearings — standards self-consistency is a P0 invariant.
- Keep it minimal: no databases, no APIs, no build steps. The only executable code is `bin/serve` (Python 3 stdlib HTTP server) and `Serve Dashboard.command` (macOS launcher wrapping it).
- `outposts/ADAMA-state.md` is a self-symlink: it points back into this same repo (`../../ADAMA/ADAMA-state.md`) so ADAMA's own state is discoverable through the same uniform `outposts/*.md` glob as every other outpost. Correct, not a bug.
- `bin/serve` still uses the variable name `SISKO_ROOT` — a leftover from the sisko→ADAMA rename. Cosmetic, not functional.
- `dashboard.md` is derived, not hand-maintained. Any field edit must be re-derivable from `outposts/*.md` frontmatter (see standards/dashboard-derivation.md, which is currently stale — see Compliance Gaps).
- No tests, lint, or typecheck. Acceptable for a markdown-first repo; the closest thing to verification is the shell snippet in dashboard-derivation.md and the dashboard-vs-frontmatter diff check.
- `.DS_Store` files exist on disk in root and `outposts/` but are NOT git-tracked (confirmed via `git ls-files`).

## Links

- AGENTS.md
- dashboard.md
- hot.md
- index.html
- standards/outpost-state.md
- standards/dashboard-derivation.md
- standards/agents.md
- standards/git.md
- standards/okf.md
- standards/init-outpost.md

## Template Feedback

This is ADAMA reviewing its own template. Gaps tracked from init reviews. Resolved items struck through.

1. ~~**Section-name contradiction between standards.**~~ **Resolved** — agents.md now references `## Full Backlog` per the Top-Three Backlog Rule.

2. ~~**`dashboard-derivation.md` did not get migrated with the phase model.**~~ **Resolved** — dashboard-derivation.md migrated. `bin/check-standards` now catches this class of drift.

3. ~~**No `standards/` self-consistency check.**~~ **Resolved** — `bin/check-standards` script added (7 checks, all passing).

4. ~~**`primary_framework: none` is awkward.**~~ **Resolved** — v1.2 convention: omit the field when no framework. ADAMA-state.md now omits it.

5. **`domain` is a free string.** ADAMA's `domain: meta` is underspecified compared to Aporium's `ai-psychology`. Consider a small enum or convention note (e.g., `meta`, `infra`, `product`, `research`, `personal`) so dashboards can group by domain. **Open.**

6. **`category: control-plane` exists in the enum** but `control-plane` is the only outpost that will ever use it, and it overlaps with `infrastructure`. Consider whether `control-plane` is distinct enough, or fold into `infrastructure` with a `role: control-plane` field. **Open.**

7. ~~**Audit checklist didn't verify .gitignore contents.**~~ **Resolved** — init-outpost.md now checks contents, not just existence.

8. ~~**`has_gitignore: true` conflates existence with compliance.**~~ **Resolved** — v1.2 convention: `has_gitignore`/`has_agents_md` are true only if file exists AND meets standards. Non-compliant → false + gap in `## Compliance Gaps`.

9. ~~**Model orchestration stacks (jamboree feedback #3).**~~ **Resolved** — v1.2 adds `runtimes` and `models` optional list fields.

10. ~~**Hybrid platforms (jamboree feedback #4).**~~ **Resolved** — v1.2: `platform` changed from scalar to list of enum.

11. ~~**Submodule superprojects (jamboree feedback #5).**~~ **Resolved** — v1.2 adds `repo_layout` and `submodule_count` fields.

12. ~~**Verification commands (jamboree feedback #7).**~~ **Resolved** — v1.2 adds `test_command`, `ci`, `hardware_requirements` fields.

13. ~~**Admin vs substantive activity (jamboree feedback #8).**~~ **Resolved** — v1.2 adds `last_code_activity` temporal field.
