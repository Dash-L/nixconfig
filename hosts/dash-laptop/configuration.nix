# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hide ipu6 camera devices (must be removed once camera support is stable)
  boot.blacklistedKernelModules = [
  "ipu6"
  "ipu6-isys"
  "ipu6-psys"
  "intel-ipu6"
  "intel-ipu6ep"
];

  networking.hostName = "dash-laptop"; # Define your hostname.

  # This device's wireguard config
  networking.wg-quick.interfaces = {
    serverworks = {
      privateKeyFile = "/etc/wireguard/priv-key";
      address = [ "10.0.9.5" ];
      dns = [ "10.0.9.1" ];

      peers = [ {
        publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
        endpoint = "47.14.120.103:14438";
        persistentKeepalive = 25;
        allowedIPs = [ "10.0.9.0/24" ];
      } ];
    };
  };


  # Microsoft Surface specific configs

  hardware.microsoft-surface.kernelVersion = "stable";

  services.thermald.enable = true;
  services.thermald.configFile = ./thermal-conf.xml;
  # services.auto-cpufreq = {
  #   enable = true;
  #   settings = {
  #     battery = {
  #        governor = "powersave";
  #        turbo = "never";
  #     };
  #     charger = {
  #        governor = "powersave";
  #        energy_performance_preference = "balance_performance";
  #        turbo = "auto";
  #     };
  #   };
  # };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  # Configure Intel Precise Touch
  services.iptsd = {
    enable = true; # not technically necessary, enabled by surface hardware config
    config = {
      Touchscreen = {
        # Disable = true;
        DisableOnPalm = true;
        # DisableOnStylus = true;
      };
    };
  };

  services.logind.settings.Login = {
    HandlePowerKey="ignore";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
