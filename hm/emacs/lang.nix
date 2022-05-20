# Doom Emacs config for different 
# programming languages
{ config, lib, pkgs, ... }:

{
  programs.doom-emacs.config = {
    initModules = {
      # General programming tools
      tools = [
        { mod = "debugger"; args = [ "lsp" ]; }
        { mod = "eval"; args = [ "overlay" ]; }
        { mod = "lookup"; args = [ "dictionary" "docsets" ]; }
        { mod = "lsp"; args = [ "peek" ]; }
      ];

      lang = [
        { mod = "haskell"; args = [ "lsp" ]; 
        "nix"
      ]
    };

    modules.dwarfmaster.nix.config.text = ''
      ;; nix
      (after! nix-mode
        (add-hook! 'nix-mode-hook #'lsp!))
    '';
  };

  # Packages needed for certain language modes.
  home.packages = [
    # nix
    rnix-lsp
    nixfmt
  ];
}
