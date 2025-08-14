{ config, pkgs, bqnlsp, uiua, ... }:

{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia";
  xdg.enable = true;
 
  imports = [
#    ./magicTileZip.nix    

    ./alacritty.nix
    ./emacs/emacs.nix
    ./dunst.nix
    ./flameshot.nix
    ./picom.nix
    ./xmonad/xmonad.nix 
    ./zsh.nix 
 ];

  # Packages not needed by root
  home.packages = with pkgs; [
    alsa-utils
    archipelago
    bqnlsp
    cbqn-replxx
    cockatrice
    chromium
    dfu-util
    emote
    ffmpeg
    firefox
    gimp
    helvum
    hunspell
    hunspellDicts.en_GB-ise
    libreoffice
    lumafly
    pavucontrol
    pcmanfm
    picat
    poptracker
    pulseaudio
    racket
    simplescreenrecorder
    sxiv
    tenacity
    uiua
    vesktop
    vlc
    winePackages.stagingFull
    winetricks
    xclip
    xdotool
    xorg.xwininfo
    xournalpp
    zoom-us
  ];

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

#  programs.doom-emacs.config = {
#    initModules = {
#      tools = [ "direnv" ];
#    };
#  };

  dconf.enable = true;  

  programs.git = {
    enable = true;
    userName = "iqubic";
    userEmail = "avi.caspe@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
