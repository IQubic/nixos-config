# Doom Emacs config for
# programming languages
{ config, pkgs, ... }:

{
  programs.doom-emacs.config = {
    initModules = {
      # General purpose programming tools
      tools = [
        { mod = "debugger"; args = [ "lsp" ]; }
        { mod = "eval"; args = [ "overlay" ]; }
        { mod = "lookup"; args = [ "dictionary" "docsets" ]; }
        { mod = "lsp"; args = [ "peek" ]; }
      ];

      lang = [
        { mod = "haskell"; args = [ "lsp" ]; } 
        "nix"
      ];
    };
    # LSP config
    modules.iqubic.lsp.config.text = ''
      (after! lsp-ui
        (setq lsp-ui-doc-show-with-cursor t))
    '';

    # Nix config
    modules.iqubic.nix.config.text = ''
      (after! nix-mode
        (add-hook! 'nix-mode-hook #'lsp!))
    '';
  };

  # Packages needed for certain language modes.
  home.packages = with pkgs; [
    # Nix
    rnix-lsp
    nixfmt
  ];
}
