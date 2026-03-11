#!/bin/bash

# Fail this script if any subcommand fails.
set -e

echo "=== ci_post_clone.sh starting ==="
echo "CI_PRIMARY_REPOSITORY_PATH: $CI_PRIMARY_REPOSITORY_PATH"
echo "Current directory: $(pwd)"
echo "macOS version: $(sw_vers -productVersion)"

# Install Flutter using git.
if [ -d "$HOME/flutter" ]; then
  echo "Flutter already exists at $HOME/flutter"
else
  echo "Cloning Flutter stable..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
fi
export PATH="$PATH:$HOME/flutter/bin"

# Print Flutter version (also triggers first-time setup).
echo "Flutter version:"
flutter --version

# Install Flutter artifacts for iOS.
echo "Running flutter precache --ios..."
flutter precache --ios

# Navigate to repository root for Flutter commands.
cd "$CI_PRIMARY_REPOSITORY_PATH"
echo "Working directory: $(pwd)"

# Install Flutter dependencies.
echo "Running flutter pub get..."
flutter pub get

# Install CocoaPods if not already available.
if command -v pod >/dev/null 2>&1; then
  echo "CocoaPods already installed: $(pod --version)"
else
  echo "Installing CocoaPods..."
  sudo gem install cocoapods --no-document
fi

# Install CocoaPods dependencies.
echo "Running pod install in ios/..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install --repo-update

echo "=== ci_post_clone.sh completed successfully ==="
