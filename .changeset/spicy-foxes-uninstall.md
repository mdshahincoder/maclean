---
"maclean": minor
---

### Added

- **`maclean uninstall`** command — remove maclean completely from your machine with one command. It removes the script, the `~/.config/maclean` config directory, and cleans up the PATH entry it added to your shell rc files. Asks for confirmation first; only the tool itself is removed (your projects, caches, and everything maclean ever cleaned stay untouched).
- **`uninstall.sh`** standalone uninstaller for the curl-pipe pattern:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/mdshahincoder/maclean/main/uninstall.sh | bash
  ```

### Fixed

- `maclean --version` and `maclean -v` now work when passed as the first argument (previously only `maclean version` worked).
