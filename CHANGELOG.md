# Changelog

All notable changes to this project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-07-09

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

[Unreleased]: https://github.com/mdshahincoder/maclean/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/mdshahincoder/maclean/releases/tag/v1.0.0
