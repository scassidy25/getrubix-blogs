#!/bin/bash

# Ensure we're in the project root
cd "$(dirname "$0")/.."

CSV_FILE="blog-post-title-with-thumbnail.csv"
MD_FILES=*.md
TMP_MAP=".thumbnail_map.tmp"
UNMATCHED_FILE="scripts/unmatched-thumbnails.log"

normalize() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr -d '"' | tr -d "'" | tr -d '[:space:]'
}

# Clean and prepare map file
rm -f "$TMP_MAP" "$UNMATCHED_FILE"

# Parse CSV into temporary lookup file
tail -n +2 "$CSV_FILE" | while IFS=',' read -r title url; do
  clean_title=$(normalize "$title")
  clean_url=$(echo "$url" | sed 's/^"//;s/"$//')
  echo "$clean_title|$clean_url|$title" >> "$TMP_MAP"
done

for file in $MD_FILES; do
  [[ ! -f "$file" ]] && continue
  title_line=$(grep -m1 '^title:' "$file")
  current_title=$(echo "$title_line" | sed 's/^title:[[:space:]]*//;s/^"//;s/"$//')
  norm_title=$(normalize "$current_title")

  match_line=$(grep "^$norm_title|" "$TMP_MAP")

  if [[ -n "$match_line" ]]; then
    new_url=$(echo "$match_line" | cut -d'|' -f2)
    original_title=$(echo "$match_line" | cut -d'|' -f3)
    echo "✅ $file: matched → $original_title"
    sed -i '' "s|^thumbnail:.*|thumbnail: $new_url|" "$file"
  else
    echo "⚠️  $file: no thumbnail mapping found for normalized title → $current_title"
    echo "$file,$current_title" >> "$UNMATCHED_FILE"
  fi
done

rm -f "$TMP_MAP"