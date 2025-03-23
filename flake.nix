{
  description = "My NixOS + Homemanager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, zen-browser, ... }:
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
          ./hosts/dash-laptop/configuration.nix
          ./system
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dash = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit zen-browser system; };
          }
        ];
      };
    };
}
