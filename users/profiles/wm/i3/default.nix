{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
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
          "${mod}+Enter" = "exec ${pkgs.rxvt-unicode}/bin/urxt";
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
