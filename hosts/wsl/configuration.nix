{ pkgs, inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nixos-wsl.nixosModules.wsl
  ];

  nix.settings.trusted-users = ["root" "wheel"];

  nixpkgs.system = "x86_64-linux";

  i18n.defaultLocale = "en_US.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  boot.use-systemd = false;

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.devmon.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "jamie";
  # wsl.wslConf.network.generateResolvConf = false;

  # networking.nameservers = [
  #   "10.0.0.69"
  #   "10.0.0.70"
  # ];

  networking.domain = "rossvideo.com";

  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = true;
  users.users = {
    jamie = {
      description = "Jamie Bertram";
      isNormalUser = true;
      group = "nogroup";
      extraGroups = [
        "wheel"
      ];
      initialPassword = "change me";
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
        eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
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
  system.stateVersion = "24.05"; # Did you read the comment?

  security.sudo.wheelNeedsPassword = false;
  environment.pathsToLink = [ "/share/zsh" ];

  systemd.services = {
    wsl-vpnkit = {
      enable = true;
      description = "wsl-vpnkit";

      serviceConfig = {
        ExecStart = "${pkgs.wsl-vpnkit}/bin/wsl-vpnkit";
        Type = "idle";
        Restart = "always";
        KillMode = "mixed";
      };
    };
  };
}
