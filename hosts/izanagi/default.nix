{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    # ./hardware-configuration.nix # To be added later
  ];

  networking.hostName = "izanagi";
}
