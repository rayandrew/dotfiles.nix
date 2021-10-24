{ suites, ... }:
{
  imports = [
    ./configuration.nix
  ]
  ++ suites.base
  ++ suites.personal
  ++ suites.hardware;

  bud.enable = true;
  bud.localFlakeClone = "/home/rayandrew/dotfiles";
}
