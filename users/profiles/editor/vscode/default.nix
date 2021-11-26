{ config
, lib
, pkgs
, ...
}:

{
  programs.vscode = {
    enable = true;
    # package = pkgs.vscodium;

    # userSettings = {
    #   "workbench.startupEditor" = "none";

    #   # theme
    #   "workbench.colorTheme" = "GitHub Dark Default";
    #   "workbench.iconTheme" = "material-icon-theme";

    #   "workbench.editor.enablePreview" = false;

    #   "editor.fontFamily" = "'Ubuntu Mono', 'monospace', monospace, 'Droid Sans Fallback'";
    #   "editor.fontSize" = 20;

    #   "editor.minimap.enabled" = false;

    #   "update.mode" = "none";

    #   # languages
    #   "[nix]" = {
    #     "editor.tabSize" = 2;
    #   };

    #   "[javascript]" = {
    #     "editor.defaultFormatter" = "esbenp.prettier-vscode";
    #     "editor.formatOnSave" = true;
    #   };

    #   "[typescript]" = {
    #     "editor.defaultFormatter" = "esbenp.prettier-vscode";
    #     "editor.formatOnSave" = true;
    #   };

    #   "[typescriptreact]" = {
    #     "editor.defaultFormatter" = "esbenp.prettier-vscode";
    #     "editor.formatOnSave" = true;
    #   };

    #   "typescript.updateImportsOnFileMove.enabled" = "never";

    # "scss.validate": false,
    # "editor.quickSuggestions": {
    #     "strings": true
    # },
    # "editor.autoClosingQuotes": "always",
    # "tailwindCSS.experimental.classRegex": [
    #     "tw`([^`]*)", // tw`...`
    #     "tw=\"([^\"]*)", // <div tw="..." />
    #     "tw={\"([^\"}]*)", // <div tw={"..."} />
    #     "tw\\.\\w+`([^`]*)", // tw.xxx`...`
    #     "tw\\(.*?\\)`([^`]*)" // tw(Component)`...`
    # ],
    # "tailwindCSS.includeLanguages": {
    #   "typescript": "javascript",
    #   "typescriptreact": "javascript"
    # }

    # vim
    # "vim.easymotion" = true;
    # "vim.incsearch" = true;
    # "vim.useSystemClipboard" = true;
    # "vim.useCtrlKeys" = true;
    # "vim.hlsearch" = true;
    # "vim.leader" = "<space>";
    # "vim.handleKeys" = {
    #   "<C-a>" = false;
    #   "<C-f>" = false;
    # };
    # };

    extensions = with pkgs.vscode-extensions; [
      ms-vscode-remote.remote-ssh
      # bbenoist.Nix
      dbaeumer.vscode-eslint
      github.github-vscode-theme
      esbenp.prettier-vscode
      pkief.material-icon-theme
      # vscodevim.vim
    ];
  };
}
