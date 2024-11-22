{ lib, pkgs, ... }: {
  imports = [
    ./systemd-boot.nix
    ./greetd.nix
    ./nix.nix
  ];

  environment.systemPackages = [
    pkgs.home-manager
  ];

  boot.use-systemd = lib.mkDefault true;
  nix.useStandardConfig = lib.mkDefault true;
}
