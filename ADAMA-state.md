---
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
primary_framework: none
frameworks: []
platform: cross-platform
repo_url: https://github.com/aporium-index/ADAMA
repo_type: github
default_branch: master
sensitivity: internal
has_agents_md: true
has_gitignore: true
phase: outpost
status: null
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
tags: [control-plane, meta, markdown, standards, dashboard]
file_version: "1.1"
---

# ADAMA

## Current Focus

Standards self-audit: this session reviewed ADAMA's own state file against its standards, surfaced three internal contradictions (stale dashboard-derivation standard, agents.md/template section-name mismatch, incomplete .gitignore), and is landing fixes.

## Full Backlog

- [ ] **Fix .gitignore to meet git.md minimum** — add `node_modules/`, `.venv/`, `__pycache__/` (standards/git.md § Repo Structure)
- [ ] **Reconcile standards/dashboard-derivation.md with phase model** — still references old `state` field and `operational`/`commissioning`/`transiting` enums; outpost-state.md now uses `phase` (brief/survey/outpost) + `status` (dormant/decommissioned/destroyed)
- [ ] **Reconcile standards/agents.md § Three Next Actions Rule with template** — references a `## Next Actions` section that does not exist in outpost-state.md; template uses `## Full Backlog` with top-3 marking
- [ ] Append hot.md entry for phase model overhaul + this audit (hot.md stops at bootstrap day)
- [ ] Rename legacy `SISKO_ROOT` variable in bin/serve to ADAMA-named equivalent
- [ ] Dashboard as persistent background service (launchd) — currently manual start via Serve Dashboard.command
- [ ] AGENTS.md rollout for jamboree, quotaz, mac-optimization-audit, ml-feedback-program (see dashboard.md compliance table)
- [ ] Versioned release process for standards — CHANGELOG or version bump automation
- [ ] Consider enriching README.md (currently a stub: `# ADAMA`)

## Blockers

None.

## Compliance Gaps

- **`.gitignore` incomplete** — only `.DS_Store` and `.tmp/` present. Missing `node_modules/`, `.venv/`, `__pycache__/` required by standards/git.md § Repo Structure. Fix: append the three entries.
- **`standards/dashboard-derivation.md` contradicts `standards/outpost-state.md`** — derivation standard still uses the retired `state` field and `operational`/`commissioning`/`transiting`/`decommissioned` enums. The phase model (outpost-state.md § Phases) replaced these with `phase` (brief/survey/outpost) + `status` (dormant/decommissioned/destroyed). The live dashboard.md was migrated but the derivation standard was not. Fix: rewrite dashboard-derivation.md column mappings and aggregations to use `phase`/`status`/`condition`.
- **`standards/agents.md` § Three Next Actions Rule references a non-existent section** — it mandates "exactly three items" in `## Next Actions`, but the outpost-state.md template defines `## Full Backlog` (all actions, top three are the immediate focus). Outposts following agents.md will look for a section the template does not define. Fix: align agents.md wording to reference `## Full Backlog` and the top-3 convention.
- **`hot.md` not updated for recent work** — last entry is the 2026-06-28 bootstrap; the phase model overhaul, template v1.1, and this audit are unlogged. Fix: append a `## 2026-06-28` ADAMA section.

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

This is ADAMA reviewing its own template. The gaps below are real and worth fixing at the standards level:

1. **Section-name contradiction between standards.** `standards/agents.md` § Three Next Actions Rule mandates a `## Next Actions` section with "exactly three items." `standards/outpost-state.md` defines `## Full Backlog` (all actions, top three marked as immediate). These contradict. Either (a) rename the template section to `## Next Actions` and cap it at three, or (b) update agents.md to reference `## Full Backlog` and the top-3 convention. Recommendation: keep `## Full Backlog` (it captures the full backlog, which is useful institutional memory) and fix agents.md to point at it.

2. **`dashboard-derivation.md` did not get migrated with the phase model.** Suggests standards changes aren't being validated against each other. A pre-commit or session-end hook that greps standards for retired enum values (`operational`, `commissioning`, `transiting`) would catch this class of drift.

3. **No `standards/` self-consistency check in the template.** The audit checklist in the init prompt checks outpost files against standards, but nothing checks standards against each other. ADAMA is the one outpost where this matters most. Consider a `standards/consistency.md` meta-standard or a verification script.

4. **`primary_framework: none` is awkward.** The enum/string for "no framework" isn't specified. For infra/meta repos with no framework, either allow null or document `none` as the sentinel. Currently `primary_framework` is optional per the field reference — so the field could simply be omitted, but the template example shows a value. Clarify.

5. **`domain` is a free string.** ADAMA's `domain: meta` is underspecified compared to Aporium's `ai-psychology`. Consider a small enum or convention note (e.g., `meta`, `infra`, `product`, `research`, `personal`) so dashboards can group by domain.

6. **`category: control-plane` exists in the enum** but `control-plane` is the only outpost that will ever use it, and it overlaps with `infrastructure`. Consider whether `control-plane` is distinct enough, or fold into `infrastructure` with a `role: control-plane` field.

7. **The audit prompt's table lists `has_agents_md` and `has_gitignore` as "Matches reality" checks** but doesn't ask the reviewer to verify the .gitignore *contents* meet the git.md minimum — only that the file exists. This is how ADAMA's own .gitignore passed review while missing three required entries. Add a content check to the audit step.
