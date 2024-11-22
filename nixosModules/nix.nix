{ lib, config, pkgs, ... }: {
  options = {
    nix.useStandardConfig = lib.mkEnableOption "Sets standard nix config.";
  };

  config = lib.mkIf config.nix.useStandardConfig {
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

    nix.settings.trusted-users = [ "root" "jamie" ];
    nix.settings.substituters = [
      "https://cache.iog.io"
    ];
    nix.settings.trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];

    nixpkgs.config.allowUnfree = true;
  };
}
