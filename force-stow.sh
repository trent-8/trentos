#!/bin/bash

set -e  # Exit immediately if a command fails

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <package> <target-dir>"
    exit 1
fi

PACKAGE="$1"
TARGET_DIR="$2"
SOURCE_DIR="$(pwd)/$PACKAGE"

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Package directory '$SOURCE_DIR' not found."
    exit 1
fi

echo "Force-stowing '$PACKAGE' into '$TARGET_DIR'..."

# Find all files in the package and create symlinks
find "$SOURCE_DIR" -type f | while read -r file; do
    rel_path="${file#$SOURCE_DIR/}"  # Get relative path
    target="$TARGET_DIR/$rel_path"
    target_dir="$(dirname "$target")"

    # Ensure parent directory exists
    echo "Making directory $target_dir."
    mkdir -p "$target_dir"

    # Remove existing file if it's not a symlink or points to something else
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "Replacing '$target' with a symlink."
        rm -rf "$target"
    fi

    # Create the symlink
    echo "Making symlink $target to $file."
    ln -sf "$file" "$target"
done

echo "Done!"
