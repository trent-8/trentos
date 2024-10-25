#!/bin/sh
set -x

mkdir -p\
    ~/school\
    ~/personal
git config --global user.email "trenthek@gmail.com"
git config --global user.name "trent-8"
git config --global pull.rebase false
git config --global core.editor "nano"
git config --global init.defaultBranch main
