#! /bin/sh
# add items to autostart here
rclone mount --daemon school: ~/school &
rclone mount --daemon personal: ~/personal &
dunst &
picom &
slstatus
