# add items to autostart here
~/trentos/scripts/apply-screenlayout.sh normal &
dunst &
picom &
if [[ "$USER" == "trent" ]]; then
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi