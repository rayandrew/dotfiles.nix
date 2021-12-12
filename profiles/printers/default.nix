{ config, lib, pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplipWithPlugin
        samsungUnifiedLinuxDriver
      ];
    };

    avahi = {
      enable = true;
      nssmdns = true;
      # nssmdns = false; # Use the settings from below

    };

    # settings from avahi-daemon.nix where mdns is replaced with mdns4
    # system.nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
    # system.nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
    #   (mkOrder 900 [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
    #   (mkOrder 1501 [ "mdns4" ]) # 1501 to ensure it's after dns
    # ]);
  };
}
