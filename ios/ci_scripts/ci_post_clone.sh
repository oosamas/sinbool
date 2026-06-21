#!/bin/bash

# Fail this script if any subcommand fails, and surface exactly where it failed.
set -eo pipefail
trap 'echo "!!! ci_post_clone.sh FAILED at line $LINENO: \"$BASH_COMMAND\" (exit $?)"' ERR

echo "=== ci_post_clone.sh starting ==="

# Pin Flutter to the exact version used for local development.
# An unpinned "stable" clone is the classic cause of CI builds that worked
# months ago breaking later, because stable advances under you.
FLUTTER_VERSION="3.38.5"

# Install Flutter (reuse the cache only if it is already the pinned version).
if [ -x "$HOME/flutter/bin/flutter" ] && "$HOME/flutter/bin/flutter" --version 2>/dev/null | grep -q "Flutter $FLUTTER_VERSION"; then
  echo "Reusing cached Flutter $FLUTTER_VERSION at $HOME/flutter"
else
  echo "Cloning Flutter $FLUTTER_VERSION..."
  rm -rf "$HOME/flutter"
  git clone https://github.com/flutter/flutter.git --depth 1 -b "$FLUTTER_VERSION" "$HOME/flutter"
fi
export PATH="$PATH:$HOME/flutter/bin"

# Disable analytics to speed up first run.
flutter config --no-analytics >/dev/null 2>&1 || true

echo "--- Flutter version ---"
flutter --version

# Pre-download iOS engine artifacts so the build step doesn't fetch them mid-archive.
echo "--- flutter precache --ios ---"
flutter precache --ios

# Navigate to repository root.
cd "$CI_PRIMARY_REPOSITORY_PATH"

# Install Flutter dependencies (also generates ios/.symlinks for plugin pods).
echo "--- flutter pub get ---"
flutter pub get

# Install CocoaPods dependencies. --repo-update refreshes the spec repo so newer
# plugin pod versions resolve cleanly against the committed Podfile.lock.
echo "--- pod install ---"
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install --repo-update

echo "=== ci_post_clone.sh completed successfully ==="
