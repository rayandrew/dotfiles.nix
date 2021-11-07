{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  alt = "Mod1";
  colors = config.colorscheme.colors;
  barName = "default";
  # term = "${pkgs.st}/bin/st";
  term = "st -e ${pkgs.fish}/bin/fish";
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      # package = pkgs.i3-gaps;
      config = {
        modifier = mod;
        keybindings = lib.mkOptionDefault {
          "${mod}+d" = "exec --no-startup-id \"${pkgs.rofi}/bin/rofi -show drun -modi run,drun,window\"";

          "${alt}+F4" = "kill";

          "${mod}+Return" = "exec ${term}";
          "${mod}+Shift+Return" = "exec ${term} -c \"tmux attach || tmux new-session\"";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+Shift+v" = "split h";
          "${mod}+v" = "split v";
        };
        bars = [
          {
            colors = {
              #             background = "$base00";
              #             separator = "$base01";
              #             statusline = "$base04";
              #              focusedWorkspace = {
              #                border = "$base05";
              #                background = "$base0D";
              #                text = "$base00";
              #              };
              #              activeWorkspace = {
              #                border = "$base05";
              #                background = "$base0D";
              #                text = "$base00";
              #              };
              #              inactiveWorkspace = {
              #                border = "$base03";
              #                background = "$base01";
              #                text = "$base05";
              #              };
              #              urgentWorkspace = {
              #                border = "$base08";
              #                background = "$base08";
              #                text = "$base00";
              #              };
              #              bindingMode = {
              #                border = "$base00";
              #                background = "$base0A";
              #                text = "$base00";
              #              };
            };
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.home.homeDirectory}/.config/i3status-rust/config-${barName}.toml";
          }
        ];
      };

      extraConfig = ''
        set $base00 #${colors.base00}
        set $base01 #${colors.base01}
        set $base02 #${colors.base02}
        set $base03 #${colors.base03}
        set $base04 #${colors.base04}
        set $base05 #${colors.base05}
        set $base06 #${colors.base06}
        set $base07 #${colors.base07}
        set $base08 #${colors.base08}
        set $base09 #${colors.base09}
        set $base0A #${colors.base0A}
        set $base0B #${colors.base0B}
        set $base0C #${colors.base0C}
        set $base0D #${colors.base0D}
        set $base0E #${colors.base0E}
        set $base0F #${colors.base0F}

        # Basic color configuration using the Base16 variables for windows and borders.
        # Property Name         Border  BG      Text    Indicator Child Border
        # client.focused          $base05 $base00 $base04 $base0D $base0C
        # client.focused_inactive $base01 $base01 $base05 $base03 $base01
        # client.unfocused        $base01 $base00 $base05 $base01 $base01
        # client.urgent           $base08 $base08 $base00 $base08 $base08
        # client.placeholder      $base00 $base00 $base05 $base00 $base00
        # client.background       $base07
      '';
    };
  };

  home.packages = with pkgs; [
    i3
    i3lock-fancy
    # i3blocks
    dmenu
  ];

  programs.i3status-rust = {
    enable = true;

    bars."${barName}" = {
      theme = "plain";
      icons = "awesome";
      blocks = [
        {
          block = "net";
          device = "wlp0s20f3";
          format = "{ssid} {signal_strength} {ip} {speed_down;K*b} {graph_down;K*b}";
          interval = 5;
        }
        {
          block = "disk_space";
          path = "/";
          alias = "/";
          info_type = "available";
          unit = "GB";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {
          block = "memory";
          display_type = "memory";
          format_mem = "{mem_used_percents}";
          format_swap = "{swap_used_percents}";
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          interval = 1;
          format = "{1m}";
        }
        {
          block = "battery";
          interval = 10;
          format = "{percentage:6#100} {percentage} {time}";
        }
        {
          block = "sound";
        }
        {
          block = "time";
          interval = 60;
          format = "%a %d/%m %R";
        }
      ];
    };
  };
}
