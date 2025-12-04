{
  config,
  pkgs,
  bqnlsp,
  uiua,
  ...
}:
{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia";
  xdg.enable = true;

  imports = [
    ./alacritty.nix
    ./emacs.nix
    ./dunst.nix
    ./flameshot.nix
    ./picom.nix
    ./xmonad/xmonad.nix
    ./zsh.nix
  ];

  # Packages not needed by root
  home.packages = with pkgs; [
    alsa-utils
    arandr
    archipelago
    betterdiscordctl
    bqnlsp
    cbqn-replxx
    cockatrice
    chromium
    dfu-util
    (discord.override {
      withOpenASAR = true;
    })
    emote
    ffmpeg
    firefox
    gimp
    helvum
    hunspell
    hunspellDicts.en_GB-ise
    libreoffice
    lumafly
    mgba
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

  dconf.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sophia Caspe";
        email = "avi.caspe@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
