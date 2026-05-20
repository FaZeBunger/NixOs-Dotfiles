{ pkgs, inputs, config, ... }:
let
  masterPkgs = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
  programmingPkgs = [
    pkgs.cargo
    pkgs.eclipses.eclipse-java
    pkgs.go
    pkgs.nodejs_24
    masterPkgs.gemini-cli
    pkgs.logisim-evolution
    pkgs.kicad
    pkgs.protonvpn-gui
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
