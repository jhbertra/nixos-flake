{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    open-sans
    font-awesome
    fira-code
    powerline-fonts
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    pavucontrol
    arandr
    brightnessctl
    libnotify
    lxqt.lxqt-notificationd
    # scrot
    # xclip
    kitty
    polkit
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    rofi-wayland
    grim
    slurp
    wl-clipboard
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.udisks2.enable = true;
  services.upower.enable = true;
  services.devmon.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYHangup = true;
    TTYVTDisallocate = true;
  };
  # services.xserver.enable = true;
  # services.xserver.displayManager.defaultSession = "none+hyprland";
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.libinput.enable = true;
  # services.xserver.windowManager.i3 = {
  #   enable = true;
  #   package = pkgs.i3-gaps;
  #   extraPackages = with pkgs; [
  #     dmenu
  #     feh
  #     polybarFull
  #     rofi
  #     betterlockscreen
  #   ];
  # };
  # services.xserver.videoDrivers = [ "modesetting" ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
