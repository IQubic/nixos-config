{ config, pkgs, ... }:
{
  programs.xmobar.enable = true;

  home.file.".config/xmobar/xmobarrc_main".text = ''
    Config { font = "Hack Mono 14"
           , additionalFonts = ["Symbols Nerd Font Mono 16"]
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
           , allDesktops = False
           , overrideRedirect = True
           , textOutputFormat = Ansi
           , commands = [ Run Date "<fc=#cba6f7>%a %b %e - %H:%M:%S</fc>" "date" 10
                        , Run XPropertyLog "_XMONAD_LOG_1"
                        , Run BatteryP ["BAT0"]
                                       ["-t", "<acstatus>"
                                       , "-S", "Off", "-d", "0", "-m", "3"
                                       , "-L", "10", "-H", "90", "-p", "3"
                                       , "-W", "0"
                                       , "-f", "󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"
                                       , "--"
                                       , "-P"
                                       , "-i", "<fn=1>\xf1e6</fn>"
                                       , "-O", "<fn=1><leftbar>  \xf1e6</fn> <timeleft>"
                                       , "-o", "<fn=1><leftbar></fn> <timeleft>"
                                       , "-l", "#f38ba8" "-h" "#a6e3a1"
                                       , "-H", "10", "-L", "7"
                                       ] 50
                        ]
           , sepChar = "%"
           , alignSep = "}{"
           , template = "<fn=1></fn> %_XMONAD_LOG_1%}%date%{%battery% <fn=1></fn>"
           }
  '';
}
