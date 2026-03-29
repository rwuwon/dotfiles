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
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  boot.loader.timeout = 1;
  #boot.kernelPackages = pkgs.linuxPackages_latest;

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

  ### Start of section for i3, not sway
  ## Enable the X11 windowing system.
  #services.xserver.enable = true;

  ## Enable the GNOME Desktop Environment.
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;

  #services.xserver = {
  #  enable = true;

  #  windowManager.i3 = {
  #    enable = true;
  #    extraPackages = with pkgs; [
  #      dmenu #application launcher most people use
  #      i3status # gives you the default i3 status bar
  #      i3blocks #if you are planning on using i3blocks over i3status
  #      ];
  #    };
  #  };
  ### End of section for i3, not sway

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  #services.printing.enable = true;

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

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    extraRules = [{
      commands = [
	{
	  command = "${pkgs.systemd}/bin/systemctl suspend";
	  options = [ "NOPASSWD" ];
	}
	{
	  command = "${pkgs.systemd}/bin/reboot";
	  options = [ "NOPASSWD" ];
	}
	{
	  command = "${pkgs.systemd}/bin/poweroff";
	  options = [ "NOPASSWD" ];
	}
      ];
      groups = [ "wheel" ];
    }];
    extraConfig = with pkgs; ''
      Defaults:picloud secure_path="${lib.makeBinPath [
	systemd
      ]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      Defaults	timestamp_timeout=60
    '';
  };

  # To set up Sway using Home Manager, you must first enable Polkit in your NixOS configuration.
  #security.polkit.enable = true;

  programs.mosh.enable = true;

  programs.firefox.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs.sway.extraPackages = with pkgs; [
    brightnessctl foot grim pulseaudio swayidle swaylock wmenu i3status i3status-rust termite rofi light bemenu wl-clipboard clipman ];

  programs.fish = {
    enable = true;
  };

  users.extraUsers.io = {
    shell = pkgs.fish;
  };
  #users.extraUsers.root = {
  #  shell = pkgs.fish;
  #};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # https://wiki.nixos.org/wiki/Nix_Cookbook#Garbage_collection
  nix.gc.automatic = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Flakes clones its dependencies through the git command,
  # so git must be installed first
  #git
  #wget

  #fishPlugins.done
  #fishPlugins.fzf-fish
  #fishPlugins.forgit
  #fishPlugins.hydro
  #fishPlugins.grc
  #fzf
  #grc
  # Use 3rd-party fish plugins manually packaged.
  #(pkgs.callPackage ../fish-colored-man.nix {buildFishPlugin = pkgs.fishPlugins.buildFishPlugin; } )

  #i3
  #x11vnc
  #xorg.xinit

  #firefox
  #grim # screenshot functionality
  #slurp # screenshot functionality
  #wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
  #mako # notification system developed by swaywm maintainer
  ];
  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

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
