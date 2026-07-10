# Changelog

## 1.1.0

### Minor Changes

- edb5fab: ### Added

  - **`maclean uninstall`** command — remove maclean completely from your machine with one command. It removes the script, the `~/.config/maclean` config directory, and cleans up the PATH entry it added to your shell rc files. Asks for confirmation first; only the tool itself is removed (your projects, caches, and everything maclean ever cleaned stay untouched).
  - **`uninstall.sh`** standalone uninstaller for the curl-pipe pattern:
    ```bash
    curl -fsSL https://raw.githubusercontent.com/mdshahincoder/maclean/main/uninstall.sh | bash
    ```

  ### Fixed

  - `maclean --version` and `maclean -v` now work when passed as the first argument (previously only `maclean version` worked).

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
