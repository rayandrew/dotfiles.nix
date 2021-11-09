{ config
, lib
, pkgs
, self
, networking
, ...
}:

let
  username = "raydreee";
  device_name = "spotifyd";
  port = "8888";
  inherit (builtins) readFile;
in
{
  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        inherit username device_name;
        # password_cmd = "${pkgs.pass}/bin/pass show spotify";
      };
    };
  };

  home.packages = with pkgs; [
    spotify
    spotify-tui
  ];

  # TODO: agenix not work on this file!!
  # age.secrets.spotify-id.file = "${self}/secrets/spotify-id.age";
  # age.secrets.spotify-id.group = "wheel";
  # age.secrets.spotify-secret.file = "${self}/secrets/spotify-secret.age";
  # age.secrets.spotify-secret.group = "wheel";
  # home.file = {
  #   "${config.xdg.configHome}/spotify-tui/client.yml" = {
  #     text = ''
  #       device_id: ~
  #       port: ${port}
  #       client_id: ${(readFile config.age.secrets.spotify-id.path)}
  #       client_secret: ${(readFile config.age.secrets.spotify-secret.path)}
  #     '';
  #   };
  # };
}
