{
    description = "A very basic gleam dev env flake";

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
                # Gleam itself
                pkgs-stable.gleam
                pkgs-stable.vimPlugins.nvim-treesitter-parsers.gleam
                # Erlang and JS targets
                pkgs-stable.erlang_26
                pkgs-stable.rebar3
                pkgs-stable.nodejs
            ];
        };
    };
}
