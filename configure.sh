#!/bin/bash
set -x
set +v
sudo mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.icons\
    ~/.icons/default
cd ~/ultimate-system
sudo cp .xinitrc ~/
sudo cp .config/terminator/config ~/.config/terminator
sudo cp .config/gtk-3.0/settings.ini ~/.config/gtk-3.0
sudo cp .config/rofi/config.rasi ~/.config/rofi
sudo cp .icons/default/index.theme ~/.icons/default
sudo cp .Xresources ~/
sudo cp .gtkrc-2.0 ~/
sudo cp .config/gtk-3.0/settings.ini /etc/gtk-3.0

git config --global user.email "trenthek@gmail.com"
git config --global user.name "trent-8"
git config --global pull.rebase false

alias notes="python ~/trentos/notes.py"