{
    description = "A very basic rust dev env flake";

    inputs = {
        core.url = "git+file:///home/shiloh/.config/flakes/core";
        rust-overlay.url = "github:oxalica/rust-overlay";
        rust-overlay.inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    outputs = { self, core, rust-overlay }:
    let
        system = "x86_64-linux";

        pkgs-stable = import core.packages.${system}.pkgs-stable {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
        };

        pkgs-unstable = import core.packages.${system}.pkgs-unstable {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
        };
    in {
        devShells.${system}.default = pkgs-stable.mkShell {
            buildInputs = [
                (pkgs-stable.rust-bin.stable.latest.default.override {
                    extensions = [ "rust-src" ];
                })
                pkgs-stable.cargo
                pkgs-stable.rustup
                pkgs-stable.rust-analyzer
            ];
            shellHook = ''
                export PATH="${pkgs-stable.rust-analyzer}/bin:$PATH"
                echo "Using rust-analyzer from Nixpkgs: $(which rust-analyzer)"
            '';
        };
    };
}
