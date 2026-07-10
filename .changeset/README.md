# Changesets

This folder is managed by [Changesets](https://github.com/changesets/changesets).

## How it works

When you make a change that should be released, run:

```bash
npm run changeset      # or: npx changeset
```

Answer the prompts:

1. **Select the package** — `maclean`
2. **Bump type** — `major` / `minor` / `patch`
3. **Summary** — a short, human-readable description of the change

This creates a new Markdown file in `.changeset/` describing the change. Commit
that file alongside your code.

When the changeset is ready to be released, the maintainer runs:

```bash
npm run bump           # = changeset version  +  sync version into the maclean script
```

Changesets consumes all pending changesets, bumps the version in `package.json`,
updates `CHANGELOG.md`, and our `sync-version` step bakes the new version into the
`maclean` Bash script. Then we commit, tag, and publish the release.

> A GitHub Action (`.github/workflows/changesets.yml`) automates this: when you
> push changesets to `main`, a bot opens a **"Version Packages"** pull request
> with the version bump + changelog already prepared. Merge it to release.
