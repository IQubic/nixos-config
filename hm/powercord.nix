inputs @ { config, pkgs, ... }:
{
  home.packages = [
    pkgs.discord-plugged.override {
      themes = [
      ];
      plugins = [
      ];
}    
