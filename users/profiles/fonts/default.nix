{ config, lib, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    # gohufont
    ubuntu_font_family
    dejavu_fonts
    source-serif-pro
    inconsolata
    hack-font
    tamzen
    roboto
    iosevka
  ];
}