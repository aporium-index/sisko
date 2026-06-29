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
| Compliance fields | Outpost agent | Re-checked on every session end |
| Phase, condition, priority, criticality, owner | **ADAMA** (or human) | During check-in only |
| Temporal fields | Automated | On every write |

Outpost agents do NOT set `phase`, `condition`, `priority`, or `criticality`. They report issues in `## Blockers`. ADAMA assigns these during check-in.

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
platform: cross-platform

# ── Repository ──
repo_url: https://github.com/aporium-index/aporium-vault
repo_type: bare
default_branch: master

# ── Compliance ──
has_agents_md: true
has_gitignore: true

# ── Lifecycle (ADAMA-written) ──
phase: survey
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
last_checkin: 2026-06-28
timestamp: 2026-06-28
stale_threshold_days: 14

# ── Dependencies (ADAMA-written) ──
depends_on: []
depended_on_by: []

# ── Meta ──
tags: [knowledge-base, obsidian, wiki, llm]
file_version: "1.1"
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

- OKF `status` field collides with lifecycle `status` — consider renaming one.
- `primary_framework: none` is awkward for repos with no framework.
- `domain` is a free string — consider a small enum for dashboard grouping.
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
| `primary_framework` | no | string | Outpost |
| `frameworks` | no | list | Outpost |
| `platform` | no | enum | Outpost |

### Repository
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `repo_url` | no | string | Outpost |
| `repo_type` | yes | enum | Outpost |
| `default_branch` | no | string | Outpost |
| `sensitivity` | no | enum | Outpost |

### Compliance
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `has_agents_md` | yes | bool | Outpost |
| `has_gitignore` | yes | bool | Outpost |

### Lifecycle
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `phase` | yes | enum | ADAMA |
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
| `last_active` | yes | date | Automated |
| `last_checkin` | yes | date | Automated |
| `timestamp` | yes | date | Automated |
| `stale_threshold_days` | no | int | ADAMA |

### Dependencies
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `depends_on` | no | list | ADAMA |
| `depended_on_by` | no | list | ADAMA |

## Body Section Reference

| Section | Required | Purpose |
|---------|----------|---------|
| `# {{ name }}` | yes | Title |
| `## Current Focus` | yes | What's being worked on. One sentence |
| `## Full Backlog` | yes | All next actions, prioritized. Top 3 marked with bold label prefix |
| `## Blockers` | yes | What's stopped and why. "None." if empty |
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

### platform
`macos` | `web` | `cli` | `cross-platform` | `cloud`

### owner_type
`human` | `agent` | `team`

## Related

- [[dashboard-derivation|Dashboard Derivation]]
- [[okf|OKF Convention]]
- [[init-outpost|Init Prompt]]
