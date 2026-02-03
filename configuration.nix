{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.spicetify-nix.nixosModules.spicetify
    ];


  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;
  virtualisation.waydroid.enable = true;

  # NixOS Insecure Packages
  nixpkgs.config.permittedInsecurePackages = [
  ];

  # Unstable Packages
  nixpkgs.overlays = [
  (self: super: {
  })
  ];

  networking.firewall.enable = false;


  # Bootloader. Make sure to configure it properly!
  boot.loader.systemd-boot.enable = true;

  # Linux Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "hid_quirks=0x04f3:0x413c:0x40"  # vendor:product:HID_QUIRK_NOINPUT
  ];


  networking.hostName = "izanagi"; # Replace with your desired hostname
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago"; # Replace with your timezone

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ebeyl = { # Replace "your-username"
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ]; # Enable 'sudo' for the user
    packages = with pkgs; [
      # Add any essential packages you want to start with, like a terminal
       kitty
       neovim
       git
       gh
    ];
  };

  # Enable sound
  security.rtkit.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
  	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
	wireplumber = {
	    enable = true; # Ensure WirePlumber is enabled
	    extraConfig.bluetoothEnhancements = {
		    "monitor.bluez.properties" = {
			      "bluez5.enable-sbc-xq" = true;
			      "bluez5.enable-msbc" = false; # Often recommended to disable if having issues
			      "bluez5.enable-hw-volume" = true;
			      "bluez5.auto-connect" = [ "a2dp_sink" ];
			      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
		    };
	    };
	};
  };

  # Select internationalisation properties.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system. You can remove this if you strictly want Wayland.
  # services.xserver.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true; # Or your preferred desktop environment

  # Enable the Sway window manager
  # services.xserver.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # environment.systemPackages = with pkgs; [ sway ];

  # Enable the Wayland display server.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # Login Screen 
  # TODO: Fix this, idk why it doesn't work rn
  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "${pkgs.hyprland}/bin/Hyprland";
    user = "ebeyl";
  };
    
  systemd.user.services.swaync = {
    enable = true;
    description = "Sway Notification Center";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
      Restart = "on-failure";
    };
    unitConfig = {
      PartOf = "graphical-session.target";
    };
  };

  services.udev = {
  	extraRules = '' SUBSYSTEMS=="hid", KERNELS=="0018:04F3:413C.0001", DRIVERS=="hid-multitouch", ENV{LIBINPUT_IGNORE_DEVICE}="1" ''; 
  };


  # Enable xWayland apps to work
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.sessionVariables = {
    HTTP_PROXY = "";
    HTTPS_PROXY = "";
    NO_PROXY = "";
  };
  environment.systemPackages = [
    # Flake PKGS
    inputs.swww.packages.${pkgs.system}.swww 		# Flake for swww live wallpapers

    #Steam stuff
    pkgs.steam-run

    # DE PKGS
    pkgs.wayland 		# What Hyprland is built on
    pkgs.hyprlock		# Lockscreen for Hyprland
    pkgs.hypridle		# Idle Manager for Hyprland
    pkgs.hyprpicker		# Color Picker for Hyprland
    pkgs.hyprlock		# Lock Screen
    pkgs.hypridle		# Hyprland Idle Daemon

    # Nix PKGS
    pkgs.kitty   		# Default Hyprland terminal
    pkgs.btop           	# Task Manager / System Resource Manager
    pkgs.starship		# Terminal Prompt Manager ( May or may not use )
    pkgs.eww			# Elko's Wacky Widgets ??? (idk how to spell it lol)
    pkgs.inotify-tools		# Watching for file changes etc...
    pkgs.gnumake		# Adds make for building C files
    pkgs.gcc			# C compiler
    pkgs.fzf			# Fuzzy Finder
    pkgs.ripgrep		# RipGrep - Better Grep
    pkgs.fd			# Better Find
    pkgs.unzip			# Unzip
    pkgs.python3		# Python
    pkgs.python312Packages.pip  # Python Pip
    pkgs.unrar			# Unrar
    pkgs.direnv
    pkgs.wireshark		# Wireshark


    # Notification PKGS
    pkgs.swaynotificationcenter	# A Notification Center with GUI
    pkgs.brightnessctl		# Brightness Manager (SwayNC needs this)
    pkgs.pamixer		# SwayNC needs this

    # Bluetooth Support (UI and Libs)
    pkgs.blueman		# GTK Bluetooth Manager (SwayNC needs this)
    pkgs.bluez			# Linux Bluetooth Protocol Stack
    pkgs.bluez-alsa		# Bluz Alsa Backend
    pkgs.bluez-tools		# Tools to manage bluetooth devices

    # Media and Audio PGKS
    pkgs.pavucontrol	# Audio Mixer and Controller
    pkgs.playerctl	# Manages Media Playback
    pkgs.jq		# Reads JSON
    pkgs.cava		# Audio Visualizer

    # SSL Certification
    pkgs.nss
    pkgs.cacert

    # Raylib Dependencies
    pkgs.xorg.libX11.dev
    pkgs.xorg.libXcursor.dev
    pkgs.xorg.libXrandr.dev
    pkgs.xorg.libXi.dev
    pkgs.xorg.libXinerama.dev
    pkgs.xorg.libXfixes.dev

    # ...
  ];


  fonts.fontconfig.enable = true;
  fonts.packages = [
    pkgs.pkgs.jetbrains-mono
    pkgs.pkgs.fira-code
    pkgs.pkgs.font-awesome
    pkgs.pkgs.cascadia-code
    pkgs.pkgs.jetbrains-mono
    pkgs.pkgs.material-design-icons 
    pkgs.pkgs.mononoki
    pkgs.pkgs.noto-fonts-cjk-sans
  ];

  /*
  programs.spicetify = 
  let 
  	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  in
  {
  	enable = true;
	theme = spicePkgs.themes.dribbblish;
	colorScheme = "catppuccin-mocha";
  };
  */
  
  programs._1password.enable = true;
  programs._1password-gui = {
  	enable = true;
	polkitPolicyOwners = ["ebeyl"];
  };

  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };

  programs.wireshark.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  stdenv.cc.cc
];



  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s recommended to leave this value at
  # the version of NixOS you installed.
  system.stateVersion = "25.05"; # Replace with your NixOS version (e.g., 23.11)
}
