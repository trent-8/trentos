#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    aphototoollibre\
    bluez-obex\
    brightnessctl\
    dunst\
    fcft\
    firefox\
    gparted\
    grim\
    gtk4\
    gvfs\
    htop\
    hunspell-en_us\
    jdk-openjdk\
    less\
    libreoffice-fresh\
    mate-calc\
    mate-polkit\
    materia-gtk-theme\
    nano\
    nano-syntax-highlighting\
    neofetch\
    noto-fonts\
    ntfs-3g\
    pamixer\
    papirus-icon-theme\
    playerctl\
    python-keyboard\
    python-libevdev\
    python-matplotlib\
    python-pipx\
    python-pygame\
    python-scipy\
    qt5-base\
    qt5-wayland\
    qt6-base\
    qt6-wayland\
    rclone\
    signal-desktop\
    spotify-launcher\
    thunar\
    tllist\
    ttf-ms-win11-auto\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    tumbler\
    unzip\
    vlc\
    wayland-protocols\
    wev\
    wget\
    wireplumber\
    wireshark-qt\
    wlroots\
    wofi\
    xorg-xwayland\
    yay\
    zip\
    zram-generator
    
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

