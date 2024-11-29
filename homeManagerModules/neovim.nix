{ config, lib, ... }:
let
  cfg = config.modules.neovim;
in
{
  options = {
    modules.neovim = {
      enable = lib.mkEnableOption "Enables neovim support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      coc = {
        enable = true;
        pluginConfig = ''
        '';
        settings = { };
      };
      defaultEditor = true;
      extraConfig = ''
      '';
      extraPackages = [
      ];
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
