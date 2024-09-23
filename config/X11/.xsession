get_battery_info() {
  if [ -f /sys/class/power_supply/BAT0/capacity ]; then
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
  else
    echo ""
    return
  fi

  if [ "$battery_status" = "Charging" ]; then
    echo "   Battery🗲${battery_level}"
  elif [ "$battery_status" = "Not Charging" ]; then
    echo "   Battery🗲${battery_level}"
  elif [ "$battery_status" = "Full" ]; then
    echo "   Battery🗲${battery_level}"
  elif [ "$battery_status" = "Discharging" ]; then
    echo "   Battery ${battery_level}"
  fi
}

get_volume_info() {
  if [ "$(pamixer --get-mute)" = "true" ]; then
    echo "Volume muted"
  else
    volume=$(pamixer --get-volume)
    echo "Volume ${volume}"
  fi
}

get_date_time() {
  date_time=$(date +"%-m/%-d/%Y   %-I:%M %P")
  echo "   ${date_time}"
}

while true; do
  battery_info=$(get_battery_info)
  date_time=$(get_date_time)
  volume_info=$(get_volume_info)
  xsetroot -name "${volume_info}${battery_info}${date_time}"
  sleep 0.1
done &
