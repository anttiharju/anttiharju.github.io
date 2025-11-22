#!/bin/sh
set -eu
# Hardcoded converter: turn top-level markdown list-item URLs in urls.md into clickable links.

TARGET="urls.md"

sed_expr='s/^([[:space:]]*[-*+][[:space:]]*)(https?:\/\/[^[:space:]<]+)[[:space:]]*$/\1[\2](\2)/'

if [ ! -f "$TARGET" ]; then
  echo "file not found: $TARGET" >&2
  exit 1
fi

tmp="$(mktemp "${TARGET}.tmp.XXXXXX")" || exit 1
sed -E "$sed_expr" "$TARGET" > "$tmp" && mv "$tmp" "$TARGET"