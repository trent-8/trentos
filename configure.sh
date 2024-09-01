#!/bin/bash
set -x
cd ~
mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.config/picom\
    ~/.icons/default
cp ~/trentos/.xinitrc ~/
cp ~/trentos/.xsession ~/
cp ~/trentos/.config/terminator/config ~/.config/terminator/
cp ~/trentos/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/
cp ~/trentos/.config/rofi/config.rasi ~/.config/rofi/
cp ~/trentos/.config/picom/picom.conf ~/.config/picom/
cp ~/trentos/.icons/default/index.theme ~/.icons/default/
cp ~/trentos/.Xresources ~/
cp ~/trentos/.bashrc ~/
cp ~/trentos/.gtkrc-2.0 ~/
sudo mkdir /usr/share/xsessions
sudo cp ~/trentos/.config/gtk-3.0/settings.ini /etc/gtk-3.0/
sudo cp ~/trentos/lightdm.conf /etc/lightdm/
sudo cp ~/trentos/dwm.desktop /usr/share/xsessions/
if [[ "$USER" == "trent" ]]; then
    mkdir -p\
        ~/school\
        ~/personal\
        ~/Downloads\
        ~/.config/rclone
    cp ~/Downloads/rclone/rclone.conf ~/.config/rclone/
    git config --global user.email "trenthek@gmail.com"
    git config --global user.name "trent-8"
    git config --global pull.rebase false
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --noconfirm --needed\
    visual-studio-code-bin\
    bluetuith\
    xcursor-breeze\
    usb-imager