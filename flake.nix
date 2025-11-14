{
    description = "Shiloh's Home Manager Configuration";

    inputs = {
        core.url                 = "git+file:///home/shiloh/.config/flakes/core";
        nixpkgs-stable.follows   = "core/nixpkgs-stable";
        nixpkgs-unstable.follows = "core/nixpkgs-unstable";

        nixvim-config.url                    = "github:ShilohAlleyne/nvim?ref=nixvim";
        nixvim-config.inputs.nixpkgs.follows = "nixpkgs-stable";

        home-manager = {
            url                    = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };
    };

    outputs = { self, core, nixpkgs-stable, nixpkgs-unstable, home-manager, nixvim-config, ... }:
    let
        system        = "x86_64-linux";
        pkgs-stable   = core.packages.${system}.pkgs-stable;
        pkgs-unstable = core.packages.${system}.pkgs-unstable;
    in {
        homeConfigurations."shiloh" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs-stable;  # Use pkgs-stable as the primary pkgs argument
            extraSpecialArgs = {
                inherit pkgs-unstable;
		inherit nixvim-config;
            };
            modules = [
	    	./home.nix
	    ];
        };
        packages.${system} = {
            pkgs-stable   = pkgs-stable;
            pkgs-unstable = pkgs-unstable;
        };
    };
}
