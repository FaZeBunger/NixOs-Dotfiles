{ config, pkgs, inputs, hostname, username, timezone, defaultLocale, ... }:
{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./modules/system/firewall.nix
      ./modules/system/bluetooth.nix
      ./modules/system/audio.nix
      ./modules/system/fonts.nix
    ];

  # Enable Docker
  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable udisks2 for USB drives
  services.udisks2.enable = true;


  # Enable drivers - Example for HP
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.avahi.nssmdns4 = true;

  # Enable network discovery
  services.avahi.enable = true;
  services.avahi.openFirewall = true;

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    # NixOS Insecure Packages
  ];
  nixpkgs.overlays = [
    (self: super: { }) # Unstable Packages
  ];


  # Bootloader. Make sure to configure it properly!
  boot.loader.systemd-boot.enable = true;

  # Linux Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "hid_quirks=0x04f3:0x413c:0x40" # vendor:product:HID_QUIRK_NOINPUT
  ];

  time.timeZone = timezone;
  i18n.defaultLocale = defaultLocale;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" ]; # Enable 'sudo' for the user
    packages = with pkgs; [
      kitty
      neovim
      git
      gh
    ];
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

  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "Hyprland";
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

  environment.systemPackages = [

    # Nix PKGS
    pkgs.kitty # Default Hyprland terminal
    pkgs.inotify-tools # Watching for file changes etc...
    pkgs.gnumake # Adds make for building C files
    pkgs.gcc # C compiler
    pkgs.fzf # Fuzzy Finder
    pkgs.ripgrep # RipGrep - Better Grep
    pkgs.fd # Better Find
    pkgs.unzip # Unzip
    pkgs.unrar # Unrar
    pkgs.direnv
    pkgs.wireshark # Wireshark
    pkgs.clamav    # OpenSource AntiVirus
    pkgs.neovim 
    pkgs.ntfs3g

    # Media and Audio PGKS
    pkgs.pavucontrol # Audio Mixer and Controller
    pkgs.playerctl # Manages Media Playback
    pkgs.jq # Reads JSON

    # SSL Certification
    pkgs.nss
    pkgs.cacert

    # Raylib Dependencies
    pkgs.libX11.dev
    pkgs.libXcursor.dev
    pkgs.libXrandr.dev
    pkgs.libXi.dev
    pkgs.libXinerama.dev
    pkgs.libXfixes.dev

    # ...
  ];



  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ username ];
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
