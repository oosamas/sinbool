#!/bin/sh

# Fail this script if any subcommand fails.
set -e

echo "=== ci_post_clone.sh starting ==="

# Install Flutter using git.
echo "Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
export PATH="$PATH:$HOME/flutter/bin"

# Install Flutter artifacts for iOS (--ios).
echo "Running flutter precache..."
flutter precache --ios

# Install Flutter dependencies.
echo "Running flutter pub get..."
flutter pub get

# Install CocoaPods if not already available.
if ! command -v pod &> /dev/null; then
  echo "Installing CocoaPods..."
  gem install cocoapods --no-document
else
  echo "CocoaPods already installed: $(pod --version)"
fi

# Install CocoaPods dependencies.
echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install

echo "=== ci_post_clone.sh completed successfully ==="
