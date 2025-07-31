{ lib, pkgs, ... }:
let
  left = "HDMI-A-1";
  right = "DP-1";
in
{
  imports = [
    ./sway-shared.nix
  ];
  
  wayland.windowManager.sway.config = {
    startup = [
      {
        command = "${lib.getExe pkgs.eww} open laptop-bar";
        always = false;
      }
    ];
    output = {
      "${right}" = {
        pos = "1920 0";
      };
      "${left}" = {
        pos = "0 0";
      };
    };
    workspaceOutputAssign = [
      { output = left; workspace = "1"; }
      { output = left; workspace = "2"; }
      { output = left; workspace = "3"; }
      { output = left; workspace = "4"; }
      { output = left; workspace = "5"; }
      { output = right; workspace = "6"; }
      { output = right; workspace = "7"; }
      { output = right; workspace = "8"; }
      { output = right; workspace = "9"; }
      { output = right; workspace = "10"; }
    ];
  };
}
