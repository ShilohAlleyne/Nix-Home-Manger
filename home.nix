{ config, pkgs-stable, pkgs-unstable, ... }:
{
    # Enanable Flakes
    nix = {
        package = pkgs-stable.nix;
        settings.experimental-features = [ "nix-command" "flakes" ];
    };

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "shiloh";
    home.homeDirectory = "/home/shiloh";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        # pkgs.hello
        
        # General
        pkgs-stable.starship
        pkgs-stable.ripgrep
        pkgs-stable.fd

        # Git
        pkgs-stable.git
        pkgs-stable.lazygit
        pkgs-stable.neofetch

        # Some globals lazyvim depends on
        pkgs-stable.zig
        pkgs-stable.fzf
        pkgs-stable.python3
        pkgs-stable.python3Packages.pip
        pkgs-stable.unzip

        # Nix language sever
        pkgs-stable.nil

        # Text Editors
        pkgs-stable.helix
        pkgs-stable.emacs
        pkgs-stable.tmux

        # fonts
        pkgs-stable.fontconfig
        pkgs-stable.nerd-fonts.terminess-ttf
        pkgs-stable.source-sans-pro

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
        # "./.config/nvim" = {
        #     source = "${config.home.homeDirectory}/.nixpkgs/nvim"; 
        #     recursive = true;
        # };
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/shiloh/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        EDITOR = "nvim";
    };

    # Git
    programs.git = {
        enable = true;
        userName = "ShilohAlleyne";
        userEmail = "ShilohAlleyne@gmail.com";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    programs.starship.enable = true;

    programs.bash.enable = true;
    programs.bash.initExtra = ''
        devshell() {
            if [ -z "$1" ]; then
                echo "Usage: devshell {haskell|gleam|rust}"
                return 1
            fi

            case "$1" in
                haskell)
                    env="tpls#haskell-env"
                    ;;
                gleam)
                    env="tpls#gleam-env"
                    ;;
                rust)
                    env="tpls#rust-env"
                    ;;
                *)
                    echo "Invalid option: $1"
                    echo "Usage: devshell {haskell|gleam|rust}"
                    return 1
                    ;;
            esac

            # Check if flake.nix exists
            if [ ! -f flake.nix ]; then
                echo "No flake found. Initializing with $env..."
                nix flake init -t "$env"
            else
                echo "flake.nix already exists, skipping initialization..."
            fi

            nix develop
        }
    '';
}
