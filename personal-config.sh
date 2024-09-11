#!/bin/sh
set -x

mkdir -p\
    ~/school\
    ~/personal\
    ~/.config/rclone
cp ~/Downloads/rclone/rclone.conf ~/.config/rclone/
git config --global user.email "trenthek@gmail.com"
git config --global user.name "trent-8"
git config --global pull.rebase false
rclone mount --daemon school: ~/school
rclone mount --daemon personal: ~/personal