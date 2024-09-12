# necessary for dwm shell commands to work for all users
cd ~

# function to get battery info
get_battery_info() {
  if [ -f /sys/class/power_supply/BAT0/capacity ]; then
    echo "    Battery: $(cat /sys/class/power_supply/BAT0/capacity)%"
  else
    echo ""
  fi
}

# display date and time
while true; do
  xsetroot -name "Volume: $(awk -F"[/]" '/front-left:/ { print $2 }' <(pactl get-sink-volume @DEFAULT_SINK@))$(get_battery_info)    $( date +"%-m/%-d/%Y   %-I:%M %P" )"
  sleep 0.1
done &