{ self
, hmUsers
, age
, config
, ...
}:

{
  age.secrets.root-pw.file = "${self}/secrets/root-pw.age";

  users.users.root.passwordFile = config.age.secrets.root-pw.path;
}
