
{
    description = "A very basic fennel dev env flake";

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
        devShells.${system}.default = config-flake.mkShell {
            packages = [
                pkgs-stable.lua54Packages.fennel
                pkgs-stable.lua
                pkgs-stable.fennel-ls
            ];
        };
    };
}

