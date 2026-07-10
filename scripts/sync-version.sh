#!/usr/bin/env bash
#
# sync-version.sh — bake the version from package.json into the maclean script.
#
# maclean is distributed as a single standalone Bash file (not an npm package),
# so it carries its version as a `VERSION="x.y.z"` line. Changesets manages the
# canonical version in package.json; this script copies it into the script so a
# `maclean --version` always reflects the real release.
#
# Runs on macOS (BSD sed) and Linux (GNU sed).
#
set -euo pipefail

cd "$(dirname "$0")/.."   # -> repo root

if ! command -v node >/dev/null 2>&1; then
  echo "✗ node is required to read the version from package.json" >&2
  exit 1
fi

VERSION=$(node -p "require('./package.json').version")

if [ -z "${VERSION:-}" ]; then
  echo "✗ could not read version from package.json" >&2
  exit 1
fi

# Replace the VERSION="..." line in the maclean script.
# `sed -i.bak` works on both BSD and GNU sed; remove the backup afterwards.
sed -i.bak -E 's/^VERSION="[^"]*"/VERSION="'"$VERSION"'"/' maclean
rm -f maclean.bak

echo "✓ synced version ${VERSION} into maclean"
