{ config, pkgs, firefox-sidebar-css, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.main = {
      isDefault = true;
      settings = {
        "sidebar.verticalTabs" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      search = {
        force = true;
        default = "ddg";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages?query={searchTerms}&channel=unstable";
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixpkgs" ];
          };

          nixos-options = {
            name = "Nixos Options";
            urls = [{
              template = "https://search.nixos.org/options?query={searchTerms}&channel=unstable";
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nixopts" ];
          };

          home-manager-options = {
            name = "HomeManager Options";
            urls = [{
              template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@hmopts" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nixwiki" ];
          };

          typst = {
            name = "Typst Universe";
            urls = [ { template = "https://typst.app/universe/search?q={searchTerms}"; }];
            definedAliases = [ "@typst" ];
          };

          bing.metaData.hidden = true;
          ebay.metaData.hidden = true;
          google.metaData.hidden = true;
        };
      };
      containersForce = true;
      containers = {
        "Personal" = {
          id = 4;
          color = "blue";
          icon = "fingerprint";
        };
        "Programming" = {
          id = 1;
          color = "purple";
          icon = "fingerprint";
        };
        "School" = {
          id = 2;
          color = "orange";
          icon = "briefcase";
        };
        "HPRC" = {
          id = 3;
          color = "red";
          icon = "circle";
        };
      };
    };
  };
  home.file."${config.programs.firefox.profilesPath}/main/chrome".source = "${firefox-sidebar-css}";
}
