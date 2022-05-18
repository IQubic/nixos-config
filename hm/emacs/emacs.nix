# Doom Emacs via:
# https://github.com/haedosa/nix-doom-emacs

{ config, pkgs, ... }:

imports = [ nix-doom-emacs.hmModule ];

# Enable Doom-Emacs
programs.doom-emacs = {
  enable = true;
  doomPrivateDir = ./doom.d;
};

# Emacs Daemon
services.emacs = {
  enable = true;
  package = programs.emacs.package;
}
