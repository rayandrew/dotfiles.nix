{ config, lib, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerSocket = {
      enable = true;
    };
    defaultNetwork = {
      dnsname = {
        enable = true;
      };
    };
  };
}
