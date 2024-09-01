#!/bin/bash
username=$1
cd /home/$username
echo $PWD
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd /home/$username
echo $PWD
cd bluetuith
makepkg -si
cd /home/$username
echo $PWD
git clone https://aur.archlinux.org/usbimager.git
cd usbimager
makepkg -si
cd /home/$username
echo $PWD
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd /home/$username
echo $PWD
git clone https://aur.archlinux.org/xcursor-breeze.git
cd xcursor-breeze
makepkg -si