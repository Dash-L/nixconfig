{ config, pkgs, ... }:

{
  home.packages = [ pkgs.rnote pkgs.dconf ];
}
