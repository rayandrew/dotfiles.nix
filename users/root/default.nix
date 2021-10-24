{ self
, hmUsers
, age
, ...
}:

{
  age.secrets.root-pw.file = "${self}/secrets/root-pw.age";

  users.users.root.password = "";
}
