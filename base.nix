{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "jamie" ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "8.8.8.8"
    "8.8.4.4"
  ];

  # Select internationalisation properties.
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

  environment.systemPackages = with pkgs; [
    docker-client
    bind
    busybox
    magic-wormhole
    openssl
    jq
    yq
    json2yaml
    yaml2json
    gnupg
    curl
    htop
    lm_sensors
    xorg.xhost
    xterm
    gparted
    less
    unzip
    wget
    gitAndTools.gitFull
    ntfs3g
    sox
  ];

  programs.bash = {
    enableCompletion = true;
  };

  programs.ssh.extraConfig = ''
    Host eu.nixbuild.net
      PubkeyAcceptedKeyTypes ssh-ed25519
      IdentityFile /root/.ssh/id-nixbuild
  '';

  programs.ssh.knownHosts = {
    nixbuild = {
      hostNames = [ "eu.nixbuild.net" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
    };
  };

  users.defaultUserShell = pkgs.bash;
  users.mutableUsers = false;
  users.users.root = {
    # hashedPassword = secrets.users.jamie.hashedPassword;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes fetch-closure
    builders-use-substitutes = true
  '';

  nixpkgs.config.allowUnfree = true;
  security.sudo.wheelNeedsPassword = false;

  nix.buildMachines = [
    {
      hostName = "build01.tweag.io";
      maxJobs = 24;
      sshUser = "nix";
      sshKey = "/root/.ssh/id-tweag-builder";
      system = "x86_64-linux";
      supportedFeatures = [ "benchmark" "big-parallel" "kvm" ];
    }
    {
      hostName = "build02.tweag.io";
      maxJobs = 24;
      sshUser = "nix";
      sshKey = "/root/.ssh/id-tweag-builder";
      systems = [ "aarch64-darwin" "x86_64-darwin" ];
      supportedFeatures = [ "big-parallel" ];
    }
    {
      hostName = "eu.nixbuild.net";
      system = "x86_64-linux";
      maxJobs = 100;
      sshKey = "/root/.ssh/id-nixbuild";
      supportedFeatures = [ "benchmark" "big-parallel" ];
    }
  ];

  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };
}
