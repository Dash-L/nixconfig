{ config, pkgs, lib, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };
  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "$git_state"
        "$git_status"
        "$git_branch"
        "$nix_shell"
        "\n"
        "$directory"
        "$cmd_duration"
        "$shlvl"
        "$character"
      ];

      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
      };

      shlvl = {
        disabled = false;
        format = "[$symbol]($style)";
        repeat = true;
        symbol = "❯";
        repeat_offset = 1;
        threshold = 0;
      };

      nix_shell = {
        impure_msg = "";
      };
    };
  };
}
