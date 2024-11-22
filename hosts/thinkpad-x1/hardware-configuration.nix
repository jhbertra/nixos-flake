{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [ "intel_pstate=active" "i915.force_probe=9a49" ];
  boot.kernelModules = [
    "v4l2loopback"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback.out
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1
  '';

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/b996e245-e550-404c-ac04-873c201a5189";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/a3b9703c-210a-48de-885d-81ab8be10405";

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/1ED3-39F3";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/aaae3d9d-21c5-4e27-8940-6b433cd6a242"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    vaapiVdpau
    libvdpau-va-gl
    intel-media-sdk
  ];
}
