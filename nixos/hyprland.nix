{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = ''
      $ua = uwsm app --

      monitor = eDP-1, 1920x1200x60hz, auto, 1
      monitor = , 2560x1440@75hz, auto, 1

      env = QT_QPA_PLATFORM,wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = GDK_BACKEND,wayland,x11
      env = GTK_THEME,Adwaita:dark
      env = ELECTRON_OZONE_PLATFORM_HINT,wayland
      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24
      env = XCURSOR_THEME,Breeze_Light

      #exec-once = dbus-update-activation-environment --systemd --all
      exec-once = uwsm finalize QT_QPA_PLATFORM QT_WAYLAND_DISABLE_WINDOWDECORATION QT_AUTO_SCREEN_SCALE_FACTOR GDK_BACKEND GTK_THEME ELECTRON_OZONE_PLATFORM_HINT XCURSOR_SIZE HYPRCURSOR_SIZE XCURSOR_THEME VISUAL EDITOR
      exec-once = $ua rclone mount --vfs-cache-mode full --daemon school: $HOME/school
      exec-once = $ua rclone mount --vfs-cache-mode full --daemon personal: $HOME/personal
      exec-once = $ua dunst
      exec-once = $ua solaar -w hide
      exec-once = systemctl --user start plasma-polkit-agent

      general {
        gaps_in = 2
        gaps_out = 3
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959cc)
        resize_on_border = true
        allow_tearing = false
        layout = dwindle
      }

      decoration {
        rounding = 1
        active_opacity = 1
        inactive_opacity = 0.90
        blur {
          enabled = true
          size = 4
        }
        shadow {
          enabled = false
        }
      }

      animations {
        bezier = smooth, 0.5, 0, 0.5, 1
        bezier = windows_in, 1, 0, 0.875, 1
        animation = windowsIn, 1, 2, windows_in, popin 50%
        animation = windowsOut, 1, 0.5, smooth, popin 50%
        animation = windowsMove, 1, 2, smooth
        animation = border, 1, 2, smooth
        animation = borderangle, 0
        animation = layers, 1, 2, smooth, fade
        animation = fade, 1, 2, smooth
        animation = fadeIn, 1, 2, windows_in
        animation = fadeOut, 1, 0.5, smooth
        animation = fadeLayers, 1, 8, smooth
        animation = workspaces, 1, 2, smooth
      }

      dwindle {
        pseudotile = true
        preserve_split = true
      }

      master {
        new_status = master
      }

      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = true
        enable_swallow = true
        swallow_regex = ^(Alacritty)$
        swallow_exception_regex = ^(wev)$
      }

      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 1
        touchpad {
          natural_scroll = false
        }
        touchdevice {
          output = eDP-1
        }
        tablet {
          output = eDP-1
        }
        accel_profile = custom 1 0 0.5
      }

      gestures {
        workspace_swipe = false
        workspace_swipe_touch = true
      }

      group {
        col.border_active = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.border_inactive = rgba(595959aa)
        drag_into_group = 2
        groupbar {
          font_size = 10
          col.active = rgba(757575ff)
          col.inactive = rgba(323232ff)
        }
      }

      bind = SUPER, A, exec, pidof wofi & pkill wofi || $ua wofi -t=alacritty -S drun -I -n -W 700 -H 700 -w 2
      bind = SUPER, X, exec, $ua alacritty
      bind = SUPER, E, exec, $ua thunar
      bind = SUPER, C, exec, $ua code
      bind = SUPER, B, exec, $ua firefox
      bind = SUPER, R, exec, $ua rnote
      bind = SUPER, S, exec, $ua spotify
      bind = SUPER, Z, exec, $ua alacritty -e bash -c 'bluetuith --adapter-states="scan:yes"'
      bind = SUPER, W, exec, $ua qemu-system-x86_64 -cdrom win10.iso -m 6G -cpu host -smp 4 -drive file=win10.qcow2,format=qcow2 -accel kvm -device virtio-vga-gl -display sdl,gl=on -usb -device usb-host,hostbus=1,hostport=1
      bind = SUPER, T, exec, $ua alacritty -e btop
      bind = SUPER SHIFT, S, exec, bash -c 'cd $HOME/Pictures ; grim -g "$(slurp -d)" - | wl-copy' image.png
      bind = SUPER SHIFT, Q, exec, loginctl terminate-user ""
      bindl = SUPER SHIFT, R, exec, systemctl reboot
      bindl = SUPER CTRL SHIFT, S, exec, systemctl suspend
      bindl = SUPER CTRL SHIFT, Q, exec, systemctl poweroff
      bind = SUPER, L, exec, $ua hyprlock
      bind = SUPER, Q, killactive
      bind = SUPER, V, togglefloating
      bind = SUPER, F, fullscreen
      bind = SUPER, P, pseudo,
      bind = SUPER, J, togglesplit

      bind = SUPER, left, movefocus, l
      bind = SUPER, right, movefocus, r
      bind = SUPER, up, movefocus, u
      bind = SUPER, down, movefocus, d
      bind = SUPER CTRL, left, workspace, -1
      bind = SUPER CTRL, right, workspace, +1
      bind = SUPER SHIFT, left, movetoworkspacesilent, -1
      bind = SUPER SHIFT, right, movetoworkspacesilent, +1
      bind = SUPER CTRL SHIFT, left, movetoworkspace, -1
      bind = SUPER CTRL SHIFT, right, movetoworkspace, +1

      bind = SUPER CTRL, 1, workspace, 1
      bind = SUPER CTRL, 2, workspace, 2
      bind = SUPER CTRL, 3, workspace, 3
      bind = SUPER CTRL, 4, workspace, 4
      bind = SUPER CTRL, 5, workspace, 5
      bind = SUPER CTRL, 6, workspace, 6
      bind = SUPER CTRL, 7, workspace, 7
      bind = SUPER CTRL, 8, workspace, 8
      bind = SUPER CTRL, 9, workspace, 9
      bind = SUPER CTRL, 0, workspace, 10
      bind = SUPER SHIFT, 1, movetoworkspacesilent, 1
      bind = SUPER SHIFT, 2, movetoworkspacesilent, 2
      bind = SUPER SHIFT, 3, movetoworkspacesilent, 3
      bind = SUPER SHIFT, 4, movetoworkspacesilent, 4
      bind = SUPER SHIFT, 5, movetoworkspacesilent, 5
      bind = SUPER SHIFT, 6, movetoworkspacesilent, 6
      bind = SUPER SHIFT, 7, movetoworkspacesilent, 7
      bind = SUPER SHIFT, 8, movetoworkspacesilent, 8
      bind = SUPER SHIFT, 9, movetoworkspacesilent, 9
      bind = SUPER SHIFT, 0, movetoworkspacesilent, 10
      bind = SUPER CTRL SHIFT, 1, movetoworkspace, 1
      bind = SUPER CTRL SHIFT, 2, movetoworkspace, 2
      bind = SUPER CTRL SHIFT, 3, movetoworkspace, 3
      bind = SUPER CTRL SHIFT, 4, movetoworkspace, 4
      bind = SUPER CTRL SHIFT, 5, movetoworkspace, 5
      bind = SUPER CTRL SHIFT, 6, movetoworkspace, 6
      bind = SUPER CTRL SHIFT, 7, movetoworkspace, 7
      bind = SUPER CTRL SHIFT, 8, movetoworkspace, 8
      bind = SUPER CTRL SHIFT, 9, movetoworkspace, 9
      bind = SUPER CTRL SHIFT, 0, movetoworkspace, 10

      bind = SUPER, mouse_down, workspace, m+1
      bind = SUPER, mouse_up, workspace, m-1
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      bindel = ,XF86AudioRaiseVolume, exec, pamixer --unmute --increase 5
      bindel = ,XF86AudioLowerVolume, exec, pamixer --unmute --decrease 5
      bindel = ,XF86AudioMute, exec, pamixer --toggle-mute
      bindel = ,XF86AudioMicMute, exec, pamixer --default-source --toggle-mute
      bindel = ,code:248, exec, pamixer --default-source --toggle-mute
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      layerrule = noanim, hyprpicker
      layerrule = noanim, selection

      windowrulev2 = tile, title:^(QEMU)$

      # Ignore maximize requests from apps. You'll probably like this.
      windowrulev2 = suppressevent maximize, class:.*

      # Fix some dragging issues with XWayland
      windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
    '';
  };
}
