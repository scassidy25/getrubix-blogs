#!/bin/bash

# Go to project root
cd "$(dirname "$0")/.."

OLD_DIR="./thumbnail-md-old"
NEW_DIR="."
LOG_FILE="./scripts/thumbnail-sync.log"

DRYRUN=false
if [[ "$1" == "--dryrun" ]]; then
  DRYRUN=true
  echo "🔍 Dry run mode: no changes will be written"
fi

> "$LOG_FILE"

for new_file in $NEW_DIR/*.md; do
  filename=$(basename "$new_file")
  old_file="$OLD_DIR/$filename"

  [[ ! -f "$old_file" ]] && {
    echo "⚠️  $filename: old file not found" >> "$LOG_FILE"
    continue
  }

  # Extract thumbnail line from old file
  old_thumb_line=$(grep '^thumbnail:' "$old_file")
  [[ -z "$old_thumb_line" ]] && {
    echo "⚠️  $filename: no thumbnail found in old file" >> "$LOG_FILE"
    continue
  }

  # Extract current thumbnail line from new file
  new_thumb_line=$(grep '^thumbnail:' "$new_file")
  [[ -z "$new_thumb_line" ]] && {
    echo "⚠️  $filename: no thumbnail found in new file" >> "$LOG_FILE"
    continue
  }

  # Only proceed if the URLs are different
  if [[ "$old_thumb_line" != "$new_thumb_line" ]]; then
    echo "✅ $filename: updating thumbnail" >> "$LOG_FILE"
    echo "    OLD: $new_thumb_line" >> "$LOG_FILE"
    echo "    NEW: $old_thumb_line" >> "$LOG_FILE"

    if [[ "$DRYRUN" == false ]]; then
      # Use delimiter | to avoid path/URL issues
      sed -i '' "s|$new_thumb_line|$old_thumb_line|" "$new_file"
    fi
  fi
done

echo "📝 Done. Log saved to: $LOG_FILE"