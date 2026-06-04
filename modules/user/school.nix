{ pkgs, inputs, config, unstable, ... }:
let
  programmingPkgs = [
    pkgs.cargo
    pkgs.eclipses.eclipse-java
    pkgs.go
    pkgs.nodejs_24
    unstable.gemini-cli
    pkgs.logisim-evolution
    pkgs.kicad
    pkgs.proton-vpn
    pkgs.python3 # Python
    pkgs.python312Packages.pip # Python Pip
    pkgs.starship # Terminal Prompt Manager ( May or may not use )
  ];

  schoolPkgs = [
    pkgs.vlc
    pkgs.chromium
    pkgs.obsidian
    pkgs.obs-studio
    pkgs.libreoffice
  ];
in
{
  home.packages = [
  ] ++ programmingPkgs ++ schoolPkgs;

  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;   
    package = pkgs.lazygit;
    settings = {
      gui.showFileTree = true;
      git.pagers = [
        {
          pager = "delta --dark --paging=never";
        }
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };

  programs.kitty = {
    enable = true;
  };

}
