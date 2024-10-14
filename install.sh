#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -Syu --noconfirm --needed\
    alacritty\
    arandr\
    bluez-obex\
    brightnessctl\
    dunst\
    fcft\
    firefox\
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
    nwg-look\
    pamixer\
    papirus-icon-theme\
    playerctl\
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
    ttf-nerd-fonts-symbols-mono\
    ttf-roboto\
    tumbler\
    unzip\
    vlc\
    xarchiver\
    wayland-protocols\
    wev\
    wget\
    wireshark-qt\
    wlroots\
    wofi\
    xorg-xwayland\
    xorg-server\
    xorg-xinit\
    xorg-xrandr\
    xorg-xsetroot\
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
    xcursor-breeze

# add all config files
mkdir -p\
    ~/.config/rofi\
    ~/Downloads\
    ~/Pictures
sudo mkdir -p /etc/gtk-2.0 /etc/gtk-3.0

# copy all the theme config files to their global locations
cp ~/trentos/config/X11/xinitrc ~/.xintitrc
cd ~/trentos/config/theme
sudo cp gtkrc /etc/gtk-2.0/
sudo cp settings.ini /etc/gtk-3.0/
sudo cp index.theme /usr/share/icons/default/
sudo cp Xresources /etc/X11/
# copy my nano config to its global location
sudo cp ~/trentos/config/nano/nanorc /etc
# copy the start-dwl script to a runnable location
sudo cp ~/trentos/start-dwl /usr/local/bin/

sudo systemctl enable --now bluetooth

# make dwl and dwm
cd ~/trentos/dwl
sudo make install
sudo make clean
cd ~/trentos/dwm
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
