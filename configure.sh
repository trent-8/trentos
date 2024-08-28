#!/bin/bash
cd ~
sudo mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.icons\
    ~/.icons/default\
    ~/school\
    ~/personal
cd ~/trentos
sudo cp .xinitrc ~/
sudo cp .config/terminator/config ~/.config/terminator
sudo cp .config/gtk-3.0/settings.ini ~/.config/gtk-3.0
sudo cp .config/rofi/config.rasi ~/.config/rofi
sudo cp .icons/default/index.theme ~/.icons/default
sudo cp .Xresources ~/
sudo cp .gtkrc-2.0 ~/
sudo cp .config/gtk-3.0/settings.ini /etc/gtk-3.0
sudo echo 'alias notes="python ~/trentos/notes.py"' > ~/.bashrc
if [[ "$USER" == "trent" ]]; then
    sudo mkdir -p\
        ~/school\
        ~/personal\
        ~/.config/rclone
    sudo cp /run/media/trent/storage/rclone/rclone.conf ~/.config/rclone
    git config --global user.email "trenthek@gmail.com"
    git config --global user.name "trent-8"
    git config --global pull.rebase false
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi