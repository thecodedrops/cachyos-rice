#!/bin/bash

CWEBP="$HOME/.local/apps/libwebp/1.6.0/bin/cwebp"

# Validate arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  exit 1
fi

SRC_DIR="${1%/}"
DEST_DIR="${2%/}"

if [ ! -d "$SRC_DIR" ]; then
  echo "Error: Source directory '$SRC_DIR' does not exist."
  exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Convert images
for img in "$SRC_DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG}; do
  [ -f "$img" ] || continue
  filename=$(basename "$img")
  "$CWEBP" -q 100 -m 6 -mt "$img" -o "$DEST_DIR/${filename%.*}.webp"
done
