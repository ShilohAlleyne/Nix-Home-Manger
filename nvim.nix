
{ config, pkgs-stable, pkgs-unstable, ... }:

{
    programs.neovim = {
        enable = true;
        package = pkgs-unstable.neovim-unwrapped; # Use the latest unstable version
        viAlias = true;
        vimAlias = true;
        plugins = [
            pkgs-unstable.vimPlugins.nvim-treesitter-parsers.latex
        ]; 
    };
}
