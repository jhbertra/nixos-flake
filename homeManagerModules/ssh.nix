{ config, lib, pkgs, ... }:
let
  cfg = config.modules.ssh;
in
{
  options = {
    modules.ssh = {
      enable = lib.mkEnableOption "Enables ssh support";
      githubIdentityFile = lib.mkOption {
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      compression = true;
      extraOptionOverrides = {
        IdentitiesOnly = "yes";
      };
      matchBlocks = {
        "github.com" = {
          host = "github.com";
          user = "git";
          identityFile = cfg.githubIdentityFile;
        };
      };
    };
  };
}
