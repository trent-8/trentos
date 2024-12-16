#!/bin/bash
script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
sudo pacman -Sy
sudo pacman -S p7zip
cd "$script_dir"
mkdir personal-dotfiles
cp encrypted-dotfiles.7z personal-dotfiles/
cd personal-dotfiles
7z x encrypted-dotfiles.7z
rm encrypted-dotfiles.7z
cp -r ./ "$HOME/"