{ config, lib, pkgs, ... }:

{
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      extraConfig = "load-module module-switch-on-connect";
      support32Bit = true;
    };
  };

  sound.enable = true;
}
