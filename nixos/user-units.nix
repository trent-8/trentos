{ config, lib, pkgs, ... }:
{
  systemd.user.services.hlrandbg = {
    enable = true;
    requires = [ "hyprpaper.service" ];
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = let
        python = pkgs.python3.withPackages (ps: with ps; [ requests ]);
      in
        "${python.interpreter} ${./executables/hlrandbg} ${./wallpapers} -r";
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
  systemd.user.services.orientation-manager = {
    enable = true;
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart =  let
        python = pkgs.python3.withPackages (ps: with ps; [ requests ]);
      in
        "${python.interpreter} ${./executables/orientation-manager}";
      Restart = "always";
      RestartSec = 10;
    };
    unitConfig = {
      After = "graphical-session-pre.target";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      Description = "Screen Orientation Manager";
      PartOf = "graphical-session.target";
    };
  };
}