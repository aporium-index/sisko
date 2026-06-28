# Standard: Agent Behavior

<!-- Context: sisko/standards | Priority: critical | Version: 1.0 | Updated: 2026-06-28 -->

**Purpose**: How AI coding agents should behave in every workspace project.

## Every Project Must Have
1. **`AGENTS.md`** in repo root — tells any agent how to work in that repo.
2. **`PROJECT.md`** in repo root — what it is, status, next move, open decisions.

## Agent Startup Protocol
1. Read `sisko/dashboard.md` for current priorities.
2. Read the target project's `AGENTS.md` and `PROJECT.md`.
3. Check `git status` — note dirty files, work around them.
4. Start working.

## Agent Shutdown Protocol
1. Update the project's `PROJECT.md` if status/decisions changed.
2. Append to `sisko/sessions/YYYY-MM-DD.md` with what was done.
3. If priorities shifted, update `sisko/dashboard.md`.

## Cross-Project Rules
- Agents work in one project at a time.
- If work touches multiple projects, note it in the session file so the human can coordinate.
- sisko is read-only for most agents — only the human or explicitly tasked agents edit it.

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
