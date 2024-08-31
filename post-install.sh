#!/bin/bash
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --needed\
    bluetuith\
    usbimager\
    visual-studio-code-bin\
    xcursor-breeze
if [[ "$USER" == "trent" ]]; then
    mkdir -p\
        ~/school\
        ~/personal\
        ~/Downloads\
        ~/.config/rclone
    cp ~/Downloads/rclone/rclone.conf ~/.config/rclone
    git config --global user.email "trenthek@gmail.com"
    git config --global user.name "trent-8"
    git config --global pull.rebase false
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi