{ config, lib, pkgs, ... }:

{
  programs.evolution = {
    enable = true;
    plugins = with pkgs; [
      evolution-ews
    ];
  };
  # home.packages = with pkgs; [
  #   evolution
  #   evolution-ews
  # ];
}
