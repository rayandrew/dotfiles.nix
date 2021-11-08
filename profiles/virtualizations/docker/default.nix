{ config, lib, pkgs, ... }:

{
  # virtualisation.docker = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    docker-client
    docker-compose
  ];
}
