{ config, pkgs, ... }:
{
  home.packages = [ pkgs.dunst pkgs.libnotify ];
 
  catppuccin.dunst.enable = true;

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "none";
        
        # Position and Size
        width = 200;
        height = 300;
        origin = "top-right";
        offset = "15x20";
        scale = 0;

        # Show all notifications
        notification_limit = 0;

        # Progress bar config
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;

        # List number of hidden alerts
        indicate_hidden = true;

        # No transparency
        transparency = 0;

        # Separator between messages
        separator_height = 2;

        # Padding
        padding = 6;
        horizontal_padding = 6;
        text_icon_padding = 0;
        
        # Frame options
        frame_width = 3;
        separator_color = "frame";

        # Sort messages by urgency
        sort = true;

        # No idle_threshold
        idle_threshold = 0;

        # Font
        font = "Iosevka Term 14";
        
        # Spacing between lines of text
        line_height = 3;
        
        # Markup options
        markup = "full";
        format = "<b>%s</b>\\n%b";

        # Text alignment
        alignment = "left";
        vertical_alignment = "center"; 

        # Show message age if older than 5 minutes
        show_age_threshold = 300;

        # Put ellipsis at the end of long lines
        ellipsize = "end";

        # Parse '\n' in notifications
        ignore_newline = false;

        # Hide duplicate notification count
        hide_duplicate_count = true;

        # Don't display indicators for URLs (U) and actions (A).
        show_indicators = false;

        # Enable word wrap
        word_wrap = false;

        # No icons
        icon_position = "off";

        # Never time out a message from history
        sticky_history = true;

        # Keep last few messages in history
        history_length = 15;

        # EWMH Properties
        title = "dunst";
        class = "dunst";

        # No rounded corners
        corner_radius = 0;

        # Don't listen to the dbus closeNotification message
        # Prevents other applications from closing notifications early
        ignore_dbusclose = true;

        # Ignore mouse clicks
        mouse_left_click   = "none";
        mouse_middle_click = "none";
        mouse_right_click  = "none";
      };
      flameshot_ignore = {
        appname = "flameshot";
        skip_display = true;
        history_ignore = true;
      };
    };  
  };
}
