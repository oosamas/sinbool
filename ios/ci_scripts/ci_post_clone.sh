#!/bin/sh

# Fail this script if any subcommand fails.
set -e

echo "=== ci_post_clone.sh starting ==="
echo "CI_PRIMARY_REPOSITORY_PATH: $CI_PRIMARY_REPOSITORY_PATH"
echo "Current directory: $(pwd)"

# Install Flutter using git.
if [ -d "$HOME/flutter" ]; then
  echo "Flutter already exists, updating..."
  cd "$HOME/flutter"
  git fetch --depth 1 origin stable
  git checkout FETCH_HEAD
  cd -
else
  echo "Cloning Flutter..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
fi
export PATH="$PATH:$HOME/flutter/bin"

echo "Flutter version:"
flutter --version

# Install Flutter artifacts for iOS.
echo "Running flutter precache..."
flutter precache --ios

# Navigate to repository root for Flutter commands.
cd "$CI_PRIMARY_REPOSITORY_PATH"
echo "Working directory: $(pwd)"

# Install Flutter dependencies.
echo "Running flutter pub get..."
flutter pub get

# Install CocoaPods if not already available.
if ! command -v pod &> /dev/null; then
  echo "Installing CocoaPods..."
  sudo gem install cocoapods --no-document
else
  echo "CocoaPods already installed: $(pod --version)"
fi

# Install CocoaPods dependencies.
echo "Running pod install..."
cd "$CI_PRIMARY_REPOSITORY_PATH/ios"
pod install

echo "=== ci_post_clone.sh completed successfully ==="
