{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/system.nix
    ./hardware-configuration.nix
    ../../modules/system/virtualization.nix
  ];

  networking.hostName = "susanoo";
}
