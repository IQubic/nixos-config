{ config, pkgs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/avi";

  imports = [
    ./alacritty.nix
    ./powercord.nix
    ./dunst.nix
#   ./firefox.nix
#   ./flameshot.nix
#   ./picom.nix
    ./xmonad-config/xmonad.nix 
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
