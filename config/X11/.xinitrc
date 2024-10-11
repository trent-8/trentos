while true; do
  xsetroot -name "$(~/trentos/get-status)"
  sleep 0.05
done &
exec dwm
