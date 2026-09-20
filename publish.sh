#!/usr/bin/env bash
# Publish Debugora_*.zip to GitHub Releases on DebugOra_windows_version.
set -euo pipefail

REPO="SahinoorHUB/DebugOra_windows_version"
VERSION="${1:-1.0.0}"
TAG="v${VERSION}"
ARCHIVE="Debugora_${VERSION}.zip"
NOTES="${2:-Standalone React Native debug dashboard for any RN app.}"

if [[ ! -f "$ARCHIVE" ]]; then
  echo "Missing $ARCHIVE in $(pwd)" >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI (gh) is required. Install: winget install GitHub.cli && gh auth login" >&2
  exit 1
fi

gh release view "$TAG" -R "$REPO" >/dev/null 2>&1 \
  && gh release upload "$TAG" "$ARCHIVE" --clobber -R "$REPO" \
  || gh release create "$TAG" "$ARCHIVE" \
    --title "DebugOra ${VERSION} (Windows)" \
    --notes "$NOTES" \
    -R "$REPO"

echo "Published: https://github.com/${REPO}/releases/download/${TAG}/${ARCHIVE}"
