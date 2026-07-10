# Changelog

All notable changes to this project are documented here.

This file is managed by [Changesets](https://github.com/changesets/changesets) —
see [`.changeset/README.md`](.changeset/README.md) for the workflow.

## 1.0.0

### 🎉 Added

- Initial public release.
- **Interactive guided scan** (`maclean` / `maclean scan`) with onboarding.
- **Profiles** that tailor the scan to the user: Everyone, Developer, Video Editor,
  Designer, Musician, Photographer, Power User.
- **Safe-by-default classification**: ✅ regenerable items vs. ⚠️ personal data.
- Commands: `scan`, `setup`, `overview`, `big`, `dev`, `nodes`, `caches`,
  `clean` (nodes, caches, dev, trash, brew), `doctor`, `update`.
- **Project-only node_modules filter** — skips tool/editor node_modules that would
  break Node/npm/extensions if deleted.
- **Dry-run mode** (`--dry-run`) and **auto-yes** (`--yes`).
- One-line curl installer and `install.sh`.
- MIT license, README, CONTRIBUTING guide, Code of Conduct, issue templates.
