{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        # font = "Iosevka:size=10";
        font = "SpaceMono:size=8";
      };
      colors = {
        alpha = 0.9;
      };
    };
  };
}
