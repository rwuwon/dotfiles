{ config, pkgs, lib, ... }:
# https://nixos-and-flakes.thiscute.world/best-practices/accelerating-dotfiles-debugging
# https://www.foodogsquared.one/posts/2023-03-24-managing-mutable-files-in-nixos/
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles";
in
{
imports =
  [ # Include the results of the hardware scan.
    ../../modules/nvim.nix
    ../../modules/btop.nix
    #../../modules/scripts.nix
  ];

  xdg.configFile = {
# Use only for testing. Beware of "recursion"!
# Switch between systems by first commenting out BOTH sections
#    fish.source = "${dotfiles}/fish";
#    tmux.source = "${dotfiles}/tmux";
    "tmux/tmux.conf".source = "${dotfiles}/tmux/tmux.conf";
    "fish/config.fish".source = "${dotfiles}/fish/config.fish";
    "fish/conf.d/grc.fish".source = "${dotfiles}/fish/grc.fish";
    "fish/functions/fish_prompt.fish".source = "${dotfiles}/fish/fish_prompt.fish";
  };

  targets.genericLinux.enable = true;
  #nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "io";
  home.homeDirectory = "/home/io";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    bat
    btdu
    cpufetch
    deno
    emoji-picker
    fastfetch
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.fzf-fish
    #fishPlugins.hydro
    #ghostty
    hello
    #kitty
    links2
    #man
    newsboat
    nix
    nix-output-monitor
    trippy
    viu
    yt-dlp

    # Previously via Flatpak:
    anki
    bitwarden-desktop
    joplin-desktop
    #musescore   # Run with: nixGL mscore
    signal-desktop
    stellarium
    telegram-desktop

    # CTF
    cyberchef
    #rockyou

    # Unfree Packages
    #hello-unfree
    #zoom-us

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')

    (writeShellScriptBin "ho" ''
      echo -e "\thome-manager switch |& nom\n"
      home-manager switch |& nom
    '')

    (writeShellScriptBin "hov" ''
      echo -e "\thome-manager switch -v |& nom\n"
      home-manager switch -v |& nom
    '')
  ];

#  nixpkgs.config.allowUnfreePredicate = pkg:
#    builtins.elem (lib.getName pkg) [
#      # Add additional package names here
#      "hello-unfree"
#      "zoom-us"
#    ];

#  { nixpkgs.config.allowUnfreePredicate = pkg:
#    builtins.elem (lib.getName pkg) [
#      "example-unfree-package"
#  ];
#  }


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


    ".config/kitty/kitty.conf".text = ''
      enable_audio_bell no
      font_family hack
      font_size 12
      text_composition_strategy 1.5 0
      map shift+page_up scroll_page_up
      map shift+page_down scroll_page_down
    '';
#    ".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/dotfiles/tmux/tmux.conf";
#    ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "/home/${config.home.username}/dotfiles/fish/config.fish";
#    ".config/fish/conf.d/grc.fish".source = /home/${config.home.username}/dotfiles/fish/grc.fish;
#    ".config/fish/functions/fish_prompt.fish".source = /home/${config.home.username}/dotfiles/fish/fish_prompt.fish;
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
  #  /etc/profiles/per-user/io/etc/profile.d/hm-session-vars.sh
  #
#  home.sessionVariables = {
#    # EDITOR = "vim";
#  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
