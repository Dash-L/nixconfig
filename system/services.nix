{ pkgs, ... }:
{
  services = {
    printing.enable = true;

    upower.enable = true;

    # Pipewire support
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig = {
        "bluez" = {
      		"monitor.bluez.properties" = {
      			"bluez5.enable-sbc-xq" = true;
      			"bluez5.enable-msbc" = true;
      			"bluez5.enable-hw-volume" = true;
      			"bluez5.roles" =  [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      		};
        };
      };
    };

    # platformio uploading
    udev.packages = with pkgs; [ platformio-core.udev ];

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  hardware = {
    graphics.enable = true;

    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # docker
  virtualisation.docker.enable = true;

  # for screensharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = ["wlr" "gtk"];
    };
  };
}
