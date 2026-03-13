#!/bin/bash

# Fail this script if any subcommand fails.
set -e

echo "=== ci_post_clone.sh starting ==="

# Install Flutter using git.
if [ -d "$HOME/flutter" ]; then
  echo "Flutter already exists at $HOME/flutter"
else
  echo "Cloning Flutter stable..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
fi
export PATH="$PATH:$HOME/flutter/bin"

# Disable analytics to speed up first run.
flutter config --no-analytics >/dev/null 2>&1 || true

echo "Flutter version:"
flutter --version

# Navigate to repository root.
cd "$CI_PRIMARY_REPOSITORY_PATH"

# Install Flutter dependencies (also registers iOS plugins).
echo "Running flutter pub get..."
flutter pub get

# Install CocoaPods dependencies.
echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install

echo "=== ci_post_clone.sh completed successfully ==="
