{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  alt = "Mod1";
  colors = config.colorscheme.colors;
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      # package = pkgs.i3-gaps;
      config = {
        modifier = mod;
        keybindings = lib.mkOptionDefault {
          "${alt}+F4" = "kill";

          "${mod}+Return" = "exec ${pkgs.rxvt-unicode}/bin/urxvt";
          "${mod}+Shift+Return" = "exec ${pkgs.rxvt-unicode}/bin/urxvt";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Shift+v" = "split h";
          "${mod}+v" = "split v";
        };
        bars = [
          {
            colors = {
              background = "$base00";
              separator = "$base01";
              statusline = "$base04";
              focusedWorkspace = {
                border = "$base05";
                background = "$base0D";
                text = "$base00";
              };
              activeWorkspace = {
                border = "$base05";
                background = "$base0D";
                text = "$base00";
              };
              inactiveWorkspace = {
                border = "$base03";
                background = "$base01";
                text = "$base05";
              };
              urgentWorkspace = {
                border = "$base08";
                background = "$base08";
                text = "$base00";
              };
              bindingMode = {
                border = "$base00";
                background = "$base0A";
                text = "$base00";
              };
            };
          }
        ];
      };

      extraConfig = ''
        set $base00 #${colors.base00}
        set $base01 #${colors.base01}
        set $base02 #${colors.base02}
        set $base03 #${colors.base03}
        set $base04 #${colors.base04}
        set $base05 #${colors.base05}
        set $base06 #${colors.base06}
        set $base07 #${colors.base07}
        set $base08 #${colors.base08}
        set $base09 #${colors.base09}
        set $base0A #${colors.base0A}
        set $base0B #${colors.base0B}
        set $base0C #${colors.base0C}
        set $base0D #${colors.base0D}
        set $base0E #${colors.base0E}
        set $base0F #${colors.base0F}

        # Basic color configuration using the Base16 variables for windows and borders.
        # Property Name         Border  BG      Text    Indicator Child Border
        client.focused          $base05 $base00 $base04 $base0D $base0C
        client.focused_inactive $base01 $base01 $base05 $base03 $base01
        client.unfocused        $base01 $base00 $base05 $base01 $base01
        client.urgent           $base08 $base08 $base00 $base08 $base08
        client.placeholder      $base00 $base00 $base05 $base00 $base00
        client.background       $base07
      '';
    };
  };

  home.packages = with pkgs; [
    i3
    i3lock-fancy
    i3blocks
    dmenu
  ];
}
