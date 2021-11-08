{ config, lib, pkgs, ... }:

{
  xdg.configFile."gtk-3.0".source = ./themes;
}
