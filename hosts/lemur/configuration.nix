{ config
, pkgs
, ...
}:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      systemd-boot = {
        configurationLimit = 10;
        enable = true;
      };
      # grub = {
      #   enable = true;
      #   version = 2;
      #   device = "nodev";
      #   efiSupport = true;
      #   gfxmodeEfi = "1024x768";
      # };
    };
  };

  networking = {
    hostName = "lemur";
    useDHCP = false;
    wireless = {
      enable = true;
      interfaces = [ "wlp0s20f3" ];
    };
    interfaces = {
      wlp0s20f3.useDHCP = true;
    };
    firewall = {
      allowedTCPPorts = [
        57621 # spotify
      ];
    };
  };

  time.timeZone = "America/Chicago";

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    openssl
  ];

  system.stateVersion = "21.05";
}

