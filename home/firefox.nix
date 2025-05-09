{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = false;
    profiles."763ofwon.default" = {
#       userChrome = ''
# #TabsToolbar {
#     visibility: collapse !important;
# }

# #sidebar-header {
#   /* display: none; */
#   visibility: collapse !important;
# }

# /* Hide splitter */
# #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] + #sidebar-splitter {
#   display: none !important;
# }

# /* Shrink sidebar until hovered */
# :root {
#   --thin-tab-width: 31px;
#   --wide-tab-width: 300px;
# }
# #sidebar-box:not([sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]) {
#   min-width: var(--wide-tab-width) !important;
#   max-width: none !important;
# }
# #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] {
#   overflow: hidden !important;
#   position: relative !important;
#   transition: all 300ms !important;
#   /*transition: all 0ms 0s !important;*/
#   min-width: var(--thin-tab-width) !important;
#   max-width: var(--thin-tab-width) !important;
#   z-index: 9999;
# }
# #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"]:hover,
# #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar {
#   /*transition-delay: 0s !important;*/
#   transition: all 300ms !important;
#   min-width: var(--wide-tab-width) !important;
#   max-width: var(--wide-tab-width) !important;
#   z-index: 9998;
#   margin-right: calc((var(--wide-tab-width) - var(--thin-tab-width)) * -1) !important;
# }
#     '';
    };
  };
}
