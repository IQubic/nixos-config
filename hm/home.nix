{ config, pkgs, plover, ... }:

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
    ./xmonad/xmonad.nix 
    ./zsh.nix
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

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

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
