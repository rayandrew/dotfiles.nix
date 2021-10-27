{ config
, lib
, pkgs
, ...
}:

let
  volumeStep = "5";
in
{
  home.packages = with pkgs; [
    xsel
    xclip
    xorg.xev
    xorg.xbacklight
  ];

  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86AudioMute" = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle";
      "XF86AudioLowerVolume" = "${pkgs.alsaUtils}/bin/amixer -q sset Master ${volumeStep}%-";
      "XF86AudioRaiseVolume" = "${pkgs.alsaUtils}/bin/amixer -q sset Master ${volumeStep}%+";
      "XF86MonBrightnessDown" = "${pkgs.light}/bin/light -U 10";
      "XF86MonBrightnessUp" = "${pkgs.light}/bin/light -A 10";
    };
  };
}
