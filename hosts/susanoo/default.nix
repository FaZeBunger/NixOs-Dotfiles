{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
    ../../modules/system/virtualization.nix
    ../../modules/system/minecraft-optimization.nix
  ];

  networking.hostName = "susanoo";

  # Enable Hyprland
  # programs.hyprland.enable = true;
  # Enable xWayland apps to work
  # programs.hyprland.xwayland.enable = true;

# Noctalia Greeter launches hyprland so remove the enable and just make sure it exists & tell the session what our displayManager is.
services.displayManager.sessionPackages = [ pkgs.hyprland ];
programs.xwayland.enable = true;

# Install UWSM's user systemd units so noctalia-greeter can launch wayland sessions
systemd.packages = [ pkgs.uwsm ];

environment.systemPackages = with pkgs; [
  hyprland
  wayland
  xwayland
];

# Add portal config so hyprland.desktop appears.
xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
};

  #Mount Other Drives
  fileSystems."/mnt/ssd1" = {
    device = "/dev/disk/by-uuid/8A1ECEB11ECE961B";
    fsType = "ntfs-3g";
    options = [ "rw"
                "uid=1000"
                "gid=100"
                "dmask=022"
                "fmask=022"
                "exec"
              ];
  };

  fileSystems."/mnt/hdd1" = {
     device = "/dev/disk/by-uuid/AEEE26E5EE26A615";
     fsType = "ntfs-3g";
     options = [ "rw" 
                "uid=1000" 
                "gid=100" 
                "dmask=022"
                "fmask=022"
                "exec" 
              ];
  };

  # Disable bluetooth on wifi card
  # Wifi uses Pcie for data while the bluetooth uses the usb that the cord connects to
  services.udev.extraRules = ''
  ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0029", ATTR{authorized}="0"
  '';

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Make sure hibernation is disabled. (Causes boot errors)
  systemd.targets.hibernate.enable =  false;
  systemd.targets.hybrid-sleep.enable =  false;

  # Pin to LTS kernel — linuxPackages_latest resolves to 7.2+ which breaks
  # NVIDIA 595.x kernel module compilation (missing strncpy API). Override
  # the common setting here until a fixed driver lands in nixpkgs stable.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the default.
    open = false; # Used true for a while, then it broke. Worth looking into again

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
