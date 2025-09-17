{
    description = "A very basic Haskell dev env flake";

    inputs = {
        config-flake.url = "git+file:///home/shiloh/.config/home-manager";
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable }:
    let
        system = "x86_64-linux";
        pkgs-stable = import nixpkgs-stable { system = system; };
        pkgs-unstable = import nixpkgs-unstable { system = system; };
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
    };
}
