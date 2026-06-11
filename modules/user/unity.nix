{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.unityhub
    pkgs.unity-test
  ];
}
