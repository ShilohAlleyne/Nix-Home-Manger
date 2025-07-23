{
    description = "A very basic fennel dev env flake";

    inputs = {
        nixpkgs-stable.url = "github:NixOS/nixpkgs";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
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
                pkgs-stable.lua54Packages.fennel
                pkgs-stable.lua
                pkgs-stable.fennel-ls
            ];
        };
    };
}

