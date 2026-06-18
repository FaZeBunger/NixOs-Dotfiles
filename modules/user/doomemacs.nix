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

    # Unity Packages for emacs support
    omnisharp-roslyn  # LSP support for C# files
    mono
    dotnet-sdk

    # Note taking shit
    miktex  # Required packages for math in emacs + much more
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.config/emacs/bin"
    "${config.home.homeDirectory}/.cargo/bin"  # Needed to add rider2emacs to path so it can run for unity integration with emacs
  ];

  home.file = {
    "./.config/doom" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/configs/doom";
      recursive = true;
    };
  };
}
