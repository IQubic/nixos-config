{ config, pkgs, ... }: 
{
  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      
      # Allow nightly contrib flake to work
      enableContribAndExtras = false;
      extraPackages = hp: [ hp.xmonad-contrib ];

      config = ./xmonad.hs;
    };
  };
}
