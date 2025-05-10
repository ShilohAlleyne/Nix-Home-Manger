{
    description = "Home Manager configuration of shiloh with multiple dev environments";

    inputs = {
        # Specify the source of Home Manager and Nixpkgs.
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs-stable = nixpkgs.legacyPackages.${system};
        pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}; # Define unstable globally
        rust-overlay = (import (builtins.fetchTarball {
            url = "https://github.com/oxalica/rust-overlay/archive/master.tar.gz";
            sha256 = "05xyk469bj6zkvkk4gmc58rkiyavamn4xhfglwkdqlanqiyfwdfz";
        }));
        rust-pkgs = (import nixpkgs {
            system = system;
            overlays = [ rust-overlay ];
        });
    in {
        # Define multiple development environments
        devShells.${system} = {

            haskell = pkgs-stable.mkShell {
                packages = [
                    pkgs-stable.haskellPackages.haskell-language-server
                    pkgs-stable.cabal-install
                    pkgs-unstable.haskell.compiler.native-bignum.ghc9121
                    pkgs-stable.zlib
                ];
            };

            gleam = pkgs-stable.mkShell {
                packages = [
                    # Gleam itself
                    pkgs-stable.gleam
                    pkgs-stable.vimPlugins.nvim-treesitter-parsers.gleam
                    # Erlang and JS targets
                    pkgs-stable.erlang_26
                    pkgs-stable.rebar3
                    pkgs-stable.nodejs 
                ];
            };

            rust = rust-pkgs.mkShell {
                buildInputs = [
                    (rust-pkgs.rust-bin.stable.latest.default.override {
                        extensions = ["rust-src"];
                    })
                    rust-pkgs.cargo
                    rust-pkgs.rustup
                ];
                shellHook = ''
                    rustup component add rust-analyzer
                '';
            };

        };

        # Home Manager Configuration
        homeConfigurations."shiloh" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs-stable;
            extraSpecialArgs = { unstable = nixpkgs-unstable.legacyPackages.${system}; }; # Pass unstable
            modules = [ 
                ./home.nix 
                ./nvim.nix 
            ];
        };
    };
}
