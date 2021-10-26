{ config
, libs
, pkgs
, ...
}:

{
  programs.password-store = {
    enable = true;
  };
}
