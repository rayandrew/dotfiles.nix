{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome
  ];
}
