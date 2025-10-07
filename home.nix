{ config, pkgs, inputs, ... }:
let
  masterPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/master.tar.gz";
    sha256 = "+JFrKE0Jtm+PTYWJrA5lv6ZA2DF5pH3B7yDj0nputg0=";
  }) { system = pkgs.system; };
in
{
  imports = [
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ebeyl";
  home.homeDirectory = "/home/ebeyl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.vesktop
  	pkgs.rofi-wayland
    pkgs.neovim
    pkgs.obsidian
    pkgs.spotify
    pkgs.steam
    pkgs.fastfetch
    pkgs.cargo
    pkgs.firefox
    pkgs.hyprland
    pkgs.waybar
    pkgs.git
    pkgs.gh
    pkgs.eclipses.eclipse-java
    pkgs.go
    pkgs.nodejs_24
    (masterPkgs.gemini-cli)
  ];

  home.file = {
    ".config/nvim".source = ./configs/nvim;
    ".config/hypr".source = ./configs/hypr;
    ".config/waybar".source = ./configs/waybar;
    ".config/rofi".source = ./configs/rofi;
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
