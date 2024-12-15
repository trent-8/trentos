#!/bin/bash
if [[ "$(id -u)" != "0" ]]; then
    echo -ne "ERROR! This script must be run under the 'root' user!\n"
    exit 1
fi
USERNAME=$1
shift
packages=()
if [ ! -t 0 ]; then
    mapfile -t stdin_packages
    packages+=("${stdin_packages[@]}")
fi
packages+=("$@")
if [ "${#packages[@]}" -eq 0 ]; then
    echo "Usage: $0 <username> [package1 package2 ...] or $0 <username> - < filename"
    exit 1
fi
cd "/home/$USERNAME/" || exit
for package in "${packages[@]}"; do
    sudo -u "$USERNAME" git clone "https://aur.archlinux.org/$package.git"
    cd "/home/$USERNAME/$package"
    sudo -u "$USERNAME" makepkg -s --noconfirm
    chown -R "root" "/home/$USERNAME/$package"
    pacman -U *.pkg.tar.zst --noconfirm --needed
    cd "/home/$USERNAME/"
    rm -r "/home/$USERNAME/$package"
done