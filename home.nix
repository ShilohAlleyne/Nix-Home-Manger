{ config, pkgs, decoy, pkgs-unstable, ... }:
{
    # Enanable Flakes
    nix = {
        package = pkgs.nix;
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
        pkgs.starship
        pkgs.zsh
        pkgs.zsh-autosuggestions
        pkgs.zsh-syntax-highlighting
        pkgs.ripgrep
        pkgs.fd
        pkgs.yazi

        # My rust command cli
        (pkgs.rustPlatform.buildRustPackage {
            pname = "commie";
            version = "0.1.0";
            src = pkgs.fetchFromGitHub {
                owner = "ShilohAlleyne";
                repo = "commie";
                rev = "11f82ede0d9661f1a661a3aac6ebbd0c1621f553";
                sha256 = "sha256-Cui+TeAAE8t6x5rb4abvq81BcgSAwS1Sa7G/WQbQuh4="; # placeholder
            };
            cargoLock.lockFile = pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/ShilohAlleyne/commie/11f82ede0d9661f1a661a3aac6ebbd0c1621f553/Cargo.lock";
                sha256 = "sha256-yM6EzXmGHg/oNielEbgwjYdF1/kGleUaffYRz088qcA="; # placeholder
            };
        })

        # Decoy
        (pkgs.rustPlatform.buildRustPackage {
            pname = "decoy";
            version = "0.1.0";

            src = pkgs.lib.cleanSource decoy;
            cargoLock.lockFile = "${decoy}/Cargo.lock";

            # Optional: if you use vendored dependencies
            # cargoSha256 = pkgs.lib.fakeSha256;
        })


        # Git
        pkgs.git
        pkgs.lazygit
        pkgs.jujutsu
        pkgs.neofetch

        # Some globals lazyvim depends on
        pkgs.zig
        pkgs.fzf
        pkgs.python3
        pkgs.python3Packages.pip
        pkgs.unzip
        pkgs.glibc
        pkgs.nodejs_24

        # Nix language sever
        pkgs.nil

        # Text Editors
        pkgs.helix
        pkgs.emacs
        pkgs.tmux

        # fonts
        pkgs.fontconfig
        pkgs.nerd-fonts.terminess-ttf
        pkgs.source-sans-pro

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
    programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
    };
}
