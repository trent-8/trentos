#!/bin/bash
set -x
# install all my pacman packages
sudo pacman -S --noconfirm --needed\
    adapta-gtk-theme\
    alacritty\
    arandr\
    bluez\
    bluez-obex\
    brightnessctl\
    dunst\
    feh\
    firefox\
    git\
    gnome-disk-utility\
    gvfs\
    htop\
    inkscape\
    less\
    libxft\
    libxinerama\
    lightdm\
    lightdm-gtk-greeter\
    nano\
    neofetch\
    noto-fonts\
    ntfs-3g\
    obs-studio\
    papirus-icon-theme\
    picom\
    playerctl\
    rclone\
    rofi\
    shotgun\
    thunar\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    tumbler\
    unzip\
    vlc\
    xarchiver\
    xorg-server\
    xorg-xinit\
    xorg-xrandr\
    xorg-xsetroot\
    wget
    

# add all config files
cd ~
mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.config/picom\
    ~/.icons/default\
    ~/Downloads
cp ~/trentos/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/
cp ~/trentos/.config/rofi/config.rasi ~/.config/rofi/
cp ~/trentos/.config/picom/picom.conf ~/.config/picom/
cp ~/trentos/.icons/default/index.theme ~/.icons/default/
cp ~/trentos/.xinitrc ~/
cp ~/trentos/.xsession ~/
cp ~/trentos/.Xresources ~/
cp ~/trentos/.zshrc ~/
cp ~/trentos/.gtkrc-2.0 ~/
sudo mkdir -p\
    /usr/share/xsessions\
    /etc/gtk-3.0
sudo cp ~/trentos/.config/gtk-3.0/settings.ini /etc/gtk-3.0/
sudo cp ~/trentos/lightdm.conf /etc/lightdm/
sudo cp ~/trentos/dwm.desktop /usr/share/xsessions/

# install yay and packages
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --needed
yay -S --noconfirm --needed\
    visual-studio-code-bin\
    bluetuith\
    xcursor-breeze\
    usbimager

sudo systemctl enable lightdm
sudo systemctl enable bluetooth

# make dwm
cd ~/trentos/dwm
sudo make install
sudo make clean