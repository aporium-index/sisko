---
type: standard
tags: [agents, behavior, conventions]
timestamp: 2026-06-28
---

# Standard: Agent Behavior

**Purpose**: How AI coding agents should behave in every workspace outpost.

## Every Outpost Must Have
1. **`AGENTS.md`** in repo root — tells any agent how to work in that repo.
2. **`<slug>-state.md`** in repo root — status, state, condition, next actions, decisions. This is the outpost's interface to ADAMA.
3. **`.gitignore`** — minimum: `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/`

## Agent Startup Protocol
1. Read the outpost's `AGENTS.md`.
2. Read the outpost's `<slug>-state.md` for current focus and next actions.
3. Check `git status` — note dirty files, work around them.
4. If blocked or unsure, check ADAMA's `dashboard.md` for cross-outpost context.

## Agent Shutdown Protocol
1. Update the outpost's `<slug>-state.md`: set `last_active`, update `## Current Focus`, check off completed actions, add new ones.
2. Git commit and push all changes.
3. If the outpost's condition has changed (build broken, blockers found), note it in `## Blockers` so ADAMA picks it up at next check-in.

## Top-Three Backlog Rule
The `## Full Backlog` section (per `outpost-state.md` template) holds all next actions in priority order. The **top three** items are the outpost's immediate focus — the three that unblock the most downstream work. If there are more than three candidates, pick three and demote the rest below a visible separator. If there are fewer than three candidates, the outpost is idle or needs direction — flag it in `## Open Decisions` or `## Blockers`.

**Dormant exemption:** When `status: dormant`, replace `## Full Backlog` with `## Reactivation Checklist` — conditions that must be true before reactivating (e.g., "baseline refreshed," "symptom reproduced"). No minimum item count. The top-three rule does not apply to dormant outposts.

## Backlog Hygiene
- **Mark done immediately.** When you complete a backlog item, mark it `[x]` in the same commit. Never leave completed work as `[ ]` — it causes duplicate suggestions and makes the outpost look idle.
- **Never suggest already-taken actions.** Before proposing a next action, verify it isn't already done or in progress. Read the backlog and recent git log before suggesting.
- **End every message with suggestions.** Every message that concludes a task — session, review, feedback, or status check — MUST end with exactly 3 concrete next actions from the backlog, ranked by impact. Never fewer than 3 unless the backlog has fewer than 3 remaining items. If the backlog is fully complete, surface 3 from the outpost's `## Open Decisions`. The human should never have to ask "what's next?"

## Git: Always Commit + Push
After every session, commit all changes and push to remote. No uncommitted work lingers between sessions. No stash-and-forget. If work is incomplete, commit with `WIP:` prefix and push. ADAMA considers `last_active` stale if there's no push within `stale_threshold_days`.

## Visibility Rule
- **Before any operation expected to take more than 5 seconds**, say what the operation is and roughly how long.
- **If the human asks "are you stuck?"**: respond with what operation is in progress.
- **Check progress signals**: if multiple turns pass without a tool call returning, say so.

## Cross-Outpost Rules
- Agents work in one outpost at a time.
- If work touches multiple outposts, update each outpost's state file.
- ADAMA is read-only for most agents — only the human or explicitly tasked agents edit ADAMA files.

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
