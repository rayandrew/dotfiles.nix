{ self, config, lib, pkgs, ... }:
{
  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    forwardX11 = true;
    openFirewall = lib.mkDefault false;
    hostKeys =  [
      { type = "rsa"; bits = 4096; path = "/etc/ssh/ssh_host_rsa_key"; }
      { type = "ed25519"; path = "/etc/ssh/ssh_host_ed25519_key"; }
    ];
  };
}
