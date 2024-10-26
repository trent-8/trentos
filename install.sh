#!/bin/sh
# get the parent directory of this script
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    bluez-obex\
    brightnessctl\
    clapper\
    dunst\
    firefox\
    grim\
    gtk4\
    gvfs\
    htop\
    hyprland\
    hunspell-en_us\
    jdk-openjdk\
    less\
    libreoffice-fresh\
    mate-calc\
    materia-gtk-theme\
    nano\
    nano-syntax-highlighting\
    nemo\
    nemo-fileroller\
    neofetch\
    network-manager-applet\
    noto-fonts\
    ntfs-3g\
    obs-studio\
    otf-font-awesome\
    pamixer\
    papirus-icon-theme\
    playerctl\
    polkit-kde-agent\
    power-profiles-daemon\
    python-libevdev\
    python-matplotlib\
    python-pip\
    python-pipx\
    python-pygame\
    python-scipy\
    qt5-base\
    qt5-wayland\
    qt6-base\
    qt6-wayland\
    rclone\
    sddm\
    shotwell\
    signal-desktop\
    speech-dispatcher\
    swaybg\
    tk\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    unzip\
    waybar\
    wev\
    wget\
    wireshark-qt\
    wofi\
    xorg-xwayland\
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
    bluetuith\
    spotify\
    ttf-aptos\
    wlrobs-hg\
    xcursor-breeze\
    visual-studio-code-bin

cd $script_dir/config
cp -r hypr/ waybar/ spotify-flags.conf $HOME/.config/
sudo cp -r nanorc gtk-2.0/ gtk-3.0/ gtk-4.0/ /etc/
sudo cp -r hypr/ /usr/share/hyprland
# make a home for background photos
cd $script_dir
cp -r Pictures/ $HOME/
# make it so "shl" will start hyprland
sudo cp $script_dir/shl /usr/local/bin/

sudo systemctl enable --now bluetooth
sudo systemctl enable --now sddm