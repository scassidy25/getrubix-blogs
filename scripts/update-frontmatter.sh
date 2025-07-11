#!/bin/bash

# Define the root directory where the .md files live
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Loop through every markdown file in the root directory (non-recursive)
for file in "$ROOT_DIR"/*.md; do
  if [[ -f "$file" ]]; then
    echo "Processing $file..."

    # Update author
    sed -i '' 's/^author: .*/author: steve@getrubix.com/' "$file"

    # Update slug: remove "/blog/" from beginning
    sed -i '' 's|^slug: /blog/|slug: |' "$file"
  fi
done

echo "✅ All markdown files updated."