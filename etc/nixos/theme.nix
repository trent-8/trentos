{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.kdePackages.breeze;
    name = "Breeze_Light";
    size = 24;
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.emacsPackages.adwaita-dark-theme;
      name = "emacs-adwaita-dark-theme";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "Roboto";
      size = 11;
    };
  };
}