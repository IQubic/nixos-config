{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";

    # Emacs
    emacs-overlay.url = "github:nix-community/emacs-overlay";
#    nix-doom-emacs = {
#      url = "github:nix-community/nix-doom-emacs";
#      inputs.nixpkgs.follows = "nixpkgs";
#      inputs.emacs-overlay.follows = "emacs-overlay";
#    };

    # Auto updating Discord overlay
    discord.url = "github:InternetUnexplorer/discord-overlay";    
    discord.inputs.nixpkgs.follows = "nixpkgs";

    # Plover
    plover-flake.url = "path:/etc/nixos/plover-flake"; 
    plover-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: {
    nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        # Overlays from flakes
        { nixpkgs.overlays = [
          inputs.discord.overlay
        ];}

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.avi.imports = [
            ./hm/home.nix

            # HM Modules
            #inputs.nix-doom-emacs.hmModule
            #./hm/emacs/doom-emacs-config-module.nix
          ];
          home-manager.extraSpecialArgs = {
            plover = inputs.plover-flake.packages."x86_64-linux".plover.with-plugins (ps: with ps; [
              plover_python_dictionary
              plover_inflect

              plover_emoji
              plover_number_format
              plover_retro_everything
              plover_retro_surround
              plover_retro_text_transform
              plover-rpn-calculator
              plover_stenobee_extended
              plover-stenotype-extended
              plover_stitching
            ]);
          };
        }
      ];
    };
  };
}
