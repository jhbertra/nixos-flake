{ config, lib, pkgs, ... }:
let
  cfg = config.modules.git;
in
{
  options = {
    modules.git = {
      enable = lib.mkEnableOption "Enables git support";
      userEmail = lib.mkOption {
        type = lib.types.str;
      };
      userName = lib.mkOption {
        type = lib.types.str;
      };
      githubUser = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      aliases = {
        br = "branch";
        ch = "checkout";
        co = "commit";
        hist = "log --oneline --graph --decorate --all";
        pf = "push --force-with-lease";
        s = "status";
      };
      difftastic.enable = true;
      lfs.enable = true;
      userEmail = cfg.userEmail;
      userName = cfg.userName;
      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        github.user = cfg.githubUser;
        init.defaultBranch = "main";
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
        mergetool = {
          keepBackup = false;
          prompt = false;
          "vimdiff" = {
            cmd = "nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'";
          };
        };
        pull.rebase = true;
        fetch.prune = true;
        diff.colorMoved = "zebra";
      };
    };
  };
}
