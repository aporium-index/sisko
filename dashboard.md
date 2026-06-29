---
type: reference
tags: [dashboard, derived]
timestamp: 2026-06-28
---

# Dashboard

> Derived from `outposts/*.md` symlinks. Rebuilt 2026-06-28.

## Active Outposts

| Outpost | State | Condition | Priority | Tier | Last Active | Focus |
|---|---|---|---|---|---|---|
| [[outposts/sisko-state\|sisko]] | operational | condition-green | P1 | tier-0 | 2026-06-28 | Architecture consolidation: symlink-based tracking, derived dashboard |
| [[outposts/_aporium-state\|Aporium]] | operational | condition-green | P1 | tier-1 | 2026-06-28 | sisko bootstrap — defining control plane standards |
| [[outposts/basicly-state\|basicly]] | operational | condition-green | P2 | tier-2 | 2026-06-28 | Transitioning from spike to implementation |
| [[outposts/jamboree-state\|jamboree]] | operational | condition-green | P2 | tier-2 | 2026-06-28 | Local audio pipeline integration |
| [[outposts/quotaz-state\|quotaz]] | operational | condition-green | P3 | tier-2 | 2026-06-28 | Pipeline automation active |
| [[outposts/prosodymaker-state\|prosodymaker]] | operational | condition-green | P3 | tier-3 | 2026-06-28 | Tracker/logs-based iteration (v0.55.0) |

## Maintenance / Dormant

| Outpost | State | Condition | Priority | Tier | Last Active | Focus |
|---|---|---|---|---|---|---|
| [[outposts/ml-feedback-program-state\|ml-feedback-program]] | dormant | — | P4 | tier-3 | 2026-06-26 | Dormant — needs discovery |
| [[outposts/mac-optimization-audit-state\|mac-optimization-audit]] | dormant | — | P4 | tier-3 | 2026-06-20 | Reference documentation only |

## Blockers

*None.*

## Control Plane Health

- Outposts: 8 total (6 operational, 2 dormant)
- Condition: 6 green, 0 yellow, 0 red, 0 adrift
- Compliance: 11/16 (see below)
- Standards: 5 files (agents, git, okf, outpost-state, dashboard-derivation)

### Compliance

| Outpost | AGENTS.md | .gitignore |
|---|---|---|
| sisko | ✓ | ✓ |
| Aporium | ✓ | ✓ |
| basicly | ✓ | ✗ |
| jamboree | ✗ | ✓ |
| quotaz | ✗ | ✓ |
| prosodymaker | ✓ | ✓ |
| mac-optimization-audit | ✗ | ✗ |
| ml-feedback-program | ✗ | ✗ |

## Recent Activity

Outposts active in past 7 days:
- **sisko**, **Aporium**, **basicly**, **jamboree**, **quotaz**, **prosodymaker** — 2026-06-28
- **ml-feedback-program** — 2026-06-26
- **mac-optimization-audit** — 2026-06-20

---
*To verify: read all `outposts/*.md` frontmatter and recompute.*
