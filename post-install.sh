#!/bin/sh
set -x
# install all my pacman packages
sudo pacman -S --noconfirm --needed\
    adapta-gtk-theme\
    alacritty\
    arandr\
    bluez\
    bluez-obex\
    brightnessctl\
    dunst\
    feh\
    firefox\
    git\
    gnome-disk-utility\
    gvfs\
    htop\
    inkscape\
    less\
    libxft\
    libxinerama\
    lightdm\
    lightdm-gtk-greeter\
    nano\
    nano-syntax-highlighting\
    neofetch\
    noto-fonts\
    ntfs-3g\
    obs-studio\
    papirus-icon-theme\
    picom\
    playerctl\
    rclone\
    rofi\
    shotgun\
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
    zsh\
    zsh-autosuggestions\
    zsh-history-substring-search\
    zsh-syntax-highlighting

# install yay and packages
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --needed
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
    ~/Downloads
cp ~/trentos/config/X11/xinitrc ~/
cp ~/trentos/.xsession ~/
sudo mkdir -p\
    /usr/share/xsessions\
    /etc/gtk-2.0\
    /etc/gtk-3.0
sudo cp ~/trentos/config/gtk-2.0/gtkrc /etc/gtk-2.0/
sudo cp ~/trentos/config/gtk-3.0/settings.ini /etc/gtk-3.0/
sudo cp ~/trentos/config/cursor/index.theme /usr/share/icons/default/
sudo cp ~/trentos/config/X11/Xresources /etc/X11/
sudo cp ~/trentos/config/zsh/zprofile /etc/zsh/
sudo cp ~/trentos/config/zsh/zshrc /etc/zsh/
sudo cp ~/trentos/config/picom/picom.conf /etc/xdg/
sudo cp ~/trentos/config/X11/dwm.desktop /usr/share/xsessions/
sudo cp ~/trentos/config/lightdm/lightdm.conf /etc/lightdm/
sudo cp ~/trentos/config/nano/nanorc /etc

chsh -s /bin/zsh
sudo chsh -s /bin/zsh
sudo systemctl enable lightdm
sudo systemctl enable bluetooth
reboot
