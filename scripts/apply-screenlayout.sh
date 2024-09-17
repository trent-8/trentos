#! /bin/sh
screen_rotation=$1
if [ screen_rotation ]; then
    screen_rotation="normal"
fi
if grep -q open /proc/acpi/button/lid/LID0/state; then
    xrandr --output eDP-1 --auto --pos 320x1440 --rotate "$screen_rotation" --output DP-1 --auto --pos 0x0
else
    xrandr --output eDP-1 --off --output DP-1 --auto --pos 0x0
fi
feh --bg-fill ~/trentos/bg.jpg