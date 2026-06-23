{ ... }:
{
  security = {
    polkit.enable = true;
    rtkit.enable = true; # Necessary for pipewire, I believe

    # Attempt to improve latency, see: https://nixos.wiki/wiki/Sway
    # pam.loginLimits = [
    #   { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    # ];
  };
}
