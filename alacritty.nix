{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "iosevka";
      };
    };
  };
}
