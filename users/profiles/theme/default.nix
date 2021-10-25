{ config
, lib
, pkgs
, inputs
, ...
}:

{
  colorscheme = inputs.nix-colors.colorSchemes.dracula;
}
