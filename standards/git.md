# Standard: Git Conventions

<!-- Context: sisko/standards | Priority: high | Version: 1.0 | Updated: 2026-06-28 -->

**Purpose**: Git conventions that apply to every project in the workspace.

## Branch Policy
- **Single branch default**: `master` (or `main` if project prefers).
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
- Every project gets `.gitignore` with at minimum: `.DS_Store`, `node_modules/`, `.venv/`, `__pycache__/`, `.tmp/`
- No full `.git/` directories in iCloud-synced locations (use gitdir pointer files).
- No virtualenvs or `node_modules/` inside synced vaults.

## Related
- [[agents|Agent Standards]]
- [[okf|OKF Convention]]
