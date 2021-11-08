{ config
, lib
, pkgs
, inputs
, ...
}:

let
  theme = pkgs.fetchFromGitHub {
    owner = "B00merang-Project";
    repo = "macOS";
    rev = "dbcd5f621f5e2f39ef5baf39573b91c68c047e1f";
    sha256 = "QrfFd/JfAO/WK3o/lmEDXa+/XCTHp/imoAKMHJaolEk=";
  };
in
{
  # colorscheme = inputs.nix-colors.colorSchemes.horizon-dark;
  colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  # cliColorscheme = inputs.nix-colors.colorSchemes.horizon-dark;

  imports = [
    ./xresources.nix
  ];

  xdg.configFile."gtk-2.0".source = theme + "/gtk-2.0";
  xdg.configFile."gtk-3.0".source = theme + "/gtk-3.0";
}
