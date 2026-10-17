{ config, pkgs, ... }:
{

  # Dependencies for emacs & doom emacs
  home.packages = with pkgs; [
    # Core dependencies
    git
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

    # Optional but recommended for code styling
    csharpier

    # Add the emacs script to pkgs
    pkgs.jq # Required to parse Hyprland's JSON output

    # Makes org roam graph view work
    graphviz

    # Spell checking for UNIX (Needed for emacs spell checking)
    ispell

    # This should probably be under system or essentials but I'm putting it here because I'm building an emacs plugin with it rn lol
    tree
    config.services.emacs.package

    # Needed for org-download to work
    xclip
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

  # Add Emacs to the XDG entry
  xdg.desktopEntries.emacsclient = {
    name = "Emacs (Client)";
    genericName = "Text Editor";
    exec = ''emacsclient -c --alternate-editor='';
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
