{
    description = "A very basic haskell dev env flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs }:
    let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
        devShells."x86_64-linux".default = pkgs.mkShell {
            packages = [
                pkgs.haskellPackages.haskell-language-server
                pkgs.cabal-install # Cabal
                pkgs.haskell.compiler.native-bignum.ghc9121 # GHC
            ];
        };
    };
}
