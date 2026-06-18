{ config, lib, pkgs, inputs, ... }:

{
  programs.quickshell = {
    enable = true;
  };

  home.file = {
    ".config/quickshell" = {
      source = ../../configs/quickshell;
      recursive = true;
    };
  };

  home.packages = [
    pkgs.hyprsunset
  ];
}
