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
    fprintd\
    grim\
    gst-libav\
    gvfs\
    htop\
    hunspell-en_us\
    jdk-openjdk\
    kvantum-theme-materia\
    less\
    libreoffice-fresh\
    mate-calc\
    mate-polkit\
    materia-gtk-theme\
    nano\
    nano-syntax-highlighting\
    nemo\
    nemo-fileroller\
    neofetch\
    network-manager-applet\
    noto-fonts\
    noto-fonts-cjk\
    noto-fonts-emoji\
    ntfs-3g\
    obs-studio\
    otf-font-awesome\
    pamixer\
    playerctl\
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
    slurp\
    speech-dispatcher\
    tk\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    unzip\
    waybar\
    wget\
    wireshark-qt\
    wofi\
    xdg-desktop-portal-gtk\
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
    hypridle-git\
    hyprlock-git\
    hyprland-git\
    hyprsunset-git\
    ipscan\
    spotify\
    ttf-aptos\
    ttf-times-new-roman\
    xcursor-breeze\
    visual-studio-code-bin\
    wlrandbg\
    xdg-desktop-portal-hyprland-git

cd $script_dir
cp -r .config/ Pictures/ $HOME/
sudo cp Hl.sh /usr/local/bin/Hl

sudo systemctl enable --now bluetooth
sudo usermod -aG input,wireshark,video $USER