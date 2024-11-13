#!/bin/sh
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
cd $script_dir
cp -r .config/ Pictures/ $HOME/
hlalias="alias hl='dbus-run-session Hyprland'"
if ! grep -qxF "$hlalias" ~/.bash_profile; then
    echo "$hlalias" >> ~/.bash_profile
fi
pkill waybar
waybar </dev/null &>/dev/null &
