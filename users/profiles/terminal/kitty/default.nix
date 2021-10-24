{ config, lib, pkgs, ... }:

let
  colors = config.colorscheme.colors;
in {
  programs.kitty = {
    enable = true;
    settings = {
      foreground = "#${colors.base05}";
      background = "#${colors.base00}";
    };
  };
}
