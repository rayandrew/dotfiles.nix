{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      nixos.url = "github:nixos/nixpkgs/release-21.05";
      latest.url = "github:nixos/nixpkgs/nixos-unstable";

      digga.url = "github:divnix/digga";
      digga.inputs.nixpkgs.follows = "nixos";
      digga.inputs.nixlib.follows = "nixos";
      digga.inputs.home-manager.follows = "home";

      bud.url = "github:divnix/bud";
      bud.inputs.nixpkgs.follows = "nixos";
      bud.inputs.devshell.follows = "digga/devshell";

      home.url = "github:nix-community/home-manager/release-21.05";
      home.inputs.nixpkgs.follows = "nixos";

      darwin.url = "github:LnL7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "latest";

      deploy.follows = "digga/deploy";

      agenix.url = "github:ryantm/agenix";
      agenix.inputs.nixpkgs.follows = "latest";

      nvfetcher.url = "github:berberman/nvfetcher";
      nvfetcher.inputs.nixpkgs.follows = "latest";
      nvfetcher.inputs.flake-compat.follows = "digga/deploy/flake-compat";
      nvfetcher.inputs.flake-utils.follows = "digga/flake-utils-plus/flake-utils";

      naersk.url = "github:nmattia/naersk";
      naersk.inputs.nixpkgs.follows = "latest";

      emacs.url = "github:nix-community/emacs-overlay";

      nixos-hardware.url = "github:nixos/nixos-hardware";

      nix-colors.url = "github:misterio77/nix-colors";
      nix-colors.inputs.nixpkgs.follows = "latest";

      # start ANTI CORRUPTION LAYER
      # remove after https://github.com/NixOS/nix/pull/4641
      nixpkgs.follows = "nixos";
      nixlib.follows = "digga/nixlib";
      blank.follows = "digga/blank";
      flake-utils-plus.follows = "digga/flake-utils-plus";
      flake-utils.follows = "digga/flake-utils";
      # end ANTI CORRUPTION LAYER
    };

  outputs =
    { self
    , digga
    , bud
    , nixos
    , home
    , emacs
    , nixos-hardware
    , nix-colors
    , nur
    , agenix
    , nvfetcher
    , deploy
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        supportedSystems = [
          "aarch64-linux"
          "x86_64-linux"
        ];

        channelsConfig = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [
              digga.overlays.patchedNix
              emacs.overlay
              nur.overlay
              agenix.overlay
              nvfetcher.overlay
              ./pkgs/default.nix
            ];
          };
          latest = {
            overlays = [
              deploy.overlay
            ];
          };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.nixosModules.bootstrapIso
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
              agenix.nixosModules.age
              bud.nixosModules.bud
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts) ];
          hosts = {
            /* set host specific properties here */
            "lemur" = {
              channelName = "latest";
              modules = [ nixos-hardware.nixosModules.system76 ];
            };
          };
          importables = rec {
            profiles = digga.lib.rakeLeaves ./profiles // {
              hardwares = digga.lib.rakeLeaves ./profiles/hardwares;
              users = digga.lib.rakeLeaves ./users;
            };
            suites = with profiles; rec {
              base = [
                core
                users.rayandrew
                users.root
                ssh
              ];
              hardware = [
                hardwares.audio
                hardwares.bluetooth
                hardwares.backlight
                hardwares.sensors
              ];
              personal = [
                cachix
                display
                packages
              ];
            };
          };
        };

        home = {
          imports = [ (digga.lib.importExportableModules ./users/modules) ];
          modules = [
            inputs.nix-colors.homeManagerModule
            ({ ... }:
              let
                nur-no-pkgs = import nur {
                  nurpkgs = import nixos { system = "x86_64-linux"; };
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
            profiles = digga.lib.rakeLeaves ./users/profiles // {
              browser = digga.lib.rakeLeaves ./users/profiles/browser;
              email = digga.lib.rakeLeaves ./users/profiles/email;
              editor = digga.lib.rakeLeaves ./users/profiles/editor;
              terminal = digga.lib.rakeLeaves ./users/profiles/terminal;
              wm = digga.lib.rakeLeaves ./users/profiles/wm;
            };
            suites = with profiles; rec {
              base = [
                direnv
                git
                utilities
                theme
                fonts
                password
                email.cli
                editor.emacs
              ];
              desktop = [
                wm.i3
                terminal.urxvt
                browser.brave
                editor.vscode
              ];
            };
          };
          users = {
            rayandrew = { suites, ... }: {
              imports = suites.base
              ++ suites.desktop;
            };
          }; # digga.lib.importers.rakeLeaves ./users/hm;
        };

        devshell = ./shell;

        homeConfigurations = digga.lib.mkHomeConfigurations self.nixosConfigurations;

        deploy.nodes = digga.lib.mkDeployNodes self.nixosConfigurations { };

        defaultTemplate = self.templates.bud;
        templates.bud.path = ./.;
        templates.bud.description = "bud template";

      }
    //
    {
      budModules = { devos = import ./bud; };
    }
  ;
}
