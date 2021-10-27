{ config
, lib
, pkgs
, ...
}:

{
  home.packages = with pkgs; [
    skypeforlinux
    # skype_call_recorder
  ];
}
