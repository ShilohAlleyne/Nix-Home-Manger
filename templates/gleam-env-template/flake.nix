{
    description = "A very basic gleam dev env flake";

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
            devShells.default = pkgs-stable.mkShell {
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
        }
    );
}
