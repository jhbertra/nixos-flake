{ config, pkgs, ... }:

{
  imports = [
    ../../../homeManagerModules
  ];
  home = {
    username = "jamie";
    homeDirectory = "/home/jamie";
    stateVersion = "24.05";

    packages = with pkgs; [
      curl
      jq
      json2yaml
      magic-wormhole
      openssl
      socat
      unipicker
      unzip
      websocat
      wget
      yaml2json
      yq
      zip
      onlykey
      onlykey-cli
      onlykey-agent
      wl-clipboard-rs
    ];

    file = {
      ".ssh/github.pub".text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFF/i8+DXuIwV4iYal0SmhOCDwv9ei8ecdVmdUs9Wvtd <ssh://git@github.com|ed25519>";
    };
    shellAliases = {
      ssh-shell = "onlykey-agent ~/.ssh/github.pub -v --shell";
    };
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
      githubIdentityFile = "~/.ssh/github.pub";
    };
    starship.enable = true;
    nushell.enable = false;
    helix.enable = true;
    neovim.enable = true;
  };
  programs = {
    bat.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    direnv.enableZshIntegration = true;
    firefox.enable = true;
    fzf.enable = true;
    fzf.enableZshIntegration = true;
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
    nix-index.enableZshIntegration = true;
    password-store.enable = true;
    starship.enableZshIntegration = true;
    zathura.enable = true;
    taskwarrior.enable = true;
    watson.enable = true;
    watson.enableZshIntegration = true;
    zsh.enable = true;
  };
}
