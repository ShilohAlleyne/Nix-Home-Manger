{
    description = "A very basic rust dev env flake";

    inputs = {
        config-flake.url = "git+file:///home/shiloh/.config/home-manager";
        rust-overlay.url = "github:oxalica/rust-overlay";
        rust-overlay.inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    outputs = { self, config-flake, rust-overlay }:
    let
        system = "x86_64-linux";

        pkgs-stable = import config-flake.packages.${system}.pkgs-stable {
            inherit system;
            overlays = [ rust-overlay.overlays.default ];
        };

        pkgs-unstable = import config-flake.packages.${system}.pkgs-unstable {
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
