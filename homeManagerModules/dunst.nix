{ config, lib, pkgs, ... }:
let
  cfg = config.modules.dunst;
in
{
  options = {
    modules.dunst = {
      enable = lib.mkEnableOption "Enables dunst support";
    };
  };

  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        size = "32x32";
      };
      settings = {
        global = {
          # Display
          follow = "keyboard";
          geometry = "500x6-10+30";
          indicate_hidden = "yes";
          padding = 16;
          horizontal_padding = 16;
          frame_width = 2;
          separator_color = "frame";
          sort = "yes";
          idle_threshold = 360;
          # Text
          font = "Fira Mono Regular 10";
          markup = "full";
          format = "<b>%s</b>\\n%b";
          alignment = "left";
          vertical_alignment = "center";
          word_wrap = "yes";
          ignore_newline = "no";
          stack_duplicates = true;
          # Icons
          icon_position = "left";
          max_icon_size = 32;
          # Misc/Advanced
          browser = "firefox";
          startup_notification = true;
          corner_radius = 8;
        };
      };
    };
  };
}
