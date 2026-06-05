{ config, pkgs, ... }:
{

  # This file is required to make sure that the system shell stays as bash since linux requires
  # POSIX languages. Otherwise if we are in an interactive shell, we will use fish.

  programs.bash = {
    interactiveShellInit = ''
      # "check if parent process is not fish" && "make nested shells work properly"
      if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
          # set $SHELL for better integration with programs like nix shell, tmux, etc.
          SHELL=${pkgs.fish}/bin/fish exec fish
      fi
    '';
  };

  programs.fish = {
    enable = true;
  };
}
