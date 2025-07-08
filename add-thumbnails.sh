#!/bin/bash

# Path to all .md files in current directory
for file in *.md; do
  echo "📄 Processing $file"

  # Insert the thumbnail line after the description line
  awk '
    BEGIN { inserted = 0 }
    /^description:/ {
      print
      if (!inserted) {
        print "thumbnail: \"https://getrubixsitecms.blob.core.windows.net/public-assets/content/v1/logo512.png\""
        inserted = 1
        next
      }
    }
    { print }
  ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done

echo "✅ Done. All .md files updated with thumbnail line."