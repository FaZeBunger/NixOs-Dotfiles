{ config, pkgs, inputs, hostname, username, timezone, defaultLocale, ... }:
{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./modules/system/firewall.nix
      ./modules/system/bluetooth.nix
      ./modules/system/audio.nix
      ./modules/system/fonts.nix
      ./modules/system/virtualization.nix
    ];

  # Mount Other Drives
    fileSystems."/mnt/ssd1" = {
    device = "/dev/disk/by-uuid/A2A0C284A0C25E83";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=100" "exec" "umask=000"];
  };

  fileSystems."/mnt/hdd1" = {
    device = "/dev/disk/by-uuid/AEEE26E5EE26A615";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=100" "exec" "umask=000"];
  };


  # Install NVIDIA Drivers
  hardware.nvidia.open = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # Enable ClamAV AntiVirus
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable udisks2 for USB drives
  services.udisks2.enable = true;

  # Enable ratbagd for mouse control
  services.ratbagd.enable = true;

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


    # Media and Audio PGKS
    pkgs.pavucontrol # Audio Mixer and Controller
    pkgs.playerctl # Manages Media Playback
    pkgs.jq # Reads JSON

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
  system.stateVersion = "25.11"; # Replace with your NixOS version (e.g., 23.11)
}
