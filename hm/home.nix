{
  config,
  pkgs,
  ...
}:
let
  snes9x-nwa = pkgs.callPackage ./snes9x-nwa/snes9x-nwa.nix { withGtk = true; };
in
{
  home.username = "sophia";
  home.homeDirectory = "/home/sophia";

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
    cockatrice
    chromium
    dfu-util
    (discord.override {
      withOpenASAR = true;
    })
    ffmpeg
    firefox
    gargoyle
    gimp
    hunspell
    hunspellDicts.en_GB-ise
    libreoffice
    lumafly
    mgba
    pavucontrol
    pcmanfm
    poptracker
    pulseaudio
    racket
    simplescreenrecorder
    sxiv
    vlc
    wineWow64Packages.stagingFull
    winetricks
    xclip
    xdotool
    xwininfo
    xournalpp
    zoom-us
  ] ++ [ snes9x-nwa ];

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
      signing.format = "openpgp";
    };
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = let
      browser  = [ "firefox.desktop" ];
      editor   = [ "emacsclient.desktop" ];
      terminal = [ "alacritty.desktop" ];
      sxiv     = [ "sxiv.desktop" ];
      vlc      = [ "vlc.desktop" ];
    in
    {
      enable = true;
      defaultApplications = {
        "application/json" = editor;
        "application/pdf" = browser;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "audio/flac" = vlc;
        "audio/mpeg" = vlc;
        "audio/x-aiff" = vlc;
        "image/apng" = sxiv;
        "image/avif" = sxiv;
        "image/gif" = sxiv;
        "image/jpeg" = sxiv;
        "image/jpg" = sxiv;
        "image/png" = sxiv;
        "image/svg+xml" = sxiv;
        "image/webp" = sxiv;
        "text/plain" = editor;
        "video/mp4" = vlc;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/terminal" = terminal;
      };
    };
  };

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
