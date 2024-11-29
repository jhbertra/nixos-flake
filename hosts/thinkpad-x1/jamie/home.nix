{ config, pkgs, ... }:

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
    dunst.enable = true;
    gpg.enable = true;
    git = {
      enable = true;
      userEmail = "jhbertra@gmail.com";
      userName = "Jamie Bertram";
      githubUser = "jhbertra";
    };
    ssh = {
      enable = true;
      githubIdentityFile = "~/.ssh/id_ed25519";
    };
    starship.enable = true;
    nushell.enable = true;
    helix.enable = true;
    neovim.enable = true;
  };
  programs = {
    bat.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    direnv.enableNushellIntegration = true;
    firefox.enable = true;
    fzf.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    hyprlock.enable = true;
    jq.enable = true;
    kitty = {
      enable = true;
      font.package = pkgs.nerdfonts;
      font.name = "Hasklig";
      themeFile = "gruvbox-dark";
    };
    less.enable = true;
    man.enable = true;
    nh.enable = true;
    nh.flake = "/home/jamie/personal/nixos";
    nix-index.enable = true;
    password-store.enable = true;
  };
}
