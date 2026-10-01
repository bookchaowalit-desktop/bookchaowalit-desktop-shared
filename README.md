# bookchaowalit-desktop-shared

Starter repository for shared desktop interface foundations in the
`bookchaowalit-desktop` organization.

## Purpose

This repository is an intentionally thin baseline for code shared by Linux,
Windows, and macOS products. It contains no product features yet.

## Repository boundary

- **Owner:** `bookchaowalit-desktop`
- **Interfaces:** Linux, Windows, macOS
- **Lifecycle:** shared desktop foundation
- **Default branch:** `main`
- **Status:** starter / skeleton

## CI

GitHub Actions runs [`scripts/check-starter.sh`](./scripts/check-starter.sh)
on pushes to `main` and on every pull request. It checks that:

- the baseline files exist (`README.md`, MIT `LICENSE`, `.gitignore`,
  `.editorconfig`, `docs/UPGRADE-PLAN.md`, CI workflow);
- this README keeps its owner-model sections;
- relative Markdown links resolve;
- no secret-bearing files (`.env`, keys, credentials) are tracked;
- while **Status** says `starter`, no implementation files have been added
  (update the Status line when the first shared module lands).

## Local development

There is no runtime or dependency setup yet. The only local check is:

```bash
bash scripts/check-starter.sh
```

Add implementation only when a concrete desktop product is approved for one
or more operating systems. The candidate shells and the first-scaffold
checklist are in [`docs/UPGRADE-PLAN.md`](./docs/UPGRADE-PLAN.md).

## License

MIT. See [`LICENSE`](./LICENSE).
