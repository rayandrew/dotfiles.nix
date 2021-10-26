{ config
, lib
, nixpkgs
, nur
, ...
}:


let
  a = { };
  #nur-no-pkgs = import nur {
  # nurpkgs = import nixpkgs { system = "x86_64-linux"; };
  #};
in
{
  imports = [
    #nur-no-pkgs.repos.rycee.hmModules.emacs-init
    #nur-no-pkgs.repos.rycee.hmModules.emacs-notmuch
  ];

  programs.emacs = {
    enable = true;
    init = {
      enable = true;
      packageQuickstart = false;
      recommendedGcSettings = true;
      usePackageVerbose = false;

      earlyInit = ''
        ;; Disable some GUI distractions. We set these manually to avoid starting
        ;; the corresponding minor modes.
        (push '(menu-bar-lines . 0) default-frame-alist)
        (push '(tool-bar-lines . nil) default-frame-alist)
        (push '(vertical-scroll-bars . nil) default-frame-alist)

        ;; Set up fonts early.
        (set-face-attribute 'default
                            nil
                            :height 80
                            :family "Fantasque Sans Mono")
        (set-face-attribute 'variable-pitch
                            nil
                            :family "DejaVu Sans")

        ;; Configure color theme and modeline in early init to avoid flashing
        ;; during start.
        (require 'base16-theme)
        (load-theme 'base16-tomorrow-night t)

        (require 'doom-modeline)
        (setq doom-modeline-buffer-file-name-style 'truncate-except-project)
        (doom-modeline-mode)
      '';
    };
  };
}
