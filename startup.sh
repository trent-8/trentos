#! /bin/sh
# add items to autostart here
if [[ "$USER" == "trent" ]]; then
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi &
dunst &
picom