{
    description = "Shiloh's Home Manager Configuration";

    inputs = {
        nixpkgs-stable.url = "github:NixOS/nixpkgs";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-stable";
        };
        decoy.url = "git+file:///home/shiloh/code/rust/decoy";
    };

    outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs-stable = import nixpkgs-stable { system = system; };
        pkgs-unstable = import nixpkgs-unstable { system = system; };
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
