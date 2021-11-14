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

  base16-monokai = {
    slug = "monokai";
    name = "Monokai";
    author = "-";
    colors = {
      base00 = "272822"; # Default Background
      base01 = "383830"; # Lighter Background (Used for status bars)
      base02 = "49483e"; # Selection Background
      base03 = "75715e"; # Comments, Invisibles, Line Highlighting
      base04 = "a59f85"; # Dark Foreground (Used for status bars)
      base05 = "f8f8f2"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "f5f4f1"; # Light Foreground (Not often used)
      base07 = "f9f8f5"; # Light Background (Not often used)
      base08 = "f92672"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "fd971f"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "f4bf75"; # Classes, Markup Bold, Search Text Background
      base0B = "a6e22e"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "a1efe4"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "66d9ef"; # Functions, Methods, Attribute IDs, Headings
      base0E = "ae81ff"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "cc6633"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
  };
in
{
  # colorscheme = inputs.nix-colors.colorSchemes.horizon-dark;
  # colorscheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;
  colorscheme = base16-monokai;
  # cliColorscheme = inputs.nix-colors.colorSchemes.horizon-dark;

  imports = [
    ./xresources.nix
  ];

  xdg.configFile."gtk-2.0".source = theme + "/gtk-2.0";
  xdg.configFile."gtk-3.0".source = theme + "/gtk-3.0";
}
