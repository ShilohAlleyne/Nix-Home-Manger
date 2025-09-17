{
    description = "A very basic Haskell dev env flake";

    inputs = {
        config-flake.url = "git+file:///home/shiloh/.config/home-manager";
    };

    outputs = { self, config-flake }:
    let
        system = "x86_64-linux";
        pkgs-stable = config-flake.packages.${system}.pkgs-stable;
        pkgs-unstable = config-flake.packages.${system}.pkgs-unstable;
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
