{ config, pkgs, ... }:
let
  # 1. Create the custom script to find the directory and launch Emacs
  emacsHereScript = pkgs.writeShellScriptBin "emacs-here" ''
    #!/usr/bin/env bash

    # Ask Hyprland for the PID of the currently active window
    WINDOW_PID=$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq '.pid')

    # If a window is currently active, try to find its directory
    if [ "$WINDOW_PID" != "null" ] && [ -n "$WINDOW_PID" ]; then

        # Function to find the deepest child process
        # (Crucial for getting past Kitty down into Fish shell / Neovim)
        get_deepest_child() {
            local parent=$1
            local child
            child=$(pgrep -P "$parent" | head -n 1)
            if [ -z "$child" ]; then
                echo "$parent"
            else
                get_deepest_child "$child"
            fi
        }

        DEEPEST_PID=$(get_deepest_child "$WINDOW_PID")

        # Get the working directory of that specific process
        CWD=$(readlink /proc/"$DEEPEST_PID"/cwd 2>/dev/null)

        # If the directory is valid, cd into it
        if [ -n "$CWD" ] && [ -d "$CWD" ]; then
            cd "$CWD" || cd "$HOME"
        fi
    fi

    # Launch Emacs Client.
    # Because we 'cd' first, Emacs will inherit this as its default-directory.
    # The -a "" flag automatically starts the Emacs daemon if it isn't running.
    emacsclient -c -n -a ""
  '';
in
{

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

    # Optional but recommended for code styling
    csharpier

    # Add the emacs script to pkgs
    emacsHereScript
    pkgs.jq # Required to parse Hyprland's JSON output

    # Makes org roam graph view work
    graphviz

    # Spell checking for UNIX (Needed for emacs spell checking)
    ispell

    # This should probably be under system or essentials but I'm putting it here because I'm building an emacs plugin with it rn lol
    tree
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

  # Create the Desktop Entry so Rofi sees our new emacs command it automatically
  xdg.desktopEntries."emacsclient" = {
    name = "Emacs (Current Directory)";
    genericName = "Text Editor";
    exec = "emacs-here";
    icon = "emacs";
    terminal = false;
    categories = [ "Development" "TextEditor" ];
    comment = "Open Emacs client in the directory of the active window";
  };
}
