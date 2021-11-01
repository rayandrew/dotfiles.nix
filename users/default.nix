{ self
, inputs
, modulesFolder
, ...
}:

let
  lib = inputs.digga.lib;
in
{
  imports = [ (lib.importExportableModules ./modules) ];
  modules = [
    inputs.nix-colors.homeManagerModule
    ({ ... }:
      let
        nur-no-pkgs = import inputs.nur {
          nurpkgs = import inputs.nixos { system = "x86_64-linux"; };
        };
      in
      {
        imports = [
          nur-no-pkgs.repos.rycee.hmModules.emacs-init
          nur-no-pkgs.repos.rycee.hmModules.emacs-notmuch
        ];
      })
  ];
  importables = rec {
    profiles = lib.rakeLeaves ./profiles // { };
    suites = with profiles; rec {
      base = [
        direnv
        utilities
        theme
        fonts
        password
        email.cli
        editor.emacs
        scm.git
        scm.svn
      ];
      desktop = [
        wm.i3
        terminal.urxvt
        terminal.kitty
        browser.brave
        editor.vscode
        communications.skype
        media.spotify
      ];
    };
  };
  users = {
    rayandrew = { suites, ... }: {
      imports = suites.base
        ++ suites.desktop;
    };
  }; # digga.lib.importers.rakeLeaves ./users/hm;
}
