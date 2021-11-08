{ config, lib, pkgs, ... }:

{
  xdg.configFile."gtk-2.0".source = ./themes;
}
