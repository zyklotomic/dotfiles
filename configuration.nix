# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./vscode.nix
		];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "demoivre"; # Define your hostname.
  
  
  # networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
  };
  
  # Set your time zone.
  time.timeZone = "US/Eastern";
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget 
  environment.systemPackages = let
  my-python-packages = python-packages: with python-packages; [
  	numpy virtualenvwrapper jupyter matplotlib ipython conda
  	tensorflow
  ];
  in with pkgs; [
  	(python37.withPackages my-python-packages)
  	wget vim firefox-bin git rofi st ranger htop
  	xmobar vscode spotify pavucontrol zip unzip
  	rxvt_unicode
  	steam xorg.libxcb
  	haskellPackages.ghc
  	gnumake
  	texlive.combined.scheme-basic
  	alacritty
  	zathura
  	gcc valgrind gdb
  ];
  nixpkgs.config.allowUnfree = true;
  
  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts-cjk
    nerdfonts
  ];
  
  # enable fish
  programs.fish.enable = true;

  # 32-bit
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = false;
  services.openssh = {
    enable = true;
    ports = [30642];
  };

  # vscode configuration
  vscode.user = "ethan";
  vscode.homeDir = "/home/ethan";
  vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
  ];
  nixpkgs.latestPackages = [
    "vscode"
    "vscode-extensions"
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak"; 
  services.xserver.xkbOptions = "caps:backspace";
  services.xserver.videoDrivers = [ "nvidia" ];
  # services.xserver.config = "xrandr --output DVI-D-0 --left-of DP-0";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ethan = {
    isNormalUser = true;
    home = "/home/ethan";
    description = "Ethan Kiang";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?  
} 
