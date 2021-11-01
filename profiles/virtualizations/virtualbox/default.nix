{ self
, lib
, config
, nixpkgs
, ...
}:

{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    # guest = {
    #  enable = true;
    # };
  };
}
