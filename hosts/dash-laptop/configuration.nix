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

  # This device's wireguard config
  networking.wg-quick.interfaces = {
    serverworks = {
      privateKeyFile = "/etc/wireguard/priv-key";
      address = [ "10.0.0.5" ];
      dns = [ "10.0.0.1" ];

      peers = [ {
        publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
        endpoint = "75.130.94.103:14438";
        persistentKeepalive = 25;
        allowedIPs = [ "10.0.0.0/24" ];
      } ];
    };
  };


  # Microsoft Surface specific configs

  services.thermald.enable = true;
  services.thermald.configFile = ./thermal-conf.xml;
  # services.tlp = {
  #   enable = true;
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

  #     CPU_MIN_PERF_ON_AC = 0;
  #     CPU_MAX_PERF_ON_AC = 100;
  #     CPU_MIN_PERF_ON_BAT = 0;
  #     CPU_MAX_PERF_ON_BAT = 20;

  #    #Optional helps save long term battery health
  #    START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
  #    STOP_CHARGE_THRESH_BAT0 = 70; # 80 and above it stops charging
  #   };
  # };
  # services.throttled.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
         governor = "powersave";
         turbo = "never";
      };
      charger = {
         governor = "powersave";
         energy_performance_preference = "balance_performance";
         turbo = "auto";
      };
    };
  };

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
        # DisableOnPalm = true;
        DisableOnStylus = true;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
