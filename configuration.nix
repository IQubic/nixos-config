{ config, lib, pkgs, ... }:

{
  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["hid-nintendo"];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup networking
  networking.hostName = "LATITUDE-NIXOS"; 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings.LC_MONETARY = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Theme the tty
  catppuccin.flavor = "mocha";
  catppuccin.tty.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    bqn386
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.hack
    nerd-fonts.symbols-only
    hack-font
    hasklig
  ];

  # Core system utils
  environment.systemPackages = with pkgs; [
    acpi
    appimage-run
    fd
    file
    git
    gnutls
    htop
    inxi
    lm_sensors
    lshw
    nixfmt-rfc-style
    pamixer
    pciutils
    ripgrep
    tree
    vim
    wget
    unzip
    usbutils
    xorg.xinit
    xorg.xev
    xorg.xmodmap
    zip
  ];
  nixpkgs.config.allowUnfree = true;

  # Enable Steam  
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Enable Joycond
  services.joycond.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "gtk";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Allow flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes auto-allocate-uids
  '';

  # Enable dconf
  programs.dconf.enable = true;

  # SSH
  services.openssh.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Ignore the power switch being pressed
  services.logind.powerKey = "ignore";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "us";
        options = "caps:escape";
      };    

      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          cursorTheme = {
            package = pkgs.catppuccin-cursors.mochaSapphire;
            name = "catppuccin-mocha-sapphire-cursors";
            size = 32;
          };
        };
      };

      windowManager.session = lib.singleton {
        name = "xsession";
        start = pkgs.writeScript "xsession" ''
          #!${pkgs.runtimeShell}
          if test -f $HOME/.xsession then
            exec ${pkgs.runtimeShell} -c $HOME/.xsession
          else
            echo "No xsession script found"
          fi
        '';
      };
    };

    libinput.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;
    udev.packages = [ pkgs.qmk-udev-rules ];

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
  };
  
  # Graphics Stuff
  hardware.graphics = {
    enable = true;
    enable32Bit = true;    
    extraPackages = [ pkgs.intel-media-driver ];
    extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ] ;
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  # Enable Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable Backlight Control
  programs.light.enable = true;

  systemd.services.upower.enable = true;

  # Users
  users.users.sophia = {
    isNormalUser = true;
    uid = 1000;
    hashedPassword = "$y$j9T$lLex0.YOa5mpogb4DyU6d0$Ykw4hDYtLVotzxxlxySIGzuhGClrTfaZESY2QDU6c.8";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "dialout"
      "systemd-journal"
      "docker"
    ];
  };
  programs.zsh.enable = true;
  # For ZSH auto completion
  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "24.05";
}
