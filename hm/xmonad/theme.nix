{ config, pkgs, ... }:
{
  catppuccin = {
    flavor = "mocha";
    accent = "sapphire";
  };

  gtk = {
    enable = true;
    theme = { 
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    }; 
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaSapphire;
      name = "catppuccin-mocha-sapphire-cursors";
    };
    cursorTheme.size = 32;

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";    
  };

  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  catppuccin.kvantum = {
    enable = true;
    apply = true;
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaSapphire;
    name = "catppuccin-mocha-sapphire-cursors";
    size = 32;
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
  ];
}
