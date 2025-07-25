{ config, pkgs, firefox-sidebar-css, lib, ... }:

let
  extension = uuid: {
    name = uuid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${uuid}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  exts = {
    ublock = extension "uBlock0@raymondhill.net";
    sideberry = extension "{3c078156-979c-498b-8990-85f7987dd929}";
    privacy-badger = extension "jid1-MnnxcxisBPnSXQ@jetpack";
    duckduckgo = extension "jid1-ZAdIEUB7XOzOJw@jetpack";
    youtube-enhancer = extension "enhancerforyoutube@maximerf.addons.mozilla.org";
  };

  ffContainerToSideberryPanel = cont: {
    name = cont.name;
    value = {
      type = 2;
      id = cont.name;
      name = cont.name;
      color = cont.value.color;
      iconSVG = cont.value.icon;
      iconIMGSrc = "";
      iconIMG = "";
      lockedPanel = false;
      skipOnSwitching = false;
      noEmpty = false;
      newTabCtx = "firefox-container-${toString cont.value.id}";
      dropTabCtx = "firefox-container-${toString cont.value.id}";
      moveRules = [];
      moveExcludedTo = -1;
      bookmarksFolderId = -1;
      newTabBtns = [];
    };
  };

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
in {
  programs.firefox = {
    enable = true;
    policies = {
      ExtensionSettings = with builtins; listToAttrs (concatLists [ [{ name = "*"; value = { installation_mode = "blocked"; }; }] (attrValues exts) ]);
    };
    profiles.main = {
      isDefault = true;
      settings = {
        "sidebar.verticalTabs" = true;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      extensions = {
        force = true;
        settings = {
          "${exts.sideberry.name}".settings = {
            sidebar = {
              panels = with builtins; with lib; listToAttrs (map ffContainerToSideberryPanel (attrsToList containers));
              nav = [ "Personal" "Programming" "School" "HPRC" "add_tp" "settings" ];
            };
            settings = {
              pinnedTabsPosition = "top";
              hScrollAction = "switch_panels";
              hideEmptyPanels = false;
              activateAfterClosing = "prev";
              activateAfterClosingStayInPanel = true;
              newTabCtxReopen = true;
            };
          };
        };
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
      inherit containers;
    };
  };
  home.file."${config.programs.firefox.profilesPath}/main/chrome".source = "${firefox-sidebar-css}";
}
