# Set-up and initial for Doom Emacs
{ pkgs, config, ... }:
{
  # Enable Emacs and Service
  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; ([
        tree-sitter-langs
        (treesit-grammars.with-grammars (p: [
          p.tree-sitter-haskell
          p.tree-sitter-nix
        ]))
      ]);
  };
  services.emacs.enable = true;

  # Add Doom executable to the path
  home.sessionPath = [ "$HOME/.emacs.d/bin" ];

  # Packages required for Doom Emacs
  home.packages = with pkgs; [
    fd
    ripgrep
    tree-sitter
  ];
}
