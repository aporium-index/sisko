---
type: standard
tags: [outpost, state, template, standards]
timestamp: 2026-06-28
---

# Standard: Outpost State File

Every repo carries one status file: `<slug>-state.md`. ADAMA's `outposts/` directory contains symlinks to each. The dashboard reads these files — never hand-maintained.

## Who Writes What

| Field group | Writer | When |
|---|---|---|
| Identity, description, location, stack | Outpost agent or human | At init, then on change |
| Repository layout, verification | Outpost agent | At init, then on change |
| Compliance fields | Outpost agent | Re-checked on every session end |
| Phase, maturity, condition, priority, criticality, owner | **ADAMA** (or human) | During check-in only |
| Temporal fields | Automated | On every write |

Outpost agents do NOT set `phase`, `maturity`, `condition`, `priority`, or `criticality`. They report issues in `## Blockers` and degradations in `## Health Risks`. ADAMA assigns these during check-in.

## Phases (lifecycle pipeline)

```
brief ──► survey ──► outpost
(idea)    (evaluate)   (build)
```

| Phase | Meaning |
|-------|---------|
| `brief` | Idea stage. Light investigation. No commitment to build. May not have a repo yet. |
| `survey` | Evaluating. Gathering requirements, validating feasibility. May have initial work but no committed roadmap. |
| `outpost` | Building. Committed, active development, clear direction. |

Phases are forward-only until a deliberate decision to move back. An outpost in `brief` graduates to `survey` when someone commits to evaluating it. An outpost in `survey` graduates to `outpost` when development begins in earnest.

Terminal statuses — an outpost leaves the active pipeline:

| Status | Meaning |
|--------|---------|
| `dormant` | Paused. Can be reactivated. Preserves state. |
| `decommissioned` | Retired. Preserved for reference. |
| `destroyed` | Deleted permanently. |

An outpost in any phase can move to `dormant`. Only decommissioned/destroyed are final.

## Condition (health)

Cuts across all phases and statuses:

| Condition | Meaning |
|-----------|---------|
| `condition-green` | Everything nominal |
| `yellow-alert` | Degraded — issues detected, still functional |
| `red-alert` | Critical — immediate intervention needed |
| `adrift` | Unresponsive — no contact, manual recovery |

Condition is null when status is terminal (dormant/decommissioned/destroyed).

## Template

```markdown
---
# ── OKF ──
type: project

# ── Identity ──
slug: _aporium
name: Aporium
category: knowledge-base
domain: ai-psychology

# ── Description & Location ──
description: >
  Personal knowledge base at the intersection of AI, human psychology,
  and meaning-making. Built on the Karpathy LLM Wiki pattern.
location: ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Aporium
location_note: iCloud vault — agent dev-state at workspace/_aporium/

# ── Stack ──
primary_language: markdown
languages: []
primary_framework: obsidian
frameworks: []
runtimes: []
local_models: []
interfaces: [web]
platform: [cross-platform]
stack_categories: {}

# ── Repository ──
repo_url: https://github.com/aporium-index/aporium-vault
repo_type: bare
default_branch: master
repo_layout: standard
submodule_count: 0

# ── Verification ──
test_command: null
ci: false
hardware_requirements: null
evidence_as_of: null
verification_scope: null

# ── Compliance ──
# has_agents_md / has_gitignore: true only if file EXISTS AND meets standards.
# If file exists but is non-compliant, set false and list gap in ## Compliance Gaps.
has_agents_md: true
has_gitignore: true

# ── Lifecycle (ADAMA-written) ──
phase: survey
maturity: null
status: null
condition: condition-green

# ── Priority (ADAMA-written) ──
priority: P1
criticality: tier-1

# ── Ownership (ADAMA-written) ──
owner: josh
owner_type: human

# ── Temporal ──
last_active: 2026-06-28
last_code_activity: 2026-06-28
last_push: 2026-06-28
last_checkin: 2026-06-28
timestamp: 2026-06-28
stale_threshold_days: 14

# ── Dependencies (ADAMA-written) ──
depends_on: []
depended_on_by: []

# ── Meta ──
tags: [knowledge-base, obsidian, wiki, llm]
file_version: "1.4"
---

# {{ name }}

## Current Focus

OKF frontmatter retrofit on wiki pages. Branch cleanup complete.

## Full Backlog

- [ ] OKF frontmatter retrofit on all 845 wiki pages
- [ ] Resolve .opencode/node_modules pollution in vault
- [ ] Ontological preface test protocol
- [ ] Decide plugin trial sequence
- [ ] Raw provenance repair wave

## Blockers

None.

## Health Risks

None.

## Compliance Gaps

- **No CI pipeline** — no automated validation for wiki files
- **Wiki files not OKF conformant** — 845 files need frontmatter retrofit

## Long-Term Direction

Phase 1: OKF frontmatter retrofit across all wiki pages.
Phase 2: Compilation pipeline stabilization and agent-driven synthesis.
Phase 3: Public knowledge graph export.

Threshold: if the compilation pipeline can reliably produce publication-ready
syntheses, promote to outpost phase with P0 priority for a production release sprint.

## Open Decisions

- Obsidian plugin trial sequence: Omnisearch → Recent Files → Homepage → Style Settings?
- First deep research packet topic?

## Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-06-28 | Bare git repo for dev-state | iCloud sync conflicts with full git repos |
| 2026-06-28 | ADAMA as control plane name | Distinctive, won't collide with project naming |

## Repo Notes

Aporium lives outside `workspace/` due to iCloud constraints.
Wikilinks resolve within Aporium's vault context, not ADAMA's.

## Links

- AGENTS.md
- [[Aporium Wiki|wiki/index.md]]
- [[Aporium Hot|wiki/hot.md]]

## Template Feedback

- ~~OKF `status` field collides with lifecycle `status`~~ — resolved (OKF renamed to `publication_status`)
- `primary_framework: none` is awkward for repos with no framework — omit the field instead
- `domain` is a free string — consider a small enum for dashboard grouping
```

## Field Reference

### Identity
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `type` | yes | enum (`project`) | Outpost — OKF requirement, first field |
| `slug` | yes | string | Outpost |
| `name` | yes | string | Outpost |
| `category` | yes | enum | Outpost |
| `domain` | yes | string | Outpost |
| `tags` | no | list | Outpost |
| `file_version` | no | string | Outpost |

### Description & Location
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `description` | yes | string | Outpost |
| `location` | yes | string | Outpost |
| `location_note` | no | string | Outpost |

### Stack
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `primary_language` | yes | string | Outpost |
| `languages` | no | list | Outpost |
| `primary_framework` | no | string | Outpost — omit if none |
| `frameworks` | no | list | Outpost — runtime libraries/SDKs the code imports |
| `runtimes` | no | list | Outpost — host environments (e.g., `ableton-live-12`, `python-3.11`) |
| `local_models` | no | list | Outpost — local ML model artifacts loaded at runtime (e.g., `demucs-htdemucs`). Empty for outposts that call remote models but load none locally |
| `interfaces` | no | list of enum | Outpost — user-facing interfaces (e.g., `cli`, `web`, `tui`, `api`) |
| `platform` | no | list of enum | Outpost — OS/portability (e.g., `macos`, `linux`, `cross-platform`) |
| `stack_categories` | no | map | Outpost — structured breakdown: `{runtime: [...], test: [...], build: [...], sdk: [...]}`. Optional; use when `frameworks` flattening is lossy |

### Repository
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `repo_url` | no | string | Outpost |
| `repo_type` | yes | enum | Outpost |
| `default_branch` | no | string | Outpost |
| `repo_layout` | no | enum | Outpost |
| `submodule_count` | no | int | Outpost — only when `repo_layout: submodule-superproject` |
| `sensitivity` | no | enum | Outpost |

### Verification
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `test_command` | no | string | Outpost — command to run tests, null if none |
| `ci` | no | bool | Outpost — has CI workflow? |
| `hardware_requirements` | no | string | Outpost — hardware/gates that can't be CI-tested |
| `evidence_as_of` | no | date | Outpost — date when evidence/measurements were captured. Use for audit/research outposts where findings expire with OS, app, or hardware versions |
| `verification_scope` | no | string | Outpost — what the verification covers and what it doesn't (e.g., "syntax check only; no runtime validation") |

### Compliance
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `has_agents_md` | yes | bool | Outpost — true only if file EXISTS AND meets standards |
| `has_gitignore` | yes | bool | Outpost — true only if file EXISTS AND meets git.md minimum |

### Lifecycle
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `phase` | yes | enum | ADAMA |
| `maturity` | no | enum | ADAMA — distinguishes a working prototype awaiting decisions from a committed build |
| `status` | no | enum | ADAMA |
| `condition` | no | enum | ADAMA |

### Priority
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `priority` | yes | enum | ADAMA |
| `criticality` | yes | enum | ADAMA |

### Ownership
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `owner` | yes | string | ADAMA |
| `owner_type` | yes | enum | ADAMA |

### Temporal
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `last_active` | yes | date | Automated — any commit |
| `last_code_activity` | no | date | Automated — last commit touching non-state, non-docs files |
| `last_push` | no | date | Automated — last successful `git push` to remote |
| `last_checkin` | yes | date | Automated |
| `timestamp` | yes | date | Automated |
| `stale_threshold_days` | no | int | ADAMA |

### Dependencies
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `depends_on` | no | list | ADAMA |
| `depended_on_by` | no | list | ADAMA |

## Schema Migration

**Authoritative version:** `"1.4"`. The `file_version` field in the state file template reflects this version. All init-outpost prompts, dashboard derivation, and standard checkers reference this version.

### Version Bump Triggers

ADAMA bumps the schema version when:
- A new required field is added to the template
- An existing field is renamed or its type/semantics change
- A new required body section is added
- An enum value is added to a required enum

Minor editorial clarifications (rewording field descriptions, adding optional fields, updating examples) do not trigger a version bump.

### Migration Procedure

When an agent encounters a state file with an older `file_version`:

1. Do **not** rewrite the state file from scratch.
2. Apply the cumulative diff from the current version to the latest, in order.
3. After migration, set `file_version` to `"1.4"`.
4. Log the migration in `hot.md` if migrating in ADAMA context.
5. If a field already exists at the newer version (e.g., outpost adopted a v1.4 field before the version bump), do not duplicate it — just bump `file_version`.

### Version Diffs

#### 1.1 → 1.2

```
# New fields (add with null/empty defaults if unknown):
runtimes: []
local_models: []          # was named "models" in v1.1
repo_layout: standard
submodule_count: 0
test_command: null
ci: false
hardware_requirements: null
last_code_activity: null  # fall back to last_active if unknown

# Changed:
platform: [macos]         # was scalar, now list of enum
has_agents_md:            # now means compliant, not just exists — re-audit
has_gitignore:            # now means compliant, not just exists — re-audit

# Convention:
primary_framework:        # omit if none (was "none")
```

#### 1.2 → 1.3

```
# Renamed:
local_models: []          # was "models" — rename field, keep values

# New fields:
interfaces: []            # split from platform (user-facing: cli/web/tui/api/gui)
stack_categories: {}      # optional map when frameworks flattening is lossy
maturity: null            # prototype | pre-release | stable
last_push: null           # falls back to last_active if unknown

# Changed:
platform: [macos]         # now OS/portability only (macos/linux/cross-platform/cloud)
                          # user-facing values moved to interfaces

# New body section:
## Health Risks           # degradations that don't stop work
```

#### 1.3 → 1.4

```
# New fields:
evidence_as_of: null      # date when measurements captured (audit/research outposts)
verification_scope: null  # what verification covers and doesn't

# New interfaces enum value:
documentation             # added to interfaces enum

# Dormant outpost body section change:
## Reactivation Checklist  # replaces ## Full Backlog when status: dormant
                          # no minimum item count, top-three rule does not apply

# Clarified (no field changes):
# freshness semantics: last_active (liveness), last_code_activity (product velocity),
#   last_push (remote sync) are distinct — dashboard must not conflate them
```

### Agent Checklist

When migrating an outpost state file:

1. Note the current `file_version` in the state file.
2. Apply each version diff in order from current → latest.
3. For renamed fields: rename the key, preserve the value.
4. For new required fields: use `null`, `[]`, `{}`, or `false` as appropriate.
5. Re-audit `has_agents_md` and `has_gitignore` under the "compliant, not just exists" convention.
6. Bump `file_version` to `"1.4"`.
7. For dormant outposts (`status: dormant`): replace `## Full Backlog` with `## Reactivation Checklist`.

## Body Section Reference

| Section | Required | Purpose |
|---------|----------|---------|
| `# {{ name }}` | yes | Title |
| `## Current Focus` | yes | What's being worked on. One sentence |
| `## Full Backlog` | yes (active) | All next actions, prioritized. Top 3 marked with bold label prefix. Replaced by `## Reactivation Checklist` when dormant |
| `## Reactivation Checklist` | yes (dormant) | Conditions that must be true before reactivating. No minimum item count. Used when `status: dormant` |
| `## Blockers` | yes | What's stopped and why. "None." if empty |
| `## Health Risks` | yes | Degradations that don't stop work but should be tracked (broken typecheck, failing lint, strategic gates). "None." if empty |
| `## Compliance Gaps` | yes | Standards violations with fixes. "None." if clean |
| `## Long-Term Direction` | yes | Phases, milestones, 6-12 month vision, thresholds |
| `## Open Decisions` | yes | Questions waiting on input. "None." if empty |
| `## Decisions` | yes | Reverse-chronological decision log |
| `## Repo Notes` | yes | Gotchas, surprises for future agents |
| `## Links` | no | Wikilinks to related files |
| `## Template Feedback` | yes (on init/review) | Where the template falls short for this outpost. How ADAMA improves |

## Enums

### phase
`brief` (idea) | `survey` (evaluating) | `outpost` (building)

### status (terminal only)
`dormant` (paused) | `decommissioned` (retired) | `destroyed` (deleted)

### condition
`condition-green` | `yellow-alert` | `red-alert` | `adrift`

### priority
`P1` (now) | `P2` (soon) | `P3` (later) | `P4` (parked)

### criticality
`tier-0` (workspace infra: ADAMA) | `tier-1` (core) | `tier-2` (supporting) | `tier-3` (experiment)

### category
`application` | `library` | `tool` | `infrastructure` | `knowledge-base` | `audit` | `brand` | `experiment` | `control-plane`

### repo_type
`github` | `local` | `bare` | `none`

### sensitivity
`public` | `internal` | `confidential` | `restricted`

### platform (list of enum)
`macos` | `web` | `cli` | `cross-platform` | `cloud` | `linux`

### interfaces (list of enum)
`cli` | `web` | `tui` | `api` | `gui` | `documentation` | `none`

### maturity
`prototype` (works but pre-decision) | `pre-release` (feature-complete, polishing) | `stable` (production-ready). Null when phase is `brief` or outpost is clearly committed.

### repo_layout
`standard` | `submodule-superproject` | `monorepo`

### owner_type
`human` | `agent` | `team`

## Related

- [[dashboard-derivation|Dashboard Derivation]]
- [[okf|OKF Convention]]
- [[init-outpost|Init Prompt]]
