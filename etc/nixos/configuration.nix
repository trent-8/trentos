# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  imports = [
      ./hardware-configuration.nix
      ./user-units.nix
      <home-manager/nixos>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "minipc";
  networking.networkmanager.enable = true;

  time.timeZone = "US/Central";

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;

  
  system.userActivationScripts = {
    zshSetup = {
      text = ''
      touch .zshrc
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      '';
      deps = [];
    };
  };

  users.users.trent = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
  users.defaultUserShell = pkgs.zsh;

  home-manager.backupFileExtension = "bak";
  home-manager.users.trent = {
    imports = [ ./hypridle.nix ./hyprland.nix ./theme.nix ./waybar.nix ];
    programs.git = {
      enable = true;
      userName  = "trent-8";
      userEmail = "trenthek@gmail.com";
    };
    programs.alacritty.settings = {
      window.padding = { x = 7; y = 7; };
    };
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [ "/home/trent/Pictures/Backgrounds/Hawaii-Sunset.jpg" ];
        wallpaper = [ ", /home/trent/Pictures/Backgrounds/Hawaii-Sunset.jpg" ];
      };
    };
    home.stateVersion = "24.11";
  };
  nixpkgs.config.allowUnfree = true;
  programs.zsh = {
    enable = true;
    histSize = 1000;
    shellAliases = {
      ls = "ls --color=auto";
      update = "sudo nixos-rebuild switch";
      startwl = "uwsm start -S hyprland-systemd.desktop";
    };
    shellInit = ''
      bindkey '^[[H' beginning-of-line # home
      bindkey '^[[F' end-of-line # end
      bindkey "^[[2~" overwrite-mode # insert
      bindkey '^?' backward-delete-char # backspace
      bindkey '^H' backward-delete-word # ctrl+backspace
      bindkey '^[[3~' delete-char # delete
      bindkey '^[[3;5~' delete-word # ctrl+delete
      bindkey '^[[1;5A' history-search-backward # up
      bindkey '^[[1;5B' history-search-forward # down
      bindkey '^[[D' backward-char
      bindkey '^[[C' forward-char
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[5~' beginning-of-buffer-or-history
      bindkey '^[[6~' end-of-buffer-or-history
      bindkey '^[[Z' reverse-menu-complete # shift+tab
      bindkey '^[w' kill-region
    '';
    setOptions = [
      "appendhistory"
      "sharehistory"
      "hist_ignore_space"
      "hist_save_no_dups"
      "hist_ignore_dups"
      "hist_find_no_dups"
      "autocd"
      "prompt_subst"
    ];
    promptInit = "PROMPT='%F{white}%n@%m%F{#888888}: %F{green}%~ %F{yellow}%(#.#.$) '";
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
  };
  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/home/trent/.nix-profile/bin/Hyprland";
    };
  };
  
  environment = {
    systemPackages = with pkgs; [ 
      alacritty
      bluetuith
      brightnessctl
      btop
      bzip2
      discord
      fzf
      grim
      gvfs
      gzip
      hyprpolkitagent
      kdePackages.breeze
      mate.mate-calc
      nano
      nanorc
      neofetch
      networkmanagerapplet
      ntfs3g
      ntp
      papirus-icon-theme
      p7zip
      pamixer
      playerctl
      python312Packages.matplotlib
      python312Packages.numpy
      python314
      pwvucontrol
      rclone
      rnote
      signal-desktop
      slurp
      speechd
      spotify
      thunderbird
      unzip
      usbutils
      vscode
      wget
      wofi
      xfce.thunar
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      zip
      zoxide
    ];
  };
  fonts.packages = with pkgs; [
    font-awesome
    liberation_ttf
    nerdfonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-monochrome-emoji
    roboto
    source-code-pro
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  services.openssh.enable = true;
  services.power-profiles-daemon.enable = true;
  # services.libinput.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?

}

