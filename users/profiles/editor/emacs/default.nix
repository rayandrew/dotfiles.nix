{ config
, lib
, nixos
, inputs
, pkgs
, ...
}:


# Config is taken from @rycee
# https://gitlab.com/rycee/configurations/-/blob/master/user/emacs.nix
{
  # imports = [
  #   nur-no-pkgs.repos.rycee.hmModules.emacs-init
  #   nur-no-pkgs.repos.rycee.hmModules.emacs-notmuch
  # ];

  imports = [
    inputs.nix-doom-emacs.hmModule
  ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = self: super: {
      magit-delta = super.magit-delta.overrideAttrs (esuper: {
        buildInputs = esuper.buildInputs ++ [ pkgs.git ];
      });
    };
  };

  # programs.emacs = {
  #   enable = true;
  #   init = {
  #     enable = true;
  #     packageQuickstart = false;
  #     recommendedGcSettings = true;
  #     usePackageVerbose = false;

  #     earlyInit = ''
  #       ;; Disable some GUI distractions. We set these manually to avoid starting
  #       ;; the corresponding minor modes.
  #       (push '(menu-bar-lines . 0) default-frame-alist)
  #       (push '(tool-bar-lines . nil) default-frame-alist)
  #       (push '(vertical-scroll-bars . nil) default-frame-alist)

  #       ;; Set up fonts early.
  #       (set-face-attribute 'default
  #                           nil
  #                           :height 140
  #                           :family "Ubuntu Mono")
  #       (set-face-attribute 'variable-pitch
  #                           nil
  #                           :family "DejaVu Sans")

  #       ;; Configure color theme and modeline in early init to avoid flashing
  #       ;; during start.
  #       (require 'base16-theme)
  #       (load-theme 'base16-tomorrow-night t)

  #       (require 'doom-modeline)
  #       (setq doom-modeline-buffer-file-name-style 'truncate-except-project)
  #       (doom-modeline-mode)
  #     '';

  #     prelude = ''
  #       ;; Disable startup message.
  #       (setq inhibit-startup-screen t
  #             inhibit-startup-echo-area-message (user-login-name))

  #       (setq initial-major-mode 'fundamental-mode
  #             initial-scratch-message nil)

  #       ;; Don't blink the cursor.
  #       (setq blink-cursor-mode nil)

  #       ;; Set frame title.
  #       (setq frame-title-format
  #             '("" invocation-name ": "(:eval
  #                                       (if (buffer-file-name)
  #                                           (abbreviate-file-name (buffer-file-name))
  #                                         "%b"))))

  #       ;; Make sure the mouse cursor is visible at all times.
  #       (set-face-background 'mouse "#ffffff")

  #       ;; Accept 'y' and 'n' rather than 'yes' and 'no'.
  #       (defalias 'yes-or-no-p 'y-or-n-p)

  #       ;; Don't want to move based on visual line.
  #       (setq line-move-visual nil)

  #       ;; Stop creating backup and autosave files.
  #       (setq make-backup-files nil
  #             auto-save-default nil)

  #       ;; Default is 4k, which is too low for LSP.
  #       (setq read-process-output-max (* 1024 1024))

  #       ;; Always show line and column number in the mode line.
  #       (line-number-mode)
  #       (column-number-mode)

  #       ;; Enable some features that are disabled by default.
  #       (put 'narrow-to-region 'disabled nil)

  #       ;; Typically, I only want spaces when pressing the TAB key. I also
  #       ;; want 4 of them.
  #       (setq-default indent-tabs-mode nil
  #                     tab-width 4
  #                     c-basic-offset 4)

  #       ;; Trailing white space are banned!
  #       (setq-default show-trailing-whitespace t)

  #       ;; Use one space to end sentences.
  #       (setq sentence-end-double-space nil)

  #       ;; I typically want to use UTF-8.
  #       (prefer-coding-system 'utf-8)

  #       ;; Nicer handling of regions.
  #       (transient-mark-mode 1)

  #       ;; Make moving cursor past bottom only scroll a single line rather
  #       ;; than half a page.
  #       (setq scroll-step 1
  #             scroll-conservatively 5)

  #       ;; Enable highlighting of current line.
  #       (global-hl-line-mode 1)

  #       ;; Improved handling of clipboard in GNU/Linux and otherwise.
  #       (setq select-enable-clipboard t
  #             select-enable-primary t
  #             save-interprogram-paste-before-kill t)

  #       ;; Pasting with middle click should insert at point, not where the
  #       ;; click happened.
  #       (setq mouse-yank-at-point t)

  #       ;; Enable a few useful commands that are initially disabled.
  #       (put 'upcase-region 'disabled nil)
  #       (put 'downcase-region 'disabled nil)

  #       ;; (setq custom-file (locate-user-emacs-file "custom.el"))
  #       ;; (load custom-file)

  #       ;; When finding file in non-existing directory, offer to create the
  #       ;; parent directory.
  #       (defun with-buffer-name-prompt-and-make-subdirs ()
  #         (let ((parent-directory (file-name-directory buffer-file-name)))
  #           (when (and (not (file-exists-p parent-directory))
  #                       (y-or-n-p (format "Directory `%s' does not exist! Create it? " parent-directory)))
  #             (make-directory parent-directory t))))

  #       (add-to-list 'find-file-not-found-functions #'with-buffer-name-prompt-and-make-subdirs)

  #       ;; Don't want to complete .hi files.
  #       (add-to-list 'completion-ignored-extensions ".hi")

  #       (defun rah-disable-trailing-whitespace-mode ()
  #         (setq show-trailing-whitespace nil))

  #       ;; Shouldn't highlight trailing spaces in terminal mode.
  #       (add-hook 'term-mode #'rah-disable-trailing-whitespace-mode)
  #       (add-hook 'term-mode-hook #'rah-disable-trailing-whitespace-mode)

  #       ;; Ignore trailing white space in compilation mode.
  #       (add-hook 'compilation-mode-hook #'rah-disable-trailing-whitespace-mode)

  #       (defun rah-prog-mode-setup ()
  #         ;; Use a bit wider fill column width in programming modes
  #         ;; since we often work with indentation to start with.
  #         (setq fill-column 80))

  #       (add-hook 'prog-mode-hook #'rah-prog-mode-setup)

  #       (defun rah-lsp ()
  #         (interactive)
  #         (envrc-mode)
  #         (lsp))

  #       ;(defun rah-sort-lines-ignore-case ()
  #       ;  (interactive)
  #       ;  (let ((sort-fold-case t))
  #       ;    (call-interactively 'sort-lines)))
  #     '';

  #     usePackage = {
  #       base16-theme = {
  #         enable = true;
  #         extraConfig = ":disabled";
  #       };

  #       doom-modeline = {
  #         enable = true;
  #         extraConfig = ":disabled";
  #       };

  #       nix-mode = {
  #         enable = true;
  #         hook = [ "(nix-mode . subword-mode)" ];
  #       };

  #       # Use ripgrep for fast text search in projects. I usually use
  #       # this through Projectile.
  #       ripgrep = {
  #         enable = true;
  #         command = [ "ripgrep-regexp" ];
  #       };
  #     };
  #   };
  # };
}
