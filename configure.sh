#!/bin/bash
cd ~
mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.icons\
    ~/.icons/default\
cd ~/trentos
cp .xinitrc ~/
cp .config/terminator/config ~/.config/terminator
cp .config/gtk-3.0/settings.ini ~/.config/gtk-3.0
cp .config/rofi/config.rasi ~/.config/rofi
cp .icons/default/index.theme ~/.icons/default
cp .Xresources ~/
cp .bashrc ~/
cp .gtkrc-2.0 ~/
sudo cp .config/gtk-3.0/settings.ini /etc/gtk-3.0
if [[ "$USER" == "trent" ]]; then
    mkdir -p\
        ~/school\
        ~/personal\
        ~/.config/rclone
    cp /run/media/trent/storage/rclone/rclone.conf ~/.config/rclone
    git config --global user.email "trenthek@gmail.com"
    git config --global user.name "trent-8"
    git config --global pull.rebase false
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi