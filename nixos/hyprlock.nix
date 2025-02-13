{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        enable_fingerprint = true;
      };
      input-field = {
        monitor = "";
        fade_on_empty = false;
        fail_color = "rgb(255, 143, 46, 1.0)";
        font_color = "rgba(200, 200, 200, 1.0)";
        font_family = "Roboto";
        inner_color = "rgba(20, 20, 20, 1.0)";
        outer_color = "rgba(100, 100, 100, 1.0)";
        rounding = 12;
        size = "300, 70";
        placeholder_text = "<i>Enter Password</i>";
      };
      background = {
        color = "rgb(33, 33, 33)";
      };
    };
  };
}