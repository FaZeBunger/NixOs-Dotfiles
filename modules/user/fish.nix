{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
      { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
    ];

    shellAliases = {
      ll = "ls -la --color=auto";
      emacs = "emacsclient -c -n -a ''";
      tmacs = "emacsclient -a ''";
      reubuild = "sudo nixos-rebuild switch --flake /home/ebeyl/dotfiles.#";
    };

    functions = {
      # This will rebuild the system and doom emacs any time a change has been made. If the rebuild fails doom won't sync
      rebuild = ''
        sudo nixos-rebuild switch --flake /home/ebeyl/.dotfiles/.#$argv[1] && ~/.config/emacs/bin/doom sync
      '';
    };

    binds = {
      "\\t" = {
        command = "accept-autosuggestion";
        operate = "user";
      };
      "\\cj" = {
        command = "down-or-search";
        operate = "user";
      };
      "\\ck" = {
        command = "up-or-search";
        operate = "user";
      };
    };
  };

  home.sessionVariables = { 
    EDITOR = "emacsclient -c -n -a ''";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.packages = [
    pkgs.grc # Required for text coloring
  ];
}
