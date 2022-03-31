{ config, pkgs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/avi";

  imports = [
    ./alacritty.nix
    ./plover/plover.nix
    ./powercord.nix
    ./dunst.nix
#   ./firefox.nix
    ./flameshot.nix
    ./picom.nix
    ./xmonad-config/xmonad.nix 
    ./zsh.nix
  ];

  # Packages not needed by root
  home.packages = with pkgs; [
    firefox-bin
    gimp
    pavucontrol
    wine
    zoom-us
  ];

  programs.git = {
    enable = true;
    userName = "iqubic";
    userEmail = "avi.caspe@gmail.com";
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
