{
  description = "Example of Nix shell";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      localOverlay = import ./nix/overlay.nix;
      overlays = [ localOverlay ];
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system overlays;
          };
        in
        {
          legacyPackages = pkgs;
          inherit (pkgs) devShell;
        }) // {
      overlay = final: prev: (nixpkgs.lib.composeManyExtensions overlays) final prev;
      inherit overlays;
    };
}
