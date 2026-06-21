{ pkgs, inputs, config, unstable, ... }:
let

  schoolPkgs = [
    pkgs.vlc
    pkgs.chromium
    pkgs.obsidian
    pkgs.obs-studio
    pkgs.libreoffice
  ];
in
{
  home.packages = [
  ]  ++ schoolPkgs;
}
