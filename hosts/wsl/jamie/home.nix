{ ... }:

{
  imports = [
    ../../../homeManagerModules
  ];
  home = {
    username = "jamie";
    homeDirectory = "/home/jamie";
    stateVersion = "24.05";

    packages = [
    ];

    file = { };
  };

  modules = {
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "james.bertram@rossvideo.com";
      userName = "James Bertram";
      githubUser = "jhbertra";
    };
    ssh = {
      enable = true;
      githubIdentityFile = "~/.ssh/id_ed25519";
    };
    starship.enable = true;
    neovim.enable = true;
  };
  programs = {
    bat.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    fzf.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    jq.enable = true;
    less.enable = true;
    man.enable = true;
    nh.enable = true;
    nh.flake = "/home/jamie/nixos-flake";
    nix-index.enable = true;
    zsh.enable = true;
    ripgrep.enable = true;
    git.signing.gpgPath = "/mnt/c/Program Files (x86)/gnupg/bin/gpg.exe";
  };
}
