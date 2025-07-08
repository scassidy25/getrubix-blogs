import os
import frontmatter

# --- You can expand these to suit your content ---
CATEGORIES = {
    "intune": ["intune", "configuration profiles", "compliance", "endpoint manager"],
    "azure": ["azure", "aad", "entra", "active directory"],
    "powershell": ["powershell", "script", "scripting"],
    "security": ["defender", "compliance", "zero trust", "security"],
    "automation": ["automation", "automate", "logic apps", "flow"],
}

# --- Generate tags from title/description ---
def generate_metadata(title: str, content: str):
    text = (title + " " + content).lower()
    matched_categories = set()
    matched_tags = set()

    for category, keywords in CATEGORIES.items():
        for keyword in keywords:
            if keyword in text:
                matched_categories.add(category)
                matched_tags.add(keyword)

    return list(matched_categories), list(matched_tags)

# --- Process all markdown files in a folder ---
def update_md_files(folder):
    for filename in os.listdir(folder):
        if filename.endswith(".md"):
            path = os.path.join(folder, filename)
            post = frontmatter.load(path)

            title = post.get("title", "")
            content = post.content
            categories, tags = generate_metadata(title, content)

            post["categories"] = categories
            post["tags"] = tags

            with open(path, "w") as f:
                f.write(frontmatter.dumps(post))
            print(f"✅ Updated: {filename}")

# --- Run this ---
if __name__ == "__main__":
    folder_path = "./"  # <-- replace with your local path
    update_md_files(folder_path)