{ config
, lib
, pkgs
, ...
}:

{
  programs = {
    brave = {
      enable = true;
    };
  };
}
