#!/bin/sh
set -x
script_dir=$(cd "$(dirname "$0")" && pwd -P)
cp -r "$script_dir/.config/" "$script_dir/Pictures/" "$script_dir/.bashrc" "$script_dir/.bash_profile" "$HOME/"