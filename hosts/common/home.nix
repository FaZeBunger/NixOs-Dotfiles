{ config, pkgs, inputs, username, ... }:
{
  imports = [
    ../../modules/user/school.nix
    ../../modules/user/essentials.nix
    ../../modules/user/stylix.nix
    ../../modules/user/fish.nix
  ];


  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/" + username;

  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  home.sessionVariables = { };

  # Tells NixOS where to store the configs for programs managed by Nix
  home.file = {
    ".config/nvim" = {
      # Neovim must be able to modify the config files thus 
      # we cannot use symlinks to the NixStore as it would be immutable
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/nvim";
      recursive = true;
    };
    ".config/hypr" = {
      source = ../../configs/hypr;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../configs/waybar;
      recursive = true;
    };
    ".config/rofi" = {
      source = ../../configs/rofi;
      recursive = true;
    };
    ".config/swaync" = {
      source = ../../configs/swaync;
      recursive = true;
    };
    ".config/starship" = {
      source = ../../configs/starship;
      recursive = true;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
