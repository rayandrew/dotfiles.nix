{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    lm_sensors
  ];
}
