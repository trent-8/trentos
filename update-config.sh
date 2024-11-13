#!/bin/sh
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
cd $script_dir
cp -r .config/ Pictures/ .bash_profile $HOME/
sudo cp Hl.sh /usr/local/bin/Hl
pkill waybar
waybar </dev/null &>/dev/null &
