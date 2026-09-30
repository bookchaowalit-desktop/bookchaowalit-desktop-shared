# Upgrade plan

## Current state

**Score: 3/10** (was 2/10) for a starter: owner-model README, MIT license
and a CI contract that now checks something meaningful. No shared desktop
code yet, by design.

## Backlog

### P0 (only once a desktop product is approved)
- Decide the desktop shell and record it here. Candidates, in order of fit
  with the rest of the portfolio (TypeScript/Next.js on the web):
  1. **Tauri 2** (Rust core + web UI): small binaries on Linux, Windows and
     macOS; reuses the web front-end stack.
  2. **Electron**: largest ecosystem, heavier runtime.
  3. Native per-OS toolkits: only if a product needs deep OS integration.
- Scope what "shared" means before adding code, e.g. a TypeScript package
  for settings storage, auto-update channel config, crash-report opt-in, and
  design tokens shared with the web design system.
- Add the scaffold, stack-specific `.gitignore` entries, and CI that runs
  lint/test/build on `ubuntu-latest`, `windows-latest` and `macos-latest`.
  Change README **Status** from `starter` so `scripts/check-starter.sh`
  stops treating code as out of place.

### P1
- Code-signing and notarisation checklist (secrets live in CI settings,
  never in this repository).
- Accessibility baseline: keyboard navigation, OS high-contrast and
  reduced-motion settings, screen-reader labels.

### P2
- Release notes template and versioning policy for shared modules.

## Done in this pass (2026-09-30)
- Replaced the "files exist" CI check with `scripts/check-starter.sh`
  (README sections, MIT license, link check, tracked-secret guard, honest
  Status). Verified locally, including negative cases.
- Added `.gitignore` (secrets, OS/editor, common build output) and
  `.editorconfig`.
- CI now also runs on pull requests to any branch and on demand.
