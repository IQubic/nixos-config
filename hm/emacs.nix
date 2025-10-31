# Set-up and initial for Doom Emacs
{ pkgs, config, ... }:
{
  # Enable Emacs and Service
  programs.emacs = {
    enable = true;
  };
  services.emacs.enable = true;

  home.sessionPath = [ "$HOME/.emacs.d/bin" ];

  # Packages required for Doom Emacs
  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
