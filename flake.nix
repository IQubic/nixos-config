{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";

    # Lix is just better!!!
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # BQN
    bqnlsp.url = "sourcehut:~detegr/bqnlsp";
    bqnlsp.inputs.nixpkgs.follows = "nixpkgs";

    #Uiua
    uiua.url = "github:uiua-lang/uiua";
    uiua.inputs.nixpkgs.follows = "nixpkgs";

    # Theming
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ { nixpkgs, home-manager, bqnlsp, uiua, ... }: {
    nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      modules = [
        inputs.lix-module.nixosModules.default

        ./configuration.nix
        ./hardware-configuration.nix

        inputs.catppuccin.nixosModules.catppuccin

        # Overlay XMonad
        { nixpkgs.overlays = [
            (self: super: {
              haskellPackages = super.haskellPackages.override {
                overrides = hself: hsuper: {
                  xmonad = hsuper.callHackageDirect {
                    pkg = "xmonad";
                    ver = "0.18.0";
                    sha256 = "sha256-2Puz25XGjQVj74Am4QpihWrldDKFHtiQvoqCZ+xosl4=";
                  } {};
                  xmonad-contrib = hsuper.callHackageDirect {
                    pkg = "xmonad-contrib";
                    ver = "0.18.1";
                    sha256 = "sha256-3N85ThXu3dhjWNAKNXtJ8rV04n6R+/rGeq5C7fMOefY=";
                  } {};        
                  xmonad-extras = hsuper.callHackageDirect { 
                    pkg = "xmonad-extras";
                    ver = "0.17.2";
                    sha256 = "sha256-p1kRvVJwjEjQkG/tUMIUJ+0BLnrAffkWJ0IVjDg0HkY=";
                  } {};
                };
              };
            })
          ];
        }
        
        # Add Uiua fonts
        { fonts.packages = [ uiua.packages.${system}.fonts ]; }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = { 
            inherit inputs; 
            bqnlsp = bqnlsp.packages.${system}.lsp;
            uiua = uiua.packages.${system}.default;
          };

          home-manager.users.sophia.imports = [
            ./hm/home.nix
            inputs.catppuccin.homeModules.catppuccin
          ];
        }
      ];
    };
  };
}
