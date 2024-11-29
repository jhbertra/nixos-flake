{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./gpg.nix
    ./ssh.nix
    ./dunst.nix
    ./starship.nix
    ./nushell.nix
    ./helix.nix
    ./neovim.nix
    ./zsh.nix
  ];
}
