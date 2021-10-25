{ config
, pkgs
, libs
, ...
}:

{
  programs.neomutt = {
    enable = true;
  };
}
