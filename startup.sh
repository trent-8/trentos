#! /bin/sh
# add items to autostart here
exec <&- &
rclone mount --daemon school: ~/school &
rclone mount --daemon personal: ~/personal &
dunst