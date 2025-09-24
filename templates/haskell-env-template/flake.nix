{
    description = "A very basic Haskell dev env flake";

    inputs = {
        core.url = "git+file:///home/shiloh/.config/flakes/core";
    };

    outputs = { self, core }:
    let
        system = "x86_64-linux";
        pkgs-stable = core.packages.${system}.pkgs-stable;
        pkgs-unstable = core.packages.${system}.pkgs-unstable;
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
