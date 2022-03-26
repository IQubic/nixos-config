{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.discord-plugged
#    pkgs.discord-plugged.override {
#      themes = [ ];
#      plugins = [ ];
#    }
  ];
}
