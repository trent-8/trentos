# add items to autostart here
~/trentos/scripts/monitor.sh &
feh --bg-fill ~/trentos/bg.png &
dunst &
picom &
if [[ "$USER" == "trent" ]]; then
    rclone mount --daemon school: ~/school
    rclone mount --daemon personal: ~/personal
fi