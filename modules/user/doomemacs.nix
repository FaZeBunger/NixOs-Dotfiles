{ config, pkgs, ... }: {

  # Dependencies for emacs & doom emacs
  home.packages = with pkgs; [
    git
    emacs
    ripgrep
    coreutils
    fd
    clang
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.file = {
    "./config/doom" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom";
      recursive = true;
    };
  };
}
