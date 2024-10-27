#!/bin/sh
# get the parent directory of this script
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    kitty\
    bluez-obex\
    brightnessctl\
    clapper\
    dunst\
    firefox\
    gvfs\
    htop\
    hypridle\
    hyprland\
    hyprlock\
    hunspell-en_us\
    jdk-openjdk\
    kvantum-theme-materia\
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
    playerctl\
    polkit-kde-agent\
    power-profiles-daemon\
    python-libevdev\
    python-matplotlib\
    python-pip\
    python-pipx\
    python-pygame\
    python-scipy\
    rclone\
    shotwell\
    signal-desktop\
    speech-dispatcher\
    swaybg\
    tk\
    ttf-roboto\
    unzip\
    waybar\
    wget\
    wireshark-qt\
    wofi\
    xdg-desktop-portal-gtk\
    xdg-desktop-portal-hyprland\
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
    xcursor-breeze\
    visual-studio-code-bin

cd $script_dir
cp -r .config/ Pictures/ .bash_profile $HOME/

# make it so "shl" will start hyprland
sudo cp $script_dir/shl /usr/local/bin/

sudo systemctl enable --now bluetooth