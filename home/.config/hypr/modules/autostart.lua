-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
  hl.exec_cmd("dunst &")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("quickshell -p ~/.config/quickshell/trentos")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("sleep 1 && megasync")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
  hl.exec_cmd("/usr/bin/kdeconnectd")
  hl.exec_cmd("thunar --daemon")
  hl.exec_cmd("twingate service-start")
  hl.exec_cmd("twingate desktop-start")
end)

