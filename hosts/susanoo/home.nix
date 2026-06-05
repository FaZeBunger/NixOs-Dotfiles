{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
    ../../modules/user/assistant.nix
    ../../modules/user/gaming.nix
  ];
}
