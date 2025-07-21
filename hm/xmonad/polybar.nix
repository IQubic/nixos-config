{ config, pkgs, lib, ... }:
{
   # Don't have systemd start polybar
   systemd.user.services.polybar = lib.mkForce { };

   catppuccin.polybar.enable = true;

   services.polybar = {
    enable = true;

    package = pkgs.polybar.override { pulseSupport = true; };

    config = {
      "bar/main" = {
        bottom = false;

        modules-left = "nixos xworkspaces layout xwindow";
        modules-center = "date";
        modules-right = "audio network battery xmonad";

        fixed-center = true;

        enable-ipc = true;

        tray = "none";

        wm-restack = "bottom";
        enable-struts = true;

        font-0 = "Hack:style=Regular:size=12";
        font-1 = "Symbols Nerd Font Mono:size=14" ;

        background = "\${colors.base}";
        foreground = "\${colors.text}";
        line-size = 3;

        width = "100%";
        height = "26pt";
        padding = 1;
        module-margin = "10px";

        cursor-click = "pointer";
        cursor-scroll = "default";
      };
      "module/nixos" = {
        type = "custom/text";
        format = "<label>";
        format-padding = 0;
        label = "";
      };
      "module/xmonad" = {
        type = "custom/text";
        format = "<label>";
        format-padding = 0;
        label = "";
      };
      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        enable-click = true;
        enable-scroll = true;
        group-by-monitors = false;

        icon-0 = "1;󰎦";
        icon-1 = "2;󰎩";
        icon-2 = "3;󰎬";
        icon-3 = "4;󰎮";
        icon-4 = "5;󰎰";
        icon-5 = "6;󰎵";
        icon-6 = "7;󰎸";
        icon-7 = "8;󰎻";
        icon-8 = "9;󰎾";
        format-padding = 0;

        label-active = "%icon%";
        label-active-foreground = "\${colors.sapphire}";
        label-active-underline = "\${colors.sapphire}";

        label-occupied = "%icon%";
        label-occupied-foreground = "\${colors.text}";

        label-urgent = "%icon%";
        label-urgent-forground = "\${colors.red}";

        label-empty = "";

        label-active-padding = "5px";
        label-urgent-padding = "5px";
        label-occupied-padding = "5px";
        label-empty-padding = 0;
      };
      "module/xwindow" = {
        type = "internal/xwindow";
        format-padding = 0;

        label = "%title:0:40:...%";
      };
      # TODO Figure out how to have an IPC module start blank
      # and then get updated by poly-msg action "#layout.send.<data>"
      "module/layout" = {
        type = "custom/ipc";
      };
      "module/date" = {
        type = "internal/date";

        date = "%a %b %e";
        time = "%H:%M:%S";
        label = "%date% - %time%";
        label-foreground = "\${colors.mauve}";
        label-underline = "\${colors.mauve}";
      };
      "module/audio" = {
        type = "internal/pulseaudio";

        use-ui-max = false;

        format-volume = "<ramp-volume> <label-volume>";
        label-volume = "%percentage%%";
        ramp-volume-0 = ""; 
        ramp-volume-1 = "";
        ramp-volume-2 = "";

        label-muted = "";
        label-muted-foreground = "\${colors.red}";
        label-muted-underline = "\${colors.red}";
      };
      "module/network" = {
        type = "internal/network";

        interface = "wlp2s0";
        interface-type = "wireless";

        interval = 3;

        format-connected = "<ramp-signal>";
        ramp-signal-0 = "󰤯";
        ramp-signal-1 = "󰤟"; 
        ramp-signal-2 = "󰤢";
        ramp-signal-3 = "󰤥";
        ramp-signal-4 = "󰤨";
        format-connected-foreground = "\${colors.green}";
        format-connected-underline = "\${colors.green}";

        format-disconnected = "<label-disconnected>";
        label-disconnected = "󰤭";
        format-disconnected-foreground = "\${colors.red}";
        format-disconnected-underline = "\${colors.red}";
      };
      "module/battery" = {
        type = "internal/battery";

        battery = "BAT0";
        adapter = "AC";
        low-at = 15;

        format-charging = "<ramp-capacity>%{T2}󱐋%{T-} <label-charging>";
        label-charging = "%time%";
        format-charging-foreground = "\${colors.yellow}";
        format-charging-underline = "\${colors.yellow}";

        format-discharging = "<ramp-capacity> <label-discharging>";
        label-discharging = "%time%";
        format-discharging-foreground = "\${colors.text}";

        ramp-capacity-0  = "󰂎";
        ramp-capacity-1  = "󰁺";
        ramp-capacity-2  = "󰁻";
        ramp-capacity-3  = "󰁼";
        ramp-capacity-4  = "󰁽";
        ramp-capacity-5  = "󰁾";
        ramp-capacity-6  = "󰂀";
        ramp-capacity-7  = "󰂀";
        ramp-capacity-8  = "󰂁";
        ramp-capacity-9  = "󰂂";
        ramp-capacity-10 = "󰁹";

        label-full = "󰁹 FULL";
        label-full-foreground = "\${colors.green}";
        label-full-underline = "\${colors.green}";

        label-low = "󱃍 LOW";
        label-low-foreground = "\${colors.red}";
        label-low-underline = "\${colors.red}";

        time-format = "%H:%M";
      };
    };
  };
}
