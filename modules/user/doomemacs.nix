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

  # Add Emacs to the XDG entry
  xdg.desktopEntries.emacsclient = {
    name = "Emacs (Client)";
    genericName = "Text Editor";
    exec = ''emacsclient -c -a ""'';
    icon = "emacs";
    terminal = false;
    categories = [ "Development" "TextEditor" ];
  };

  # Enable emacs by default so the daemon is always running
  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;   # native Wayland GUI support — important for daemon+GUI
    client.enable = false;         # provides a proper emacsclient .desktop entry too, not needed since I made my own
  };
}
