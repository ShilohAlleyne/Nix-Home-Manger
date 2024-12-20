{
    description = "Shiloh's flake templates";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, ... }: {
        templates = {
            haskell-env = {
                path = ./haskell-env-template;
                description = "A simple haskell dev env";
            };
            gleam-env = {
                path = ./gleam-env-template;
                description = "A simple gleam dev env";
            };
            rust-env = {
                path = ./rust-env-template;
                description = "A simple rust dev env"
            }
        };
    };
}
