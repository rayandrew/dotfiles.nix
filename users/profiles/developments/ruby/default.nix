{ config, lib, pkgs, ... }:

let
  ruby = pkgs.ruby_3_0;
  # bundler = (pkgs.bundler.override {
  #   inherit ruby;
  # });
in
{
  home.packages = with pkgs; [
    ruby
    # bundler
  ];
}
