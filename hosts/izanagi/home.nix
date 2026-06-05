{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
  ];

  home.packages = with pkgs; [
    steam
  ];
}
