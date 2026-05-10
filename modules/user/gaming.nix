{ pkgs, ... }:
{
  home.packages = [
    pkgs.steam-run # Steam stuff
    pkgs.vesktop
    pkgs.spotify
    pkgs.steam
    pkgs.cava # Audio Visualizer
  ];
}
