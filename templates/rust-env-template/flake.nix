{
    description = "A very basic rust dev env flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self , nixpkgs, nixpkgs-unstable }:
    let
        rust-overlay = (import (builtins.fetchTarball {
            url = "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
            sha256 = "05xyk469bj6zkvkk4gmc58rkiyavamn4xhfglwkdqlanqiyfwdfz";
        }));
        pkgs-stable = (import nixpkgs {
                system = "x86_64-linux";
                overlays = [ rust-overlay ];
        });
        pkgs-unstable = ( import nixpkgs-unstable {
            system = "x86_64-linux";
            overlays = [ rust-overlay ];
        });
    in
    {
        devShells."x86_64-linux".default = pkgs-stable.mkShell {
            buildInputs = [
                (pkgs-stable.rust-bin.stable.latest.default.override {
                    extensions = ["rust-src"];
                })
                pkgs-stable.cargo
                pkgs-stable.rustup
            ];
            shellHook = ''
                rustup component add rust-analyzer
            '';
        };
    };
}

