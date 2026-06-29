---
type: standard
tags: [git, conventions, version-control]
timestamp: 2026-06-28
---

# Standard: Git Conventions

**Purpose**: Git conventions that apply to every outpost in the workspace.

## Always Commit + Push
After every session, commit all changes and push to remote. This is not optional.

```
git add -A
git commit -m "type: description"
git push
```

- If work is incomplete, prefix commit message with `WIP:`.
- If nothing changed, no commit needed — but verify before moving on.
- sisko considers `last_active` stale if there's no push within `stale_threshold_days`. No push means the outpost appears dormant even if work happened locally.

## Branch Policy
- **Single branch default**: `main` (or `master` if outpost prefers).
- Do not create/switch branches for normal work.
- Do not use `git stash` for normal flow.
- Do not use destructive cleanup (`git reset --hard`, `git clean -fd`) unless explicitly requested.

## Commit Messages
- Format: `type: short description`
- Types: `feat`, `fix`, `refactor`, `docs`, `chore`, `maintenance`, `ingest`, `compile`
- Keep under 72 characters for the summary line.
- Body optional — include context when the "why" isn't obvious.

## Multi-Agent Safety
1. At session start: `git branch --show-current` + `git status --short`
2. If not on default branch, switch before editing.
3. If unrelated dirty files exist, work around them — do not discard.
4. If parking work, prefer a WIP commit over stash.

## Repo Structure
- Every outpost gets `.gitignore` with at minimum: `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/`
- No full `.git/` directories in iCloud-synced locations (use gitdir pointer files).
- No virtualenvs or `node_modules/` inside synced vaults.

## Related
- [[agents|Agent Standards]]
- [[okf|OKF Convention]]
