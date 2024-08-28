#!/bin/bash
sudo pacman -S --needed base-devel
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --needed\
    arandr\
    bluetuith\
    breeze-gtk\
    brightnessctl\
    code\
    dunst\
    feh\
    firefox\
    gvfs\
    htop\
    inkscape\
    libxft\
    libxinerama\
    nano\
    neofetch\
    obs-studio\
    papirus-icon-theme\
    picom\
    playerctl\
    prusa-slicer\
    rclone\
    rofi\
    shotgun\
    spotify-launcher\
    terminator\
    thunar\
    ttf-nerd-fonts-symbols-mono\
    tumbler\
    unzip\
    usbimager\
    vlc\
    xarchiver\
    xcursor-breeze\
    xorg-server\
    xorg-xinit\
    xorg-xrandr\
    xorg-xsetroot
cd ~/trentos/dwm
sudo make install
sudo make clean
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
~/trentos/configure.sh
