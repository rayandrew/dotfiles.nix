{ config
, lib
, pkgs
, ...
}:

{
  programs.rofi = {
    enable = true;
    # plugins = with pkgs; [
    #   rofi-emoji
    #   rofi-calc
    # ];
    terminal = "st";
    extraConfig = {
      modi = "run,drun,ssh";
    };
    theme = ./icons.rasi;
  };
}
