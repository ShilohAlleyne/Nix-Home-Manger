{
    description = "A very basic haskell dev env flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable }:
    let
        system = "x86_64-linux";
        pkgs-stable = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
        devShells.${system}.default = pkgs-stable.mkShell {
            packages = [
                pkgs-stable.haskellPackages.haskell-language-server
                pkgs-stable.cabal-install # Cabal
                pkgs-unstable.haskell.compiler.native-bignum.ghc9121 # GHC
                pkgs-stable.zlib
            ];
        };
    };
}
