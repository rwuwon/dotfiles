{ config, pkgs, ... }:
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}";
in
{
imports =
  [ # Include the results of the hardware scan.
    ../../modules/nvim.nix
    #../../modules/btop.nix   # btop doesn't work on android'
    #../../modules/scripts.nix
  ];

  xdg.configFile = {
# Use only for testing. Beware of "recursion"!
# Switch between systems by first commenting out BOTH sections
#    fish.source = "${dotfiles}/fish";
#    tmux.source = "${dotfiles}/tmux";
    "bat/config".source = "${dotfiles}/nix/dotfiles/bat/config";
    "btop/btop.conf".source = "${dotfiles}/nix/dotfiles/btop/btop.conf";

    "fish/config.fish".source = "${dotfiles}/nix/hosts/nixos/fish/config.fish";
    "fish/functions/fish_prompt.fish".source = "${dotfiles}/nix/dotfiles/fish/fish_prompt.fish";
    "fish/conf.d/grc.fish".source = "${dotfiles}/nix/dotfiles/fish/grc.fish";

    "tmux/tmux.conf".source = "${dotfiles}/nix/dotfiles/tmux/tmux.conf";
  };

  home.username = "io";
  home.homeDirectory = "/home/io";

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
    #gnused
    #gnutar
    jq
    tmux
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
    #ghostty
    #kitty
    #alacritty

    # terminal image viewer
    viu

    # vnc
    wayvnc

    #weechat
    #cyberchef # offline instance of cyberchef
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    signing = {
      key = "83C2250548D62119977DC1511D25FD60D6C614ED";
      signByDefault = false;
    };
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # https://discourse.nixos.org/t/link-scripts-to-bin-home-manager/41774/4
  home.file = {
    #".local/bin" = {
    #  source = ../../scripts;
    #  recursive = true;
    #};
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

    # vim: Won't work well with plugins if sourced.
#    ".config/bat/config".source = config.lib.file.mkOutOfStoreSymlink "/home/io/dotfiles/bat/config";
#
#    ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "/home/io/nix/hosts/nixos/fish/config.fish";
#    ".config/fish/functions/fish_prompt.fish".source = config.lib.file.mkOutOfStoreSymlink "/home/io/nix/dotfiles/fish/fish_prompt.fish";
#    ".config/fish/conf.d/grc.fish".source = config.lib.file.mkOutOfStoreSymlink "/home/io/nix/dotfiles/fish/grc.fish";
#
#    ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/io/nix/dotfiles/tmux/tmux.conf";
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
  #programs.alacritty = {
  #  enable = true;
  #  # custom settings
  #  settings = {
  #    env.TERM = "xterm-256color";
  #    font = {
  #      size = 10;
  #      #draw_bold_text_with_bright_colors = true;
  #    };
  #    scrolling.multiplier = 5;
  #    selection.save_to_clipboard = true;
  #  };
  #};

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # UNUSED:
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
}
