{ self
, hmUsers
, age
, config
, home
, ...
}:

{
  age.secrets.user-pw.file = "${self}/secrets/user-pw.age";

  home-manager.users = { inherit (hmUsers) rayandrew; };

  users.extraUsers.rayandrew = {
    createHome = true;
    description = "Ray Andrew";
    group = "users";
    home = "/home/rayandrew";
    uid = 1000;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
      "vboxusers"
      "docker"
    ];
    passwordFile = config.age.secrets.user-pw.path;
  };

  users.extraGroups = {
    vboxusers = {
      members = [ "rayandrew" ];
    };
  };
}
