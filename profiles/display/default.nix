{ pkgs, ... }:
let inherit (builtins) readFile;
in
{
  imports = [ ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  boot = {
    tmpOnTmpfs = true;
    # kernel.sysctl."kernel.sysrq" = 1;
  };

  # environment = {
  #   systemPackages = with pkgs; [

  #   ];
  # };

  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager = {
      startx = {
        enable = true;
      };
    };
  };
}
