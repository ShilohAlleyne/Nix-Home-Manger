{ config, pkgs, pkgs-unstable, nixvim-config, ... }:
let
    nvim = nixvim-config.packages.${pkgs.system}.default;
in
{
    # Enanable Flakes
    nix = {
        package = pkgs.nix;
        settings.experimental-features = [ "nix-command" "flakes" ];
    };

    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username              = "shiloh";
    home.homeDirectory         = "/home/shiloh";
    home.extraOutputsToInstall = [ "share" ];

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion       = "24.11"; # Please read the comment before changing.
    fonts.fontconfig.enable = true;
    nix.settings.download-buffer-size = 536870912; # 512 MiB

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
        pkgs.glibc
        pkgs.cairo
        pkgs.glib
        pkgs.zlib
        pkgs.libpng
        pkgs.direnv
        pkgs.nix-direnv
        pkgs.xclip
        pkgs.wsl-open
        pkgs.texliveFull
        (pkgs.hunspell.withDicts (ps: [ pkgs.hunspellDicts.en-gb-ise ]))

        # Git
        pkgs.git
        pkgs.lazygit
        pkgs-unstable.jujutsu

        # Some globals lazyvim depends on
        pkgs.zig
        pkgs.fzf
        pkgs.unzip
        pkgs.glibc
        pkgs.nodejs_24

        # Nix language sever
        pkgs.nil

        # Text Editors
        nvim
        pkgs.tmux

        # fonts
        pkgs.fontconfig
        pkgs.nerd-fonts.terminess-ttf
        pkgs.nerd-fonts.iosevka
        pkgs.source-sans-pro
        pkgs.nerd-fonts.iosevka-term
        (pkgs.iosevka-bin.override { variant = "Aile"; })
        pkgs.nerd-fonts.symbols-only
        pkgs.symbola

        # Email
        pkgs.mu
        pkgs.isync

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
        DICPATH = "$HOME/.nix-profile/share/hunspell";
    };

    # Git
    programs.git = {
        enable   = true;
        settings = {
            user.name  = "ShilohAlleyne";
            user.email = "ShilohAlleyne@gmail.com";
        };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    programs.starship.enable     = true;

    programs.zsh = {
        enable                    = true;
        autosuggestion.enable     = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
            export TERM=xterm-256color

            eval "$(direnv hook zsh)"
            export DIRENV_LOG_FORMAT=""

            export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/tmp/user-$UID}"
            if [ ! -d "$XDG_RUNTIME_DIR" ]; then
                mkdir -p "$XDG_RUNTIME_DIR"
                chmod 700 "$XDG_RUNTIME_DIR"
            fi
        '';
    };

    programs.emacs = {
        enable        = true;
        package       = pkgs.emacs;
        extraPackages = epkgs: [
            epkgs.vterm
            epkgs.pdf-tools
            epkgs.typst-ts-mode
            epkgs.mu4e
        ];
    };
}
