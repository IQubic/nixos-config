{ config, pkgs, ... }:
{
  programs.xmobar.enable = true;

  home.file.".config/xmobar/xmobarrc_main".text = ''
    Config { font = "Hack Mono 12"
      , additionalFonts = ["Symbols Nerd Font Mono 12"]
      , borderColor = "black"
      , border = FullB
      , bgColor = "#1e1e2e"
      , fgColor = "#cdd6f4"
      , alpha = 255
      , position = TopH 26
      , lowerOnStart = True
      , pickBroadest = False
      , persistent = True
      , hideOnStart = False
      , allDesktops = True
      , overrideRedirect = True
      , textOutputFormat = Ansi
      , commands = [ Run Date "<fc=#cba6f7>%a %b %e - %H:%M:%S</fc>" "date" 10
                 --  , Run Alsa "default" "Master"
                   , Run BatteryP ["BAT0"]
                                  [ "-t", "<acstatus>"
                                  , "-S", "Off", "-d", "0", "-m", "3"
                                  , "-L", "10", "-H", "90", "-p", "3"
                                  , "-W", "0"
                                  , "-f", "\xf008e\xf007a\xf007b\xf007c\xf007d\xf007e\xf007f\xf0080\xf0081\xf0082\xf0079"
                                  , "--"
                                  , "-P"
                                  , "-i", "<fn=1>\xf1e6</fn>"
                                  , "-O", "<fn=1><leftbar>  \xf1e6</fn> <timeleft>"
                                  , "-o", "<fn=1><leftbar></fn> <timeleft>"
                                  , "-l", "#f38ba8" "-h" "#a6e3a1"
                                  , "-H", "10", "-L", "7"
                                  ] 50
                   , Run XPropertyLog "_XMONAD_LOG_1"
                   ]
      , sepChar = "%"
      , alignSep = "}{"
      , template = "<fn=1>\xf313</fn> %_XMONAD_LOG_1%}%date%{%battery% <fn=1>\xf35e</fn>"

  '';
}
