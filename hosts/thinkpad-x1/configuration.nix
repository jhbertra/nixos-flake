{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
  ];

  virtualisation.vmVariant.virtualisation.sharedDirectories = {
    sops-keys = {
      source = "/nix/persist/var/lib/sops-nix";
      target = "/nix/persist/var/lib/sops-nix";
    };
  };

  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/nix/persist/var/lib/sops-nix/keys.txt";
  sops.secrets."root/hashedPassword" = {
    neededForUsers = true;
  };
  sops.secrets."jamie/hashedPassword" = {
    neededForUsers = true;
  };

  nixpkgs.system = "x86_64-linux";

  networking.hostName = "thinkpad-x1";
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
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.devmon.enable = true;


  users.defaultUserShell = pkgs.bash;
  users.mutableUsers = false;
  users.users = {
    root = {
      hashedPasswordFile = config.sops.secrets."root/hashedPassword".path;
    };

    jamie = {
      description = "Jamie Bertram";
      uid = 1111;
      isNormalUser = true;
      group = "nogroup";
      extraGroups = [
        "libvirtd"
        "wheel"
        "sound"
        "pulse"
        "audio"
        "lp"
        "networkmanager"
        "podman"
        "docker"
      ];
      hashedPasswordFile = config.sops.secrets."jamie/hashedPassword".path;
      home = "/home/jamie";
      createHome = true;
      shell = pkgs.zsh;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableBashCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "command-not-found"
        "fzf"
        "git"
        "history"
      ];
    };
    interactiveShellInit =
      ''
        export GPG_TTY="$(tty)"
      '';
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      jamie = import ./jamie/home.nix;
    };
  };
  home-manager.useUserPackages = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  security.sudo.wheelNeedsPassword = false;
  security.pam.services.hyprlock = { };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };
  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.hyprland.enable = true;
  services.udev.extraRules = builtins.readFile ../../hardware/onlykey.udev;
}
