{ config, pkgs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/avi";

  imports = [
#   ./alacritty.nix
#   ./dunst.nix
#   ./flameshot.nix
#   ./picom.nix
    ./xmonad/xmonad.nix 
#   ./zsh.nix
  ];

  programs.git = {
    enable = true;
    userName = "iqubic";
    userEmail = "avi.caspe@gmail.com";
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
