{ config, lib, ... }:
let
  cfg = config.modules.helix;
in
{
  options = {
    modules.helix = {
      enable = lib.mkEnableOption "Enables helix support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "gruvbox_dark";
      };
    };
  };
}
