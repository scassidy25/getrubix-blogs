import os
import re
from pathlib import Path

def fix_description_lines(folder):
    for file in Path(folder).glob("*.md"):
        with file.open("r", encoding="utf-8") as f:
            lines = f.readlines()

        if not lines or not lines[0].strip().startswith("---"):
            continue  # Skip if no frontmatter

        # Only edit if there's a description line
        new_lines = []
        in_frontmatter = False
        for line in lines:
            if line.strip() == "---":
                in_frontmatter = not in_frontmatter
                new_lines.append(line)
                continue

            if in_frontmatter and line.strip().startswith("description:"):
                key, value = line.split(":", 1)
                value = value.strip()
                if not (value.startswith('"') and value.endswith('"')):
                    # Escape any existing quotes in the value
                    value = value.replace('"', '\\"')
                    line = f'{key}: "{value}"\n'
            new_lines.append(line)

        with file.open("w", encoding="utf-8") as f:
            f.writelines(new_lines)
        print(f"✅ Fixed: {file.name}")

if __name__ == "__main__":
    fix_description_lines("./")  # Update path if needed