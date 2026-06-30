{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-compose
    lazydocker
    pkgs.gh
    pkgs.git
    pkgs.delta # Git syntax highlighting pager
    pkgs.cargo
    pkgs.eclipses.eclipse-java
    pkgs.go
    pkgs.nodejs_24
    pkgs.logisim-evolution
    pkgs.kicad
    pkgs.proton-vpn
    pkgs.python3 # Python
    pkgs.python312Packages.pip # Python Pip
  ];

  programs.lazygit = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
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

}
