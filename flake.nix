{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    vim-textobj-entire.url = "github:kana/vim-textobj-entire";
    vim-textobj-entire.flake = false;
    vim-textobj-line.url = "github:kana/vim-textobj-line";
    vim-textobj-line.flake = false;
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
                  packages = [ pkgs.nixpkgs-fmt pkgs.sops ];

                  enterShell = ''
                  '';
                }
              ];
            };
          });
      nixosConfigurations.thinkpad-x1 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thinkpad-x1/configuration.nix
          ./nixosModules
        ];
      };
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wsl/configuration.nix
          ./nixosModules
        ];
      };
    };
}
