#!/bin/bash
set -x
USERNAME=$1
PACKAGE_LIST_FILE=$2
mapfile -t packages < "$PACKAGE_LIST_FILE"
cd "/home/$USERNAME/"
for package in "${packages[@]}"; do
    sudo -u $USERNAME git clone "https://aur.archlinux.org/$package.git"
    cd "/home/$USERNAME/$package"
    sudo -u $USERNAME makepkg -s --noconfirm
    chown -R "root" "/home/$USERNAME/$package"
    pacman -U *.pkg.tar.zst --noconfirm --needed
    cd "/home/$USERNAME/"
    rm -r "/home/$USERNAME/$package"
done