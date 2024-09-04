#!/bin/bash
set -x
# install all my pacman packages
sudo pacman -S --noconfirm --needed\
    adapta-gtk-theme\
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
    pipewire\
    pipewire-audio\
    pipewire-alsa\
    pipewire-pulse\
    pipewire-jack\
    playerctl\
    rclone\
    rofi\
    shotgun\
    spotify-launcher\
    terminator\
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
    wget\
    wireplumber

# add all config files
cd ~
mkdir -p\
    ~/.config/gtk-3.0\
    ~/.config/rofi\
    ~/.config/terminator\
    ~/.config/picom\
    ~/.icons/default\
    ~/Downloads
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

# install yay and packages
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -S --noconfirm --needed\
    visual-studio-code-bin\
    bluetuith\
    xcursor-breeze\
    usb-imager