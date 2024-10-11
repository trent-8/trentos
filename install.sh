#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    bluez\
    bluez-obex\
    brightnessctl\
    dunst\
    firefox\
    git\
    gtk4\
    gtk3\
    gtk2\
    gvfs\
    htop\
    less\
    libreoffice-fresh\
    libxft\
    libxinerama\
    mate-calc\
    materia-gtk-theme\
    nano\
    nano-syntax-highlighting\
    neofetch\
    noto-fonts\
    ntfs-3g\
    obs-studio\
    pamixer\
    papirus-icon-theme\
    playerctl\
    qt6-base\
    qt5-base\
    rclone\
    signal-desktop\
    spotify-launcher\
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
    zip
    
# install yay and packages
cd ~
if [ ! -d yay ]; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm --needed
fi
yay -S --noconfirm --needed\
    visual-studio-code-bin\
    bluetuith\
    xcursor-breeze\
    usbimager

# add all config files
mkdir -p\
    ~/.config/rofi\
    ~/Downloads\
    ~/Pictures
sudo mkdir -p /etc/gtk-2.0 /etc/gtk-3.0
sudo cp ~/trentos/config/gtk-2.0/gtkrc /etc/gtk-2.0/
sudo cp ~/trentos/config/gtk-3.0/settings.ini /etc/gtk-3.0/
sudo cp ~/trentos/config/cursor/index.theme /usr/share/icons/default/
sudo cp ~/trentos/config/cursor/Xresources /etc/X11/
sudo cp ~/trentos/start-dwl /usr/local/bin/
sudo cp ~/trentos/config/nano/nanorc /etc

sudo systemctl enable --now bluetooth

# make dwl
cd ~/trentos/dwl
sudo make install
sudo make clean
