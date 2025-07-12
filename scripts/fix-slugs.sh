#!/bin/bash

# Enable dry run with --dry-run
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
  echo "Running in DRY RUN mode. No files will be modified."
fi

ROOT_DIR="$(dirname "$0")/.."
MODIFIED_COUNT=0

# Find .md files at root level (excluding /scripts/)
find "$ROOT_DIR" -maxdepth 1 -type f -name "*.md" | while read -r file; do
  MODIFIED=false

  # Check if slug needs updating
  original_slug=$(grep -E '^slug: /blog/' "$file")
  if [[ -n "$original_slug" ]]; then
    updated_slug=$(echo "$original_slug" | sed -E 's|^(slug: )/blog/|\1|')
    if $DRY_RUN; then
      echo "[DRY RUN] $file"
      echo "  - Slug:    $original_slug → $updated_slug"
    else
      sed -i '' -E 's|^(slug: )/blog/|\1|' "$file"
    fi
    MODIFIED=true
  fi

  # Check if author needs updating
  original_author=$(grep -E '^author: stevew1015@gmail.com' "$file")
  if [[ -n "$original_author" ]]; then
    updated_author="author: steve@getrubix.com"
    if $DRY_RUN; then
      echo "[DRY RUN] $file"
      echo "  - Author:  $original_author → $updated_author"
    else
      sed -i '' -E 's|^author: stevew1015@gmail.com|author: steve@getrubix.com|' "$file"
    fi
    MODIFIED=true
  fi

  if $MODIFIED; then
    ((MODIFIED_COUNT++))
    if ! $DRY_RUN; then
      echo "Updated: $file"
    fi
  fi
done

echo ""
if $DRY_RUN; then
  echo "Dry run complete. Files that would be modified: $MODIFIED_COUNT"
else
  echo "Update complete. Files modified: $MODIFIED_COUNT"
fi