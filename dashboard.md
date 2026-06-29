---
type: reference
tags: [dashboard, derived]
timestamp: 2026-06-29
---

# Dashboard

> Derived from `outposts/*.md` symlinks. Rebuilt 2026-06-29.

## Phase Pipeline

```
brief ──► survey ──► outpost
(idea)    (evaluate)   (build)
```

| Phase | Outposts |
|-------|----------|
| outpost | ADAMA |
| survey | Aporium, basicly, jamboree, quotaz, prosodymaker |
| brief | — |
| dormant | Mac Optimization Audit, ml-feedback-program |

## All Outposts

| Outpost | Phase | Status | Condition | Priority | Tier | Last Active | Focus |
|---|---|---|---|---|---|---|---|---|
| [[outposts/ADAMA-state\|ADAMA]] | outpost | — | condition-green | P1 | tier-0 | 2026-06-28 | Control plane for the workspace |
| [[outposts/_aporium-state\|Aporium]] | survey | — | condition-green | P1 | tier-1 | 2026-06-29 | Personal knowledge base — AI, psychology, meaning-making |
| [[outposts/basicly-state\|basicly]] | survey | — | condition-green | P2 | tier-2 | 2026-06-28 | macOS language assistant — spelling, grammar, vocabulary signals |
| [[outposts/jamboree-state\|jamboree]] | survey | — | condition-green | P2 | tier-2 | 2026-06-29 | Audio suite — Ableton Live 12, Python, local audio pipeline |
| [[outposts/quotaz-state\|quotaz]] | survey | — | condition-green | P3 | tier-2 | 2026-06-29 | AI model eval toolkit — compare free-tier models |
| [[outposts/prosodymaker-state\|prosodymaker]] | survey | — | condition-green | P3 | tier-3 | 2026-06-29 | Chain-of-thought song maker — tracker/logs-based dev |
| [[outposts/mac-optimization-audit-state\|mac-optimization-audit]] | — | dormant | — | P4 | tier-3 | 2026-06-29 | Mac optimization reference docs |
| [[outposts/ml-feedback-program-state\|ml-feedback-program]] | — | dormant | — | P4 | tier-3 | 2026-06-26 | ML feedback — unknown stack, needs discovery |

## Compliance

| Outpost | AGENTS.md | .gitignore |
|---|---|---|---|
| ADAMA | ✓ | ✓ |
| Aporium | ✗ | ✗ |
| basicly | ✓ | ✗ |
| jamboree | ✗ | ✗ |
| quotaz | ✗ | ✗ |
| prosodymaker | ✗ | ✗ |
| mac-optimization-audit | ✓ | ✓ |
| ml-feedback-program | ✗ | ✗ |

## Control Plane Health

- Outposts: 8 (1 outpost, 5 survey, 2 dormant)
- Condition: 6 green, 0 yellow, 0 red, 0 adrift
- Compliance: 5/16

---
*To verify: read all `outposts/*.md` frontmatter and recompute.*
