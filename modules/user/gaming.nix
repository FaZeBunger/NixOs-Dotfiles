{ pkgs, ... }:
{
  home.packages = [
    pkgs.steam-run # Steam stuff
    pkgs.piper # Controlls Mouse DPI, Polling Rate, etc.
    pkgs.osu-lazer
    pkgs.linux-wallpaperengine
  ];
}
