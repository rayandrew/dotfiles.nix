{ self
, hmUsers
, age
, config
, ...
}:

let inherit (builtins) readFile;
in
{
  age.secrets.user-pw.file = "${self}/secrets/user-pw.age";

  home-manager.users = { inherit (hmUsers) rayandrew; };

  users.users.rayandrew = {
    createHome = true;
    description = "Ray Andrew";
    group = "users";
    home = "/home/rayandrew";
    uid = 1000;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    passwordFile = config.age.secrets.user-pw.path;
  };
}
