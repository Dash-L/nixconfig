{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
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
        # "1118:3127:Intel_Touch_Host_Controller_Touchscreen" = {
        #   events = "disabled";
        # };
        # "1118:3127:IPTS_Touch" = {
        #   events = "disabled";
        # };
      };
    };
  };
}
