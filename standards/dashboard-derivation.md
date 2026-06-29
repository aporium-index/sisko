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
ADAMA/outposts/
├── _aporium-state.md    →  symlink → ../../_aporium/_aporium-state.md
├── basicly-state.md     →  symlink → ../../basicly/basicly-state.md
├── jamboree-state.md    →  symlink → ../../jamboree/jamboree-state.md
├── ADAMA-state.md       →  symlink → ../../ADAMA/ADAMA-state.md
└── ...
```

Every `.md` file in `outposts/` is a symlink to a real state file in its repo. The dashboard reads through these symlinks.

## Dashboard Table

```
| Outpost | State | Condition | Priority | Tier | Last Active | Focus |
```

### Column Mapping

| Dashboard Column | Frontmatter Field | Logic |
|---|---|---|
| Outpost | `name` | Display name, wikilinked to symlink target |
| Phase | `phase` | Raw value (`brief` / `survey` / `outpost`) |
| Status | `status` | Raw value (`dormant` / `decommissioned` / `destroyed`), or `—` if null (active) |
| Condition | `condition` | Raw value, or `—` if status is terminal |
| Priority | `priority` | Raw value |
| Tier | `criticality` | Raw value |
| Last Active | `last_active` | Date, with staleness indicator if threshold exceeded |
| Last Code | `last_code_activity` | Date of last non-state/non-docs commit. Falls back to `last_active` if absent. |
| Focus | — | First line of `## Current Focus` body section |

### Sorting

```
1. criticality  (tier-0 → tier-3)
2. priority     (P1 → P4 within each tier)
3. phase        (outpost → survey → brief), then terminal status
                 (dormant → decommissioned → destroyed)
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

# Phase counts (active pipeline)
brief_count      = count(phase == 'brief')
survey_count     = count(phase == 'survey')
outpost_count    = count(phase == 'outpost')

# Terminal status counts (left the pipeline)
dormant_count          = count(status == 'dormant')
decommissioned_count   = count(status == 'decommissioned')
destroyed_count        = count(status == 'destroyed')

total_outposts  = count(all)
active_count    = total_outposts - dormant_count - decommissioned_count - destroyed_count

# Condition counts — only meaningful for active outposts
green_count    = count(condition == 'condition-green' AND status == null)
yellow_count   = count(condition == 'yellow-alert'  AND status == null)
red_count      = count(condition == 'red-alert'     AND status == null)
adrift_count   = count(condition == 'adrift'        AND status == null)
```

Display:
```
Control Plane Health
- Outposts: {total_outposts} ({active_count} active: {outpost_count} outpost, {survey_count} survey, {brief_count} brief; {dormant_count} dormant, {decommissioned_count} decommissioned, {destroyed_count} destroyed)
- Condition: {green_count} green, {yellow_count} yellow, {red_count} red, {adrift_count} adrift
- Compliance: {compliance_score}/{max_compliance}
- Standards: {standards_count} standards files
```

## Rebuilding the Dashboard

### Shell Verification (no yq required)

Verify outpost count matches workspace dir count:
```bash
diff <(ls outposts/*.md | xargs -n1 basename -s .md | sort) \
     <(ls -d ../*/ | grep -v ADAMA | xargs -n1 basename | sort)
```

Verify all symlinks resolve:
```bash
for f in outposts/*.md; do [ -L "$f" ] && [ -e "$f" ] || echo "BROKEN: $f"; done
```

Extract all phases for quick scan:
```bash
for f in outposts/*.md; do
  slug=$(basename "$f" .md)
  phase=$(sed -n '/^---$/,/^---$/p' "$f" | grep '^phase:' | cut -d' ' -f2)
  status=$(sed -n '/^---$/,/^---$/p' "$f" | grep '^status:' | cut -d' ' -f2)
  cond=$(sed -n '/^---$/,/^---$/p' "$f" | grep '^condition:' | cut -d' ' -f2)
  echo "$slug | phase=$phase | status=$status | condition=$cond"
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

````
---
type: reference
tags: [dashboard, derived]
timestamp: YYYY-MM-DD
---

# Dashboard

> Derived from outpost state files. Last rebuilt: YYYY-MM-DD.

## Phase Pipeline

```
brief ──► survey ──► outpost
(idea)    (evaluate)   (build)
```

| Phase | Outposts |
|-------|----------|
| outpost | {{ names where phase == 'outpost' }} |
| survey | {{ names where phase == 'survey' }} |
| brief | {{ names where phase == 'brief' }} |
| dormant | {{ names where status == 'dormant' }} |
| decommissioned | {{ names where status == 'decommissioned' }} |

## All Outposts

| Outpost | Phase | Status | Condition | Priority | Tier | Last Active | Focus |
|---|---|---|---|---|---|---|---|
| {{ range sorted outposts }} |
| [[outposts/{{slug}}-state|{{name}}]] | {{phase}} | {{status_display}} | {{condition_display}} | {{priority}} | {{criticality}} | {{last_active}}{{stale_marker}} | {{focus_line}} |
| {{ end }} |

## Blockers

{{ range outposts where blockers present }}
- **{{name}}**: {{blocker_summary}}
{{ end }}

## Control Plane Health

- Outposts: {{total}} ({{active_count}} active: {{outpost_count}} outpost, {{survey_count}} survey, {{brief_count}} brief; {{dormant_count}} dormant, {{decommissioned_count}} decommissioned, {{destroyed_count}} destroyed)
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
````

## Related

- [[outpost-state|Outpost State File]]
- [[okf|OKF Convention]]
