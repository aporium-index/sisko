---
type: standard
tags: [agents, behavior, conventions]
timestamp: 2026-06-28
---

# Standard: Agent Behavior

**Purpose**: How AI coding agents should behave in every workspace outpost.

## Every Outpost Must Have
1. **`AGENTS.md`** in repo root — tells any agent how to work in that repo.
2. **`<slug>-state.md`** in repo root — status, state, condition, next actions, decisions. This is the outpost's interface to sisko.
3. **`.gitignore`** — minimum: `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/`

## Agent Startup Protocol
1. Read the outpost's `AGENTS.md`.
2. Read the outpost's `<slug>-state.md` for current focus and next actions.
3. Check `git status` — note dirty files, work around them.
4. If blocked or unsure, check sisko's `dashboard.md` for cross-outpost context.

## Agent Shutdown Protocol
1. Update the outpost's `<slug>-state.md`: set `last_active`, update `## Current Focus`, check off completed actions, add new ones.
2. Git commit and push all changes.
3. If the outpost's condition has changed (build broken, blockers found), note it in `## Blockers` so sisko picks it up at next check-in.

## Three Next Actions Rule
The `## Next Actions` section must always contain exactly three items. Not two. Not ten. Three. This forces prioritization. If there are more than three candidates, pick the three that unblock the most downstream work. If there are fewer than three, the outpost is idle or needs direction — flag it.

## Git: Always Commit + Push
After every session, commit all changes and push to remote. No uncommitted work lingers between sessions. No stash-and-forget. If work is incomplete, commit with `WIP:` prefix and push. sisko considers `last_active` stale if there's no push within `stale_threshold_days`.

## Visibility Rule
- **Before any operation expected to take more than 5 seconds**, say what the operation is and roughly how long.
- **If the human asks "are you stuck?"**: respond with what operation is in progress.
- **Check progress signals**: if multiple turns pass without a tool call returning, say so.

## Cross-Outpost Rules
- Agents work in one outpost at a time.
- If work touches multiple outposts, update each outpost's state file.
- sisko is read-only for most agents — only the human or explicitly tasked agents edit sisko files.

## Verification Threshold
For any autonomous workflow that makes persistent, externally visible, or security-relevant changes, state:
1. **Task boundary** — explicit scope, forbidden actions, success condition.
2. **Context boundary** — which instructions/memory are allowed.
3. **Checkpoint boundary** — pause/review before irreversible action.
4. **Verification boundary** — output checked by tests, diffs, or second-pass critique.
5. **Reversibility boundary** — containment through rollback or audit trace.

## Related
- [[git|Git Conventions]]
- [[okf|OKF Convention]]
- [[outpost-state|Outpost State File]]
