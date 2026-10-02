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


  # Make sure these are on for Noctalia
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.tuned.enable = true;

  networking.hostName = "izanagi";
}
