{ config, pkgs, inputs, ... }:
let
  essentialPackages = [
    inputs.awww.packages.${pkgs.system}.awww # Flake for awww live wallpapers
    pkgs._1password-gui
    pkgs.gh
    pkgs.git
    pkgs.wl-clipboard
    pkgs.xfce.thunar
    pkgs.firefox
    pkgs.hyprland
    pkgs.waybar
    pkgs.neovim
    pkgs.rofi
    pkgs.fastfetch
    pkgs.grimblast # Screenshot tool
    pkgs.magic-wormhole
    pkgs.btop # Task Manager / System Resource Manager

    # DE PKGS
    pkgs.wayland # What Hyprland is built on
    pkgs.hyprlock # Lockscreen for Hyprland
    pkgs.hypridle # Idle Manager for Hyprland
    pkgs.hyprpicker # Color Picker for Hyprland
    pkgs.hypridle # Hyprland Idle Daemon

    # Notification PKGS
    pkgs.swaynotificationcenter # A Notification Center with GUI
    pkgs.brightnessctl # Brightness Manager (SwayNC needs this)
    pkgs.pamixer # SwayNC needs this
  ];
in
{
  imports = [
    ./school.nix
    ./gaming.nix
  ];


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ebeyl";
  home.homeDirectory = "/home/ebeyl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.git # always installed
  ] ++ essentialPackages;


  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/configs/nvim";
      recursive = true;
    };
    ".config/hypr".source = ./configs/hypr;
    ".config/waybar".source = ./configs/waybar;
    ".config/rofi".source = ./configs/rofi;
    ".config/swaync".source = ./configs/swaync;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
