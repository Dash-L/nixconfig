{ lib, pkgs, ... }:
{
  imports = [
    ./sway-shared.nix
  ];

  programs.quickshell.activeConfig = "laptop";

  wayland.windowManager.sway.config = {
    startup = [
      {
        command = "${lib.getExe pkgs.eww} open laptop-bar";
        always = false;
      }
    ];

    input = {
      "1118:2479:Microsoft_Surface_045E:09AF_Touchpad" = {
        click_method = "clickfinger";
        drag = "enabled";
        natural_scroll = "enabled";
        middle_emulation = "enabled";
        tap = "enabled";
        tap_button_map = "lrm";
        scroll_factor = "0.5";
      };
      "1118:3127:IPTS_Stylus" = {
        map_to_output = "eDP-1";
      };
      "1118:3127:IPTS_Touch" = {
        map_to_output = "eDP-1";
      };
      "1386:884:Wacom_Intuos_S_Pen" = {
        map_to_output = "eDP-1";
        # 2880x1920
        # 152x95mm
        map_from_region = "0.0x0.0 0.65x0.6933";
      };
    };
  };
}
