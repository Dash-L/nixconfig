{ config, pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    settings = { PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.local/share/password-store"; };
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };
}
