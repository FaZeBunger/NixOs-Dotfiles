{ pkgs, ... }:
{
  home.packages = [
    pkgs.steam-run # Steam stuff
    pkgs.spotify
    pkgs.steam
    pkgs.cava # Audio Visualizer
    pkgs.piper # Controlls Mouse DPI, Polling Rate, etc. 
    pkgs.osu-lazer
    pkgs.linux-wallpaperengine
  ];
}
