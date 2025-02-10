{
  systemd.user.services.hlrandbg = {
    enable = true;
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "/usr/bin/hlrandbg /home/trent/wallpapers -r";
      Restart = "always";
      RestartSec = 10;
    };
    unitConfig = {
      After = "graphical-session-pre.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "Wallpaper Randomizer";
      PartOf = "graphical-session.target";
    };
  };
  ### uncomment for laptops with accelerometers
  # systemd.user.services.orientation-manager = {
  #   enable = true;
  #   wantedBy = ["graphical-session.target"];
  #   serviceConfig = {
  #     ExecStart = "/usr/bin/orientation-manager";
  #     Restart = "always";
  #     RestartSec = 10;
  #   };
  #   unitConfig = {
  #     After = "graphical-session-pre.target";
  #     ConditionEnvironment = "WAYLAND_DISPLAY";
  #     Description = "Screen Orientation Manager";
  #     PartOf = "graphical-session.target";
  #   };
  # };
}