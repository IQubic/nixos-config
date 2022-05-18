{ config, pkgs, plover, nix-doom-emacs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/avi";

  imports = [
    ./alacritty.nix
    ./emacs/emacs.nix
    ./powercord.nix
    ./dunst.nix
    ./flameshot.nix
    ./picom.nix
    ./xmonad-config/xmonad.nix 
    ./zsh.nix

    nix-doom-emacs.hmModule
  ];

  # Packages not needed by root
  home.packages = with pkgs; [
    firefox-bin
    gimp
    libreoffice
    pavucontrol
    plover
    qxw
    sxiv
    wine
    zoom-us
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.git = {
    enable = true;
    userName = "iqubic";
    userEmail = "avi.caspe@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
