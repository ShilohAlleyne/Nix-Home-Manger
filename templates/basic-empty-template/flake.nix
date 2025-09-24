{
    description = "A empty dev env flake";

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
                # Empty
            ];
        };
    };
}


