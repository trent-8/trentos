#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if uwsm check may-start; then
    uwsm start -C "tiling compositor that does not sacrifice on its looks" -S -- hyprland.desktop
fi