{ config, pkgs, ... }:
{
  # Let home-manager create the screenshots directory
  home.file."screenshots/.keep".text = "";

  services.flameshot = {
    enable = true;

    settings = {
      General = {
        buttons="@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\xf\0\0\0\0\0\0\0\x1\0\0\0\x2\0\0\0\x3\0\0\0\x4\0\0\0\x5\0\0\0\x6\0\0\0\x13\0\0\0\b\0\0\0\t\0\0\0\x10\0\0\0\n\0\0\0\v\0\0\0\x17\0\0\0\f)";
        contrastOpacity=188;
        contrastUiColor="#00a4b0";
        filenamePattern="%F_%T";
        saveAsFileExtension="jpeg";
        savePath="${config.home.homeDirectory}/screenshots";
        savePathFixed=true;
        uiColor="#00ffde";
      };

      Shortcuts = {
        TYPE_MOVE_DOWN="J";
        TYPE_MOVE_LEFT="H";
        TYPE_MOVE_RIGHT="L";
        TYPE_MOVE_UP="K";
        TYPE_RESIZE_DOWN="Shift+J";
        TYPE_RESIZE_LEFT="Shift+H";
        TYPE_RESIZE_RIGHT="Shift+L";
        TYPE_RESIZE_UP="Shift+K";
      };
    };
  };
}
