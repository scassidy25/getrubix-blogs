import os
import frontmatter

def check_md_frontmatter(folder_path):
    print("🔍 Scanning for invalid frontmatter...\n")
    invalid_files = []
    for filename in os.listdir(folder_path):
        if filename.endswith(".md"):
            path = os.path.join(folder_path, filename)
            try:
                frontmatter.load(path)
            except Exception:
                invalid_files.append(filename)

    if invalid_files:
        print("❌ Files with invalid frontmatter:")
        for fname in invalid_files:
            print(f" - {fname}")
    else:
        print("✅ All files have valid frontmatter.")

if __name__ == "__main__":
    check_md_frontmatter("./")