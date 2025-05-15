{
    description = "Home Manager configuration of shiloh";

    inputs = {
        nixpkgs-stable.url = "github:NixOS/nixpkgs";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager }:
    let
        system = "x86_64-linux";
        pkgs-stable = import nixpkgs-stable { system = system; };
        pkgs-unstable = import nixpkgs-unstable { system = system; };
    in {
        homeConfigurations."shiloh" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs-stable;
            inherit pkgs-unstable;

            modules = [ ./home.nix ./nvim.nix ];

            # Pass pkgs-unstable to home.nix
            extraSpecialArgs = { };
        };
    };
}
