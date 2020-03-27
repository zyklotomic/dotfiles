# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		# ./vscode.nix
		];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "demoivre"; # Define your hostname.
  # networking.interfaces.enp3s0.ipv4.addresses = [{
  #   address = "192.168.1.2";
  #   prefixLength = 24;
  # }];
    
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.  
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Select internationalisation properties.
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [mozc libpinyin];
  };
  
  # Set your time zone.
  time.timeZone = "US/Eastern";
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget 
  environment.systemPackages = 
  # let
  # my-python3-packages = python-packages: with python-packages; [
  # 	numpy virtualenvwrapper jupyter matplotlib
  # 	pylint pandas scikitlearn flake8 pytest
  #       pytorch beautifulsoup4
  #       selenium
  # ];
  # in
  with pkgs; [
  	# (python37.withPackages my-python3-packages)
  	wget vim firefox-bin git rofi st ranger htop
  	xmobar spotify pavucontrol zip unzip
        emacs
  	rxvt_unicode
  	xorg.libxcb
  	haskellPackages.ghc
  	gnumake
  	texlive.combined.scheme-basic
  	alacritty
  	zathura qutebrowser
  	gcc valgrind gdb dunst
	nodejs
	ruby jekyll
	bundler
        google-chrome
        usbutils
        rustc cargo
        geckodriver
        jetbrains.idea-ultimate
        neovim rustup rustc
        screen
  ];
  nixpkgs.config.allowUnfree = true;
  
  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts-cjk font-awesome
  ];
  
  # enable zsh
  programs.zsh.enable = true;

  # 32-bit
  hardware.opengl.driSupport32Bit = true; 
  
  # Virtualization with a "z"
  virtualisation.docker.enable = true;

  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # Full build necessary for Bluetooth
    package = pkgs.pulseaudioFull;
    support32Bit = true;
  };

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak"; 
  services.xserver.xkbOptions = "caps:backspace";
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xrandrHeads = [
    { output = "DVI-D-0"; }
    { output = "DP-0"; primary = true; }
  ];

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: with haskellPackages; [
        xmonad-contrib
        xmonad-extras
      ];
  };

  # Enable the urxvtd daemon, smh my head, rip in peace grammar
  services.urxvtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ethan = {
    isNormalUser = true;
    home = "/home/ethan";
    description = "Ethan Kiang";
    extraGroups = [ "wheel"  "docker"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

} 
