---
type: standard
tags: [outpost, state, template, standards]
timestamp: 2026-06-28
---

# Standard: Outpost State File

Every repo in the workspace carries a single status file: `_<slug>-state.md`. No other status files. No PROJECT.md. No README-as-status. This file is the outpost's interface to sisko.

Sisko's `outposts/` directory contains symlinks pointing to each repo's state file. The dashboard is derived from these symlinks — never hand-maintained.

## Who Writes What

| Field group | Writer | When |
|---|---|---|
| Identity, description, location | Human or commissioning agent | Once, at setup |
| Stack, repo, standards compliance | Agent (repo-level) | At setup, then on change |
| Current focus, next actions, decisions | Agent or human | After every working session |
| State, condition, priority, criticality, owner | **sisko** (or human) | During check-in only |
| Last active, last checkin, timestamp | Automated (agent or tooling) | On every write |

Repo-level agents do NOT set `state`, `condition`, or `priority`. They report issues in `## Blockers`. sisko assigns condition during check-in.

## File Naming

```
_<slug>-state.md
```

Lowercase. Underscore prefix matches repo directory convention (`_aporium/`). `-state` suffix distinguishes from other repo files.

Examples:
- `_aporium-state.md`
- `_basicly-state.md`
- `_sisko-state.md`

## Template

```markdown
---
# ── Identity (outpost-written at setup, rarely changes) ──
slug: _aporium
name: Aporium
category: knowledge-base
domain: ai-psychology
sensitivity: internal

# ── Stack (outpost-written at setup, updated when stack changes) ──
primary_language: markdown
languages: []
primary_framework: obsidian
frameworks: []
platform: cross-platform

# ── Repository (outpost-written at setup) ──
repo_url: local
repo_type: bare
default_branch: main

# ── Compliance (outpost-written, re-checked on session end) ──
has_agents_md: true
has_gitignore: true

# ── Lifecycle (sisko-written during check-in) ──
state: operational
condition: condition-green

# ── Priority (sisko-written during check-in) ──
priority: P1
criticality: tier-1

# ── Ownership (sisko-written) ──
owner: josh
owner_type: human

# ── Temporal (automated) ──
last_active: 2026-06-28
last_checkin: 2026-06-28
timestamp: 2026-06-28
stale_threshold_days: 14

# ── Dependencies (sisko-written) ──
depends_on: []
depended_on_by: []

# ── Meta ──
tags: [knowledge-base, obsidian, wiki, llm]
file_version: "1.0"
---

# {{ name }}

## Description

Personal knowledge base at the intersection of AI, human psychology, and
meaning-making. Built on the Karpathy LLM Wiki pattern. Obsidian vault
synced via iCloud.

## Location

`~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Aporium`

Dev-state bare repo at `workspace/_aporium/`.

## Current Focus

OKF frontmatter retrofit on wiki pages. Branch cleanup complete,
compilation pipeline is stable.

## Next Actions

- [ ] OKF frontmatter retrofit on all wiki pages
- [ ] Resolve .opencode/node_modules pollution in vault
- [ ] Ontological preface test protocol
- [ ] Decide plugin trial sequence

## Blockers

None.

## Open Decisions

- **Obsidian plugin trial sequence**: Omnisearch → Recent Files → Homepage → Style Settings?
- **First deep research packet**: AI companionship off-ramps vs local AI infrastructure vs creative infrastructure?

## Decisions

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-06-28 | Bare git repo for dev-state | iCloud sync conflicts with full git repos |
| 2026-06-28 | sisko as control plane name | Distinctive, won't collide with project naming |

## Notes

Aporium lives outside `workspace/` due to iCloud constraints.
Wikilinks in this file resolve within Aporium's vault context.

## Links

- AGENTS.md
- [[Aporium Wiki|wiki/index.md]]
- [[Aporium Hot|wiki/hot.md]]
```

## Field Reference

### Identity
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `slug` | yes | string | Outpost |
| `name` | yes | string | Outpost |
| `category` | yes | enum | Outpost |
| `domain` | yes | string | Outpost |
| `sensitivity` | no | enum | Outpost |
| `tags` | no | list | Outpost |

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

### Compliance
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `has_agents_md` | yes | bool | Outpost |
| `has_gitignore` | yes | bool | Outpost |

### Lifecycle
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `state` | yes | enum | sisko |
| `condition` | yes | enum | sisko |

### Priority
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `priority` | yes | enum | sisko |
| `criticality` | yes | enum | sisko |

### Ownership
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `owner` | yes | string | sisko |
| `owner_type` | yes | enum | sisko |

### Temporal
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `last_active` | yes | date | Automated |
| `last_checkin` | yes | date | Automated |
| `timestamp` | yes | date | Automated |
| `stale_threshold_days` | no | int | sisko |

### Dependencies
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `depends_on` | no | list | sisko |
| `depended_on_by` | no | list | sisko |

### Meta
| Field | Required | Type | Set by |
|-------|----------|------|--------|
| `file_version` | no | string | Outpost |

## Enums

### state
`commissioning` | `operational` | `dormant` | `transiting` | `decommissioned` | `destroyed`

### condition
`condition-green` | `yellow-alert` | `red-alert` | `adrift`

### priority
`P1` (now) | `P2` (soon) | `P3` (later) | `P4` (parked)

### criticality
`tier-0` (workspace infra: sisko) | `tier-1` (core product) | `tier-2` (supporting) | `tier-3` (experiment)

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

### owner (convention)
Use lowercase GitHub-style handles for humans, agent names for agents.

## Condition Determination

During check-in, sisko evaluates:

| If | Then condition |
|----|---------------|
| Outpost responded to check-in, no issues in `## Blockers` | `condition-green` |
| Outpost responded but reports blockers or stale warnings | `yellow-alert` |
| Outpost responded but reports build/tool failure, data loss, or auth breach | `red-alert` |
| Outpost is `operational` but `last_active` exceeds `stale_threshold_days` | `yellow-alert` (flag) |
| Outpost is `operational` but no response to check-in for 2x `stale_threshold_days` | `adrift` |

## Related

- [[dashboard|Dashboard Derivation]]
- [[okf|OKF Convention]]
