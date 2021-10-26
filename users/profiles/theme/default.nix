{ config
, lib
, pkgs
, inputs
, ...
}:

{
  colorscheme = inputs.nix-colors.colorSchemes.horizon-dark;
  # cliColorscheme = inputs.nix-colors.colorSchemes.horizon-dark;

  imports = [ ./xresources.nix ];
}
