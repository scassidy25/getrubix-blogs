#!/bin/bash

# Ensure we're in the project root
cd "$(dirname "$0")/.."

OLD_BASE="http://images.squarespace-cdn.com"
NEW_BASE="https://getrubixsitecms.blob.core.windows.net/public-assets"

DRYRUN=false
if [[ "$1" == "--dryrun" ]]; then
  DRYRUN=true
  echo "🔍 Running in DRY RUN mode. No files will be changed."
fi

LOG_FILE="./scripts/updated-thumbnails.log"
> "$LOG_FILE"

for file in ./*.md; do
  [[ ! -f "$file" ]] && continue

  echo "Checking: $file"

  # Match any line containing the OLD_BASE
  matched_line=$(grep "$OLD_BASE" "$file")

  if [[ -n "$matched_line" ]]; then
    new_line=$(echo "$matched_line" | sed "s|$OLD_BASE|$NEW_BASE|")

    echo "🔁 $file" >> "$LOG_FILE"
    echo "    OLD: $matched_line" >> "$LOG_FILE"
    echo "    NEW: $new_line" >> "$LOG_FILE"

    if [[ "$DRYRUN" == false ]]; then
      sed -i '' "s|$matched_line|$new_line|" "$file"
    else
      echo "    [Dry Run] Would update thumbnail in: $file"
    fi
  fi
done

echo "✅ Done. See log → $LOG_FILE"