{
  description = "My NixOS + Homemanager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-sidebar-css = {
      url = "github:drannex/FirefoxSidebar";
      flake = false;
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, zen-browser, catppuccin, firefox-sidebar-css, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

      baseConfig = extraModules: extraHMModules: nixpkgs.lib.nixosSystem {
        inherit pkgs;

        modules = [
          ./system
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dash = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ] ++ extraHMModules;
            };
            home-manager.extraSpecialArgs = { zen-browser=zen-browser.packages.${system}.default; inherit firefox-sidebar-css; };
          }
        ] ++ extraModules;
      };
    in {
      nixosConfigurations.dash-laptop = baseConfig [ ./hosts/dash-laptop/configuration.nix nixos-hardware.nixosModules.microsoft-surface-pro-intel ] [ ./home/sway-laptop.nix ];
      nixosConfigurations.dash-desktop = baseConfig [ ./hosts/dash-desktop/configuration.nix ] [ ./home/sway-desktop.nix ];
    };
}
