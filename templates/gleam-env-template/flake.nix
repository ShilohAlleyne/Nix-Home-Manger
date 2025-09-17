{
    description = "A very basic gleam dev env flake";

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
