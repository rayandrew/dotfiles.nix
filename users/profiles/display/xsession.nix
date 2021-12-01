{ config, lib, pkgs, ... }:

{
  xsession = {
    enable = true;
    initExtra = ''
      ${pkgs.nitrogen}/bin/nitrogen --restore &
    '';
  };
}
