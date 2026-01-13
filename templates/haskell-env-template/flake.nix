{
    description = "A very basic Haskell dev env flake";

    inputs = {
        nixpkgs-stable.url   = "github:NixOS/nixpkgs";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        flake-utils.url      = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs-stable   = import nixpkgs-stable   { inherit system; };
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
        in
        {
            devShells.${system}.default = pkgs-stable.mkShell {
                packages = [
                    pkgs-stable.haskellPackages.haskell-language-server
                    pkgs-stable.cabal-install
                    pkgs-unstable.haskell.compiler.ghcHEAD
                    pkgs-stable.zlib
                    pkgs-stable.haskellPackages.hoogle
                    pkgs-stable.stylish-haskell
                ];
            };
        }
    );
}
