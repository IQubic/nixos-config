{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup networking
  networking.hostName = "LATITUDE-NIXOS"; 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalization properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    hack-font
  ];

  environment.systemPackages = with pkgs; [
    appimage-run
    git
    tree
    vim
    wget
    zip
  ];
  nixpkgs.config.allowUnfree = true;
  
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Allow flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      layout = "us,gr";
      xkbOptions = "caps:escape,grp:shifts_toggle,grp_led:caps";
 
      libinput.enable = true;

      # See ./hm/xmonad-config/xmonad.nix for additional config
      displayManager.defaultSession = "none+xmonad";
      windowManager.xmonad.enable = true;
    };

    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
  };

  # Enable sound.
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;

  # Users
  users.users.avi = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "dialout"
      "systemd-journal"
    ];
  };

  system.stateVersion = "21.11";
}

