{
  description = "My NixOS + Homemanager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, zen-browser, lix-module, catppuccin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in {
      nixosConfigurations.dash-laptop = nixpkgs.lib.nixosSystem {
        inherit pkgs;

        modules = [
          catppuccin.nixosModules.catppuccin
          ./hosts/dash-laptop/configuration.nix
          ./system
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          lix-module.nixosModules.default
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dash = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = { zen-browser=zen-browser.packages.${system}.default; };
          }
        ];
      };
    };
}
