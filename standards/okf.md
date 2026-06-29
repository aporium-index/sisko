---
type: standard
tags: [okf, frontmatter, conventions]
timestamp: 2026-06-28
---

# Standard: OKF Frontmatter Convention

<!-- Context: ADAMA/standards | Priority: high | Version: 1.0 | Updated: 2026-06-28 -->

**Purpose**: Adopt the Open Knowledge Format (OKF) frontmatter convention for all Markdown files in the workspace. Makes content portable and agent-readable.

## Required Fields

Every Markdown file that represents a knowledge artifact should start with:

```yaml
---
type: concept | guide | standard | project | session | reference
tags: []
timestamp: YYYY-MM-DD
---
```

## Type Values

| Type | Use for |
|---|---|
| `concept` | Core idea or definition |
| `guide` | How-to / procedural |
| `standard` | Convention or rule |
| `project` | Project metadata file |
| `session` | Session record |
| `reference` | Lookup table or cheat sheet |

## Additional Recommended Fields

```yaml
status: active | draft | archived
priority: P1 | P2 | P3 | P4
project: project-slug        # which project this belongs to
```

## Implementation
- Apply to all new files in ADAMA.
- Retrofit existing Aporium wiki pages (they already use similar YAML frontmatter — align field names).
- Other projects: apply to `AGENTS.md`, `PROJECT.md`, and any docs/ files.

## Compatibility
- OKF is compatible with Obsidian YAML frontmatter.
- Existing Aporium frontmatter already maps closely: `type`, `tags`, `status`, `last_updated`.
- The key addition is `timestamp` (ISO date, YYYY-MM-DD) for sortability.

## Related
- [[git|Git Conventions]]
- [[agents|Agent Standards]]
- [OKF Spec](https://github.com/GoogleCloudPlatform/knowledge-catalog/tree/main/okf)
