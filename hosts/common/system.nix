{ config, pkgs, inputs, hostname, username, timezone, defaultLocale, ... }:
{
  imports =
    [
      # Hardware configuration is handled per-host
      ../../modules/system/firewall.nix
      ../../modules/system/bluetooth.nix
      ../../modules/system/audio.nix
      ../../modules/system/fonts.nix
      ../../modules/system/fish.nix
    ];

  # Enable Tailscale
  services.tailscale.enable = true;

  # We define this here even though we manage noctalia mostly on the user level,
  # our greeter runs before we login and should get the direct path to things like what the cursor should look like
  services.displayManager.noctalia-greeter = {
    enable = true; # Ensures the greeter service is active
    settings = {
      cursor = {
        theme = "BreezeX-RosePine-Linux";
        size = 24;
        path = "${pkgs.rose-pine-cursor}/share/icons";
      };
    };
  };

  # Enable Docker
  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # Enable ClamAV AntiVirus
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    fangfrisch.enable = true;
  };

  #  Install GnuPG for encryption and
  #  Configure the GPG Agent daemon and password entry tool
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
    enableSSHSupport = true;
  };

  # Smart card daemon service (highly recommended for GPG operations)
  services.pcscd.enable = true;

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

  nix.settings = {
    download-buffer-size = 524288000; # 500 MB
  };

  # Bootloader. Make sure to configure it properly!
  boot.loader.systemd-boot.enable = true;

  # Make sure drivers for NTFS drives are always loaded on boot
  # Also add drivers for SD Cards
  boot.supportedFilesystems = [ "ntfs" "exfat" "vfat"];

  # Always use latest Linux Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Needed for wazuh scanning
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 524288;
  };

  boot.extraModprobeConfig = "options kvm_amd nested=1";

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

  # Enable locate service
  services.locate = {
    enable = true;
    package = pkgs.plocate;
  };

  # Enable the Wayland display server.
  services.xserver.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    # ExFat file system utilities (SD Cards)
    pkgs.exfatprogs

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
    pkgs.clamav # OpenSource AntiVirus
    pkgs.neovim
    pkgs.ntfs3g
    pkgs.niri

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

  programs.git = {
    enable = true;
    config = {
      core.editor = "nvim";
    };
    lfs.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 10";
    flake = "/home/ebeyl/.dotfiles"; # sets NH_OS_FLAKE variable
  };

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
  system.stateVersion = "25.11"; 
}
