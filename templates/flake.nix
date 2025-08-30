{
    description = "Shiloh's flake templates";

    inputs = {
        nixpkgs-stable.url = "github:NixOS/nixpkgs";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    };


    outputs = { self, ... }: {
        templates = {
            empty = {
                path = ./basic-empty-template;
                description = "An empty dev flake";
            };
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
                description = "A simple rust dev env";
            };
            unison-env = {
                path = ./unison-env-template;
                description = "A simple unsion dev env";
            };
            scala-env = {
                path = ./scala-env-template;
                description = "A simple scala dev env";
            };
            fennel-env = {
                path = ./fennel-env-template;
                description = "A simple fennel dev env";
            };
        };
    };
}
