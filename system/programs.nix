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

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 2";
    };
  };

  environment.systemPackages = with pkgs; [
    helix
    wget
  ];
}
