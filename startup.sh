#! /bin/sh
# add items to autostart here
exec <&- &
rclone mount --daemon school: ~/school &
rclone mount --daemon personal: ~/personal &
dbus-update-activation-environment --systemd --all &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
swaybg -i ~/Pictures/bg.jpg -m fill &
dunst