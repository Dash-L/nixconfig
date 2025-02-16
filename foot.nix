{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka:size=10";
      };
      colors = {
        alpha = 0.9;
      };
    };
  };
}
