{
    description = "Shiloh's Home Manager Configuration";

    inputs = {
        core.url = "git+file:///home/shiloh/.config/flakes/core";
        nixpkgs-stable.follows = "core/nixpkgs-stable";
        nixpkgs-unstable.follows = "core/nixpkgs-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };
        decoy.url = "git+file:///home/shiloh/code/rust/decoy";
    };

    outputs = { self, core, nixpkgs-stable, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs-stable = core.packages.${system}.pkgs-stable;
        pkgs-unstable = core.packages.${system}.pkgs-unstable;
    in {
        homeConfigurations."shiloh" = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs-stable;  # Use pkgs-stable as the primary pkgs argument
            modules = [ ./home.nix ./nvim.nix ];
            
            # Pass pkgs-unstable as an extra argument
            extraSpecialArgs = {
                pkgs-unstable = pkgs-unstable;
                decoy = self.inputs.decoy;
                decoyRev = self.inputs.decoy.rev;
            };
        };
        packages.${system} = {
            pkgs-stable = pkgs-stable;
            pkgs-unstable = pkgs-unstable;
        };
    };
}
