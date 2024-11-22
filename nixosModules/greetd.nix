{ lib, config, ... }: {
  options = {
    services.greetd.enableStandard = lib.mkEnableOption
      "Enables greetd with standard options";
  };

  config = lib.mkIf config.services.greetd.enableStandard {
    services.greetd = {
      enable = true;
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
  };
}
