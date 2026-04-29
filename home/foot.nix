{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # font = "Iosevka:size=10";
        font = "SpaceMono:size=8";
      };
      colors-dark = {
        alpha = 0.9;
      };
    };
  };
}
