{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python39
  ];
}
