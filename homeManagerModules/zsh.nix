{ config, lib, ... }:
let
  cfg = config.modules.zsh;
in
{
  options = {
    modules.zsh = {
      enable = lib.mkEnableOption "Enables zsh support";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "command-not-found"
          "fzf"
          "git"
          "history"
          "ripgrep"
        ];
      };
      initExtra =
        ''
          export GPG_TTY="$(tty)"
        '';
    };
  };
}
