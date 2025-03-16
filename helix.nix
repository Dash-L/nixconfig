{ config, pkgs, lib, ... }:

# let 
#   helixFlakePkgs = (builtins.getFlake (toString ./helix)).packages.${pkgs.system};
# in
{
  # home.packages = [ helixFlakePkgs.steel ];
  programs.helix = {
    enable = true;
    # package = helixFlakePkgs.default;
    defaultEditor = true;
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
          # exportPdf = "onDocumentHasTitle";
          formatterMode = "typstyle";
          # outputPath = "$root/out/$dir/$name";
        };
      };
      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
      };
      language-server.ccls = {
        command = "${pkgs.ccls}/bin/ccls";
      };
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
  # home.file = {
  #   "${config.xdg.configHome}/helix/helix.scm".text = ''
  #     (require "helix/editor.scm")
  #     (require (prefix-in helix. "helix/commands.scm"))
  #     (require (prefix-in helix.static. "helix/static.scm"))

  #     (provide shell git-add)

  #     ;;@doc
  #     ;; Specialized shell implementation, where % is a wildcard for the current file
  #     (define (shell cx . args)
  #     ;; Replace the % with the current file
  #     (define expanded (map (lambda (x) (if (equal? x "%") (current-path cx) x)) args))
  #     (apply helix.run-shell-command expanded))

  #     ;;@doc
  #     ;; Adds the current file to git	
  #     (define (git-add cx)
  #     (shell cx "git" "add" "%"))
  #   '';
  #   "${config.xdg.configHome}/helix/init.scm".text = ''
  #     (require (prefix-in helix. "helix/commands.scm"))
  #     (require (prefix-in helix.static. "helix/static.scm"))
  #   '';
  # };
}
