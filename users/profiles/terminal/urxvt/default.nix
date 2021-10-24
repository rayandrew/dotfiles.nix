{ config, lib, pkgs, ... }:

{
  programs.urxvt = {
    enable = true;
    keybindings = {
      "M-c" = "perl:clipboard:copy";
      "M-v" = "perl:clipboard:paste";
    };
    scroll = {
      bar = {
        enable = true;
      };
    };
  };
}
