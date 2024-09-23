#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    arandr\
    bluez\
    bluez-obex\
    brightnessctl\
    dunst\
    feh\
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
    lightdm\
    lightdm-gtk-greeter\
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
    picom\
    playerctl\
    qt6-base\
    qt5-base\
    rclone\
    rofi\
    shotgun\
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
    zip\
    
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

# make dwm
cd ~/trentos/dwm
sudo make install
sudo make clean

# add all config files
mkdir -p\
    ~/.config/rofi\
    ~/Downloads\
    ~/Pictures
cp ~/trentos/config/X11/.xinitrc ~/
cp ~/trentos/config/X11/.xsession ~/
sudo mkdir -p\
    /usr/share/xsessions\
    /etc/gtk-2.0\
    /etc/gtk-3.0
sudo cp ~/trentos/config/gtk-2.0/gtkrc /etc/gtk-2.0/
sudo cp ~/trentos/config/gtk-3.0/settings.ini /etc/gtk-3.0/
sudo cp ~/trentos/config/cursor/index.theme /usr/share/icons/default/
sudo cp ~/trentos/config/X11/Xresources /etc/X11/
sudo cp ~/trentos/config/picom/picom.conf /etc/xdg/
sudo cp ~/trentos/config/X11/dwm.desktop /usr/share/xsessions/
sudo cp ~/trentos/config/lightdm/lightdm.conf /etc/lightdm/
sudo cp ~/trentos/config/nano/nanorc /etc

sudo systemctl enable --now lightdm
sudo systemctl enable --now bluetooth
