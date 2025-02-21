{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
window#waybar {
    color: #ffffff;
    background-color: rgba(33, 33, 33, 0.9);
    font-weight: bold;
    border-radius: 0;
    border: none;
}

window#waybar.hidden {
    opacity: 0.2;
}

button {
    color: #ffffff;
    border: none;
    background-color: rgba(55, 55, 55, 0.9);
}

button:hover, #pulseaudio:hover, #workspaces button:hover, #workspaces button.visible, #custom-wofi:hover {
    background-color: rgba(88, 88, 88, 0.9);
}

#workspaces, #window {
    background-color: transparent;
    border: none;
    font-family: Roboto;
    font-size: 16px;
    border-radius: 4px;
}

#workspaces button {
    margin-right: 1px;
}

#workspaces button.active {
    color: rgba(14, 255, 195, 0.9);
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#clock, #power-profiles-daemon, #cpu, #memory, #disk, #backlight, #network, #pulseaudio, #wireplumber, #custom-wofi, #temperature, #tray, #workspaces button {
    background-color: rgba(55, 55, 55, 0.9);
    padding: 2px 7px;
    border: 1px solid rgba(88, 88, 88, 0.9);
    font-family: Roboto;
    font-size: 16px;
    border-radius: 4px;
}

#battery {
    color: rgba(68, 167, 7, 0.9);
    background-color: rgba(55, 55, 55, 0.9);
    padding: 2px 7px;
    border: 1px solid rgba(88, 88, 88, 0.9);
    font-family: Source Code Pro;
    font-size: 16px;
    border-radius: 4px;
}

#battery.warning {
    color: rgba(167, 116, 7, 0.9);
}

#battery.critical {
    color: rgba(209, 24, 7, 0.9);
}

#pulseaudio.muted {
    background-color: rgba(55, 55, 55, 0.9);
}

#wireplumber.muted {
    background-color: rgba(55, 55, 55, 0.9);
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: rgba(55, 55, 55, 0.9);
}
    '';
    settings = [{
      layer = "top";
      position = "bottom";
      spacing = 1;
      modules-left = ["custom/wofi" "hyprland/workspaces"];
      modules-center = ["hyprland/window"];
      modules-right = ["tray" "power-profiles-daemon" "network" "pulseaudio" "battery" "clock"];
      tray = {
        icon-size = 21;
        spacing = 10;
      };
      clock = {
        tooltip = false;
        format = "{:%I:%M}";
        format-alt = "{:%m/%d/%Y}";
      };
      battery = {
        # bat = "BAT0";
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon}{capacity}";
        # format-full = "{icon} full";
        format-charging = "🔌 {icon} {capacity}";
        format-icons = ["▏     " "▎     " "▍     " "▌     " "▋     " "▊     " "▉     " "█     " "█▏    " "█▎    " "█▍    " "█▌    " "█▋    " "█▊    " "█▉    " "██    " "██▎   " "██▍   " "██▌   " "██▋   " "██▊   " "██▉   " "███   " "███▏  " "███▎  " "███▍  " "███▌  " "███▋  " "███▊  " "███▉  " "████  " "████▏ " "████▎ " "████▍ " "████▌ " "████▋ " "████▊ " "████▉ " "█████ " "█████▎" "█████▍" "█████▌" "█████▋" "█████▊" "█████▉" "██████"];
        
      };
      memory = {
        format = "{used:0.1f}GB";
        tooltip = false;
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "performance";
          performance = "performance";
          balanced = "balanced";
          power-saver = "power-saver";
        };
      };
      pulseaudio = {
        scroll-step = 2;
        format = "{icon}{volume} {format_source}";
        format-muted = "🔇 {format_source}";
        format-source = "🎙{volume}";
        format-source-muted = "🎙m";
        format-icons = {
          default = ["🔈" "🔉" "🔊"];
        };
        on-click = "uwsm-app pwvucontrol";
        on-click-right = "uwsm-app -- alacritty -e bash -c 'bluetuith --adapter-states=\"scan:yes\"'";
      };
      "custom/wofi" = {
        tooltip-format = "application menu";
        format = "≡";
        tooltip = true;
        on-click = "pidof wofi && pkill wofi || wofi --show drun --allow-images --normal-window";
      };
      temperature = {
        format = "{temperatureF}°F";
      };
      network = {
        format = "{ipaddr} {ifname}";
        format-wifi = "{ifname} {essid} {frequency}GHz";
      };
    }];
  };
}
