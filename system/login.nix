{ lib, config, pkgs, ... }:
{
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "niri";
        comment = "Niri (UWSM)";
        binPath = "${lib.getExe config.programs.niri.package}";
        extraArgs = [ "--session" ];
      };
    };
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe config.programs.uwsm.package} start niri-uwsm.desktop";
        user = "dash";
      };
    };
  };
}
