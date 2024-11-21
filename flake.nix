{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  languages.nix.enable = true;
                  git-hooks.hooks = {
                    detect-private-keys.enable = true;
                    flake-checker.enable = true;
                    nil.enable = true;
                    treefmt = {
                      enable = true;
                      settings.formatters = [
                        pkgs.nixpkgs-fmt
                        pkgs.nodePackages.prettier
                      ];
                    };
                    typos.enable = true;
                  };
                  packages = [ pkgs.nixpkgs-fmt ];

                  enterShell = ''
                  '';
                }
              ];
            };
          });
      nixosConfigurations.thinkpad-x1 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.thinkpad-x1.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
