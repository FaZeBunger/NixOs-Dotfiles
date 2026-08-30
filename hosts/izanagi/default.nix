{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
  ];

  # Enable Niri on laptop
  programs.niri.enable = true;

  services.greetd.enable = true;
  services.greetd.settings.default_session = {
    command = "niri-session";
    user = "ebeyl";
  };

  # Make sure these are on for Noctalia
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;

  networking.hostName = "izanagi";
}
