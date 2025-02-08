{
  programs.waybar = {
    enable = true;
    style = ''
* {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto;
    font-size: 16px;
    border-radius: 7px;
    border: none;
}

window#waybar {
    color: #ffffff;
    background-color: rgba(33, 33, 33, 0.95);
    transition-property: background-color;
    transition-duration: .5s;
    font-weight: bold;
    border-radius: 0;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    color: #ffffff;
    border: none;
    background-color: rgba(77, 77, 77, 0.95);
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background-color: rgba(100, 100, 100, 0.95);
}

/* you can set a style on hover for any module like this */
#pulseaudio:hover {
    background-color: rgba(100, 100, 100, 0.95);
}

#workspaces {
    background-color: rgba(33, 33, 33, 0.95);
}

#workspaces button {
    color: #ffffff;
    background-color: rgba(77, 77, 77, 0.95);
    margin-right: 1px;
}

#workspaces button:hover {
    background: rgba(100, 100, 100, 0.95);
}

#workspaces button.active {
    color: rgba(14, 255, 195, 0.95);
}

#workspaces button.visible {
    color: rgba(14, 255, 195, 0.95);
    background: rgba(100, 100, 100, 0.95);
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#custom-wofi,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#power-profiles-daemon,
#mpd {
    padding: 0 12px 0 10px ;
}

#window {
    background-color: transparent;
    margin-right: 0;
}

#clock {
    background-color: rgba(77, 77, 77, 0.95);
    margin-right: 0;
    padding: 0 7px;
}

#battery {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 7px;
}

#battery.charging, #battery.plugged {
    background-color: rgba(77, 77, 77, 0.95);
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: #f53c3c;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#power-profiles-daemon {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 15px 0 8px;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: rgba(77, 77, 77, 0.95);
}

#memory {
    background-color: rgba(77, 77, 77, 0.95);
}

#disk {
    background-color: rgba(77, 77, 77, 0.95);
}

#backlight {
    background-color: rgba(77, 77, 77, 0.95);
}

#network {
    background-color: rgba(77, 77, 77, 0.95);
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 8px;
}

#pulseaudio.muted {
    background-color: rgba(77, 77, 77, 0.95);
}

#wireplumber {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 8px;
}

#wireplumber.muted {
    background-color: rgba(77, 77, 77, 0.95);
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-wofi {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 15px 0 10px ;
}

#custom-wofi:hover {
    background-color: rgba(100, 100, 100, 0.95);
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    background-color: rgba(77, 77, 77, 0.95);
}

#temperature.critical {
    background-color: rgba(77, 77, 77, 0.95);
}

#tray {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 10px;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: rgba(77, 77, 77, 0.95);
}

#idle_inhibitor {
    background-color: rgba(77, 77, 77, 0.95);
    padding: 0 15px 0 7px ;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #00b093;
    color: #740864;
    padding: 0 5px;
    min-width: 16px;
}

#keyboard-state {
    background: #97e1ad;
    color: #000000;
    padding: 0 0px;
    min-width: 16px;
}

#keyboard-state > label {
    padding: 0 5px;
}

#keyboard-state > label.locked {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
  background-color: transparent;
}

#privacy {
    padding: 0;
}

#privacy-item {
    padding: 0 5px;
}

#privacy-item.screenshare {
    background-color: #cf5700;
}

#privacy-item.audio-in {
    background-color: #1ca000;
}

#privacy-item.audio-out {
    background-color: #0069d4;
}
    '';
    settings = [{
      layer = "top";
      position = "bottom";
      spacing = 1;
      modules-left = ["custom/wofi" "hyprland/workspaces"];
      modules-center = ["hyprland/window"];
      modules-right = ["tray" "pulseaudio" "power-profiles-daemon" "idle_inhibitor" "battery" "clock"];
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
        bat = "BAT0";
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}";
        format-full = "{icon} full";
        format-charging = " {capacity} ";
        format-icons = ["" "" "" "" ""];
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };
      pulseaudio = {
        scroll-step = 2;
        format = "{icon} {volume}  {format_source}";
        format-muted = "🔇  {format_source}";
        format-source = " {volume}";
        format-source-muted = "";
        format-icons = {
          headphone = "🎧";
          hands-free = "";
          headset = "🎧";
          phone = "";
          portable = "";
          car = "";
          default = ["🔈" "🔉" "🔊"];
        };
        on-click = "pwvucontrol";
        on-click-right = "alacritty -e bash -c 'bluetuith --adapter-states=\"scan:yes\"'";
      };
      "custom/wofi" = {
        tooltip-format = "application menu";
        format = "";
        tooltip = true;
        on-click = "pidof wofi && pkill wofi || wofi --show drun --allow-images --normal-window";
      };
    }];
  };
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      general {
        enable_fingerprint = true
      }

      input-field {
        monitor =
        fade_on_empty = false
        rounding = 12
      }

      background {
        color = rgb(23, 39, 41)
      }
    '';
  };
}