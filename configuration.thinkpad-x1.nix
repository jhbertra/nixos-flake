{ config, pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.thinkpad-x1.nix
      ./base.nix
      ./jamie/profile.nix
      ./audio.nix
    ];

  nixpkgs.system = "x86_64-linux";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.emergencyAccess = true;

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "jamie";
  };

  services.xserver.dpi = 192;
  environment.variables = {
    EDITOR = "nvim";
    FZF_BASE = "${pkgs.fzf}/share/fzf";
    GDK_SCALE = "1.33";
    TERMINAL = "st";
    XCURSOR_SIZE = "32";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    ZSH_CUSTOM = "$HOME/.config/oh-my-zsh";
  };

  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.extraHosts =
    ''
      10.0.0.1 gateway

      # Range 10.0.0.[2..31] Devices that run desktop OSes
      10.0.0.2 thinkpad-x1
      10.0.0.3 dell
      10.0.0.4 raspberrypi

      # Range 10.0.0.[32..63] Mobile devices / e-readers / tablets
      10.0.0.32 pixel-3
      10.0.0.33 pixel-8
      10.0.0.34 kinkle

      # Range 10.0.0.[64..95] Gaming consoles
      10.0.0.64 switch
      10.0.0.65 ps3

      # Range 10.0.0.[96..127] Embedded / smart devices
      10.0.0.96 cookie
      10.0.0.97 envy
    '';
}
