{ pkgs, ... }:
{
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    # steam configs
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };

    # mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    helix
    wget
  ];
}
