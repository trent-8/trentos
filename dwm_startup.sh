#!/usr/bin/sh
get_status() {
    printf "Volume $(pamixer --get-volume)"
    if [ $(pamixer --get-mute) = true ]; then
        printf 🔇
    fi
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        BAT0_status=$(cat /sys/class/power_supply/BAT0/status)
        printf "   Battery $(cat /sys/class/power_supply/BAT0/capacity)"
        if [ "$BAT0_status" = "Charging" -o "$BAT0_status" = "Not charging" -o  "$BAT0_status" = "Full" ]; then
            printf 🔌
        fi
    fi
    printf "   $(date +"%-m/%-d/%Y   %-I:%M %P")"
}

dunst &
feh --bg-fill ${HOME}/.config/hypr/wallpapers/Mandelbrot_Set1.png &
solaar -w hide &

while true; do
    xsetroot -name "$(get_status)"
    sleep 0.05
done
