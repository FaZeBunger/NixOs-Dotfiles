{ pkgs, inputs, ... }:
{
  home.packages = [
    pkgs._1password-gui
    pkgs.gh
    pkgs.git
    pkgs.delta # Git syntax highlighting pager
    pkgs.wl-clipboard
    pkgs.thunar
    pkgs.firefox
    pkgs.hyprland
    pkgs.waybar
    pkgs.neovim
    pkgs.rofi


    pkgs.grimblast # Screenshot tool
    pkgs.magic-wormhole
    pkgs.qdirstat # WinDirStat for Linux
    pkgs.ffmpeg
    pkgs.udiskie # Mounting / Reading / Writing to USB drives
    pkgs.imhex # Hex Editor

    pkgs.remmina # RDP Client

    # DE PKGS
    pkgs.wayland # What Hyprland is built on
    pkgs.hyprlock # Lockscreen for Hyprland
    pkgs.hypridle # Idle Manager for Hyprland
    pkgs.hyprpicker # Color Picker for Hyprland
    pkgs.hypridle # Hyprland Idle Daemon
    pkgs.hyprpaper # Hyprland Wallpaper Daemon
    pkgs.rose-pine-cursor # Mouse Cursor 

    # Notification PKGS
    pkgs.swaynotificationcenter # A Notification Center with GUI
    pkgs.brightnessctl # Brightness Manager (SwayNC needs this)
    pkgs.pamixer # SwayNC needs this
  ];

}
