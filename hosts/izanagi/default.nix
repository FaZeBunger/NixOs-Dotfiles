{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
  ];

  services.upower.enable = true;

  networking.hostName = "izanagi";
}
