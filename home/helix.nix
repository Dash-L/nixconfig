{ config, pkgs, lib, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    ignores = [
      ".direnv"
    ];
    settings = {
      theme = "catppuccin_macchiato";
      keys = {
        normal = {
          ret = ["open_below" "normal_mode"];
          "C-ret" = ["open_above" "normal_mode"];
          q = {
            i = ":toggle lsp.display-inlay-hints";
            w = ":toggle whitespace.render all none";
            f = ":format";
          };
        };
      };
      editor = {
        line-number = "relative";
        soft-wrap.enable = true;
        mouse = true;
        completion-replace = true;
        bufferline = "always";
        color-modes = true;
        statusline = {
          center = ["version-control"];
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker = {
          git-ignore = false;
          hidden = false;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        indent-guides.render = true;
      };
    };
    languages = {
      language-server.tinymist = {
        config = {
          formatterMode = "typstyle";
        };
      };
      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
      };
      language = [
        {
          name = "typescript";
          auto-format = false;
          formatter = {
            command = "$prettier";
            args = ["--parser" "typescript"];
          };
        }
        {
          name = "tsx";
          auto-format = false;
          formatter = {
            command = "prettier";
            args = ["--parser" "typescript"];
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nixd"];
        }
        {
          name = "typst";
          language-servers = ["tinymist"];
        }
      ];
    };
  };
}
