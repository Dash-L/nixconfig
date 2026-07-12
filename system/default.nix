{ pkgs, ... }:
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

  # lix
  nix.package = pkgs.lixPackageSets.stable.lix;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # cache
  nix.settings = {    
    extra-substituters = [
         "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
