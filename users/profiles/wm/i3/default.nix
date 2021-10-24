{ config, lib, pkgs, ... }:

{
  xsession = {
    enable = true;
    windowManager.command = "i3";
  };

  home.packages = with pkgs; [
    i3
    i3lock-fancy
    i3blocks
    dmenu
  ];
}
