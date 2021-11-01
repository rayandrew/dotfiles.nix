{ config
, lib
, pkgs
, self
, ...
}:

let
  port = "8888";
  inherit (builtins) readFile;
in
{
  # age.secrets.spotify-id.file = "${self}/secrets/spotify-id.age";
  # age.secrets.spotify-id.group = "wheel";
  # age.secrets.spotify-secret.file = "${self}/secrets/spotify-secret.age";
  # age.secrets.spotify-secret.group = "wheel";

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        username = "raydreee";
        password_cmd = "${pkgs.pass}/bin/pass show spotify";
        # device_name = pkgs.config.networking.hostName;
      };
    };
  };

  home.packages = with pkgs; [
    spotify-tui
  ];

  home.file = {
    "${config.xdg.configHome}/spotify-tui/client.yml" = {
      text = ''
        device_id: ~
        port: ${port}
      '';
    };
  };

  #   client_id: ${(readFile age.secrets.spotify-id.path)}
  # client_secret: ${(readFile age.secrets.spotify-secret.path)}
}
