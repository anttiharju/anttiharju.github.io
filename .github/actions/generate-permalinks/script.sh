#!/bin/sh
set -eu

SCRIPT_DIR=$(dirname "$0")

ids=$(yq e '.[].id' permalinks.yml)

echo "SETTING UP REDIRECTS"
for id in $ids; do
  name=$(yq e ".[] | select(.id == \"$id\") | .name" permalinks.yml)
  url=$(yq e ".[] | select(.id == \"$id\") | .url" permalinks.yml)
  echo "$name"
  echo "* https://anttiharju.dev/$id -> $url"
  cp "$SCRIPT_DIR/template.html" "$id.html"

  # sed is used different between macOS and Linux (= github actions runner)
  if [ "$(uname)" = "Darwin" ]; then    
    sed -i '' "s|\$url|$url|g" "$id.html"
    sed -i '' "s|\$name|$name|g" "$id.html"
  else
    sed -i "s|\$url|$url|g" "$id.html"
    sed -i "s|\$name|$name|g" "$id.html"
  fi
done
