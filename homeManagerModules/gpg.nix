{ config, lib, pkgs, ... }:
let
  cfg = config.modules.gpg;
in
{
  options = {
    modules.gpg.enable = lib.mkEnableOption "Enables GPG support";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      git.signing.signByDefault = true;
      git.signing.key = null;
      gpg.enable = true;
    };
    services = {
      gpg-agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
      };
    };
  };
}
