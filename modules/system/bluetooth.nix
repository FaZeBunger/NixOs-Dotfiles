{ config, pkgs, ... }: {

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Bluetooth Support (UI and Libs)
  environment.systemPackages = [
    pkgs.blueman # GTK Bluetooth Manager (SwayNC needs this)
    pkgs.bluez # Linux Bluetooth Protocol Stack
    pkgs.bluez-alsa # Bluz Alsa Backend
    pkgs.bluez-tools # Tools to manage bluetooth devices
  ];

}
