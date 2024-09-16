# Function to get battery info
get_battery_info() {
  # Check for BAT0 or BAT1 existence
  if [ -f /sys/class/power_supply/BAT0/capacity ]; then
    battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT0/status)
  elif [ -f /sys/class/power_supply/BAT1/capacity ]; then
    battery_level=$(cat /sys/class/power_supply/BAT1/capacity)
    battery_status=$(cat /sys/class/power_supply/BAT1/status)
  else
    echo ""
    return
  fi

  # Add 'p' if the laptop is plugged in (Charging or Full)
  if [ "$battery_status" = "Charging" ]; then
    echo "   Battery charging ${battery_level}%"
  elif [ "$battery_status" = "Not Charging" ]; then
    echo "   Battery full ${battery_level}%"
  elif [ "$battery_status" = "Full" ]; then
    echo "   Battery full ${battery_level}%"
  elif [ "$battery_status" = "Discharging" ]; then
    echo "   Battery ${battery_level}%"
  fi
}

# Function to get volume info
get_volume_info() {
  # Check if the volume is muted
  muted=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
  if [ "$muted" = "yes" ]; then
    echo "Volume muted"
  else
    # Get the volume level
    volume=$(pamixer --get-volume)
    echo "Volume ${volume}%"
  fi
}

# Function to get current date and time
get_date_time() {
  date_time=$(date +"%-m/%-d/%Y   %-I:%M %P")
  echo "   ${date_time}"
}

# Display date, time, volume, and battery info
while true; do
  # Get the battery info
  battery_info=$(get_battery_info)
  # Get the current date and time
  date_time=$(get_date_time)
  # Get the current volume level
  volume_info=$(get_volume_info)
  # Update the status bar
  xsetroot -name "${volume_info}${battery_info}${date_time}"
  sleep 0.1
done &
