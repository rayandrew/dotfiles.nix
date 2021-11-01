{ self
, config
, lib
, pkgs
, ...
}:

{
  programs.autorandr = {
    enable = true;
  };
}
