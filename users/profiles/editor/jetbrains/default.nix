{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs.jetbrains; [
    clion
  ];
}
