#!/bin/sh
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
set -x
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    bluez-obex\
    brightnessctl\
    btop\
    clapper\
    dunst\
    firefox\
    fprintd\
    grim\
    gst-libav\
    gvfs\
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
    ttf-liberation\
    unzip\
    waybar\
    wget\
    wireshark-qt\
    wofi\
    xdg-desktop-portal-gtk\
    zip\
    zram-generator
if [ ! -d $HOME/yay ]; then
    cd $HOME/
    git clone https://aur.archlinux.org/yay.git
    cd $HOME/yay/
    makepkg -si --noconfirm --needed
fi
yay -S --noconfirm --needed\
    bluetuith\
    hypridle-git\
    hyprlock-git\
    hyprland-git\
    hyprpaper-git\
    hyprpolkitagent-git\
    hyprsunset-git\
    ipscan\
    spotify\
    ttf-aptos\
    ttf-times-new-roman\
    xcursor-breeze\
    uwsm\
    visual-studio-code-bin\
    wlrandbg\
    xdg-desktop-portal-hyprland-git
$script_dir/update-config.sh
sudo usermod -aG input,wireshark,video $USER
systemctl --user enable hyprland@0.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service