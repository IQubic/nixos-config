# Doom Emacs via:
# https://github.com/haedosa/nix-doom-emacs
{ config, pkgs, ... }:

{
  # Enable Doom-Emacs
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  # Emacs Daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
}
