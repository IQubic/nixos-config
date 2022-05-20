# Doom Emacs config for
# programming languages
{ config, lib, pkgs, ... }:

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
        { mod = "haskell"; args = [ "lsp" ]; 
        "nix"
      ]
    };

    # Nix config
    modules.iqubic.nix.config.text = ''
      (after! nix-mode
        (add-hook! 'nix-mode-hook #'lsp!))
    '';
  };

  # Packages needed for certain language modes.
  home.packages = [
    # Nix
    rnix-lsp
    nixfmt
  ];
}
