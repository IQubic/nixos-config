{ config, pkgs, ... }:
{
  services.picom = {
    enable           = true;
    shadow           = false;
    activeOpacity    = 1.0;
    inactiveOpacity  = 1.0;
    menuOpacity      = 1.0;
  };
}
