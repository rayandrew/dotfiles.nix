{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
  ];
}
