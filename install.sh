#!/bin/bash
sudo pacman -S --needed base-devel
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --needed\
    bluetuith\
    usbimager\
    visual-studio-code-bin\
    xcursor-breeze
cd ~/trentos/dwm
sudo make install
sudo make clean
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable lightdm
