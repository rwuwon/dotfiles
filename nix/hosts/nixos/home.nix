{ config, pkgs, ... }:

{
  home.username = "io";
  home.homeDirectory = "/home/io";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager

    # archives
    #zip
    #xz
    #unzip
    #p7zip

    # utils
    #ripgrep # recursively searches directories for a regex pattern
    #jq # A lightweight and flexible command-line JSON processor
    #yq-go # yaml processor https://github.com/mikefarah/yq
    #eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    grc

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    bat
    cowsay
    cpufetch
    emoji-picker
    fastfetch
    file
    #gawk
    gdu
    gnupg
    #gnused
    #gnutar
    jq
    tree
    wget
    which
    zstd

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    #hugo # static site generator
    glow # markdown previewer in terminal

    atop
    btop  # htop/bmon alternative
    htop
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # terminal emulators
    ghostty
    kitty
    alacritty
    viu

    # vnc
    wayvnc

    #weechat
    #neovim
    #cyberchef # offline instance of cyberchef
  ];

  # basic configuration of git, please change to your own
  #programs.git.settings = {
  #  enable = true;
  #  username = "io";
  #  useremail = "<>";
  #};
  programs.git = {
    enable = true;
    settings.user = {
      name  = "io";
      email = "<io@nixos>";
    };
    settings.init.defaultBranch = "main";
    ignores = [
      "*~"
      "**/*~"
      "**/*.bak"
      "**/*.sw[abcdefghijklmnop]"
      ];
  };

  # starship - an customizable prompt for any shell
  #programs.starship = {
  #  enable = true;
  #  # custom settings
  #  settings = {
  #    add_newline = false;
  #    aws.disabled = true;
  #    gcloud.disabled = true;
  #    line_break.disabled = true;
  #  };
  #};

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 10;
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  programs.tmux = {
  enable = true;
  clock24 = true;
  # used for less common options, intelligently combines if defined in multiple places.
  extraConfig = ''
  # The next line is why the config is here and not sourced from dotfiles:
  #set-option -g default-shell /home/io/.nix-profile/bin/fish
  set-option -g prefix2 C-Space
  setw -g mode-keys vi
  set -g display-time 0
  set -g history-limit 99999
  set -g mouse on
  bind -n S-PPage copy-mode -ue
  bind-key a set mouse
  bind-key j set mouse
  bind-key ` attach -d
  set -g base-index 1
  setw -g pane-base-index 1
  set-option -g renumber-windows on
  '';
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile vim/vimrc;

    plugins = with pkgs.vimPlugins; [
      fzf-vim
      nerdtree
      vim-airline
      vim-indent-guides
      vim-nix
      vim-sensible
    ];
    settings = { ignorecase = true; };
  };

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
    ".bash_aliases".text = ''
      alias f='fish'
      '';

    # In terms of safety, nix > home.file sourcing > mkOutOfStoreSymlink
    # vim: Won't work well with plugins if sourced.
    # fish: Generally behaves well. Use conf.d/ for extra reliability.
    # tmux: Safer to not source, to maintain set-option -g default-shell

    ".config/fish/config.fish".source = fish/config.fish;
    ".config/fish/functions/fish_prompt.fish".source = fish/fish_prompt.fish;

    # Sourcing vim/myfiletypes.vim doesn't seem to work for some reason.
    ".vim/myfiletypes.vim" = {
      text = ''
        augroup filetype
                au!
                au! BufRead,BufNewFile *.jy   set filetype=python
        augroup END
      '';
    };

    ".tmux.conf" = {
      text = ''
        set-option -g default-shell /run/current-system/sw/bin/fish
        set-window-option -g mode-keys vi
        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ',screen-256color:Tc'
        set-option -g prefix2 C-Space
        set -g display-time 0
        set -g history-limit 99999
        bind -n S-PPage copy-mode -ue
        bind-key a set mouse
        bind-key j set mouse
        bind-key ` attach -d
      '';
    };

  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
