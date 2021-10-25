{ config, lib, pkgs, ... }:

{
  programs.urxvt = {
    enable = true;
    fonts = [ "xft:Inconsolata-g for Powerline:size=15" ];
    extraConfig = {
      "perl-ext-common" = "default,tabbedex,clipboard,keyboard-select,url-select";
      "perl-lib" = "${pkgs.rxvt-unicode}/lib/urxvt/perl";
      "clipboard.autocopy" = true;
      "copyCommand" = "${pkgs.xclip}/bin/xclip -i selection clipboard";
      "pasteCommand" = "${pkgs.xclip}/bin/xclip -o selection clipboard";
      "letterSpace" = "1";
      "lineSpace" = "1";
    };
    keybindings = {
      "M-c" = "perl:clipboard:copy";
      "M-v" = "perl:clipboard:paste";
    };
    scroll = {
      bar = {
        enable = false;
      };
    };
  };
}
