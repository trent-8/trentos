#!/bin/bash
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
