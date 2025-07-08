import os
import frontmatter

def fix_description_format(text):
    # Collapse multiline descriptions
    text = text.replace("\n", " ").strip()
    # Escape double quotes
    text = text.replace('"', '\\"')
    # Wrap in double quotes
    return f'"{text}"'

def fix_md_files(folder_path):
    for filename in os.listdir(folder_path):
        if filename.endswith(".md"):
            path = os.path.join(folder_path, filename)
            try:
                post = frontmatter.load(path)
                if "description" in post.metadata:
                    original = post.metadata["description"]
                    fixed = fix_description_format(original)
                    post.metadata["description"] = fixed
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(frontmatter.dumps(post))
                    print(f"✅ Fixed: {filename}")
            except Exception as e:
                print(f"❌ Error in {filename}: {e}")

if __name__ == "__main__":
    fix_md_files("./")  # Run in current directory