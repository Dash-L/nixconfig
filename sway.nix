{ config, pkgs, lib, ... }:

{
  wayland.windowManager.sway =
  let
    left = "DP-4";
    middle = "DP-5";
    right = "eDP-1";
  in
    {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      defaultWorkspace = "workspace number 1";
      keybindings = let 
                      mod = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${mod}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";
        "${mod}+c" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | tee /tmp/$(date +'screenshot-%H:%M:%S.png') | ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
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
        # Screen mirroring
        "${mod}+m" = "exec ${pkgs.wl-mirror}/bin/wl-present mirror";
      };
      startup = [
        {
          command = "${pkgs.swww}/bin/swww-daemon";
          always = false;
        }
      ];
      gaps = {
        outer = 5;
        inner = 2;
      };
      window = {
        commands = [
          {
            command = "floating enable";
            criteria = {
              title = "Wayfarer";
            };
          }
        ];
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
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "50";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
        };
        "1118:3127:IPTS_Stylus" = {
          map_to_output = "${right}";
        };
        "1118:3127:IPTS_Touch" = {
          map_to_output = "${right}";
        };
        # "1118:3127:Intel_Touch_Host_Controller_Touchscreen" = {
        #   events = "disabled";
        # };
        # "1118:3127:IPTS_Touch" = {
        #   events = "disabled";
        # };
      };
      # output = {
      #   "${right}" = {
      #     pos = "1920 0";
      #   };
      #   "${left}" = {
      #     pos = "-1600 0";
      #   };
      #   "${middle}" = {
      #     pos = "0 0";
      #   };
      # };
      # workspaceOutputAssign = [
      #   { output = left; workspace = "1"; }
      #   { output = left; workspace = "2"; }
      #   { output = left; workspace = "3"; }
      #   { output = middle; workspace = "4"; }
      #   { output = middle; workspace = "5"; }
      #   { output = middle; workspace = "6"; }
      #   { output = middle; workspace = "7"; }
      #   { output = right; workspace = "8"; }
      #   { output = right; workspace = "9"; }
      #   { output = right; workspace = "10"; }
      # ];
    };
  };
}
