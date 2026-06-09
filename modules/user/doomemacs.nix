{ config, pkgs, ... }: {

  # Dependencies for emacs & doom emacs
  home.packages = with pkgs; [
    # Core dependencies
    git
    emacs
    ripgrep
    coreutils
    fd
    clang
    cmake  # Needed for the terminal in emacs
    libtool # Needed to compile vterm

    # LSP Packages
    nixd
    rust-analyzer
    rustc
    pyright
    ruff
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
  ];

  home.file = {
    "./.config/doom" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom";
      recursive = true;
    };
  };
}
