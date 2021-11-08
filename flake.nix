{
  description = "Ray Andrew's Poor Configuration";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs =
    {
      nixos = {
        # url = "github:nixos/nixpkgs/release-21.05";
        url = "github:nixos/nixpkgs/nixos-unstable";
      };

      latest = {
        url = "github:nixos/nixpkgs/nixos-unstable";
      };

      blank = {
        url = "github:divnix/blank";
      };

      digga = {
        url = "github:divnix/digga";
        inputs = {
          nixpkgs.follows = "nixos";
          nixlib.follows = "nixos";
          home-manager.follows = "home";
        };
      };

      bud = {
        url = "github:divnix/bud";
        inputs = {
          nixpkgs.follows = "nixos";
          devshell.follows = "digga/devshell";
        };
      };

      home = {
        url = "github:nix-community/home-manager/release-21.05";
        inputs = {
          nixpkgs.follows = "nixos";
        };
      };

      darwin = {
        url = "github:LnL7/nix-darwin";
        inputs = {
          nixpkgs.follows = "latest";
        };
      };

      deploy = {
        follows = "digga/deploy";
      };

      agenix = {
        url = "github:ryantm/agenix";
        inputs = {
          nixpkgs.follows = "latest";
        };
      };

      nvfetcher = {
        url = "github:berberman/nvfetcher";
        inputs = {
          nixpkgs.follows = "nixos";
          flake-compat.follows = "digga/deploy/flake-compat";
          flake-utils.follows = "digga/flake-utils-plus/flake-utils";
        };
      };

      nix-prefetch-github = {
        url = "github:seppeljordan/nix-prefetch-github";
        inputs = {
          flake-utils.follows = "digga/flake-utils-plus/flake-utils";
        };
      };

      naersk = {
        url = "github:nmattia/naersk";
        inputs = {
          nixpkgs.follows = "nixos";
        };
      };

      emacs = {
        url = "github:nix-community/emacs-overlay";
        inputs = {
          nixpkgs.follows = "nixos";
        };
      };

      nix-doom-emacs = {
        url = "github:vlaci/nix-doom-emacs";
        inputs = {
          nixpkgs.follows = "nixos";
          flake-utils.follows = "digga/flake-utils-plus/flake-utils";
        };
      };

      nixos-hardware = {
        url = "github:nixos/nixos-hardware";
      };

      nix-colors = {
        url = "github:misterio77/nix-colors";
        inputs = {
          nixpkgs.follows = "latest";
        };
      };
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
    , nix-doom-emacs
    , agenix
    , nvfetcher
    , deploy
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

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
                virtualizations.virtualbox
                virtualizations.docker
                virtualizations.podman
                virtualizations.arion
              ];
            };
          };
        };

        home = ./users;

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
