{ config, pkgs, ... }:
{

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
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      starship init fish | source
    '';
  };

  environment.systemPackages = [
    pkgs.fishPlugins.grc
    pkgs.fishPlugins.async-prompt
    pkgs.fishPlugins.autopair
    pkgs.fishPlugins.fzf-fish
    pkgs.grc # Required for text coloring
  ];
}
