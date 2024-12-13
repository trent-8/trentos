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
    less\
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
    ollama\
    otf-font-awesome\
    openssh\
    pamixer\
    playerctl\
    power-profiles-daemon\
    python-libevdev\
    python-matplotlib\
    python-pip\
    python-pipx\
    python-pygame\
    python-scipy\
    qemu-desktop\
    qt5-wayland\
    rclone\
    rnote\
    shotwell\
    signal-desktop\
    slurp\
    speech-dispatcher\
    texlive\
    tk\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    ttf-liberation\
    unzip\
    waybar\
    wget\
    wofi\
    xdg-desktop-portal-gtk\
    zip\
    zram-generator\
    zsh\
    zsh-autosuggestions\
    zsh-history-substring-search\
    zsh-syntax-highlighting
if [ ! -d $HOME/yay ]; then
    cd $HOME/
    git clone https://aur.archlinux.org/yay.git
    cd $HOME/yay/
    makepkg -si --noconfirm --needed
fi
yay -S --noconfirm --needed\
    bluetuith\
    ipscan\
    pwvucontrol\
    ttf-aptos\
    ttf-times-new-roman\
    uwsm\
    visual-studio-code-bin\
    wlrandbg\
    xcursor-breeze\
$script_dir/update-config.sh
sudo usermod -aG input,video $USER
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now ollama
sudo systemctl enable --now sshd
sudo systemctl start systemd-zram-setup@zram0.service
sudo chsh -s /usr/bin/zsh
chsh -s /usr/bin/zsh