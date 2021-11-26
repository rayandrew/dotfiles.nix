{ config
, lib
, pkgs
, ...
}:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "45a9ff6d0932b0e9835cbeb60b9794ba706eef10";
          sha256 = "pWkEhjbcxXduyKz1mAFo90IuQdX7R8bLCQgb0R+hXs4=";
        };
      }
      {
        name = "fasd";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-fasd";
          rev = "98c4c729780d8bd0a86031db7d51a97d55025cf5";
          sha256 = "8JASaNylXAGnWd2IV88juk73b8eJJlVrpyiRZUwHGFQ=";
        };
      }
    ];

    shellAliases = {
      "g" = "git";
      # "la"  = "ls -a";
      # "lal" = "ls -al";
      "d" = "pu";
      "e" = "emacs -nw";
      "top" = "${pkgs.htop}/bin/htop";
    };

    functions = {
      __fish_command_not_found_handler = {
        body = "__fish_default_command_not_found_handler $argv[1]";
        onEvent = "fish_command_not_found";
      };
      gitignore = "${pkgs.curl}/bin/curl -sL https://www.gitignore.io/api/$argv";
    };

    shellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';

    interactiveShellInit = ''
      fish_add_path ${config.home.homeDirectory}/.npm-global/bin
    '';
  };
}
