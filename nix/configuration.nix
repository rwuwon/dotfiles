# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
#  boot.loader.grub.enable = true;
#  boot.loader.grub.device = "/dev/vda";
#  boot.loader.grub.useOSProber = true;
#  boot.loader.timeout = 1;

  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/vda";
        useOSProber = true;
      };
      timeout = 1;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Etc/UTC";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
#  services.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
#  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.io = {
    isNormalUser = true;
    description = "io";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnWSu79DOWQHv9/+szfYVX83FW+DqsXKOjLqwpf4DDH io@cassini"
                                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlUXxbg46VdgDnCqjIKkfVvjmzidWTjfiY+pN1m6odM io@stardust" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
#  programs.sway.extraPackages = with pkgs; [
#    brightnessctl foot grim pulseaudio swayidle swaylock wmenu i3status i3status-rust termite rofi light ];

	programs.vim = {
		enable = true;
		defaultEditor = true;
		package = (pkgs.vim-full.override {  }).customize{
			name = "vim";
			# Install plugins for example for syntax highlighting of nix files
			vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
				start = [ vim-nix vim-lastplace ];
				opt = [];
			};
			vimrcConfig.customRC = ''
				" your custom vimrc
				set nocompatible
				set backspace=indent,eol,start
				" Turn on syntax highlighting by default
				syntax on
				" ...
				set smarttab
				set smartindent
				set tabstop=2
				set shiftwidth=2
				set bg=dark
				set expandtab
        nmap <Tab> :bn<CR>
        nmap <S-Tab> :bp<CR>

        " Use CTRL-S for saving, also in Insert mode
        noremap <C-S> :update<CR>
        vnoremap <C-S> <C-C>:update<CR>
        inoremap <C-S> <C-O>:update<CR>
			'';
		};
	};

	programs.tmux = {
		enable = true;
		clock24 = true;
		extraConfig = '' # used for less common options, intelligently combines if defined in multiple places.
		# Apply changes by running: tmux source-file ~/.tmux.conf

		# Prefix tip via https://www.reddit.com/r/neovim/comments/wta8k2/why_not_use_space_as_leader_key/
		# and https://koenwoortman.com/tmux-prefix-ctrl-space/
		set -g prefix2 C-Space
		
		set -g mode-keys vi
		set -g display-time 0
		set -g history-limit 99999
		# Interferes with local selection & copy:
		set -g mouse on
		
		# Setup 'v' to begin selection as in Vim
		#bind-key -T vi-copy v begin-selection
		#bind-key -T vi-copy y copy-pipe "cat >/tmp/out"
		
		# Update default binding of `Enter` to also use copy-pipe
		#unbind -T vi-copy Enter
		#bind-key -T vi-copy Enter copy-pipe "cat >/tmp/out"
		
		# Scroll
		bind -n S-PPage copy-mode -ue
		
		# Use Ctrl-B a to toggle mouse mode
		bind-key a set mouse
		# j included for faster toggling from home row
		bind-key j set mouse
		
		# Detach other attached sessions
		bind-key ` attach -d
		'';
	};

	programs.fish.enable = true;
	users.extraUsers.root = {
		shell = pkgs.fish;
	};
	users.extraUsers.io = {
		shell = pkgs.fish;
	};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
	tmux
  fzf
  git
  btop
  firefox
	grim # screenshot functionality
	slurp # screenshot functionality
  wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
  mako # notification system developed by swaywm maintainer
	weechat
  neovim
  cyberchef # offline instance of cyberchef
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
	services.openssh.settings.PasswordAuthentication = false;

  # https://wiki.nixos.org/wiki/Sway
  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  # Autologin:
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "io";
      };
      default_session = initial_session;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
