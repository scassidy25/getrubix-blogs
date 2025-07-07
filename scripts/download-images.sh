#!/bin/bash

# Source and destination folders
BLOG_DIR="content/blog"
IMAGE_DIR="content/"
CSV_LOG="rewrite-log.csv"
NEW_BASE_URL="https://getrubixsitecms.blob.core.windows.net/public-assets/"
echo '"original_url","rewritten_url"' > "$CSV_LOG"

# Create image directory if it doesn't exist
mkdir -p "$IMAGE_DIR"

# Extract all image URLs from markdown files and rewrite URLs in markdown files
find "$BLOG_DIR" -type f -name "*.md" | while read -r file; do
  # Extract image URLs and process
  grep -oE '!\[[^]]*\]\((http[^)]+)\)' "$file" | sed -E 's/.*\((http[^)]+)\)/\1/' >> /tmp/image-urls.txt
  grep -oE '<img[^>]+src="(http[^"]+)"' "$file" | sed -E 's/.*src="(http[^"]+)".*/\1/' >> /tmp/image-urls.txt

  # Rewrite image URLs in the markdown file
  # Find all URLs in markdown image syntax and HTML img tags
  grep -oE '!\[[^]]*\]\((http[^)]+)\)' "$file" | while read -r match; do
    url=$(echo "$match" | sed -E 's/.*\((http[^)]+)\)/\1/')
    # Compute relative path (preserve structure after 'content/v1/')
    relative_path=$(echo "$url" | sed -E 's|.*(content/v1/.*)|\1|')
    if [ -n "$relative_path" ]; then
      new_url="${NEW_BASE_URL}${relative_path}"
      # Replace in markdown
      sed -i '' "s|$url|$new_url|g" "$file"
      # Log rewrite
      echo "\"$url\",\"$new_url\"" >> "$CSV_LOG"
    fi
  done
  grep -oE '<img[^>]+src="(http[^"]+)"' "$file" | while read -r match; do
    url=$(echo "$match" | sed -E 's/.*src="(http[^"]+)".*/\1/')
    relative_path=$(echo "$url" | sed -E 's|.*(content/v1/.*)|\1|')
    if [ -n "$relative_path" ]; then
      new_url="${NEW_BASE_URL}${relative_path}"
      # Replace in markdown
      sed -i '' "s|$url|$new_url|g" "$file"
      # Log rewrite
      echo "\"$url\",\"$new_url\"" >> "$CSV_LOG"
    fi
  done
done

# Deduplicate and download images, preserving folder structure
sort /tmp/image-urls.txt | uniq | while read -r url; do
  # Compute relative path (preserve structure after 'content/v1/')
  relative_path=$(echo "$url" | sed -E 's|.*(content/v1/.*)|\1|')
  if [ -z "$relative_path" ]; then
    continue
  fi
  # Create directory for image
  image_path="content/$relative_path"
  image_dir=$(dirname "$image_path")
  mkdir -p "$image_dir"
  if [ -f "$image_path" ]; then
    echo "✓ Skipping (exists): $image_path"
    continue
  fi
  echo "↓ Downloading: $image_path"
  curl -s -L "$url" -o "$image_path"
  sleep 1
done

rm /tmp/image-urls.txt

echo "✅ Done downloading images and rewriting URLs."