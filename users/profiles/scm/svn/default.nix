{ config
, libs
, pkgs
, ...
}:

{
  home.packages = with pkgs; [
    subversion
  ];
}
