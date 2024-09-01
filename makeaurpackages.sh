#!/bin/bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/$username
cd bluetuith
makepkg -si
cd /home/$username
git clone https://aur.archlinux.org/usbimager.git
cd usbimager
makepkg -si
cd /home/$username
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd /home/$username
git clone https://aur.archlinux.org/xcursor-breeze.git
cd xcursor-breeze
makepkg -si