{
    description = "A very basic Unison development environment flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Correct capitalization of NixOS and the ref format
        unison-nix.url = "github:ceedubs/unison-nix";
    };

    outputs = { self, nixpkgs, unison-nix }:
    let
        system = "x86_64-linux"; # Define the system architecture in one place for consistency
        pkgs = import nixpkgs { inherit system; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [
                unison-nix.packages.${system}.ucm # This brings in Unison Code Manager
            ];
        };
    };
}

