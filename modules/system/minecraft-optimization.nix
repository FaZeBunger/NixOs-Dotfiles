{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      ocl-icd
      opencl-headers
    ];
  };

  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
