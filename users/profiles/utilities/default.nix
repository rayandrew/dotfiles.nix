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
    file
    arandr
    nix-prefetch-github
    fasd

    neofetch
    feh

    audio-recorder
    evince
    meld
    pavucontrol
    flameshot
    nitrogen

    gnumake
    pkg-config

    pdftk

    sqlite
  ];

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.htop = {
    enable = true;
  };

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

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  home.keyboard = {
    options = [
      "ctrl:nocaps"
    ];
  };
}
