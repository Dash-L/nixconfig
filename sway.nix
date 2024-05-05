{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";
      keybindings = let 
                      mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";
        "${mod}+c" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" /tmp/$(date +'screenshot-%H:%M:%S.png')";
        # Audio controls
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 1%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_SINK@ 1%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        # Brightness controls
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
      };
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
      output = {
        eDP-1 = {
          pos = "1920 0";
        };
        DP-6 = {
          pos = "-1600 0";
        };
        DP-7 = {
          pos = "0 0";
        };
      };
      workspaceOutputAssign = [
        { output = "DP-7"; workspace = "1"; }
        { output = "DP-7"; workspace = "2"; }
        { output = "DP-7"; workspace = "3"; }
        { output = "DP-7"; workspace = "4"; }
        { output = "eDP-1"; workspace = "5"; }
        { output = "eDP-1"; workspace = "6"; }
        { output = "eDP-1"; workspace = "7"; }
        { output = "DP-6"; workspace = "8"; }
        { output = "DP-6"; workspace = "9"; }
        { output = "DP-6"; workspace = "10"; }
      ];
    };
  };
}
