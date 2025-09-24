{
    description = "A very basic gleam dev env flake";

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
