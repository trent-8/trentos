#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    bluez-obex\
    blueman\
    brightnessctl\
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
    mate-polkit\
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
    pamixer\
    papirus-icon-theme\
    playerctl\
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
    shotwell\
    signal-desktop\
    speech-dispatcher\
    spotify-launcher\
    swaybg\
    tk\
    tllist\
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    unzip\
    vlc\
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
    ttf-aptos\
    visual-studio-code-bin\
    wlrobs-hg\
    xcursor-breeze

mkdir -p ~/Pictures
sudo mkdir -p /etc/gtk-2.0 /etc/gtk-3.0 /etc/gtk-4.0 ~/.config/hypr

cd ~/trentos/config
cp hyprland.conf ~/.config/hypr/
sudo cp nanorc /etc/
sudo cp waybar/config.jsonc /etc/xdg/waybar/
cd theme
sudo cp gtkrc /etc/gtk-2.0/
sudo cp settings-gtk3.ini /etc/gtk-3.0/settings.ini
sudo cp settings-gtk4.ini /etc/gtk-4.0/settings.ini
sudo cp index.theme /usr/share/icons/default/
sudo cp Xresources /etc/X11/

sudo systemctl enable --now bluetooth

# make dwl
cd ~/trentos/dwl
sudo make install
sudo make clean

# Function to present a menu and prompt for user input
present_menu() {
    echo "Please select the Vulkan package you want to install:"
    echo "1. vulkan-nvidia (for NVIDIA GPUs)"
    echo "2. vulkan-radeon (for AMD GPUs)"
    echo "3. vulkan-intel (for Intel GPUs)"
    echo "4. vulkan-nouveau (for Nouveau GPUs)"
    echo "5. Exit"
}

# Function to install the selected Vulkan package
install_package() {
    case $1 in
        1)
            echo "Installing vulkan-nvidia..."
            sudo pacman -S --noconfirm --needed vulkan-nvidia
            ;;
        2)
            echo "Installing vulkan-radeon..."
            sudo pacman -S --noconfirm --needed vulkan-radeon
            ;;
        3)
            echo "Installing vulkan-intel..."
            sudo pacman -S --noconfirm --needed vulkan-intel
            ;;
        4)
            echo "Installing vulkan-nouveau..."
            sudo pacman -S --noconfirm --needed vulkan-nouveau
            ;;
        5)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid selection. Please choose a number between 1 and 5."
            ;;
    esac
}

# Present the menu and get user selection
present_menu
read -p "Enter your choice (1-5): " choice

# Install the selected package
install_package $choice
