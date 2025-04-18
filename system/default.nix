{ ... }:
{
  imports = [
    ./locale.nix
    ./login.nix
    ./networking.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./users.nix
  ];

  catppuccin = {
    flavor = "macchiato";
    accent = "rosewater";
    enable = true;
  };
}
