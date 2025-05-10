{ config, pkgs, unstable, ... }:

{
    programs.neovim = {
        enable = true;
        package = unstable.neovim-unwrapped; # Use the latest unstable version
        viAlias = true;
        vimAlias = true;
    };
}
