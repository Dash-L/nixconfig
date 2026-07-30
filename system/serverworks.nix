{ ip }: { ... }:
{
  services.dnsmasq.settings.server = [
    "/server.works/10.0.9.1"
  ];
  networking.wireguard.interfaces.serverworks = {
    ips = [ ip ];

    privateKeyFile = "/etc/wireguard/priv-key";
    peers = [
      {
        publicKey = "LDqLLPMJPuj1w2ea/JqEnDHcqeUxDqzgcu/rLAe8on4=";
        endpoint = "47.14.120.103:14438";
        persistentKeepalive = 25;
        allowedIPs = [ "10.0.9.0/24" ];
      }
    ];
  };
}
