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
    love
    pavucontrol
    plover
    qxw
    sxiv
    tenacity
    vlc
    wine
    zoom-us
  ];

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.doom-emacs.config = {
    initModules = {
      tools = [ "direnv" ];
    };
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
