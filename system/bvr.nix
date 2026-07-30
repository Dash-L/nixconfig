{ ip }: { ... }:
{
  services.dnsmasq.settings.server = [
    "/bvr.arpa/10.21.9.1"
  ];
  networking.wireguard.interfaces.bvr = {
    ips = [ ip ];

    privateKeyFile = "/etc/wireguard/priv-key";
    peers = [
      {
        publicKey = "xb7tW0EHGmK8IH5CCdAwnMcbjkMbFAnSjF1vPoP7Pm4=";
        endpoint = "goatworks.duckdns.org:43481";
        persistentKeepalive = 25;
        allowedIPs = [ "10.19.0.0/16" "10.21.0.0/16" ];
      }
    ];
  };

  security.pki.certificateFiles = [ ../certs/bvr.crt ];
}
