{ config, pkgs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/${home.username}";

#  imports = [
#   ./alacritty
#   ./dunst
#   ./flameshot
#   ./picom 
#   ./zsh
#  ]

  programs.git = {
    enable = true;
    userName = "iqubic"
    userEmail = "avi.caspe@gmail.com"
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
