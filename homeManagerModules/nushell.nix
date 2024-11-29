{ config, lib, ... }:
let
  cfg = config.modules.nushell;
in
{
  options = {
    modules.nushell = {
      enable = lib.mkEnableOption "Enables nushell support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;
    };
  };
}
