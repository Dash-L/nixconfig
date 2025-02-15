# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # for droidcam
  # boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  # boot.kernelModules = [ "v4l2loopback" ];
  # programs.adb.enable = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "dash-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.graphics.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # docker
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.wireshark = {};
  
  users.users.dash = {
    isNormalUser = true;
    description = "Dashiell Elliott";
    extraGroups = [ "networkmanager" "wheel" "video" "dialout" "docker" "wireshark" ];
    shell = pkgs.bash;
    packages = with pkgs; [];
  };

  # Attempt to improve latency, see: https://nixos.wiki/wiki/Sway
  # security.pam.loginLimits = [
  #   { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  # ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
  #  wget
  ];

  security.polkit.enable = true;

  # printing
  services.printing.enable = true;

  # power management
  services.upower.enable = true;

  # Pipewire support
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # for screensharing
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = ["wlr" "gtk"];
    };
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  # List services that you want to enable:

  # platformio uploading
  services.udev.packages = with pkgs; [ platformio-core.udev ];

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

  # steam configs
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # for connecting to WPI wifi while off campus (removed from nixpkgs?)
  # services.globalprotect.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.thermald.enable = true;
  services.thermald.configFile = /home/dash/.config/home-manager/thermal-conf.xml;
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
