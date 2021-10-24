{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
  ];
}
