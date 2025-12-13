{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "Dashiell Elliott";
      user.email = "dashiell.elliott@yahoo.com";
      init.defaultBranch = "main";
    };
  };
  programs.gh = {
    enable = true;
  };
}
