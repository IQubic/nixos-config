{ config, pkgs, ... }:
{
  # Let home-manager create the screenshots directory
  home.file."screenshots/.keep".text = "";

  services.flameshot = {
    enable = true;

    settings = {
      General = {
        contrastOpacity = 188;
        contrastUiColor = "#00a4b0";
        filenamePattern = "%F_%T";
        saveAsFileExtension = "jpeg";
        savePath = "${config.home.homeDirectory}/screenshots";
        savePathFixed = true;
        uiColor = "#00ffde";
        useX11LegacyScreenshot = true;
      };

      Shortcuts = {
        TYPE_MOVE_DOWN = "J";
        TYPE_MOVE_LEFT = "H";
        TYPE_MOVE_RIGHT = "L";
        TYPE_MOVE_UP = "K";
        TYPE_RESIZE_DOWN = "Shift+J";
        TYPE_RESIZE_LEFT = "Shift+H";
        TYPE_RESIZE_RIGHT = "Shift+L";
        TYPE_RESIZE_UP = "Shift+K";
      };
    };
  };
}
