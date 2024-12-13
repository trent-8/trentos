#!/bin/sh
script_dir=$( cd "$(dirname "${SH_SOURCE[0]}")" ; pwd -P )
set -x
if [ ! -d $HOME/yay ]; then
    cd $HOME/
    git clone https://aur.archlinux.org/yay.git
    cd $HOME/yay/
    makepkg -si --noconfirm --needed
fi
yay -Syu --noconfirm --needed\
source $script_dir/.arch-package-list
source $script_dir/.aur-package-list

cp -r "$script_dir/.config/" "$script_dir/Pictures/" "$script_dir/.zshrc" "$script_dir/.zprofile" "$HOME/"
sudo cp -r $script_dir/scripts/* /usr/bin/
sudo cp $script_dir/.zshrc /etc/zsh/zshrc
chsh -s /usr/bin/zsh