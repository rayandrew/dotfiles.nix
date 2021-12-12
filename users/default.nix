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
        shells.fish
        shells.tmux
      ];
      desktop = [
        display.xsession
        display.i3
        display.rofi
        display.xrandr
        display.picom
        display.dunst
        terminal.urxvt
        terminal.kitty
        terminal.st
        browser.brave
        browser.google-chrome
        editor.vscode
        editor.jetbrains
        communications.skype
        communications.slack
        communications.discord
        media.spotify
      ];
      devs = [
        developments.latex
        developments.c
        developments.ruby
        developments.python
        developments.javascript
      ];
    };
  };
  users = {
    rayandrew = { suites, ... }: {
      imports = suites.base
        ++ suites.desktop
        ++ suites.devs;
    };
  }; # digga.lib.importers.rakeLeaves ./users/hm;
}
