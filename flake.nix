{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Lix is just better!!!
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix = {
        url = "git+https://git.lix.systems/lix-project/lix";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    # Emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # Theming
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          inputs.lix-module.nixosModules.default

          ./configuration.nix
          ./hardware-configuration.nix

          inputs.catppuccin.nixosModules.catppuccin

          # Overlay XMonad
          {
            nixpkgs.overlays = [
              (self: super: {
                haskellPackages = super.haskellPackages.override {
                  overrides = hself: hsuper: {
                    xmonad = (hsuper.callHackageDirect {
                      pkg = "xmonad";
                      ver = "0.18.1";
                      sha256 = "sha256-1BZXX32aEDEi0SN4gbZDinX6/iqn8mCTDmh6uUfn83s=";
                    } { }).overrideAttrs (old: {
                      buildInputs = (old.buildInputs or []) ++ [
                        super.libxcursor
                      ];
                    });
                    xmonad-contrib = hsuper.callHackageDirect {
                      pkg = "xmonad-contrib";
                      ver = "0.18.2";
                      sha256 = "sha256-i2hu4L5cFCtgcaumdqa+OxnDSwyQVY06la2bugMa16A=";
                    } { };
                    xmonad-extras = hsuper.callHackageDirect {
                      pkg = "xmonad-extras";
                      ver = "0.17.2";
                      sha256 = "sha256-p1kRvVJwjEjQkG/tUMIUJ+0BLnrAffkWJ0IVjDg0HkY=";
                    } { };
                  };
                };
              })
              (final: prev: { gnome3 = { inherit (final) gnome-themes-extra; }; })              
            ];
          }

          { }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.sophia.imports = [
              ./hm/home.nix
              inputs.catppuccin.homeModules.catppuccin
            ];
          }
        ];
      };
    };
}
