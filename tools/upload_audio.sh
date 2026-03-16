#!/bin/bash
# Upload generated audio files to Firebase Storage
#
# Prerequisites:
#   1. Install Firebase CLI: npm install -g firebase-tools
#   2. Login: firebase login
#   3. Set your project: firebase use YOUR_PROJECT_ID
#
# Usage:
#   ./tools/upload_audio.sh [language]
#   ./tools/upload_audio.sh en        # Upload English audio
#   ./tools/upload_audio.sh ar        # Upload Arabic audio
#   ./tools/upload_audio.sh           # Upload all languages

set -e

LANGUAGE="${1:-all}"
AUDIO_DIR="tools/generated_audio"
BUCKET="" # Leave empty to use default bucket, or set to "gs://your-bucket"

if [ ! -d "$AUDIO_DIR" ]; then
  echo "Error: $AUDIO_DIR not found. Run generate_audio.dart first."
  exit 1
fi

upload_language() {
  local lang="$1"
  local dir="$AUDIO_DIR/$lang"

  if [ ! -d "$dir" ]; then
    echo "No audio files found for language: $lang"
    return
  fi

  local count=$(ls "$dir"/*.mp3 2>/dev/null | wc -l | tr -d ' ')
  echo "Uploading $count files for language: $lang"

  for file in "$dir"/*.mp3; do
    if [ -f "$file" ]; then
      local filename=$(basename "$file")
      local storage_path="audio/$lang/$filename"
      echo "  Uploading $filename -> $storage_path"

      if [ -n "$BUCKET" ]; then
        firebase storage:upload "$file" "$storage_path" --bucket "$BUCKET"
      else
        # Use gsutil for more reliable uploads
        gsutil cp "$file" "gs://$(firebase apps:list 2>/dev/null | grep -o '[^ ]*\.appspot\.com' | head -1)/$storage_path" 2>/dev/null || \
          echo "  -> Please upload manually: $file to $storage_path"
      fi
    fi
  done

  echo "Done uploading $lang audio files."
}

if [ "$LANGUAGE" = "all" ]; then
  for lang_dir in "$AUDIO_DIR"/*/; do
    if [ -d "$lang_dir" ]; then
      lang=$(basename "$lang_dir")
      upload_language "$lang"
    fi
  done
else
  upload_language "$LANGUAGE"
fi

echo ""
echo "=== Upload Complete ==="
echo "Audio files are now available in Firebase Storage under audio/{language}/"
echo "The app will automatically download them on first play."
