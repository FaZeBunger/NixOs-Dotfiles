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
    pkgs.python312Packages.pip # Python Pip
<<<<<<< HEAD
    (pkgs.python3.withPackages (ps: with ps; [
      pillow
      tkinter
      requests
    ]))
=======
    pkgs.pkg-config # C utility for libraries
    pkgs.clang
    pkgs.clang-tools
    pkgs.cmake
    pkgs.cmake-language-server
    pkgs.cmake-lint
    pkgs.cmake-format
>>>>>>> origin/main
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
