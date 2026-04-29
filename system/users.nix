{ pkgs, ... }:
{
  users = {
    groups.wireshark = {};
  
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.dash = {
      isNormalUser = true;
      description = "Dashiell Elliott";
      extraGroups = [ "networkmanager" "wheel" "video" "dialout" "docker" "wireshark" "wpa_supplicant" ];
      shell = pkgs.bash;
      packages = with pkgs; [];
    };
  };
}
