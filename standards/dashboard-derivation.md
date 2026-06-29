---
type: standard
tags: [dashboard, derivation, standards]
timestamp: 2026-06-28
---

# Standard: Dashboard Derivation

The dashboard is not a hand-maintained document. It is a deterministic view computed from the YAML frontmatter of every outpost state file. Any agent or human can verify it in one command.

## Principle

> Every field in the dashboard has a single source of truth. No dashboard value exists that isn't derivable from a state file frontmatter field.

## Source

```
sisko/outposts/
├── _aporium-state.md    →  symlink → ../workspace/_aporium/_aporium-state.md
├── _basicly-state.md    →  symlink → ../workspace/basicly/_basicly-state.md
├── _jamboree-state.md   →  symlink → ...
├── _sisko-state.md      →  symlink → ../workspace/sisko/_sisko-state.md
└── ...
```

Every `.md` file in `outposts/` is a symlink to a real state file in its repo. The dashboard reads through these symlinks.

## Dashboard Table

```
| Outpost | State | Condition | Priority | Tier | Last Active | Focus |
```

### Column Mapping

| Dashboard Column | Frontmatter Field | Logic |
|---|---|---|---|
| Outpost | `name` | Display name, wikilinked to symlink target |
| State | `state` | Raw value |
| Condition | `condition` | Raw value, or `—` if terminal state |
| Priority | `priority` | Raw value |
| Tier | `criticality` | Raw value |
| Last Active | `last_active` | Date, with staleness indicator if threshold exceeded |
| Focus | — | First line of `## Current Focus` body section |

### Sorting

```
1. criticality  (tier-0 → tier-3)
2. priority     (P1 → P4 within each tier)
3. state        (operational first, then dormant, then terminal)
4. name         (alphabetical)
```

### Staleness Indicator

If `last_active` exceeds `stale_threshold_days` from today:
- Append `⚠` to the Last Active cell
- Also triggers `condition: yellow-alert` at next check-in if not already

## Control Plane Health (aggregations)

Every field in the health section is derived:

```
compliance_score = sum(has_agents_md + has_gitignore) per outpost
max_compliance   = 2 * outpost_count

operational_count     = count(state == 'operational')
dormant_count         = count(state == 'dormant')
commissioning_count   = count(state == 'commissioning')
decommissioned_count  = count(state == 'decommissioned')
transiting_count      = count(state == 'transiting')
total_outposts        = count(all)

green_count    = count(condition == 'condition-green' AND state == 'operational')
yellow_count   = count(condition == 'yellow-alert' AND state == 'operational')
red_count      = count(condition == 'red-alert' AND state == 'operational')
adrift_count   = count(condition == 'adrift')
```

Display:
```
Control Plane Health
- Outposts: {total_outposts}  ({operational_count} operational, {dormant_count} dormant, ...)
- Condition: {green_count} green, {yellow_count} yellow, {red_count} red, {adrift_count} adrift
- Compliance: {compliance_score}/{max_compliance}
- Standards: 3 standards files
```

## Rebuilding the Dashboard

### Shell Verification (no yq required)

Verify outpost count matches workspace dir count:
```bash
diff <(ls outposts/*.md | xargs -n1 basename -s .md | sort) \
     <(ls -d ../*/ | grep -v sisko | xargs -n1 basename | sort)
```

Verify all symlinks resolve:
```bash
for f in outposts/*.md; do [ -L "$f" ] && [ -e "$f" ] || echo "BROKEN: $f"; done
```

Extract all states for quick scan:
```bash
for f in outposts/*.md; do
  slug=$(basename "$f" .md)
  state=$(sed -n '/^---$/,/^---$/p' "$f" | grep '^state:' | cut -d' ' -f2)
  cond=$(sed -n '/^---$/,/^---$/p' "$f" | grep '^condition:' | cut -d' ' -f2)
  echo "$slug | $state | $cond"
done
```

### Agent Rebuild

An agent rebuilding the dashboard:
1. Read every symlink in `outposts/*.md`
2. Extract frontmatter (between `---` fences)
3. Apply column mapping above
4. Sort by sort order
5. Compute health aggregations
6. Write `dashboard.md`

An agent verifying the dashboard:
1. Read every state file's frontmatter
2. Recompute the table and aggregations
3. Diff against current `dashboard.md`
4. Report discrepancies

## Dashboard Template (output only)

```
---
type: reference
tags: [dashboard, derived]
timestamp: YYYY-MM-DD
---

# Dashboard

> Derived from outpost state files. Last rebuilt: YYYY-MM-DD.

## Active Outposts

| Outpost | State | Condition | Priority | Tier | Last Active | Focus |
|---|---|---|---|---|---|---|
| {{ range sorted outposts }} |
| [[outposts/{{slug}}-state|{{name}}]] | {{state}} | {{condition_display}} | {{priority}} | {{criticality}} | {{last_active}}{{stale_marker}} | {{focus_line}} |
| {{ end }} |

## Blockers

{{ range outposts where blockers present }}
- **{{name}}**: {{blocker_summary}}
{{ end }}

## Control Plane Health

- Outposts: {{total}} ({{operational_count}} operational, {{dormant}} dormant, {{commissioning}} commissioning, {{transiting}} transiting, {{decommissioned}} decommissioned)
- Condition: {{green}} green, {{yellow}} yellow, {{red}} red, {{adrift}} adrift
- Compliance: {{compliance_score}}/{{max_compliance}}
- Standards: {{standards_count}} standards files

## Recent Activity

> Derived from last_active across all outposts. Outposts active in past 7 days:

{{ range outposts where last_active >= 7 days ago }}
- **{{name}}** — {{last_active}}
{{ end }}

*No recent activity.* (if none)

---
*Dashboard is derivable. To verify: read all `outposts/*.md` frontmatter and recompute.*
```

## Related

- [[outpost-state|Outpost State File]]
- [[okf|OKF Convention]]
