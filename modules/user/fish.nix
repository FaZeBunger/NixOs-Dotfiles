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
    EDITOR = "nvim";
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
