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
        };
    };
}
