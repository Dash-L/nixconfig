{ ... }:
{
  networking = {
    hostName = "dash-laptop"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager = {
      enable = true;
      appendNameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };

    # wireguard = {
    #   enable = true;
    #   interfaces = {
    #     serverworks = {
    #       privateKeyFile = "/etc/wireguard/priv-key";
    #       ips = [ "10.0.0.5" ];

    #       peers = [ {
    #         publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
    #         endpoint = "75.130.94.103:14438";
    #         persistentKeepalive = 25;
    #         allowedIPs = [ "10.0.0.0/24" ];
    #       } ];
    #     };
    #   };
    # };
    wg-quick.interfaces = {
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

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };
}
