{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Dashiell Elliott";
    userEmail = "dashiell.elliott@yahoo.com";
    extraConfig.init.defaultBranch = "main";
  };
  programs.gh = {
    enable = true;
  };
}
