#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if uwsm check may-start; then
    exec uwsm start -S hyprland.desktop
fi