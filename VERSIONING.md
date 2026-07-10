# Versioning

maclean uses [**Changesets**](https://github.com/changesets/changesets) for
versioning and changelog generation. It's the same system used by Vercel, Radix,
Astro, and many major open-source projects.

Because maclean ships as a **standalone Bash file** (not an npm package), there's
one extra step: the canonical version lives in `package.json`, and
`scripts/sync-version.sh` bakes it into the `VERSION="..."` line of the `maclean`
script so that `maclean --version` is always correct.

## For contributors

Whenever your PR changes user-facing behavior, add a changeset describing it:

```bash
npm run changeset
```

You'll be asked:

1. **Which package** — `maclean`
2. **Bump type** — `patch` (bugfix) · `minor` (feature) · `major` (breaking)
3. **Summary** — a short, human-readable description

Commit the generated file (e.g. `.changeset/spicy-foxes-march.md`) along with your
code. That's it — the rest is automated.

> Using [SemVer](https://semver.org/): `patch` = `1.0.0 → 1.0.1`,
> `minor` = `1.0.0 → 1.1.0`, `major` = `1.0.0 → 2.0.0`.

## For maintainers

### Automated (recommended)

The GitHub Action in `.github/workflows/changesets.yml` runs on every push to
`main`. When there are pending changesets, the **Changesets bot** opens a pull
request titled *"chore(release): version packages"* with:

- the new version in `package.json`
- updated `CHANGELOG.md`
- the new version baked into the `maclean` script

Merge that PR to cut a release, then tag it:

```bash
git checkout main && git pull
VERSION=$(node -p "require('./package.json').version")
git tag -a "v$VERSION" -m "maclean v$VERSION"
git push origin "v$VERSION"
gh release create "v$VERSION" --generate-notes
```

### Manual

If you prefer to release locally:

```bash
npm install                 # first time only
npm run changeset           # describe the change (creates a .changeset/*.md)
# ... commit the changeset ...
npm run bump                # versions package.json + CHANGELOG, syncs the script
# ... commit the bump ...
git tag -a "v$(node -p "require('./package.json').version")" -m "release"
git push --follow-tags
gh release create "v$(node -p "require('./package.json').version")" --generate-notes
```

### What `npm run bump` does

```
changeset version   →  consumes .changeset/*.md, bumps package.json, updates CHANGELOG.md
bash scripts/sync-version.sh  →  copies package.json's version into maclean's VERSION line
```

## Files

| Path | Purpose |
|------|---------|
| `package.json` | Canonical version (`"version"`) + Changesets scripts |
| `package-lock.json` | Lockfile — required for CI (`npm ci`) |
| `.changeset/config.json` | Changesets configuration |
| `.changeset/README.md` | Explains the changesets folder to contributors |
| `scripts/sync-version.sh` | Bakes `package.json` version into the `maclean` script |
| `.github/workflows/changesets.yml` | Auto "Version Packages" PR bot |
| `CHANGELOG.md` | Generated/maintained by Changesets |

## Notes

- `package.json` is marked `"private": true` — maclean is **never published to
  npm**. Changesets is used purely for version + changelog management.
- `node_modules/` is gitignored; only the lockfile is committed.
