{ config, pkgs, ... }:
{
  programs.xmobar.enable = true;

  home.file.".config/xmobar/xmobarrc_main".text = ''
    Config { font = "Hack Mono 14"
           , additionalFonts = ["Symbols Nerd Font Mono 18"]
           , bgColor = "#1e1e2e"
           , fgColor = "#cdd6f4"
           , alpha = 255
           , position = TopH 34
           , lowerOnStart = True
           , pickBroadest = False
           , persistent = True
           , hideOnStart = False
           , allDesktops = False
           , overrideRedirect = True
           , textOutputFormat = Ansi
           , commands = [ Run XPropertyLog "_XMONAD_LOG_1"
                        , Run Date "<fc=#cba6f7>%a %b %e - %H:%M:%S</fc>" "date" 10
                        , Run Alsa "default" "Master"
                              [ "-t", "<status>"
                              , "-S", "On"
                              , "-W", "0", "-f", ""
                              , "--"
                              , "-O", "<fn=1><volumebar></fn> <volume>"
                              , "-o", "<fn=1></fn>"
                              , "-C", "#cdd6f4"
                              , "-c", "#f38ba8"
                              ]
                        , Run Wireless "wlp2s0"
                              [ "-t", "<qualitybar>"
                              , "-L", "1", "-l", "#f38ba8"
                              , "-n", "#a6e3a1", "-h", "#a6e3a1"
                              , "-W", "0", "-f", "󰤭󰤯󰤯󰤟󰤟󰤢󰤢󰤥󰤥󰤨󰤨"
                              ] 50
                        , Run BatteryP ["BAT0"]
                              [ "-t", "<acstatus>"
                              , "-S", "Off", "-d", "0", "-m", "3"
                              , "-L", "10", "-H", "90", "-p", "3"
                              , "-l", "#f38ba8"
                              , "-W", "0", "-f", "󰂎󰁺󰁻󰁼󰁽󰁾󰁿󰂀󰂁󰂂󰁹"
                              , "--"
                              , "-P"
                              , "-i", "<fc=#a6e3a1><fn=1>󰁹</fn> FULL</fc>"
                              , "-O", "<fc=#f9e2af><fn=1><leftbar> 󱐋</fn> <timeleft></fc>"
                              , "-o", "<fn=1><leftbar></fn> <timeleft>"
                              ] 50
                        ]
           , sepChar = "%"
           , alignSep = "}{"
           , template = "<fn=1></fn>  %_XMONAD_LOG_1%}%date%{%alsa:default:Master%  %wlp2s0wi%  %battery%<fn=1>  </fn>"
           }
  '';

  home.file.".config/xmobar/xmobarrc_other".text = ''
    Config { font = "Hack Mono 14"
           , additionalFonts = ["Symbols Nerd Font Mono 16"]
           , bgColor = "#1e1e2e"
           , fgColor = "#cdd6f4"
           , alpha = 255
           , position = TopH 34
           , lowerOnStart = True
           , pickBroadest = False
           , persistent = True
           , hideOnStart = False
           , allDesktops = False
           , overrideRedirect = True
           , textOutputFormat = Ansi
           , commands = [ Run XPropertyLog "_XMONAD_LOG_2"
                        , Run Date "<fc=#cba6f7>%a %b %e - %H:%M:%S</fc>" "date" 10
                        ]
           , sepChar = "%"
           , alignSep = "}{"
           , template = "%_XMONAD_LOG_2%}{%date%"
           }
  '';
}
