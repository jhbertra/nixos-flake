{ config, lib, pkgs, ... }:
let
  cfg = config.modules.starship;
in
{
  options = {
    modules.starship = {
      enable = lib.mkEnableOption "Enables starship support";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        git_commit = {
          tag_disabled = false;
          only_detached = false;
        };
        git_metrics = {
          disabled = false;
        };
        memory_usage = {
          disabled = false;
          format = "via $symbol[\${ram_pct}]($style) ";
          threshold = -1;
        };
        shlvl = {
          disabled = false;
          symbol = "↕";
          threshold = -1;
        };
        status = {
          disabled = false;
          map_symbol = true;
          pipestatus = true;
        };
        time = {
          disabled = false;
          format = "[\\[ $time \\]]($style) ";
        };
      };
    };
  };
}
