{ lib, ... }: {
  imports = [
    ./systemd-boot.nix
    ./greetd.nix
    ./nix.nix
  ];

  boot.use-systemd = lib.mkDefault true;
  nix.useStandardConfig = lib.mkDefault true;
}
