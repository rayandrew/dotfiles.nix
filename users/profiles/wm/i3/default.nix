{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  alt = "Mod1";
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
      };
    };
  };

  home.packages = with pkgs; [
    i3
    i3lock-fancy
    i3blocks
    dmenu
  ];
}
