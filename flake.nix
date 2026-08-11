{
    description = "Shiloh's Home Manager Configuration";

    inputs = {
        nixpkgs.url          = "github:nixos/nixpkgs/nixos-26.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        nixvim-config = {
            url                    = "github:ShilohAlleyne/nvim?ref=nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim-config, ... }:
    let
        system = "x86_64-linux";

        # Initialize the package sets
        pkgs          = import nixpkgs { inherit system; config.allowUnfree = true; };
        pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    in {
        homeConfigurations."shiloh" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
                inherit pkgs-unstable nixvim-config;
            };
            modules = [ ./home.nix ];
        };
    };
}
