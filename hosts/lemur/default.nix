{ suites, ... }:
{
  imports = [
    ./configuration.nix
  ]
  ++ suites.base
  ++ suites.personal
  ++ suites.hardware
  ++ suites.db;

  bud.enable = true;
  bud.localFlakeClone = "/home/rayandrew/dotfiles";
}
