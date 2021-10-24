{ config, pkgs, lib, ... }: {
  programs = {
    nano.syntaxHighlight = true;
  };

  environment = {
    systemPackages = with pkgs; [
      # utilities packages
      killall
      git
      lm_sensors

      unzip
      tmux
      bash-completion
      htop

      nano
      vim
      wget
      google-chrome

      notify-osd
      libnotify

      nix-index
      nix-zsh-completions
    ];
  };

  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
