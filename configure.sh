#!/bin/bash
cd ~
mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.config/picom\
    ~/.icons\
    ~/.icons/default
cp ~/trentos/.xinitrc ~/
cp ~/trentos/.xsession ~/
cp ~/trentos/.config/terminator/config ~/.config/terminator
cp ~/trentos/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0
cp ~/trentos/.config/rofi/config.rasi ~/.config/rofi
cp ~/trentos/.config/picom/picom.conf ~/.config/picom
cp ~/trentos/.icons/default/index.theme ~/.icons/default
cp ~/trentos/.Xresources ~/
cp ~/trentos/.bashrc ~/
cp ~/trentos/.gtkrc-2.0 ~/
sudo cp ~/trentos/.config/gtk-3.0/settings.ini /etc/gtk-3.0
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