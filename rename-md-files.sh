#!/bin/bash

for file in *.md; do
  # Extract the slug value from frontmatter
  slug=$(grep '^slug:' "$file" | sed -E 's/^slug:[[:space:]]*"?//; s/"?$//')

  # Skip if slug is empty or doesn't contain /blog/
  if [[ -z "$slug" || "$slug" != /blog/* ]]; then
    echo "⚠️  Skipping $file (no valid /blog/ slug)"
    continue
  fi

  # Strip leading /blog/ and any trailing slashes
  filename=$(basename "${slug#/blog/}")
  filename="${filename%%/}.md"

  # Rename the file
  if [[ "$file" != "$filename" ]]; then
    echo "🔁 Renaming $file → $filename"
    mv "$file" "$filename"
  else
    echo "✅ $file is already correctly named"
  fi
done

echo "🎉 Done renaming files."