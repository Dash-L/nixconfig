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
    # ./libcamera.nix
  ];

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
