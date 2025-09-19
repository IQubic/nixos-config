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
           , allDesktops = False
           , overrideRedirect = True
           , textOutputFormat = Ansi
           , commands = [ Run Date "<fc=#cba6f7>%a %b %e - %H:%M:%S</fc>" "date" 10
                        , Run XPropertyLog "_XMONAD_LOG_1"
                        ]
           , sepChar = "%"
           , alignSep = "}{"
           , template = "<fn=1>\uf313</fn> %_XMONAD_LOG_1%}%date%{%battery% <fn=1>\uf35e</fn>"
           }
  '';
}
