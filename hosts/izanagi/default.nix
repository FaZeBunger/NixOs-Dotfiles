{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
  ];


  # Enable Niri on laptop
  programs.niri.enable = true;

  # Since moving to the noctalia-greeter we don't need to enable greetd since noctalia-greeter already does it
  # I'm keeping this here since I don't want to completely remove this incase the noctalia-greeter doesn't work/breaks
  # services.greetd.enable = true;
  # services.greetd.settings.default_session = {
  #   command = "niri-session";
  #   user = "ebeyl";
  # };


  # Make sure these are on for Noctalia
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.tuned.enable = true;

  networking.hostName = "izanagi";
}
