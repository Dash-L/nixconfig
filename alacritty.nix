{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "iosevka";
        };
        size = 15;
      };
      window = {
        opacity = 0.8;
      };
    };
  };
}
