{ config, pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
    profiles.main = {
      isDefault = true;
    };
  };
}
