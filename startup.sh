# add items to autostart here
~/.screenlayout/apply-layout.sh &
dunst &
picom &
if [[ "$USER" == "trent" ]]; then
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi