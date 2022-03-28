{ config, pkgs, ... }:
{
  services.picom = {
    enable = true;

    shadow           = false;
    blur             = false;
    active-opacity   = 1;
    inactive-opacity = 1;
    menu-opacity     = 1;
  };
}
