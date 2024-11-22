{ lib, config, ... }: {
  options = {
    boot.use-systemd = lib.mkEnableOption
      "Enables booting with the systemd-boot EFI boot loader";
  };

  config = lib.mkIf config.boot.use-systemd {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.systemd.enable = true;
    boot.initrd.systemd.emergencyAccess = true;
  };
}
