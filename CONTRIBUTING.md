# Contributing to maclean 🧹

First off — thank you for taking the time to contribute! 💜 Every PR, issue, and
star makes maclean better.

maclean is intentionally **one Bash file** (`maclean`) so it's easy to read,
understand, and modify. You don't need a build step.

## Quick start

```bash
git clone https://github.com/mdshahincoder/maclean.git
cd maclean
chmod +x maclean
./maclean --help           # try it out
```

To test your changes locally without installing:

```bash
./maclean scan --dry-run --yes
```

## Ways to contribute

- 🐛 **Fix a bug** — check [open issues](https://github.com/mdshahincoder/maclean/issues).
- 🆕 **Add scan profiles** — the easiest high-impact contribution. Find where a
  popular app (Blender, Notion, Slack, FCPX, DaVinci, …) stores its caches/data and
  add it to the relevant `scan_*` function with a `finding` + `safe_add`.
- 🎨 **Improve output / UX** — better formatting, clearer copy.
- 🌍 **Translations / localization**.
- 📝 **Docs** — improve the README, add examples.
- 🧪 **Tests** — see below.

## Adding a new app to scan (example)

Inside the matching `scan_*` function (or a new one), add:

```bash
kb=$(meas "$HOME/Library/Caches/SomeApp")
if [ "$kb" -gt 0 ] 2>/dev/null; then
  finding SAFE "$kb" "SomeApp cache" "regenerable"      # ✅ auto-cleanable
  safe_add "SomeApp cache" "$kb" rm "$HOME/Library/Caches/SomeApp"
fi
```

Use `finding REVIEW …` (without `safe_add`) for anything that's the user's
personal data — **never auto-delete things you didn't create.**

## Guidelines

- **Safe by default.** When in doubt, mark an item `REVIEW`, not `SAFE`. maclean's
  reputation depends on never deleting someone's work.
- **Bash 3.2 compatible.** macOS still ships Bash 3.2 as `/bin/bash`. Avoid
  associative arrays (`declare -A`), `mapfile`, and other Bash 4+ features.
  Run `bash -n maclean` to check syntax.
- **No external dependencies.** Stick to tools that ship with macOS
  (`find`, `du`, `df`, `awk`, `stat`). If a feature needs an optional tool
  (like `brew` or `pnpm`), guard it with `command -v`.
- **One purpose per change.** Keep PRs focused and easy to review.
- **Test on your own Mac** before submitting — ideally run `maclean scan` and a
  `--dry-run` clean.

## Submitting a pull request

1. Fork the repo and create a branch: `git checkout -b feature/my-cool-thing`
2. Make your changes in `maclean` (and docs if needed).
3. Verify: `bash -n maclean` passes and `./maclean scan --dry-run --yes` runs clean.
4. **If your change is user-facing, add a changeset** so it lands in the next release:
   ```bash
   npm install          # first time only
   npm run changeset    # pick patch/minor/major + write a summary
   ```
   Commit the generated `.changeset/*.md` file with your code.
5. Commit with a clear message.
6. Open a PR describing **what** changed and **why**.

See [VERSIONING.md](VERSIONING.md) for how releases are cut (it's automated by a
GitHub bot — you just add the changeset).

## Reporting bugs

Please include:

- macOS version (`sw_vers`)
- maclean version (`maclean --version`)
- The exact command you ran
- The output (or error message)

## Code of conduct

By participating you agree to uphold our [Code of Conduct](CODE_OF_CONDUCT.md).
Be kind, patient, and welcoming. 💜

Happy hacking! 🧹
