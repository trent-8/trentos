#!/bin/sh
set -x
script_dir=$(cd "$(dirname "$0")" && pwd -P)
sudo printf "[zram0]\nzram-size = ram * 2\ncompression-algorithm = zstd\n" > /etc/systemd/zram-generator.conf
cp -r "$script_dir/.config/" "$script_dir/Pictures/" "$script_dir/.zshrc" "$script_dir/.zprofile" "$HOME/"
sudo cp -r $script_dir/scripts/* /usr/bin/
systemctl --user restart waybar.service