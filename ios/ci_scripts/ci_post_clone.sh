#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# Install Flutter using git.
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios).
flutter precache --ios

# Install Flutter dependencies.
echo "Running flutter pub get..."
flutter pub get

# Install CocoaPods using Homebrew.
echo "Installing CocoaPods..."
HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods

# Install CocoaPods dependencies.
echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install

echo "ci_post_clone.sh completed successfully."
