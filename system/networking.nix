{ ... }:
{
  services.dnsmasq = {
    enable = true;  # Turn on dnsmasq to handle fallback DNS requests.
    settings = {
      no-resolv = true;  # Don't use default system DNS servers.
      server = [
        # NOTE: servers are listed in reverse order for priority!
        "1.1.1.1"
      ];
    };
  };

  networking = {
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager = {
      enable = true;
      insertNameservers = [ "127.0.0.1" ];
    };

    # NOTE: see the hosts/<host>/configuration.nix files for wireguard configs

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };
}
