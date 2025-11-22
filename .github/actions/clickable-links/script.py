#!/usr/bin/env python3
import re
import sys
from pathlib import Path

# Hardcoded converter: turn top-level markdown list-item URLs in urls.md into clickable links.

TARGET = "urls.md"

target_path = Path(TARGET)

if not target_path.is_file():
    print(f"file not found: {TARGET}", file=sys.stderr)
    sys.exit(1)

# Pattern to match list-item URLs
pattern = re.compile(r'^(\s*[-*+]\s*)(https?://\S+)\s*$')

# Read, transform, and write atomically
lines = target_path.read_text().splitlines(keepends=True)
transformed_lines = []

for line in lines:
    match = pattern.match(line.rstrip('\n\r'))
    if match:
        prefix = match.group(1)
        url = match.group(2)
        transformed_lines.append(f"{prefix}[{url}]({url})\n")
    else:
        transformed_lines.append(line)

# Write to temp file then atomically replace
temp_path = target_path.with_suffix(target_path.suffix + '.tmp')
temp_path.write_text(''.join(transformed_lines))
temp_path.replace(target_path)
