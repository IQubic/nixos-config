{ nixpkgs, flake-inputs, ...}:

let
  pkgs = flake-inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in

{
  environment.systemPackages = with pkgs; [
    # Force better `use nix`/`use flake` for `direnv`
    (nix-direnv.override { enableFlakes = true; })
  ];

  # Links `nix-direnv`'s code to `/run/current-system` 
  # so it can be easily referenced
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
