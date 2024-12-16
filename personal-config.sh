#!/bin/bash
script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
pacman -Sy
pacman -S p7zip
cd "$script_dir"
7z x personal-dotfiles.zip
mkdir personal-dotfiles
cp dotfiles.zip personal-dotfiles/
rm dotfiles.zip
cd personal-dotfiles
7z x dotfiles.zip
rm dotfiles.zip
cp -r ./ "$HOME/"