{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;

    shadow           = false;
    blur             = false;
    activeOpacity    = "1.0";
    inactiveOpacity  = "1.0";
    menuOpacity      = "1.0";
  };
}
