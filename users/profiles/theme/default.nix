{ config
, lib
, pkgs
, inputs
, ...
}:

{
  # colorscheme = inputs.nix-colors.colorSchemes.horizon-dark;
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  # cliColorscheme = inputs.nix-colors.colorSchemes.horizon-dark;

  imports = [ ./xresources.nix ];
}
