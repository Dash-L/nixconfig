{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_macchiato";
      keys = {
        normal = {
          space = {
            i = ":toggle lsp.display-inlay-hints";
          };
        };
      };
      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        cursorcolumn = true;
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
          hidden = false;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        whitespace.render = "all";
        indent-guides.render = true;
      };
    };
    languages = {
      language = [
        {
          name = "typescript";
          auto-format = false;
          formatter = {
            command = "prettier";
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
      ];
    };
  };
}
