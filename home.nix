{ config, pkgs, inputs, ... }:
let
  masterPkgs = import (builtins.fetchTarball {
    # url = "github:NixOS/nixpkgs/nixos-unstable";
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
    sha256 = "1mqwcpjyq690m9m52njw0dr9baw715s4j9sh7s8nq5wf8psm6w98";
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
  # compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    inputs.awww.packages.${pkgs.system}.awww 		# Flake for awww live wallpapers
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
    pkgs.kicad
    pkgs.obs-studio
    pkgs.vlc
    pkgs.magic-wormhole
    pkgs.grimblast
  ];

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/nvim";
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
