{ config, lib, pkgs, ... }:

# see for further fixes
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/networking/instant-messengers/zoom-us/default.nix
# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/programs/firejail.nix

let
  zoom-bin = "zoom-secure";
  firejail-home = "~/.firejail";
in
{
  environment.systemPackages = with pkgs; [
    (zoom-us.overrideAttrs (oldAttrs: rec {
      postFixup = ''
        ${oldAttrs.postFixup}

        # Desktop File
        # TODO Need to fix this, change /run/current-system...
        #      to real firejail-wrapped-binaries path
        substituteInPlace $out/share/applications/Zoom.desktop \
          --replace "Exec=$out/bin/zoom" "Exec=/run/current-system/sw/bin/${zoom-bin}"
      '';
    }))
  ];

  programs.firejail.wrappedBinaries = {
    "${zoom-bin}" = {
      executable = "${lib.getBin pkgs.zoom-us}/bin/zoom-us";
      profile = "${pkgs.firejail}/etc/firejail/zoom.profile";
      extraArgs = [
        "--private=${firejail-home}"
      ];
    };
  };
}
