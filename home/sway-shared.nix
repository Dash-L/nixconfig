{ config, pkgs, lib, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ./eww-config;
  };
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      defaultWorkspace = "workspace number 1";
      keybindings =
        let
          mod = modifier;
        in lib.mkOptionDefault {
          "${mod}+d" = "exec ${lib.getExe pkgs.fuzzel}";
          "${mod}+c" = "exec ${lib.getExe pkgs.grim} -g \"$(${lib.getExe pkgs.slurp})\" - | tee /tmp/$(date +'screenshot-%H:%M:%S.png') | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} -t image/png";
          # Audio controls
          "XF86AudioRaiseVolume" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_SINK@ 1%+";
          "XF86AudioLowerVolume" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_SINK@ 1%-";
          "XF86AudioMute" = "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_SINK@ toggle";
          "XF86AudioPlay" = "exec ${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioPause" = "exec ${lib.getExe pkgs.playerctl} play-pause";
          "XF86AudioNext" = "exec ${lib.getExe pkgs.playerctl} next";
          "XF86AudioPrev" = "exec ${lib.getExe pkgs.playerctl} previous";
          # Brightness controls
          "XF86MonBrightnessDown" = "exec ${lib.getExe pkgs.brightnessctl} set 5%-";
          "XF86MonBrightnessUp" = "exec ${lib.getExe pkgs.brightnessctl} set 5%+";
          # Screen mirroring
          "${mod}+m" = "exec ${lib.getExe' pkgs.wl-mirror "wl-present"} mirror";
        };
      startup = [
        {
          # Wallpaper manager
          command = "${lib.getExe' pkgs.swww "swww-daemon"}";
          always = false;
        }
        {
          command = "${lib.getExe pkgs.networkmanagerapplet}";
          always = false;
        }
      ];
      gaps = {
        outer = 4;
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
          {
            command = "border pixel 1";
            criteria = {
              class = ".*";
            };
          }
        ];
      };
      bars = [];
      input = {
        "type:keyboard" = {
          repeat_delay = "200";
          repeat_rate = "50";
        };
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "-0.5";
        };
      };
    };
  };
}
